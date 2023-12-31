
USE [SEMA_ADV]			-- DB TO BE CHANGED 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER  PROCEDURE [dbo].[SEMA_AUTOMATION_PART_1] 
		@BRANDAAIAID varchar(20)
AS
SET NOCOUNT ON;

BEGIN

DECLARE @DATEMONTH varchar(8) = (SELECT convert(varchar(7), getdate(), 126))

IF NOT EXISTS(SELECT AAIA FROM GRAVY.dbo.AAIA where AAIA = @BRANDAAIAID)  
  BEGIN  
     PRINT('NOT Found AAIA Code in GRAVY.dbo.AAIA Table. EXITING..')
	 RETURN
  END  


---- CREATE  #TEMP_SEMA_BBSP_Aces
---- CREATE  #TEMP_SEMA_BBSP_Pies

DECLARE @AcesTab varchar(100) = '[SEMA_ADV].Dbo.TEMP_SEMA_' + @BRANDAAIAID + '_Aces'
DECLARE @PiesTab varchar(100) = '[SEMA_ADV].Dbo.TEMP_SEMA_' + @BRANDAAIAID + '_Pies'

print('Aces Table: ' +  @AcesTab )
print('Pies Table: ' +  @PiesTab )

IF  NOT EXISTS (SELECT * FROM sys.tables
			WHERE name = Replace(@PiesTab, '[SEMA_ADV].Dbo.', '') AND type = 'U')
	BEGIN
	  Print('ERROR: PIES Table DOES NOT Exist. EXITING..  Table: ' + @PiesTab)
	  Return
	END

 
----  CREATE  TEMPORARY EXTENDED PIES TABLE with '#' To Fill SM_ Columns  from PIES Table

CREATE TABLE #SEMA_EXTENDED_PIES (
	[PartNumber] [varchar](255) NULL,
	[BrandID] [varchar](255) NULL,
	[PartTerminologyLabel] [varchar](255) NULL,
	[Title] [varchar](max) NULL,
	[LongDescription] [varchar](max) NULL,
	[FeaturesandBenefits] [varchar](max) NULL,
	[ProductAttributes] [varchar](max) NULL,
	[MarketingDescription] [varchar](max) NULL,
	[ExtendedDescription] [varchar](max) NULL,
	--[Jobber] [varchar](max) NULL,
	--[Retail] [float] NULL,
	--[MAP] [float] NULL,
	[PrimaryImageURL] [varchar](max) NULL,
	[SM_LDHeight] [nvarchar](max) NULL,           -- Lift Drop Height 
	[SM_Color] [nvarchar](max) NULL,
	[SM_Finish] [nvarchar](max) NULL,
	[SM_Position] [nvarchar](max) NULL,
	[SM_Style] [nvarchar](max) NULL,
	[SM_Diameter] [nvarchar](max) NULL,
	[SM_SoldAs] [nvarchar](max) NULL,
	[SM_SeatType] [nvarchar](max) NULL,
 ) 


 DECLARE @SQL varchar(MAX)        ----  Change SEMATEST to RFC , And DB Also

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = Replace(@PiesTab, '[SEMA_ADV].Dbo.', '')  And COLUMN_NAME = 'PrimaryImageURL' )  
BEGIN     --Print('PrimaryImageURL Column Exist in PIES Table.')

  Print(' CASE 1 .. WITH PrimaryImageURL  ')

SET @SQL = 'Insert Into #SEMA_EXTENDED_PIES ([PartNumber], [BrandID], [PartTerminologyLabel], 
	       [Title], [LongDescription] , [FeaturesandBenefits], [ProductAttributes],
	        [PrimaryImageURL] )
		 Select distinct [PartNumber], [BrandID], [PartTerminologyLabel], [Title], 
		  [LongDescription] , [FeaturesandBenefits], [ProductAttributes], 
		   [PrimaryImageURL]   From @PiesTab'
END
ELSE 
BEGIN
	Print('PrimaryImageURL Column DOES NOT Exist in PIES Table.')   
	-- For BBGL Structure; PrimaryImageURL Missing. Use MarketingDescription Instead of FeatureandBenefits

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = Replace(@PiesTab, '[SEMA_ADV].Dbo.', '')  And COLUMN_NAME = 'MarketingDescription' ) 
BEGIN
  Print(' CASE 2 .. NO PrimaryImage, WITH MarketingDescription ')

	SET @SQL = 'Insert Into #SEMA_EXTENDED_PIES ([PartNumber], [BrandID], [PartTerminologyLabel], 
	       [Title], [LongDescription] ,[FeaturesandBenefits], [ProductAttributes], 
		   [MarketingDescription], [ExtendedDescription] )
		  Select distinct [PartNumber], [BrandID], [PartTerminologyLabel], [Title], 
		  [LongDescription],[FeaturesandBenefits],[ProductAttributes],
		  [MarketingDescription], [ExtendedDescription]  From @PiesTab'
END
ELSE 
BEGIN   ----  NO MktDescr, No PrimartyImageURL
  Print(' CASE 3 .. NO MktDescr, No PrimartyImageURL ')

	SET @SQL = 'Insert Into #SEMA_EXTENDED_PIES ([PartNumber], [BrandID], [PartTerminologyLabel], 
	       [Title], [LongDescription] ,[FeaturesandBenefits], [ProductAttributes],
		   [ExtendedDescription] )
		  Select distinct [PartNumber], [BrandID], [PartTerminologyLabel], [Title], 
		  [LongDescription], [FeaturesandBenefits], [ProductAttributes], [ExtendedDescription] 
		   From @PiesTab'

END
END

SET @SQL = Replace(@SQL, '@PiesTab', @PiesTab)
EXEC(@SQL)

--Print('** INSERT INTO #SEMA_EXTENDED_PIES TABLE, Rec Num: ' + cast(@@ROWCOUNT as varchar) )

---- REMOVE EXTENDED ASCII Chars From PIES TABLE -- Title, LongDescription,
----  [FeaturesandBenefits],[ProductAttributes],[MarketingDescription]

 UPDATE #SEMA_EXTENDED_PIES 
     SET Title = [SEMA_ADV].[dbo].[Remove_ExtendAscii_Chars](Title)

 UPDATE #SEMA_EXTENDED_PIES 
     SET Title = [SEMA_ADV].[dbo].[FirstLetterCap](Title)
	   
 UPDATE #SEMA_EXTENDED_PIES 
     SET LongDescription = [SEMA_ADV].[dbo].[Remove_ExtendAscii_Chars](LongDescription)

 UPDATE #SEMA_EXTENDED_PIES 
     SET FeaturesandBenefits = [SEMA_ADV].[dbo].[Remove_ExtendAscii_Chars](FeaturesandBenefits)
 
 UPDATE #SEMA_EXTENDED_PIES 
     SET ProductAttributes = [SEMA_ADV].[dbo].[Remove_ExtendAscii_Chars](ProductAttributes)
 
 UPDATE #SEMA_EXTENDED_PIES 
     SET MarketingDescription = [SEMA_ADV].[dbo].[Remove_ExtendAscii_Chars](MarketingDescription)
 
 UPDATE #SEMA_EXTENDED_PIES 
     SET LongDescription = [SEMA_ADV].[dbo].[FirstLetterCap](LongDescription),
	     MarketingDescription = [SEMA_ADV].[dbo].[FirstLetterCap](MarketingDescription)

 ---- REMOVE 'TITLE:' From  #SEMA_EXTENDED_PIES  TABLE
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = TRIM(Replace(ProductAttributes, tmp.value, ''))
    from #SEMA_EXTENDED_PIES  Cross Apply ( Select value from STRING_SPLIT(ProductAttributes, ';')) 
	as tmp  where tmp.value like '%TITLE:%'
 
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = TRIM(Replace(ProductAttributes, tmp.value, ''))
    from #SEMA_EXTENDED_PIES  Cross Apply ( Select value from STRING_SPLIT(ProductAttributes, ';')) 
	as tmp  where tmp.value like '%CARB E.O%'
 
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = TRIM(Replace(ProductAttributes, tmp.value, ''))
    from #SEMA_EXTENDED_PIES  Cross Apply ( Select value from STRING_SPLIT(ProductAttributes, ';')) 
	as tmp  where tmp.value like '%CARB E.O%'
 
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = TRIM(Replace(ProductAttributes, tmp.value, ''))
    from #SEMA_EXTENDED_PIES  Cross Apply ( Select value from STRING_SPLIT(ProductAttributes, ';')) 
	as tmp  where tmp.value like '%Prop 65%'
 
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = TRIM(Replace(ProductAttributes, tmp.value, ''))
    from #SEMA_EXTENDED_PIES  Cross Apply ( Select value from STRING_SPLIT(ProductAttributes, ';')) 
	as tmp  where tmp.value like '%Prop 65%'
 
 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = 
      Trim(Replace(Replace(Replace(ProductAttributes, ';;;;', ';'),';;;', ';'), ';;', ';'))
    where ProductAttributes like '%;;%'

 UPDATE #SEMA_EXTENDED_PIES  SET ProductAttributes = NULL
    where trim(ProductAttributes)  = ''


 UPDATE #SEMA_EXTENDED_PIES 
     SET FeaturesandBenefits = [SEMA_ADV].[dbo].[FirstLetterCap](FeaturesandBenefits),
	     ProductAttributes = [SEMA_ADV].[dbo].[FirstLetterCap](ProductAttributes)

PRINT('REMOVED From PIES Table- ExtendAscii And Unwanted Phrases, Capitalized First Letter')

 --SET @SQL = 'UPDATE @AcesTab 
	--	      SET Notes = [SEMA_ADV].[dbo].[FirstLetterCap](Notes)' 

 --SET @SQL = REPLACE(@SQL,'@AcesTab', @AcesTab ) 
 --EXEC(@SQL)

----------------------  ACES Table - Notes FisrtLetterCap()  --------------

Create Table #TEMP_ACES_NOTES ([Notes1] nvarchar(max), [Notes2] nvarchar(max) )

----INSERT INTO #TEMP_ACES_NOTES  select DISTINCT Notes as [Notes1], 'NULL' as [Notes2]
----    from [SEMA_ADV].[dbo].TEMP_SEMA_BBGC_ACES

 SET @SQL = 'INSERT INTO #TEMP_ACES_NOTES  select DISTINCT Notes as [Notes1], 
		     ''NULL'' as [Notes2] from @AcesTab' 

 SET @SQL = REPLACE(@SQL, '@AcesTab', @AcesTab ) 
 EXEC(@SQL)


UPDATE #TEMP_ACES_NOTES 
	SET  Notes2  = [SEMA_ADV].[dbo].[FirstLetterCap](Notes1)


 ----SET @SQL = 'UPDATE @AcesTab  SET Aspiration = Notes' 
 ----SET @SQL = REPLACE(@SQL, '@AcesTab', @AcesTab ) 
 ----EXEC(@SQL)


 SET @SQL = 'UPDATE @AcesTab  SET Notes = t1.Notes2
			  FROM @AcesTab t2 LEFT OUTER JOIN  #TEMP_ACES_NOTES t1   
              ON t1.Notes1 = t2.Notes' 

 SET @SQL = REPLACE(@SQL, '@AcesTab', @AcesTab ) 
 EXEC(@SQL)

 

---- Drop Table if exists #TEMP_KVP_SEMA 

Create Table #TEMP_KVP_SEMA ( [PartNumber] varchar(max), [BrandID] varchar(255),
			[PartTerminologyLabel] nvarchar(max),  [productAttributes] nvarchar(max), 
			[Tags] nvarchar(max), [value] nvarchar(max) )

INSERT INTO #TEMP_KVP_SEMA  select DISTINCT PartNumber, BrandID,	
	PartTerminologyLabel, ProductAttributes,
    case when cs.Value like '%:%' then LEFT(cs.Value, CHARINDEX(':', cs.Value) - 1) 
    else NULL end [Tags],
	case when cs.Value like '%:%' then RIGHT(cs.Value, (len(cs.Value) - CHARINDEX(':', cs.Value))) 
    else cs.Value end [Value]
    from #SEMA_EXTENDED_PIES cross apply STRING_SPLIT (ProductAttributes, ';') cs


--Print('** INSERT INTO #TEMP_KVP_SEMA TABLE, Rec # ' + cast(@@ROWCOUNT as varchar) )


--------------------  UPDATE SM_COLUMNS  ---------------------

--------------  POPULATE SM_COLOR  Column  -----------------

UPDATE  #SEMA_EXTENDED_PIES 
   set SM_COLOR = Concat('Color: ', ISNULL( FN.[Value], CF.[Value] ) )
   from  #SEMA_EXTENDED_PIES  M   
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Color' ) FN    on M.PartNumber = FN.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Color Group' ) CF   on M.PartNumber = CF.PartNumber
   where M.[SM_Color] is NULL  


UPDATE #SEMA_EXTENDED_PIES 
   set SM_COLOR = NULL   Where SM_COLOR in ('Color: ')
 

--------------  POPULATE SM_LDHEIGHT  Column  -----------------

 UPDATE #SEMA_EXTENDED_PIES 
   set SM_LDHEIGHT =  Concat('Lift / Drop Height: ', ISNULL( FN.[Value], ISNULL(CF.[Value], Tab.[Value])) )
   from #SEMA_EXTENDED_PIES M   
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Lift Height' ) FN    on M.PartNumber = FN.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Amount Raised Or Lowered' ) CF   on M.PartNumber = CF.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Amount Raised Or Lowered (IN)' ) Tab   on M.PartNumber = Tab.PartNumber
   where M.[SM_LDHEIGHT] is NULL  


UPDATE #SEMA_EXTENDED_PIES 
   set SM_LDHEIGHT = NULL   Where  SM_LDHEIGHT in ('Lift / Drop Height: ')

UPDATE #SEMA_EXTENDED_PIES 
   set SM_LDHEIGHT = Replace(SM_LDHEIGHT, 'Inch', 'Inch Lift')   
   Where  SM_LDHEIGHT like '%Inch' And ProductAttributes like '%Lift Height:%'


 -- select * from [TEMP_SEMA_EXTENDED_10PIES] 
 -- where  SM_LDHEIGHT  is NOT NULL 
 -- ProductAttributes like '%;Drop:%' OR ProductAttributes like '%;Lift:%'  And


--------  POPULATE SM_FINISH  Column  ------------

 UPDATE #SEMA_EXTENDED_PIES 
   SET SM_FINISH =  Concat('Finish: ', ISNULL( FN.[Value], CF.[Value] ) )
   from #SEMA_EXTENDED_PIES M   
   LEFT JOIN ( SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Finish' ) FN   on  M.PartNumber = FN.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
   where [Tags] = 'Color/ Finish' ) CF   on  M.PartNumber = CF.PartNumber
   where M.SM_Finish is NULL  

UPDATE #SEMA_EXTENDED_PIES 
   set SM_FINISH = NULL   Where SM_FINISH in ('Finish: ')

UPDATE #SEMA_EXTENDED_PIES 
   set SM_FINISH = Replace(SM_FINISH, 'w/ ', 'With ')
   Where SM_FINISH like '%/%' And  SM_FINISH  like '%w/ %'

UPDATE #SEMA_EXTENDED_PIES 
   set SM_FINISH = Replace(SM_FINISH, 'with ', 'With ')
   Where SM_FINISH like '%with %'

UPDATE #SEMA_EXTENDED_PIES 
   set SM_FINISH = Replace(SM_FINISH, '/', ' / ')
   Where SM_FINISH like '%/%' And  SM_FINISH NOT like '% / %'


 --select * from #SEMA_EXTENDED_PIES 
 -- where SM_FINISH is NOT NULL 
 --   And ProductAttributes like '%Color/ Finish%'


--------------  POPULATE SM_POSITION  Column  -----------------

UPDATE #SEMA_EXTENDED_PIES
   set SM_POSITION = Concat('Position: ', PS.[Value])
   from #SEMA_EXTENDED_PIES M
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Position') PS  on  M.PartNumber = PS.PartNumber
   where M.[SM_POSITION] is NULL

	UPDATE #SEMA_EXTENDED_PIES set SM_Position = null
	 where SM_Position in ('Position: ')


--------------  POPULATE SM_STYLE  Column  -----------------

   UPDATE #SEMA_EXTENDED_PIES
   set SM_STYLE =  Concat('Style: ', ISNULL( ST.[Value], MS.[Value] ) )
   from #SEMA_EXTENDED_PIES M
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Style') ST on M.PartNumber = ST.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Mounting Style') MS on M.PartNumber = MS.PartNumber
   where M.[SM_STYLE] is NULL

   UPDATE #SEMA_EXTENDED_PIES set SM_STYLE = null
   where SM_STYLE in ('Style: ')


--------------  POPULATE SM_DIAMETER  Column  -----------------

 UPDATE #SEMA_EXTENDED_PIES
   set SM_DIAMETER =  Concat('Diameter: ', ISNULL( DM.[Value], ISNULL (DI.[Value], BD.[Value] ) ) )
   from #SEMA_EXTENDED_PIES M
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Diameter' ) DM   on  M.PartNumber = DM.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Diameter (IN)' ) DI   on  M.PartNumber = DI.PartNumber
   LEFT JOIN (SELECT distinct PartNumber,Tags,[value] FROM #TEMP_KVP_SEMA 
	where [Tags] = 'Body Diameter (ID)' ) BD   on  M.PartNumber = BD.PartNumber
   where M.[SM_DIAMETER] is NULL

   UPDATE #SEMA_EXTENDED_PIES set SM_DIAMETER = replace(SM_DIAMETER, 'mm', ' mm')
	where SM_DIAMETER like '%mm%'

   UPDATE #SEMA_EXTENDED_PIES set SM_DIAMETER = null
	where SM_DIAMETER in ('Diameter: ')


 print('INSERTED INTO SM_*  COLUMNS  SUCCESFUL .. ')

------ CREATE RFC  TABLE  AND ADD DATA FROM ACES TABLE AND PIES TABLE.

-- DECLARE @RFCtable varchar(max)    
-- SET @RFCtable = '[ReadyForCustomization].[dbo].[RFC_' + @BRANDAAIAID + '_' + @DATEMONTH
DECLARE @RFCTab varchar(100)

SET @RFCTab = '[SEMA_ADV].[dbo].[RFC_' + @BRANDAAIAID + '_' + @DATEMONTH + ']'

--SET @SQL = 'DROP TABLE IF EXISTS [SEMA_ADV].[dbo].[RFC_@BRANDAAIAID_@DATEMONTH]
SET @SQL = 'DROP TABLE IF EXISTS @RFCTab

    CREATE TABLE  @RFCTab(
	[dcicode] [nvarchar](max) NULL,
	[brandaaiaid] [nvarchar](max) NULL,
	[company] [nvarchar](max) NULL,
	[fromyear] [nvarchar](max) NULL,
	[toyear] [nvarchar](max) NULL,
	[SingleYear] [nvarchar](max) NULL,
	[makename] [nvarchar](max) NULL,
	[modelname] [nvarchar](max) NULL,
	[submodelname] [nvarchar](max) NULL,
	[engbase] [nvarchar](max) NULL,
	[fueltype] [nvarchar](max) NULL,
	[drivetype] [nvarchar](max) NULL,
	[BedLength] [nvarchar](max) NULL,
	[BedTypeName] [nvarchar](max) NULL,
	[bodynumdoor] [nvarchar](max) NULL,
	[bodytype] [nvarchar](max) NULL,
	[note1] [nvarchar](max) NULL,
	[Note2] [nvarchar](max) NULL,
	[note3] [nvarchar](max) NULL,
	[note4] [nvarchar](max) NULL,
	[qtyper] [nvarchar](max) NULL,
	[partterminologyname] [nvarchar](max) NULL,
	[SubModelGuide] [nvarchar](max) NULL,
	[position] [nvarchar](max) NULL,
	[exppartno] [nvarchar](max) NULL,
	[mfrlabel] [nvarchar](max) NULL,
	[mfrlabelnew] [nvarchar](max) NULL,
	[Deleted] [int] null,
	[Height] [nvarchar](max) NULL,
	[Width] [nvarchar](max) NULL,
	[Depth] [nvarchar](max) NULL,
	[ActualWeight] [nvarchar](max) NULL,
	[ShippingWeight] [nvarchar](max) NULL,
	[WeightUnit] [nvarchar](max) NULL,
	[UPCCode] [float] NULL,
	[LongDesc] [nvarchar](max) NULL,
	[ShortDesc] [nvarchar](max) NULL,
	[MktDesc] [nvarchar](max) NULL,
	[ExtDesc] [nvarchar](max) NULL,
	[ImageHiResURL1] [nvarchar](max) NULL,
	[ImageHiResURL2] [nvarchar](max) NULL,
	[ImageHiResURL3] [nvarchar](max) NULL,
	[ImageHiResURL4] [nvarchar](max) NULL,
	[ImageHiResURL5] [nvarchar](max) NULL,
	[ImageHiResURL6] [nvarchar](max) NULL,
	[LogoURL] [nvarchar](max) NULL,
	[WarrantyURL] [nvarchar](max) NULL,
	[InstallationURL] [nvarchar](max) NULL,
	[VideoURL1] [nvarchar](max) NULL,
	[VideoURL2] [nvarchar](max) NULL,
	[VideoURL3] [nvarchar](max) NULL,
	[Prop65URL] [nvarchar](max) NULL,
	[fitmentNote] [nvarchar](max) NULL,
	[apqidstring] [nvarchar](max) NULL,
	[pqidstring] [nvarchar](max) NULL,
	[SM_LDHeight] [nvarchar](max) NULL,
	[SM_Color] [nvarchar](max) NULL,
	[SM_Finish] [nvarchar](max) NULL,
	[SM_Position] [nvarchar](max) NULL,
	[SM_Style] [nvarchar](max) NULL,
	[SM_Diameter] [nvarchar](max) NULL,
	[SM_SoldAs] [nvarchar](max) NULL,
    [SM_SeatType] [nvarchar](max) NULL,
	[productQualifier] [nvarchar](max) NULL,
	[productQualifierShort] [nvarchar](max) NULL,
	[vqidstring] [nvarchar](max) NULL,
	[vehicleQualifier] [nvarchar](max) NULL,
	[SM_BedSides] [nvarchar](max) NULL,
	[SM_BedStyle] [nvarchar](max) NULL,
	[SM_BodyStyleON] [nvarchar](max) NULL,
	[SM_BodyStyle] [nvarchar](max) NULL,
	[SM_Transmission] [nvarchar](max) NULL,
	[SM_CabStyle] [nvarchar](max) NULL,
	[SM_DoorNum] [nvarchar](max) NULL,
	[SM_DriveWheel] [nvarchar](max) NULL,
	[SM_SeatRows] [nvarchar](max) NULL,
	[SM_StowAndGo] [nvarchar](max) NULL,
	[SmartWord] [nvarchar](max) NULL,
	[Submodel1] [nvarchar](max) NULL,
	[Submodel2] [nvarchar](max) NULL,
	[Submodel3] [nvarchar](max) NULL,
	[Submodel4] [nvarchar](max) NULL,
	[Submodel5] [nvarchar](max) NULL,
	[Submodel6] [nvarchar](max) NULL,
	[LastUpdated] [datetime] NOT NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'

 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 --SET @SQL = REPLACE(@SQL,'@DATEMONTH', @DATEMONTH )

 EXEC(@SQL)

Print('DROPPED And CREATED RFC Table: ' + @RFCTab )


------  HANDLE EXCEPTIONS FOR ACES TABLE ---------------
---- CHECK For PartTypeDescription Column in ACES Table -- e,g, BBGL Brand ----

DECLARE @FlagPartTypeDescr varchar(100) = 'NULL'
DECLARE @FlagMktDescr varchar(100) = 'NULL'

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = Replace(@PiesTab, '[SEMA_ADV].Dbo.', '')  And COLUMN_NAME = 'MarketingDescription' )  
BEGIN
   Print('MarketingDescription Column Exist in PIES Table.')
   SET @FlagMktDescr = 't1.MarketingDescription'
END

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = Replace(@AcesTab, '[SEMA_ADV].Dbo.', '')  And COLUMN_NAME = 'PartTypeDescription' )  
BEGIN
   SET @FlagPartTypeDescr = 't2.PartTypeDescription'
END


 DECLARE @BRANDNAME nvarchar(MAX) = (select top(1) Brand FROM GRAVY.dbo.AAIA where AAIA = @BRANDAAIAID)

---- POPULATE RFC TABLE FROM ACES AND PIES TABLES..
-- Change DB Name 

SET @SQL = 'INSERT into @RFCTab      
  SELECT distinct 
    null as [dcicode],							t1.BrandID as [brandaaiaid],    
	''@BRANDNAME'' as [company],				null as [fromyear],    
	null as [toyear],							t2.Year as [SingleYear],
    t2.Make as [makename],						t2.Model as [modelname],    
	t2.Submodel as [submodelname],				null as [engbase],    
	t2.FuelType as [fueltype],					t2.Drivetype as [drivetype],
    t2.Bedlengthin as [BedLength],				t2.Bedtype as [BedTypeName],
    t2.Bodydoors as [bodynumdoor],				t2.Bodytype as [bodytype],
    t2.Notes as [note1],						t1.FeaturesAndBenefits as [Note2],    
	t1.ProductAttributes as [note3],			null as [note4],    
	null as [qtyper],							t1.PartTerminologyLabel as [partterminologyname],    
	Null as [SubModelGuide],					t2.Position as [position],    
	t1.PartNumber as [exppartno],				trim(t1.PartTerminologyLabel) as [mfrlabel],   
	null as  [mfrlabelnew],						0 as deleted,             
	null as [Height],							null as [Width],    
	null as [Depth],							null as [ActualWeight],
    null as [ShippingWeight],					null as [WeightUnit],    
	null as [UPCCode],							t1.LongDescription as [LongDesc],    
	@FlagPartTypeDescr  as [ShortDesc],		  -- PartTypeDescription in ACES Table			
	@FlagMktDescr  as [MktDesc],    
	ISNULL(t1.ExtendedDescription, t1.Title)  as [ExtDesc],		
	t1.PrimaryImageURL  as [ImageHiResURL1],    
	Null  as [ImageHiResURL2],			null as [ImageHiResURL3],    
	null as[ImageHiResURL4],					null as [ImageHiResURL5],    
	null as [ImageHiResURL6],				    null as [LogoURL],    
	null as [WarrantyURL],						null as [InstallationURL],    
	null as [VideoURL1],						null as [VideoURL2],
    null as [VideoURL3],						null as [Prop65URL],    
	null as [fitmentNote],						null as [apqidstring],    
	null as [pqidstring],						t1.[SM_LDHeight]  as [SM_LDHeight],
    t1.[SM_Color] as [SM_Color],				t1.[SM_Finish] as [SM_Finish],    
	ISNULL(t1.[SM_Position], Trim(t2.Position))  as [SM_Position],			
	t1.[SM_Style] as [SM_Style],    
	t1.[SM_Diameter] as [SM_Diameter],			t1.[SM_SoldAs] as [SM_SoldAs],
    t1.[SM_SeatType] as [SM_SeatType],			null as [productQualifier],
	null as [productQualifierShort],			null as [vqidstring],
    null as [vehicleQualifier],					null as [SM_BedSides],
    null as [SM_BedStyle],						null as [SM_BodyStyleON],    
	null as [SM_BodyStyle],						null as [SM_Transmission],    
	t2.BodyType as [SM_CabStyle],				t2.Bodydoors as [SM_DoorNum],    
	t2.Drivetype as [SM_DriveWheel],			null as [SM_SeatRows],    
	null as [SM_StowAndGo],						null as [SmartWord],
    Null  as [Submodel1],						null as [Submodel2],    
	null as [Submodel3],						null as [Submodel4],    
	null as [Submodel5],						null as [Submodel6],
    CURRENT_TIMESTAMP as [LastUpdated] 
    FROM  @AcesTab t2  LEFT JOIN				
		  #SEMA_EXTENDED_PIES  t1  ON  t1.PartNumber = t2.PartNumber'

---- WILL CHANGE TABLE NAMES  

 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 --SET @SQL = REPLACE(@SQL,'@DATEMONTH', @DATEMONTH )
 SET @SQL = REPLACE(@SQL,'@BRANDNAME', @BRANDNAME )
 SET @SQL = REPLACE(@SQL,'@AcesTab', @AcesTab )
 SET @SQL = REPLACE(@SQL,'@FlagPartTypeDescr', @FlagPartTypeDescr )
 SET @SQL = REPLACE(@SQL,'@FlagMktDescr', @FlagMktDescr )

 EXEC(@SQL)

 print('INSERT INTO RFC TABLE SUCCESFUL.. Table: ' + @RFCTab + '; Count: ' + cast(@@ROWCOUNT as varchar))

 SET @SQL = 'UPDATE @RFCTab 
		  SET [SM_Position] = CONCAT(''Position: '', [SM_Position])
		  WHERE [SM_Position] NOT LIke ''%Position:%''' 

 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab ) 
 EXEC(@SQL)

---- POPULATE MFRLABEL TABLE IF THERE ARE NEW SKU'S  ----
---- INSERTING MFRLABEL TO GRAVY.DBO.MFRLABEL

---- 
---- Replace Special Ascii Chars,like, char(13) [Carriage Return], char(10) [Line Feed]
---- in Mfrlabel and Parterminologyname

SET @SQL = 'UPDATE @RFCTab 
		SET Mfrlabel = Replace(Replace(Mfrlabel,char(13),''''), char(10),'''')' 

 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 --SET @SQL = REPLACE(@SQL,'@DATEMONTH', @DATEMONTH )
  
  EXEC(@SQL)
 --print ('UPDATE MFRLABEL char(13): ')

 
SET @SQL = 'INSERT INTO [GRAVY].[DBO].[Mfrlabel] 
    select Distinct brandaaiaid as aaia, ''@BRANDNAME''  as Manufacturer, exppartno as Sku, 
    mfrlabel as mfrlabel, null as mfrlabelnew, 	null as deleted,
	CURRENT_TIMESTAMP as lastUpdated, 1 as Published,  null as updatedby, ''SEMA'' as Source
      FROM @RFCTab  Where Exppartno NOT IN 
	  ( SELECT distinct SKU FROM [GRAVY].[DBO].[Mfrlabel]  where aaia = ''@BRANDAAIAID'' )' 

 SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@BRANDNAME', @BRANDNAME )
 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 
 EXEC(@SQL)

 IF (@@ROWCOUNT > 0 ) BEGIN
	print ('INSERTED NEW SKUs INTO MFRLABEL TABLE. Count: ' + cast(@@ROWCOUNT as varchar) )
  END
 
---- UPDATE MFRLABEL's IN RFC Table from  GRAVY.DBO.MFRLABEL for existing SKU's

SET @SQL = 'UPDATE @RFCTab
     Set Mfrlabel = t2.Mfrlabel    from   
     (Select * from [GRAVY].[DBO].[mfrlabel]  Where  aaia = ''@BRANDAAIAID'' ) t1
     INNER JOIN  @RFCTab  t2  ON t2.Exppartno = t1.SKU'
   
 SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 
 --print ('UPDATE MFRLABEL IN RFC TABLE. ' )
 EXEC(@SQL)

 
---- INSERT New PartTerminologyLabel IN DEF_PartTermToSubmodel Table from  This RFC Table --
----  First Replace Special Chars, like, char(13), char(10)

SET @SQL = 'UPDATE @RFCTab	SET Partterminologyname 
         = Replace(Replace(Partterminologyname,char(13),''''), char(10),'''')' 

 --SET @SQL = REPLACE(@SQL, '@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL, '@RFCTab', @RFCTab )
  
 EXEC(@SQL)


SET @SQL = 'INSERT INTO [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel] (partterminologyname, 
		SubModelGuide, LastUpdated, Source)  Select distinct partterminologyname as 
		[partterminologyname], NULL as [SubModelGuide], CURRENT_TIMESTAMP as [LastUpdated],
		 ''SEMA'' as  [Source]   from  @RFCTab t1  Where  partterminologyname 
	     NOT IN  ( Select Distinct partterminologyname from 
	     [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel] )'
   
 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 
 --print ('SQL String PartTerminologyLabel: ' + @SQL )

 EXEC(@SQL)

 IF (@@ROWCOUNT > 0 ) BEGIN
	print ('INSERTED NEW PartTerminologyLabel. Count: ' + cast(@@ROWCOUNT as varchar) )
  END

print (' END of Procedure SEMA_AUTOMATION_PART_1.')

END

