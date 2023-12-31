
USE [SEMA_ADV]			-- DB TO BE CHANGED 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   PROCEDURE [dbo].[SEMA_AUTOMATION_PART_2] 
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

DECLARE @RFCTab varchar(100)
SET @RFCTab = 'RFC_' + @BRANDAAIAID + '_' + @DATEMONTH

IF  NOT EXISTS (SELECT * FROM sys.tables
	WHERE name =  @RFCTab AND type = 'U')
	BEGIN
	  Print('ERROR: RFC Table DOES NOT Exist. EXITING..  Table: ' + @RFCTab)
	  Return
	END

--print('RFC TABLE: ' + @RFCTab )
 
DECLARE @SQL varchar(MAX)        
DECLARE @RowCnt INT = 0
DECLARE @TabName  Varchar(150) = ''

SET  @TabName = '[SEMA_ADV].Dbo.[' + @RFCTab + ']'
print('RFC TabName: ' + @TabName )

--Set @RowCnt = ( Select count(*) from [SEMA_ADV].Dbo.[RFC_BBSP_2022-06])


---- UPDATE MFRLABELNEW IN RFC Table from  GRAVY.DBO.MFRLABEL for All SKU's
BEGIN TRY 
SET @SQL = 'UPDATE @TabName
		 SET Mfrlabelnew = t1.Mfrlabelnew  FROM   
		 (Select * from GRAVY.DBO.mfrlabel Where  aaia = ''@BRANDAAIAID'' ) t1   
		 INNER JOIN   @TabName t2   ON  t2.Exppartno = t1.SKU'
   
 --SET @SQL = REPLACE(@SQL,'@RFCTab', @RFCTab )
 SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 
 EXEC(@SQL)

 SET @SQL = 'UPDATE @TabName
		 SET Mfrlabel = Mfrlabelnew   Where Mfrlabel is NULL'
   
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

 SET @SQL = 'UPDATE @TabName
		 SET partterminologyname = Mfrlabelnew   Where partterminologyname is NULL'
   
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

 print ('SUCCESFUL: UPDATED MfrlabelNew.. ')
 END TRY
 BEGIN CATCH
  print ('ERROR: UPDATED MfrlabelNew.. EXITING.. ')
  Return
 END CATCH

---- UPDATE MFRLABELNEW IN RFC Table from  GRAVY.DBO.MFRLABEL for All SKU's

BEGIN TRY
---  DROP And CREATE #TEMP_RFC_TABLE USING RFC TABLE Structure. Then INSERT Data.

	DROP TABLE IF EXISTS #TEMP_RFC_TABLE

    CREATE TABLE  #TEMP_RFC_TABLE (
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
	[LastUpdated] [datetime] NOT NULL )


	SET @SQL= 'INSERT INTO  #TEMP_RFC_TABLE  SELECT * from  @TabName'
	SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
	EXEC(@SQL)
END TRY
BEGIN CATCH
	Print('ERROR: Extracting RFC Data INTO #TEMP_RFC  Table. EXITING..')
	Return
END CATCH

BEGIN TRY 
DROP TABLE IF EXISTS #PTN_TABLE			--- CHANGE this to #PTN_TABLE
SELECT ROW_NUMBER() OVER (order by tab.partterminologyname asc) as RowNum, 
       tab.partterminologyname, P.Submodel1, P.Submodel2, P.Submodel3, 
	   P.Submodel4, P.Submodel5, P.Submodel6 INTO #PTN_TABLE FROM 
       ( SELECT DISTINCT partterminologyname from #TEMP_RFC_TABLE ) tab
	   INNER JOIN  [TEST_DCI_PLAT].[DBO].[DEF_ParttermToSubModel] P
	   ON P.partterminologyname = tab.partterminologyname

select @RowCnt = max(RowNum)  from  #PTN_TABLE
Print('Distinct PartTerminology in RFC Table, @RowCnt: ' + cast(@RowCnt as varchar) )

 -- PRINT (CONVERT( VARCHAR(24), GETDATE(), 121))
END TRY
BEGIN CATCH
	Print('ERROR: Creating Temp PartTerminology Table from DEF_ParttermToSubModel And  Temp RFC Table. EXITING..')
	Return
END CATCH

 DECLARE @PTN varchar(200)
 DECLARE @SM1 varchar(200), @SM2 varchar(200), @SM3 varchar(200)
 DECLARE @SM4 varchar(200), @SM5 varchar(200), @SM6 varchar(200) 
DECLARE @Counter INT = 1

BEGIN TRY
	WHILE  @Counter <= @RowCnt
	 BEGIN
		 --Print('INSIDE WHILE, @Counter: ' + cast(@Counter as varchar))

	 SELECT @PTN = partterminologyname, @SM1 = Submodel1, @SM2 = Submodel2, @SM3 = Submodel3,
				   @SM4 = Submodel4, @SM5 = Submodel5,  @SM6 = Submodel6
	 from #PTN_TABLE  Where RowNum = @Counter
				
	 SET @SQL= 'UPDATE  #TEMP_RFC_TABLE   SET Submodel1 = @SM1, Submodel2 = @SM2,
				Submodel3 = @SM3, Submodel4 = @SM4, Submodel5 = @SM5, Submodel6 = @SM6 
				Where partterminologyname = ''@PTN'''

	 SET @SQL = REPLACE(@SQL,'@PTN', @PTN )
	 SET @SQL = REPLACE(@SQL,'@SM1', ISNULL(@SM1,'NULL') )
	 SET @SQL = REPLACE(@SQL,'@SM2', ISNULL(@SM2, 'NULL') )
	 SET @SQL = REPLACE(@SQL,'@SM3', ISNULL(@SM3, 'NULL') )
	 SET @SQL = REPLACE(@SQL,'@SM4', ISNULL(@SM4, 'NULL') )
	 SET @SQL = REPLACE(@SQL,'@SM5', ISNULL(@SM5, 'NULL') )
	 SET @SQL = REPLACE(@SQL,'@SM6', ISNULL(@SM6, 'NULL') )

	 EXEC(@SQL)
	 SET @Counter += 1
  END

SET @SQL = 'DELETE From  @TabName;
		    INSERT INTO  @TabName  Select * from #TEMP_RFC_TABLE'
   
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 --SET @SQL = REPLACE(@SQL,'@DATEMONTH', @DATEMONTH )
 EXEC(@SQL)

 print ('SUCCESFUL: DROPDOWNS UPDATED.. ')

END TRY
BEGIN CATCH
	Print('ERROR: UPDATING DROPDOWNS. EXITING..')
	Return
END CATCH
 
 DECLARE @INFO2 VARCHAR(100) = 'INFO: DROPDOWNS PROCESSED..'
RAISERROR (@INFO2 , 0, 1) WITH NOWAIT

 --PRINT (CONVERT( VARCHAR(24), GETDATE(), 121))

--DECLARE @BRANDNAME nvarchar(MAX) = (select top(1) Brand FROM GRAVY.dbo.AAIA where AAIA = @BRANDAAIAID)
DROP TABLE IF EXISTS #TEMP_RFC_TABLE
--DROP TABLE IF EXISTS #PTN_TABLE

 --PRINT (CONVERT( VARCHAR(24), GETDATE(), 121))

 ---- CLEANING: Remove CARB E.O., WARNING,  Special Chars...
 
BEGIN TRY
SET @SQL = 'UPDATE @TabName    set Note3 = Replace(Note3, tmp.value, '''')
         from  @TabName  Cross Apply  ( Select value from STRING_SPLIT(Note3, '';'')) as tmp
         where tmp.value like ''%WARNING%'''
 
--SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )

EXEC(@SQL)
EXEC(@SQL)

--print ('CLEANING: WARNING  Successful.. ')

-- SET @SQL = 'UPDATE @TabName   set Note3 = Replace(Note3, tmp.value, '''')
--         from  @TabName  Cross Apply  ( Select value from STRING_SPLIT(Note3, '';'')) as tmp
--          where tmp.value like ''%CARB E.O.%'''
 
-- SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
-- SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
-- EXEC(@SQL)
-- EXEC(@SQL)

-- print ('CLEANING: Prop 65.. ')

-- SET @SQL = 'UPDATE @TabName   set Note3 = Replace(Note3, tmp.value, '''')
--         from  @TabName  Cross Apply  ( Select value from STRING_SPLIT(Note3, '';'')) as tmp
--          where tmp.value like ''%Prop 65%'''
-- SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
-- SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
-- EXEC(@SQL)
-- EXEC(@SQL)

SET @SQL = 'UPDATE @TabName
          SET Note3 = Trim(Replace(Replace(Note3, '';;;'', '';''), '';;'', '';''))
          where Note3 like ''%;;%'''
 
 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

  print ('SUCCESFUL: CLEANING Of RFC Table..')
  END TRY
  BEGIN CATCH
	print ('ERROR: CLEANING Of RFC Table.. EXITING.. ')
	Return
  END CATCH

-- DECLARE @INFO1 VARCHAR(100) = 'INFO: CLEANING Of RFC Table DONE.'
-- RAISERROR (@INFO1 , 0, 1) WITH NOWAIT

 --PRINT (CONVERT( VARCHAR(24), GETDATE(), 121))

 ---- APPLY HTML Tags To: Note2, Note3, FitmentNote , 
 BEGIN TRY
	SET @SQL = 'UPDATE @TabName
            SET Note2 = [SEMA_ADV].[dbo].[RFC_Insert_Html_Tags](Note2, '';'')
			 WHERE NOTE2 IS NOT NULL'

 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

SET @SQL = 'UPDATE @TabName
            SET FitmentNote = [SEMA_ADV].[dbo].[RFC_Insert_Html_Tags](FitmentNote, '';'')
			 WHERE FitmentNote IS NOT NULL'

 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

SET @SQL = 'UPDATE @TabName
            SET  Note3 = [SEMA_ADV].[dbo].[RFC_Insert_Html_Tags](Note3, '';'')
			 WHERE NOTE3 IS NOT NULL'

 --SET @SQL = REPLACE(@SQL,'@BRANDAAIAID', @BRANDAAIAID )
 SET @SQL = REPLACE(@SQL,'@TabName', @TabName )
 EXEC(@SQL)

 Print('SUCCESFUL: INTRODUCED HTML TAGS.. ')
 END TRY 
 BEGIN CATCH
    print ('ERROR: INTRODUCING HTML TAGS.. EXITING.. ')
	Return
 END CATCH

 --PRINT (CONVERT( VARCHAR(24), GETDATE(), 121))
   print ('END Of PROCEDURE  SEMA_AUTOMATION_PART_2.. ')

 ---- ON HOLD --  Update RFC table with  ModelFirstWord  (ask for field in RFC Table)

END

