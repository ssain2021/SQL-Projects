
---- 1)  CURT  --  CUR    - BDKW 

---- TEST RUN on  28-JUNE --   DCI BRANDS  ---  

CURT  --  CUR    -  BKDK   (Manu:  177 )

-- Run Proc 1	[Took  3:28 mins ]  [ Took 2:22 mins ]
-- Run Proc 2	[Took  25:51 mins ]  [ Took 9:32 mins ]
-- Run Proc 3	[Took  7:33 mins ]   [ Took 3:30 mins ]


---- UPDATED NOTE2 For SKU # 16027 with html tags  [ 30:00 mins includes discussion ] 
-- ADD Fitment Notes for Part # 16027: 
-- For use for Ford, Chevy, and General Motors Trucks with Factory Towing Prep Package

--UPDATE [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
--  Set Note2 =  Concat('For use for Ford, Chevy, and General Motors Trucks with Factory Towing Prep Package; ', Note2)
--  WHERE  exppartno = '16027'

--UPDATE [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
--  Set Note2 = Replace(Note2, 'For use for Ford, Chevy, and General Motors Trucks with Factory Towing Prep Package; <ul>',
--  '<ul><li>For use for Ford, Chevy, and General Motors Trucks with Factory Towing Prep Package</li>')
--  WHERE  exppartno = '16027'  And
--  Note2 like 'For use for Ford, Chevy, and General Motors Trucks with Factory Towing Prep Package; <ul>%'

--Select makename, modelname, submodelname, singleyear, Note2, Note3
-- from [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
--  where exppartno = '16027'  order by makename, modelname, singleyear

----  Lotsa of Cleaning was Required before..

----  UPDATE Mfrlabelnew  --

UPDATE  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
    SET  MFRLABELNew = T2.MFRLABELNew
	FROM  [GRAVY].[dbo].MFRLABEL T2  INNER JOIN 
	[ReadyForCustomization].[dbo].[RFC_CUR_2022-07] T1  
	ON T1.EXPPARTNO = T2.SKU    WHERE T2.AAIA = 'BKDK'


--Select * from 	[GRAVY].[dbo].Catlist where catcode = 'CUR'
--catname	catid	catcode	brandcode
--CURT    1171	CUR    	BKDK     


UPDATE  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
    SET Submodel1 = 'The 60Th Anniversary Edition'
	where Submodel1 = 'THE 60TH ANNIVERSARY EDITION'




--------  FITMENT DATA Correction --------------

--UPDATE Gravy.dbo.Mfrlabel 
-- SET  Mfrlabelnew = Mfrlabel
-- WHere aaia = 'BKDK'
-- And SKU in ('16063', '16073','16668','16675', '16685')
--Select distinct * FROM [Gravy].[dbo].[TEMP_CURT_NEW_FITDATA]


INSERT INTO [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
  ( mfrlabelnew, mfrlabel, SingleYear, Makename, Modelname,Bedlength, SM_BedStyle, 
    BedTypeName, Note1, Note3, Partterminologyname, UPCCODE, MktDesc, ExtDesc, 
	 Exppartno, LastUpdated )
  select t1.mfrlabelnew, t1.mfrlabelnew, t1.SingleYear, t1.Makename, t1.Modelname,
   t1.Bedlength, t1.SM_BedStyle, t1.BedTypeName, t1.Note1, t1.Note3, t1.Partterminologyname,
   t2.UPCCODE, t2.MktDesc, t2.ExtDesc , t1.exppartno, CURRENT_TIMESTAMP 
  from [Gravy].[dbo].[TEMP_CURT_NEW_FITDATA] t1
  INNER JOIN  ( select distinct Exppartno, UPCCODE, MktDesc, ExtDesc from 
    [ReadyForCustomization].[dbo].[RFC_CUR_2022-07] 
	Where exppartno in ('16063', '16073','16668','16675', '16685') ) t2
	ON T1.exppartno = t2.exppartno



-----  DATA CORRECTION For 100 DEADENDS  (Mostly BedLengths, etc.) ------------

UPDATE [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
 SET BEDLENGTH = 'BED STYLE: 8 ft 2 in. Long Bed', SM_BEDSTYLE = 'BED STYLE: 8 ft 2 in. Long Bed'
 WHERE mfrlabelnew in ('5th Wheel Trailer Hitch Leg Kit') and BedLength is Null

UPDATE [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
 SET BEDTypeName = 'BED SIDES: Standard Side Bed', SM_BedSides = 'BED SIDES: Standard Side Bed'
 WHERE mfrlabelnew in ('5th Wheel Trailer Hitch Leg Kit') and BEDTypeName is Null


UPDATE [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
 SET SM_BEDSTYLE = Case 
 when exppartno in ('16022') Then 'BED STYLE: 6 ft 4 in. Standard Bed'
 when exppartno in ('16073') Then 'BED STYLE: 8 ft 2 in. Long Bed'
 when exppartno in ('16685') Then 'BED STYLE: 6 ft 4 in. Standard Bed'
 when exppartno in ('16029') Then 'BED STYLE: 8 ft 2 in. Long Bed'
 when exppartno in ('16031') Then 'BED STYLE: 8 ft 2 in. Long Bed'
 when exppartno in ('16034') Then 'BED STYLE: 8 ft 2 in. Long Bed'
 when exppartno in ('16424') Then 'BED STYLE: 8 ft 2 in. Long Bed'
 when exppartno in ('16302') Then 'BED STYLE: 8 ft Long Bed'
 else SM_BEDSTYLE end
 WHERE SM_BEDSTYLE is Null


----  FROM DELAN  ----  UPDATE NULL BEDLENGTHS ----
--ExppartNo   -		   SM_BEDSTYLE:
--16027		-  IGNORE
--16029		-  BED STYLE: 8 ft 2 in. Long Bed
--16031		-  BED STYLE: 8 ft 2 in. Long Bed
--16034		-  BED STYLE: 8 ft 2 in. Long Bed
--16424		-  BED STYLE: 8 ft 2 in. Long Bed
--16302		-  BED STYLE: 8 ft Long Bed  


---- CORRECTION FOR  16300	--  BED STYLE: 5 ft 6 in. Short Bed | 6 ft 6 in. Standard Bed | 8ft Long Bed

DELETE From [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
where exppartno in ('16300') and Singleyear in ('2005','2006','2007','2008') 
and engbase not in ('V8 - 5.4L - GAS') and bedlength is null

DELETE From [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
where exppartno in ('16300') and Singleyear in ('2008') 
and submodelname in ('Limited') and bedlength is null


 INSERT INTO  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
  SELECT distinct 
    [dcicode],	[brandaaiaid], [company], [fromyear], [toyear],	[SingleYear],
    [makename],	[modelname], [submodelname], [engbase], [fueltype], [drivetype],
    'BED STYLE: 5 ft 6 in. Short Bed' as [BedLength],				
	[BedTypeName], [bodynumdoor], [bodytype], [note1], [Note2],  [note3], [note4],    
	[qtyper], [partterminologyname], [SubModelGuide], [position],    
	[exppartno], [mfrlabel], [mfrlabelnew], deleted,             
	[Height], [Width], [Depth],	[ActualWeight], [ShippingWeight], [WeightUnit],    
	[UPCCode], [LongDesc], [ShortDesc],	[MktDesc], [ExtDesc],		
	[ImageHiResURL1], [ImageHiResURL2],	[ImageHiResURL3],    
	[ImageHiResURL4], [ImageHiResURL5], [ImageHiResURL6], [LogoURL],    
	[WarrantyURL], [InstallationURL], [VideoURL1],	[VideoURL2],
    [VideoURL3], [Prop65URL],  [fitmentNote], [apqidstring],    
	[pqidstring], [SM_LDHeight], [SM_Color], [SM_Finish],    
	[SM_Position],	[SM_Style], [SM_Diameter], [SM_SoldAs],
    [SM_SeatType],	[productQualifier], [productQualifierShort],	
	[vqidstring], [vehicleQualifier], [SM_BedSides], 
	'BED STYLE: 5 ft 6 in. Short Bed' as [SM_BedStyle], 	[SM_BodyStyleON],    
	[SM_BodyStyle],	[SM_Transmission], [SM_CabStyle], [SM_DoorNum],    
	[SM_DriveWheel], [SM_SeatRows], [SM_StowAndGo],	 [SmartWord],
    [Submodel1], [Submodel2],  [Submodel3], [Submodel4], [Submodel5],	
	[Submodel6], CURRENT_TIMESTAMP as [LastUpdated] 
    FROM  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
	where exppartno in ('16300') and bedlength is null
	and Singleyear in ('2005','2006','2007','2008','2009','2010','2011') 


 INSERT INTO  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
  SELECT distinct 
    [dcicode],	[brandaaiaid], [company], [fromyear], [toyear],	[SingleYear],
    [makename],	[modelname], [submodelname], [engbase], [fueltype], [drivetype],
    'BED STYLE: 6 ft 6 in. Standard Bed' as [BedLength],				
	[BedTypeName], [bodynumdoor], [bodytype], [note1], [Note2],  [note3], [note4],    
	[qtyper], [partterminologyname], [SubModelGuide], [position],    
	[exppartno], [mfrlabel], [mfrlabelnew], deleted,             
	[Height], [Width], [Depth],	[ActualWeight], [ShippingWeight], [WeightUnit],    
	[UPCCode], [LongDesc], [ShortDesc],	[MktDesc], [ExtDesc],		
	[ImageHiResURL1], [ImageHiResURL2],	[ImageHiResURL3],    
	[ImageHiResURL4], [ImageHiResURL5], [ImageHiResURL6], [LogoURL],    
	[WarrantyURL], [InstallationURL], [VideoURL1],	[VideoURL2],
    [VideoURL3], [Prop65URL],  [fitmentNote], [apqidstring],    
	[pqidstring], [SM_LDHeight], [SM_Color], [SM_Finish],    
	[SM_Position],	[SM_Style], [SM_Diameter], [SM_SoldAs],
    [SM_SeatType],	[productQualifier], [productQualifierShort],	
	[vqidstring], [vehicleQualifier], [SM_BedSides], 
	'BED STYLE: 6 ft 6 in. Standard Bed' as [SM_BedStyle], 	[SM_BodyStyleON],    
	[SM_BodyStyle],	[SM_Transmission], [SM_CabStyle], [SM_DoorNum],    
	[SM_DriveWheel], [SM_SeatRows], [SM_StowAndGo],	 [SmartWord],
    [Submodel1], [Submodel2],  [Submodel3], [Submodel4], [Submodel5],	
	[Submodel6], CURRENT_TIMESTAMP as [LastUpdated] 
    FROM  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
	where exppartno in ('16300') and bedlength is null
	and Singleyear in ('2005','2006','2007','2008','2009','2010','2011') 


UPDATE  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
  Set  BedLength = 'BED STYLE: 8ft Long Bed', SM_BEDSTYLE = 'BED STYLE: 8ft Long Bed'
	where exppartno in ('16300') and bedlength is null
	and Singleyear in ('2005','2006','2007','2008','2009','2010','2011') 
	

---- CORRECTION For  16441	--  BED STYLE: 6 ft 6 in. Standard Bed | 8ft Long Bed

DELETE From [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
where exppartno in ('16441') and Singleyear in ('2005','2006','2007') 
and engbase not in ('V8 - 5.4L - GAS') and bedlength is null

DELETE From [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
where exppartno in ('16441') and Singleyear in ('2006') 
and submodelname in ('XL') and bedlength is null



 INSERT INTO  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
  SELECT distinct 
    [dcicode],	[brandaaiaid], [company], [fromyear], [toyear],	[SingleYear],
    [makename],	[modelname], [submodelname], [engbase], [fueltype], [drivetype],
    'BED STYLE: 6 ft 6 in. Standard Bed' as [BedLength],				
	[BedTypeName], [bodynumdoor], [bodytype], [note1], [Note2],  [note3], [note4],    
	[qtyper], [partterminologyname], [SubModelGuide], [position],    
	[exppartno], [mfrlabel], [mfrlabelnew], deleted,             
	[Height], [Width], [Depth],	[ActualWeight], [ShippingWeight], [WeightUnit],    
	[UPCCode], [LongDesc], [ShortDesc],	[MktDesc], [ExtDesc],		
	[ImageHiResURL1], [ImageHiResURL2],	[ImageHiResURL3],    
	[ImageHiResURL4], [ImageHiResURL5], [ImageHiResURL6], [LogoURL],    
	[WarrantyURL], [InstallationURL], [VideoURL1],	[VideoURL2],
    [VideoURL3], [Prop65URL],  [fitmentNote], [apqidstring],    
	[pqidstring], [SM_LDHeight], [SM_Color], [SM_Finish],    
	[SM_Position],	[SM_Style], [SM_Diameter], [SM_SoldAs],
    [SM_SeatType],	[productQualifier], [productQualifierShort],	
	[vqidstring], [vehicleQualifier], [SM_BedSides], 
	'BED STYLE: 6 ft 6 in. Standard Bed' as [SM_BedStyle], 	[SM_BodyStyleON],    
	[SM_BodyStyle],	[SM_Transmission], [SM_CabStyle], [SM_DoorNum],    
	[SM_DriveWheel], [SM_SeatRows], [SM_StowAndGo],	 [SmartWord],
    [Submodel1], [Submodel2],  [Submodel3], [Submodel4], [Submodel5],	
	[Submodel6], CURRENT_TIMESTAMP as [LastUpdated] 
    FROM  [ReadyForCustomization].[dbo].[RFC_CUR_2022-07]
	where exppartno in ('16441') and bedlength is null
	and Singleyear in ('2005','2006','2007') 



---------------------------------------------------------------------
---- 3) BushWacker  ----- BUS - BDMQ ------

DCI Procedure_1 : 0:40 min
DCI Procedure_2 : 4:37 min		--- DROPDowns DONE
DCI Procedure_3 : 0:32 min

---- Total Record: 171,665 ,  Total SKU: 841  [ NO NEW SKU ]
---- Mfrlabel SKU Count: 852 


UPDATE [ReadyForCustomization].[dbo].[RFC_BUS_2022-07]
set makename = Null , modelname = Null , submodelname = Null 
where SingleYear is Null

UPDATE [ReadyForCustomization].[dbo].[RFC_BUS_2022-07]
set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, Submodel4 = NULL 
where SingleYear is Null


---- RESET Submodel1 and Submodel2 to NULL for 'Fender Flares' PartTerm. Reran the Brand.



EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_BUS_2022-07'   
--- 0:10 min

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_BUS_2022-07'
--- Unique SKU Count is 10 for FITMENT Products  [ 0:30 Mins ]


EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_BUS_2022-07'
---  ZERO Deadends    [ 0:29 Mins ]


----  ANALYSIS / CHECKLIST ----   

--select distinct  exppartno, mfrlabel, mfrlabelnew, makename
--select distinct  exppartno, mfrlabel, mfrlabelnew, Note1, Note2, Note3
--select distinct  mfrlabelnew, mfrlabel
--select distinct  submodel1, submodel2, submodel3
--select distinct mktdesc, extdesc
select distinct exppartno, mfrlabelnew, Note1, Note3, Note2
--select top 100 * 
 from [ReadyForCustomization].[dbo].[RFC_BUS_2022-07] 
	 Order by 3








--------------------------------------------------------
----- 4)  Spyder Auto  --  'SPY'    - 'FCLH'  ---------
SELECT * From AAIA Where Brand Like '%Spyder%'     -- 'SPY'  - 'FCLH' / 273 ManuID
SELECT * From mfrlabel  Where aaia = 'FCLH'		-- 3,265 Sku's ( OLD Brand )


DCI Procedure_1 : 0:52 min
DCI Procedure_2 : 6:06 min		--- DROPDowns DONE
DCI Procedure_3 : 0:52 min

---- Total Record: 313,347 ,  Total SKU: 2,303  [ NO NEW SKU ]
---- Mfrlabel SKU Count: 3,265 

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_SPY_2022-07] 
where exppartno not in (
select distinct SKU from Gravy.dbo.Mfrlabel where aaia = 'FCLH' )


SELECT count(*) From  [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]   -- 313,367 Records
  --where submodel3 is not Null
--  where mfrlabel in ('Tail Light Assembly') order by Makename
--SELECT distinct mfrlabel, mfrlabelnew  From mfrlabel  Where aaia = 'FCLH' order by mfrlabelnew

--select * from [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]
--  Where SingleYear is Null  and makename is not null

----  START of DML Script  ---------

UPDATE [ReadyForCustomization].[dbo].[RFC_SPY_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	   fromyear= NULL, toyear = NULL    
     Where SingleYear is Null and makename is not null

UPDATE [ReadyForCustomization].[dbo].[RFC_SPY_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   
   Where SingleYear is Null  and Submodel1 is Not Null


---- REDUCE UNIQUE SKU COUNT from 20 --   ADD DropDown  -- Chevrolet, GMC, Ram, Ford 

select distinct Note1,Note2,Note3 from [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]
	where mfrlabelnew in ('Tail Light Assembly')

select distinct submodel1, submodel2  from [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]
	where mfrlabelnew in ('Tail Light Assembly')


--- UPDATE [ReadyForCustomization].[dbo].[RFC_SPY_2022-07] 
--- set Note1= Trim(Note1), Note2= Trim(Note2), Note3= Trim(Note3), Note4= Trim(Note4)


--  ---------  FILL  SubModel2  Finish ---------------------
  UPDATE [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]  Set Submodel2 = case
  when Note1 like '%Red Clear%' then 'Finish: Red Clear'
  when Note1 like '%Red/Clear%' then 'Finish: Red Clear'
  when Note1 like '%Red/Smoke%' then 'Finish: Red Smoke'
  when Note1 like '%Red Smoke%' then 'Finish: Red Smoke'
  when Note1 like '%Black Smoke%' then 'Finish: Black Smoke'
  when Note1 like '%Smoke%' then 'Finish: Black Smoke'
  when Note1 like '%Black%' then 'Finish: Black'
  when Note1 like '%Chrome%' then 'Finish: Chrome'
  Else Submodel2 End
    Where  (mfrlabelnew in ('Tail Light Assembly') and Makename in ('Ram','Chevrolet',
	'GMC','Ford')) OR (mfrlabelnew in ('XTune Tail Light Assembly') and Makename in ('GMC')) 

UPDATE [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]  Set Submodel2 = case
   When exppartno in ('9032004','9028779') then 'Finish: Chrome And Red Clear'
   When exppartno in ('') then 'Finish: Chrome And Red Smoke'
   When exppartno in ('') then 'Finish: Chrome And Red Smoke'
   When exppartno in ('9033100','9031915','9031922','9031991','9032028','9033087',
							'9033094') 	then 'Finish: Chrome And Red Clear'
   Else Submodel2 End
   Where  mfrlabelnew in ('XTune Tail Light Assembly') and Makename in ('GMC')



EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_SPY_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_SPY_2022-07'
--- Unique SKU Count is now 11  for 'Tail Light Assembly'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_SPY_2022-07'
----  ZERO DEADENDS


----------  END Of DML Script -----------------

-----  ANALYSIS -- CHECKLIST  -------

--select distinct  mfrlabelnew
select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
	 from [ReadyForCustomization].[dbo].[RFC_SPY_2022-07]
	 --Where exppartno in ('5015372','5075192','9042270','9046964','9047343','9948473')
	 Order by 5

--select distinct  mfrlabelnew,Note1, Note2,Note3, submodel1, submodel2, submodel3





----------------------------------------------------------------

SELECT COUNT(*) FROM  [ReadyForCustomization].[dbo].[RFC_SPY_2022-07] 


-------------------------------------------
----- K&N : ----  KNE -- BBWQ  ----

SELECT * From AAIA Where Brand Like '%K&N%'     -- 'KNE'  - 'BBWQ'
SELECT * From mfrlabel  Where aaia = 'BBWQ'		-- 4,495 Sku's in Mfrlabel ( OLD Brand )
  order by sku

SELECT  count(*)  From  [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]   -- 292,691 Records
  --where submodel3 is not Null
  --where mfrlabel in ('Tail Light Assembly') order by Makename
SELECT *  From mfrlabel  Where aaia = 'BBWQ' order by mfrlabel, sku

---- Total SKU in RFC -  3,528  (NO NEW SKU )

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel where aaia = 'BBWQ' )


-----  START OF DML Script  -------------------

UPDATE [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	  fromyear= NULL, toyear = NULL   
	  Where SingleYear is Null and makename is not null

UPDATE [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null

INSERT INTO [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]  
  SELECT distinct   dcicode,    brandaaiaid,   company,
    null as fromyear,    null as toyear,   Null as SingleYear,
    Null as makename,    Null as modelname,  Null as submodelname,
    Null as engbase,   Null as fueltype,    Null as drivetype,   
	Null as BedLength,  Null as BedTypeName,   Null as bodynumdoor,
     Null as  bodytype,   Note1,   NULL as Note2, 	note3,  
	 Null as  note4,  qtyper,	partterminologyname,   SubModelGuide,
	 position,   exppartno,   mfrlabel,   mfrlabelnew,  deleted, 
	 Height,    Width,   Depth,  ActualWeight,   ShippingWeight, 
	 WeightUnit,	UPCCode,   LongDesc,   ShortDesc,
    MktDesc,   ExtDesc,   ImageHiResURL1,  ImageHiResURL2,
	ImageHiResURL3,   ImageHiResURL4,   ImageHiResURL5,  
	ImageHiResURL6,    LogoURL,    WarrantyURL,
    InstallationURL,    VideoURL1,    VideoURL2,
    VideoURL3,    null as Prop65URL,    null as fitmentNote,
    null as apqidstring,    null as pqidstring,    SM_LDHeight,
    SM_Color,    SM_Finish,     SM_Position,
    null as SM_Style,    null as SM_Diameter,    SM_SoldAs,
    null as SM_SeatType,    productQualifier,	productQualifierShort, 
	null as vqidstring,   null as vehicleQualifier,   null as SM_BedSides,
    null as SM_BedStyle,    null as SM_BodyStyleON,    null as SM_BodyStyle,
    null as SM_Transmission,    null as SM_CabStyle,    Null as SM_DoorNum, 
	Null as SM_DriveWheel,    null as SM_SeatRows,    null as SM_StowAndGo,
	SmartWord,    null as Submodel1,    null as Submodel2,  
	null as Submodel3,    null as Submodel4,    null as Submodel5, 
	null as Submodel6,    CURRENT_TIMESTAMP as LastUpdated 
	from  [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]  
	where  exppartno  in ('RU-5065XD','RE-0961')		  ---- INSERT UNIVERSAL Records

DELETE From  [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
    Where exppartno  in ('RU-5065XD','RE-0961') and  SingleYear is NOT NULL


UPDATE [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
   SET Note2  = TRIM(Replace(Note2, tmp.value, ''))
   from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
     Cross Apply ( Select value from STRING_SPLIT(Note2, ';')) as tmp 
    where tmp.value like '%CARB E.O%'


UPDATE [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
   set Note2 = Trim(Substring(Note2, 2, len(Note2)))
   Where Note2 like ';%'

UPDATE [ReadyForCustomization].[dbo].[RFC_KNE_2022-07] 
   set Note2 = Null    Where Note2 = ''


-----------  REDUCE 23 DEADENDS  ----  DELETE REDUNDANT DATA  ----------

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Blackhawk Air Induction Kit') and Exppartno in ('71-1561')
  and Singleyear in ('2019') and submodel1 in ('SLT') and Submodel2 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Throttle Control Module') and Exppartno in ('20-2599')
  and Singleyear in ('2019') and submodel1 in ('SLT','ST','Tradesman') and Submodel2 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Performance Induction Kit') and Exppartno in ('77-1561KP')
  and Singleyear in ('2019') and submodel1 in ('SLT') and Submodel2 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Oil Filter') and Exppartno in ('HP-7023','HP-7038')
  and Singleyear in ('2018') and Modelname in ('LS500','A6') and Submodel1 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Oil Filter') and Exppartno in ('HP-7037')
  and Singleyear in ('2019') and Modelname in ('MKZ') and Submodel1 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Cabin Air Filter') and Exppartno in ('VF8000','VF8001')
  and Singleyear in ('2019') and Modelname in ('M2 112') and Submodel1 is NULL

DELETE From [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
  Where mfrlabelnew in ('Performance Gold Oil Filter') and Exppartno in ('HP-2011')
  and Singleyear in ('2020') and Modelname in ('Explorer') and Submodel1 is NULL





EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_KNE_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_KNE_2022-07'
--- Unique SKU Count is now 5 for '57i Series Induction Kits'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_KNE_2022-07'
----  ZERO DEADENDS

 
-------  END OF DML SCRIPT  -----------------
----------  Data ANALYSIS / Checklist ---- 

-----  ANALYSIS -- CHECKLIST  -------
--select distinct  mfrlabelnew
select distinct  exppartno, Note1
--select distinct  exppartno, Note2
--select distinct  submodel1,submodel2,submodel3
	 from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 2


------  CHECK MIX OF UNIVERSAL AND FITMENT SKU'S ----
select distinct mfrlabelnew  from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]  
  where singleyear is null and mfrlabelnew in
( select distinct mfrlabelnew  from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]  
  where singleyear is not null )  order by 1

-- K&N has 5 Products ( Mixing of UNIV and Fitment SKU )
 Select distinct mfrlabelnew, mfrlabel, makename, Exppartno 
	from [ReadyForCustomization].[dbo].[RFC_KNE_2022-07]  
	where mfrlabelnew in ('Air Filters',
	 'Universal Air Filters')  Order by 1,3,2



--------------------------------------------------------



-------------------------------------------------------
------ FABFOURS  ---  FBF -- DKSN -------

SELECT * From AAIA Where Brand Like '%Fox%'     -- 'FBF'  - 'DKSN'
SELECT * From mfrlabel  Where aaia = 'DKSN'		-- 1,975 Sku's ( OLD Brand )

---- Total 163,313 Records ;  Distinct SKU: 1,429  [ NO NEW SKU ]
SELECT count(*) From [ReadyForCustomization].[dbo].[RFC_FBF_2022-07]   

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel 
  where aaia = 'DKSN' )


--------  Main DML Script  ----- 

----  UPDATE Mfrlabelnew  --

UPDATE  [ReadyForCustomization].[dbo].[RFC_FBF_2022-07]
    SET  MFRLABELNew = T2.MFRLABELNew
	FROM  [GRAVY].[dbo].MFRLABEL T2  INNER JOIN 
	[ReadyForCustomization].[dbo].[RFC_FBF_2022-07] T1  
	ON T1.EXPPARTNO = T2.SKU    WHERE T2.AAIA = 'DKSN'


UPDATE [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	    fromyear= NULL, toyear = NULL    
   Where SingleYear is Null and Makename is not Null

UPDATE [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null


UPDATE [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
   set Note1 =  Trim(Replace(Note1, '[AWSL];', ''))
   Where Note1 like '%AWSL%'

----  UNique SKU Count 18 -----

UPDATE [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
   set Submodel2 =  case
   When Note3 like '%: Black Powder Coated%' then 'Color: Black Powder Coated'
   When Note3 like '%: Black%' then 'Color: Black'
   When Note3 like '%: Paintable%' then 'Color: Paintable'
   When Note3 like '%: Plate Steel%' then 'Color: Plate Steel'
   Else Submodel2 End
  Where mfrlabelnew in ('Premium Winch Front Bumper') 
  and Singleyear in ('2022') and submodel1 in ('Base')


  ---------  Handle 2 DEADENDS  --------

UPDATE [ReadyForCustomization].[dbo].[RFC_FBF_2022-07] 
   set Note2 = Trim(Note4) ,  Submodel2 = Null
   Where mfrlabelnew in ('Side Step') and singleyear in ('2013') 
   and exppartno in ('J1024') and modelname in ('4500') and Submodel1 in ('Tradesman')
    and Note4 is Not Null

--Select * From  [ReadyForCustomization].[dbo].[RFC_FBF_2022-07]
--  Where mfrlabelnew in ('Side Step') and singleyear in ('2013') 
--  and exppartno in ('J1024') and modelname in ('4500') and Submodel1 in ('Tradesman')



EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_FBF_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_FBF_2022-07'
---- Unique SKU Count Reduced to 12 

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_FBF_2022-07'
----  ZERO DEADENDS  --


---------  ANALYSIS /  CHECKLIST  -----------

select distinct  exppartno, mfrlabelnew, MAKENAME
--select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
--select distinct  exppartno, Note1, Note2, Note3
--select distinct   mfrlabelnew
--select distinct submodel1, submodel2,submodel3
 select distinct  exppartno, mfrlabel, mfrlabelnew
	 from [ReadyForCustomization].[dbo].[RFC_FBF_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 3



-------------------------------------------------------
------ BACKRACK  ---  BAC -- BKHJ -------

SELECT * From AAIA Where Brand Like '%BACK%'     -- 'BAC'  - 'BKHJ'  (MANU id: 12 )
SELECT * From mfrlabel  Where aaia = 'BKHJ'		-- 307 Sku's ( OLD Brand )

---- Total 331,177 Records ;  Distinct SKU: 297  [ NO NEW SKU ]
SELECT count(*) From [ReadyForCustomization].[dbo].[RFC_BAC_2022-07]   

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_BAC_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel 
  where aaia = 'BKHJ' )


--------  Main DML Script  ----- 

UPDATE [ReadyForCustomization].[dbo].[RFC_BAC_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	    fromyear= NULL, toyear = NULL    
   Where SingleYear is Null and Makename is not Null

UPDATE [ReadyForCustomization].[dbo].[RFC_BAC_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null


   ------  RESET Submodel2 (BEDSTYLE Info Missing For Many SKU). Headache Racks Don't Need BedStyle Dropdown.
UPDATE [ReadyForCustomization].[dbo].[RFC_BAC_2022-07] 
   set Submodel2 = NUll
   where Partterminologyname in ('Truck Cab Protector/Headache Rack')

UPDATE [ReadyForCustomization].[dbo].[RFC_BAC_2022-07] 
   set Submodel1 = 'The 60Th Anniversary Edition'
   where Submodel1 in ('THE 60TH ANNIVERSARY EDITION')



EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_BAC_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_BAC_2022-07'
---- Unique SKU Count 8  ----

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_BAC_2022-07'
---- ZERO  DEADENDS  ----


-------------  ANALYSIS  -------------------------------

---------  ANALYSIS /  CHECKLIST  -----------

--select distinct  exppartno, mfrlabelnew, MAKENAME
--select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
select distinct  exppartno, Note1, Note2, Note3
--select distinct   mfrlabelnew
--select distinct submodel1, submodel2,submodel3
	 from [ReadyForCustomization].[dbo].[RFC_BAC_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 4




-------------------------------------------------------
------ BD DIESEL  ---  BDD -- BKJX -------

SELECT * From AAIA Where Brand Like '%Diesel%'     -- 'BDD'  - 'BKJX'  (Manu ID: 438)
SELECT * From mfrlabel  Where aaia = 'BKJX'		-- 1,178 Sku's ( OLD Brand )

---- Total 98,979 Records ;  Distinct SKU: 889  [ NO NEW SKU ]
SELECT count(*) From [ReadyForCustomization].[dbo].[RFC_BDD_2022-07]   

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel 
  where aaia = 'BKJX' )


--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel1 = 'Submodelname' 
--  WHERE Partterminologyname in ('Auto Trans Filter Adapter Bolt',
--  'Exhaust Brake Controler Bracket', 'Turbocharger Actuator')

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel2 = 'Engbase'
--  WHERE Partterminologyname in ('Exhaust Brake Controler Bracket', 'Turbocharger Actuator')


--------  Main DML Script  ----- 

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	    fromyear= NULL, toyear = NULL    
   Where SingleYear is Null and Makename is not Null

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null

-------------------   HANDLE 38 Deadends  -------------

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL
   Where mfrlabelnew in ('Throttle Sensitivity Booster','Air Intake Shutdown Harness',
     'Throttle Sensitivity Booster Push Button Switch Kit')

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Submodel1 = Submodelname
   Where mfrlabelnew in ('Throttle Sensitivity Booster','Air Intake Shutdown Harness',
     'Throttle Sensitivity Booster Push Button Switch Kit')


UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Submodel3 = NULL
   Where mfrlabelnew in ('Transmission Kit')

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Submodel3 = Case
   when drivetype like '%Rear Wheel Drive%' then 'Rear Wheel Drive' 
   when drivetype like '%4 Wheel Drive%' then '4 Wheel Drive' 
   Else Submodel3 END
  Where mfrlabelnew in ('Transmission Kit')
   and SingleYear in ('2005','2006','2007','2003','2004')
	and Makename in ('Dodge') and Modelname in ('Ram 2500', 'Ram 3500')


UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   SET Note2  = TRIM(Replace(Note2, tmp.value, ''))
   from [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
     Cross Apply ( Select value from STRING_SPLIT(Note2, ';')) as tmp 
    where tmp.value like '%CARB E.O%'

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Note2 = Trim(Substring(Note2, 2, len(Note2)))
   Where Note2 like ';%'

UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Note2 = Null    Where Note2 = ''

 UPDATE  [ReadyForCustomization].[dbo].[RFC_BDD_2022-07]
    SET  Submodel3 = NULL
   where Submodel3 in ('FLEX', 'GAS', 'DIESEL') 


UPDATE [ReadyForCustomization].[dbo].[RFC_BDD_2022-07] 
   set Note2 = Trim(Replace(Note2, '<li> Not For Sale on Licensed California Vehicles</li>', ''))
   Where Note2 like '%<li> Not For Sale on Licensed California Vehicles</li>%'


-------------------------------------------------------

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_BDD_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_BDD_2022-07'
---- Unique SKU Count 11  for 'Iron Horn Turbocharger Kit'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_BDD_2022-07'
----  Now ZERO DEADENDS  --


---------  ANALYSIS /  CHECKLIST  -----------

--select distinct  exppartno, mfrlabelnew, MAKENAME
--select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
select distinct  exppartno, Note3
--select distinct   mfrlabelnew
--select distinct submodel1, submodel2,submodel3
	 from [ReadyForCustomization].[dbo].[RFC_BDD_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 2



--select * from  [ReadyForCustomization].[dbo].[RFC_BDD_2022-07]
--  Where mfrlabelnew in ('Transmission Kit')
--   and SingleYear in ('2005', '2006', '2007','2003', '2004')
--	and Makename in ('Dodge') and Modelname in ('Ram 2500', 'Ram 3500')
--   order by singleyear, makename, modelname, submodel1






-------------------------------------------------------
------ FORD RACING  ( NOT PERFORMANCE ) ---  FDR  --  BDXX  -------

SELECT * From AAIA Where Brand Like '%FORD%'     -- 'FDR'  - 'BDXX'  (Manu ID: 435)
SELECT * From mfrlabel  Where aaia = 'BDXX'		-- 1,696 Sku's ( OLD Brand )

---- Total 265,079 Records ;  Distinct SKU: 967  [ NO NEW SKU ]
SELECT count(*) From [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]   

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel 
  where aaia = 'BDXX' )

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel1 = 'Submodelname' 
--  WHERE Partterminologyname in ('Accelerator Pedal Kit','Aero Splitter Kit', 'Drive Motor',
--  'Clutch Fork Pivot', 'Performance Module Dongle', 'Supercharger Kit', 'A/C Liquid Line Assembly')

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel2 = 'Engbase'
--  WHERE Partterminologyname in ('Accelerator Pedal Kit', 'Supercharger Kit',
--  'Clutch Fork Pivot', 'Performance Module Dongle', 'Drive Motor', 'A/C Liquid Line Assembly')

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel1 = 'Engbase'  WHERE Partterminologyname in ('Axle Spindle Splash Shield')


--------  Main DML Script  ----- 

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	    fromyear= NULL, toyear = NULL    
   Where SingleYear is Null and Makename is not Null

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null


UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   SET Note2  = TRIM(Replace(Note2, tmp.value, ''))
   from [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
     Cross Apply ( Select value from STRING_SPLIT(Note2, ';')) as tmp 
    where tmp.value like '%CARB E.O%'

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Note2 = Trim(Substring(Note2, 2, len(Note2)))
   Where Note2 like ';%'

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Note2 = Null    Where Note2 = ''

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Submodel1 = 'The 60Th Anniversary Edition'
   where Submodel1 in ('THE 60TH ANNIVERSARY EDITION')

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Submodel2 = 'Body Style: Coupe (2 Door)'
   where Submodel2 in ('BODY STYLE: Coupe (2 Door)')

UPDATE [ReadyForCustomization].[dbo].[RFC_FDR_2022-07] 
   set Submodel2 = 'Cab Style -Light Truck: Crew Cab'
   where Submodel2 in ('CAB STYLE -LIGHT TRUCK: Crew Cab')


 --------------  HANDLE  625  DEADENDS   ------------------

 UPDATE  [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]
    SET  Submodel2 = NULL
   where mfrlabel in ('Service Part Replacement Dongle')
     and  exppartno in ('CM-CANELOPE-B')

 UPDATE  [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]
    SET  Submodel1 = Submodelname
   where mfrlabel in ('Axle Knuckle Seal Shield') 

 UPDATE  [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]
    SET  Submodel3 = NULL
   where Submodel3 in ('FLEX', 'GAS') 


DELETE From  [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]  --  REMOVE DECAL Product
    where mfrlabel in ('Ranger Windshield Decal') 

-----------------------------------------

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_FDR_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_FDR_2022-07'
---- Unique SKU Count 10

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_FDR_2022-07'
---- Now  ZERO  DEADENDS  --


---------  ANALYSIS /  CHECKLIST  -----------

-- select distinct  exppartno, mfrlabelnew, MAKENAME
--select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
select distinct exppartno, mfrlabelnew, Note1, Note2, Note3
--select distinct   mfrlabelnew
--select distinct  submodel1, submodel2, submodel3
	 from [ReadyForCustomization].[dbo].[RFC_FDR_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 5



----------------------------------------------------------------
------ BANKS POWER    ---  BKP --  BKQC  -------

SELECT * From AAIA Where Brand Like '%BANKS POWER%'     -- 'BKP'  - 'BKQC'  (Manu ID: 434)
SELECT * From mfrlabel  Where aaia = 'BKQC'		-- 1,356 Sku's ( OLD Brand )

---- Total 136,284 Records ;  Distinct SKU: 1,102  [ NO NEW SKU ]
SELECT count(*) From [ReadyForCustomization].[dbo].[RFC_BKP_2022-07]   

select COUNT(DISTINCT exppartno) from [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
 where exppartno not in ( select distinct SKU from Gravy.dbo.Mfrlabel 
  where aaia = 'BKQC' )

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel1 = 'Submodelname' 
--  WHERE Partterminologyname in ('Accelerator Pedal Kit','Aero Splitter Kit', 'Drive Motor',
--  'Clutch Fork Pivot', 'Performance Module Dongle', 'Supercharger Kit', 'A/C Liquid Line Assembly')

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel2 = 'Engbase'
--  WHERE Partterminologyname in ('Accelerator Pedal Kit', 'Supercharger Kit',
--  'Clutch Fork Pivot', 'Performance Module Dongle', 'Drive Motor', 'A/C Liquid Line Assembly')

--UPDATE [TEST_DCI_PLAT].[dbo].[DEF_ParttermToSubModel]
--  SET Submodel1 = 'Engbase'  WHERE Partterminologyname in ('Axle Spindle Splash Shield')


--------  Main DML Script  ----- 

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set  makename = Null ,  modelname = Null , submodelname = Null,
	    fromyear= NULL, toyear = NULL    
   Where SingleYear is Null and Makename is not Null

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel1 = NUll, Submodel2 = NULL, Submodel3 = NULL, 
   Submodel4 = NULL, Submodel5 = Null, Submodel6 = NULL   Where SingleYear is Null


UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel1 = submodelname
   Where mfrlabelnew in ('Sway Bar Spacer Kit','Pedal Monster Kit')

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel2 = NULL
   Where mfrlabelnew in ('Pillar Mount Instrument Console','Pedal Monster Kit')


UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel3 = Case 
   when Note1 like '%Blk CoatedTip%'  then  'Black Coated Tips'
   when Note1 like '%Blk Coated Tip%'  then  'Black Coated Tips'
   when Note1 like '%Black Coated Tip%'  then  'Black Coated Tips'
   when Note1 like '%Black Tip%'  then  'Black Coated Tips'
   when Note1 like '%Pol. Tip%'  then  'Polished Tips'
   when Note1 like '%Polished Tip%'  then  'Polished Tips'
   when exppartno in ('48801','48842','48843','49144','49475','49476','49145','49157','49159','49495')
								then 'Polished Tips'
   when exppartno in ('47541')  then  'Crome Tips'
   Else Submodel3 End
  Where mfrlabelnew in ('PowerPack System') and makename in ('Ford')
    and Singleyear in ('2000','2001','2002','2003','2004','1999','1993','1989')


--Select distinct exppartno, submodel3, Note1
--  from  [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
--  Where mfrlabelnew in ('PowerPack System') and makename in ('Ford')
--    and Singleyear in ('2000','2001','2002','2003','2004','1999','1993','1989')
--	order by 2

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   SET Note2  = TRIM(Replace(Note2, tmp.value, ''))
   from [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
     Cross Apply ( Select value from STRING_SPLIT(Note2, ';')) as tmp 
    where tmp.value like '%CARB E.O%'

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Note2 = Trim(Substring(Note2, 2, len(Note2)))
   Where Note2 like ';%'

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Note2 = Null    Where Note2 = ''


UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Note1 = Trim(Replace(Replace(Replace(Note1, 'Available While Supplies Last', ''), '[', ''),'];',''))
   Where Note1 like '%Available While Supplies Last%'

UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Note1 = Null    Where Note1 = ''


 UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel3 = Null    
   where submodel3 in ('DIESEL','GAS','CNG','LPG')


UPDATE [ReadyForCustomization].[dbo].[RFC_BKP_2022-07] 
   set Submodel1 = 'The 60Th Anniversary Edition'
   where Submodel1 in ('THE 60TH ANNIVERSARY EDITION')


---------------------------------------------

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Shift_RFC_DropDown] 'RFC_BKP_2022-07'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_UniqueSKUCount_V2(Dyanmic)] 'RFC_BKP_2022-07'
---- Now Unique SKU Count 12 for 'Monster Exhaust System', 'PowerPack System', 'Pedal Monster Kit'

EXEC [TEST_DCI_PLAT].[dbo].[Utilties_Analyze_RFC_DeadEndSelection_v2.0] 'RFC_BKP_2022-07'
----  Now  ZERO DEADENDS  --


---------  ANALYSIS /  CHECKLIST  -----------

-- select distinct  exppartno, mfrlabelnew, MAKENAME
--select distinct  exppartno, mfrlabelnew, Note1, Note2, Note3
select distinct exppartno,  Note2
--select distinct   mfrlabelnew
--select distinct  submodel1, submodel2, submodel3
	 from [ReadyForCustomization].[dbo].[RFC_BKP_2022-07]
	 --Where exppartno in ('08179', '088014','22-2020PL','33-2944','33-3082')
	 Order by 2

