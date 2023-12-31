USE [Gravy]
GO
/****** Object:  StoredProcedure [dbo].[DCI_BulkImport]    Script Date: 12-12-2022 00:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[DCI_BulkImport]
@filePrefix nvarchar(128)
as
DECLARE @query NVARCHAR(MAX);
Declare @rawDB NVARCHAR(MAX);
Declare @attrDB NVARCHAR(MAX);
Declare @dataPrep NVARCHAR(MAX);
Declare @logfile NVARCHAR(MAX);


set @rawDB = 'Gravy.dbo.DCI_' + SUBSTRING(@filePrefix,1,3) + '_rawDB'
set @attrDB = 'Gravy.dbo.DCI_' + SUBSTRING(@filePrefix,1,3) + '_attrDB'
set @dataPrep = 'Gravy.dbo.DCI_' + SUBSTRING(@filePrefix,1,3) + '_dataPrep'
set @logfile = REPLACE(REPLACE(REPLACE(convert(nvarchar(20),GetDate(),120),':',''), '-',''),' ','') + '_' + @filePrefix


print('Extracting zip file..')
set @query = '
file.remove(list.files("D:/ftpFiles/dci/unzip",full.names = T, pattern = "txt$"));
unzip(zipfile="D:/ftpFiles/dci/'+ @filePrefix+ '_ACESPIESComboRollNet.zip",exdir="D:/ftpFiles/dci/unzip")'
EXECUTE sp_execute_external_script @language = N'R',  @script = @query


print('Creating rawdb and attr table..')

set @query = 'drop table if exists '+ @rawDB +
				';drop table if exists '+ @attrDB +
				';select * into '+ @rawDB + ' from DCI_rawDB where 0=1' +
				';select * into '+ @attrDB + ' from DCI_attrDB where 0=1'
begin transaction;
exec (@query)
commit;

print('Inserting ACESPIES_Rollup file..')
				
BEGIN TRY
set @query = 'BULK INSERT '+ @rawDB +' FROM ''D:\ftpFiles\dci\unzip\'+ @filePrefix +'_ACESPIES_Rollup.txt''
    WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'',
	ERRORFILE = ''D:\ftpFiles\dci\unzip\logs\'+ @logfile +'_ACESPIES_Rollup.log''  );' 
exec (@query)
END TRY
BEGIN CATCH
 select 'Failed to upload ' + @filePrefix +'_ACESPIES_Rollup.txt ' + error_message()
END CATCH


set @query = 'insert into [dataPrep_MergeMFRLabel]( manufacturercode, brandaaiaid, mfrlabel, mfrlabelnew, manufacturer, sku, published)
		select ''' + SUBSTRING(@filePrefix,1,3) + ''', brandaaiaid, mfrlabel,NULL, company, string_agg(exppartno, ''; '') sku, 1 from (
  select brandaaiaid, mfrlabel, company, exppartno, row_number() over(partition by mfrlabel order by exppartno)rn from (
	select distinct t1.brandaaiaid, t1.mfrlabel, t1.company, t1.exppartno
  from '+ @rawDB + ' t1 left join (select brandaaiaid, mfrlabel from [dataPrep_MergeMFRLabel] ) t2 on t1.brandaaiaid=t2.brandaaiaid and t1.mfrlabel=t2.mfrlabel
  where t2.mfrlabel is null  
  )t)t where rn<50 group by brandaaiaid, mfrlabel, company' 
exec (@query)





print('Inserting ACESPIES_RollupNet file..')

BEGIN TRY

set @query = ';BULK INSERT '+ @rawDB +' FROM ''D:\ftpFiles\dci\unzip\'+ @filePrefix +'_ACESPIES_RollupNet.txt''
    WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'',
	ERRORFILE = ''D:\ftpFiles\dci\unzip\logs\'+ @logfile +'_ACESPIES_RollupNet.log''  );' 
exec (@query)
END TRY
BEGIN CATCH
 select 'Failed to upload ' + @filePrefix +'_ACESPIES_RollupNet.txt ' + error_message()
END CATCH

print('Inserting ProductAttribute file..')


BEGIN TRY
set @query = ';BULK INSERT '+ @attrDB +' FROM ''D:\ftpFiles\dci\unzip\'+ @filePrefix +'_ProductAttribute.txt''
    WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'',
	ERRORFILE = ''D:\ftpFiles\dci\unzip\logs\'+ @logfile +'_ProductAttribute.log''  );' 
exec (@query)
END TRY
BEGIN CATCH
 select 'Failed to upload ' + @filePrefix +'_ProductAttribute.txt ' + error_message()
END CATCH

print('Inserting ProductAttributeAdd file..')


BEGIN TRY
set @query = ';BULK INSERT '+ @attrDB +' FROM ''D:\ftpFiles\dci\unzip\'+ @filePrefix +'_ProductAttributeAdd.txt''
    WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'',
	ERRORFILE = ''D:\ftpFiles\dci\unzip\logs\'+ @logfile +'_ProductAttributeAdd.log''  )' 
exec (@query)
END TRY
BEGIN CATCH
 select 'Failed to upload ' + @filePrefix +'_ProductAttributeAdd.txt ' + error_message()
END CATCH

print('Adding colour a column..')


begin transaction;
exec('alter table '+ @rawDB + ' add color varchar(max); ')
commit;

set @query = ' update '+ @rawDB + ' set color = null'+
	'; update '+ @rawDB + ' set color = t2.pqdescr
	 from '+ @rawDB + ' t1 join '+ @attrDB +' t2 on t1.exppartno = t2.exppartno where t2.pqcatdescr=''Color'''
				
exec (@query)


print('standardising year,engbase,bodynumdoor,rearspringtype,frontspringtype,BedLength,position..')


set @query = ' update '+ @rawDB + ' set color = null'+
	'; update '+ @rawDB + ' set color = t2.pqdescr
	 from '+ @rawDB + ' t1 join '+ @attrDB +' t2 on t1.exppartno = t2.exppartno where t2.pqcatdescr=''Color'''+
	 ';update  '+ @rawDB + '  set engbase = case when LEN(engbase)<10  or engbase is null then null 
			else CONCAT_ws(''-'',TRIM (SUBSTRING(engbase, 1, CHARINDEX('' '', engbase))),TRIM (SUBSTRING(engbase, CHARINDEX('' '', engbase)+1, CHARINDEX('' '', engbase))),''L'') end 
update  '+ @rawDB + '  set engbase = case when engbase is not null and fueltype is not null then concat_ws(''-'',engbase,fueltype) 
										when engbase is not null then engbase when fueltype is not null then fueltype else null end					
update  '+ @rawDB + '  set bodynumdoor = CONCAT(bodynumdoor,'' Door'') where bodynumdoor is not null
update  '+ @rawDB + '  set rearspringtype = CONCAT(''Rear Spring Type - '', rearspringtype) where rearspringtype is not null
update  '+ @rawDB + '  set frontspringtype = CONCAT(''Front Spring Type - '', frontspringtype) where frontspringtype is not null 
update  '+ @rawDB + '  set BedLength = CONCAT(BedLength, '' in. Bed'') where BedLength is not null 
update  '+ @rawDB + '  set wheelbase =  CONCAT(wheelbase, '' in. wheelbase'')  where wheelbase is not null
update '+ @rawDB + '  set position = null where position =''N/A'''
				
exec (@query)

exec('alter table '+ @rawDB + ' add Year varchar(max)--, customsm1 varchar(255), customsm2 varchar(255), customsm3 varchar(255), customsm4 varchar(255), customsm5 varchar(255), customsm6 varchar(255);')
exec('update '+ @rawDB + ' set Year = CONCAT(fromyear, ''-'', toyear) where fromyear!=''ALL'' and toyear!=''ALL''')


print('Adding new partterminologyname for mapping..')

-- inserting new categories for mapping --
set @query = 'insert into categoryDefinition (partterminologyname, brandName, sampleSku)
select partterminologyname, company, STRING_AGG(exppartno, ''; '') from (
select distinct partterminologyname, company, exppartno
  from '+ @rawDB + ' where partterminologyname is not null and partterminologyname not in (select partterminologyname from categoryDefinition))t
  group by partterminologyname, company'
				
exec (@query)


-- inserting new categories for mapping --
set @query = 'insert into shinyCategoryDefinition (brandaaiaid, brandName,partterminologyname,mfrlabel,imgUrl,sampleSku)
  select brandaaiaid, company,partterminologyname,mfrlabel,STRING_AGG(imagehiresurl1,'';''),STRING_AGG(exppartno,'';'') from (
  select distinct t1.brandaaiaid, t1.company,t1.partterminologyname,t1.mfrlabel,imagehiresurl1, exppartno
  from '+ @rawDB + ' t1 left join shinyCategoryDefinition t2 on t1.brandaaiaid=t2.brandaaiaid and t1.company=t2.brandName and t1.partterminologyname=t2.partterminologyname and t1.mfrlabel=t2.mfrlabel
  where t1.partterminologyname is not null and t2.samplesku is null)t
  group by brandaaiaid, company,partterminologyname,mfrlabel'
				
exec (@query)





--print('Adding new partterminologyname for mapping..')



set @query = 'select t1.*,t2.mfrlabelnew from (
select ''Distinct PTN / MFRL VS SKU Count''as Reporting,partterminologyname,brandaaiaid,mfrlabel, count(distinct(exppartno)) ''Distinct Skus''
from '+ @rawDB + ' 
group by partterminologyname, brandaaiaid,mfrlabel)t1 
left join dataPrep_MergeMFRLabel t2 on t1.mfrlabel=t2.mfrlabel and t1.brandaaiaid=t2.brandaaiaid
 order by 2,3
'
				
exec (@query)


set @query = '
select * from Manufacturer where AAIAID in (select distinct brandaaiaid from '+ @rawDB + ')

'
				
exec (@query)

set @query = '

select distinct partterminologyname ''partterminologyname not yet mapped'' from '+ @rawDB + ' where partterminologyname is not null and partterminologyname in (
select partterminologyname from categoryDefinition where CategoryIDs is null)

'



				
exec (@query)


set @query = '

insert into imagelibrary 
SELECT distinct t1.brandaaiaid,t1.exppartno,t1.mfrlabel,t1.ImageHiResURL1,t1.ImageHiResURL2,
t1.ImageHiResURL3,t1.ImageHiResURL4,t1.ImageHiResURL5,t1.ImageHiResURL6,t1.LogoURL,t1.WarrantyURL
,t1.InstallationURL,t1.VideoURL1,t1.VideoURL2,t1.VideoURL3,t1.Prop65URL
FROM '+ @rawDB + ' t1 left join imagelibrary t2 on t1.brandaaiaid=t2.brandaaiaid and t1.exppartno=t2.exppartno
where t2.exppartno is null


'



				
exec (@query)








--select top 10 * from DCI_BOR_rawDB where wheelbase is not null
--select top 10 * from DCI_BOR_rawDB where bedlength is not null


--update  '+ @rawDB + '  set wheelbase = case when wheelbase is null then null else CONCAT(wheelbase, '' in. wheelbase'') end