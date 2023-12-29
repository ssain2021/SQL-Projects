
---------------------------------------------------------------------------
-----------   TIRES DATA  MERGE  ---- 13-SEPT-2022 -------  

Select top 1000 * from TEMPT_Distribution   -- 22,843  Records  (2260 cells dropped)

---- DROP TABLE TEMPT_Distribution

UPDATE TEMPT_NTD 
  Set UPCCODE = '''715459395156'
   where sku = '2020514'

UPDATE TEMPT_NTD 
  Set UPCCODE = Replace(Upccode, '''', '')
  Where UPCCODE like '''%'

SELECT * INTO  WTU_Tires_Data_NTD
  From TEMPT_NTD

---- DROP TABLE -- TEMPT_NTD

SELECT * INTO  WTU_Tires_Data_Distribution
  From TEMPT_Distribution_Stox

---- DROP TABLE -- TEMPT_Distribution_Stox


--SELECT * INTO  WTU_Tires_Data_MERGED
--  From WTU_Tires_Data_NTD

--INSERT INTO  WTU_Tires_Data_MERGED
--   SELECT * from WTU_Tires_Data_Distribution

select count(*) from WTU_Tires_Data_AMP	-- 63 
select count(*) from  WTU_Tires_Data_DAI  -- 525
select count(*) from  WTU_Tires_Data_Fastco   -- 6999
select count(*) from  WTU_Tires_Data_TireInv   -- 1559
Select count(*) from TEMPT_NTD   -- 232,970  Records  
Select count(distinct sku) from TEMPT_NTD   -- 13,835  Records  
Select distinct SKU  from TEMPT_NTD  --where sku = '2020514'   


--INSERT INTO  WTU_Tires_Data_MERGED
--   SELECT * from WTU_Tires_Data_AMP
--INSERT INTO  WTU_Tires_Data_MERGED
--   SELECT * from WTU_Tires_Data_DAI
--INSERT INTO  WTU_Tires_Data_MERGED
--   SELECT * from WTU_Tires_Data_Fastco
--INSERT INTO  WTU_Tires_Data_MERGED
--   SELECT * from WTU_Tires_Data_TireInv

Select Count(*) from WTU_Tires_Data_MERGED  --  264,959

---------------------   UPDATE / CLEAN  NTD  TABLE  ( REMOVE NULL TEXT )  -----------
--UPDATE WTU_Tires_Data_NTD 
-- --Set Vendor = 'NTD' 
-- Set VendorSKU = SKU

Select * from  WTU_Tires_Data_NTD
  Where ManufacturerID = 'NULL'


Select top 200 * from WTU_Tires_Data_MERGED  --  264,959
Select distinct * from WTU_Tires_Data_NTD  order by SKU  --  264,959

----SELECT *  Into  WTU_Tires_Data_NTD_Old
----  DELETE  from  --WTU_Tires_Data_NTD

  -----  REMOVED DUPLICATES..   NOW  13,903  Records  -----
  ----INSERT INTO WTU_Tires_Data_NTD
  ----  SELECT DISTINCT * from  WTU_Tires_Data_NTD_Old

select * from WTU_Tires_Data_NTD  Where [ManufacturerID] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [Manufacturer] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [Vendor] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [Model] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [SizeCode] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [Model] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [VendorSKU] = 'NULL'
select * from WTU_Tires_Data_NTD  Where [UPCCODE] = 'NULL'


select * from WTU_Tires_Data_NTD  Where [ManufacturerID] IS NULL
Select distinct [RunFlat] from WTU_Tires_Data_NTD  order by SKU  --  264,959

Select distinct [RunFlat]  From  dbo.[107Attributes_09132022]

---------  REMOVE NULL  AND INSERT INTO MERGED  TABLE -------------

UPDATE WTU_Tires_Data_NTD   SET [ManufacturerID]= NULL   Where [ManufacturerID]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [Manufacturer]= NULL   Where [Manufacturer]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [Vendor]= NULL   Where [Vendor] = 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [Model]= NULL   Where [Model]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [SKU]= NULL   Where [SKU]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [VendorSKU]= NULL   Where [VendorSKU]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [UPCCode]= NULL   Where [UPCCode]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [SizeCode]= NULL   Where [SizeCode]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TireType]= NULL   Where [TireType]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TireWidth]= NULL   Where [TireWidth]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [AspectRatio]= NULL   Where [AspectRatio]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [Construction]= NULL   Where [Construction]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [RimDiameter]= NULL   Where [RimDiameter]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TreadDepth]= NULL   Where [TreadDepth]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [UTQG]= NULL   Where [UTQG]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TreadWear]= NULL   Where [TreadWear]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TractionRating]= NULL   Where [TractionRating]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TemperatureRating]= NULL   Where [TemperatureRating]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [SeasonDesignation]= NULL   Where [SeasonDesignation]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [RunFlat]= NULL   Where [RunFlat]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [SidewallType]= NULL   Where [SidewallType]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [LoadIndexDisplay]= NULL   Where [LoadIndexDisplay]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [LoadIndex]= NULL   Where [LoadIndex]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [SpeedRating]= NULL   Where [SpeedRating]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TirePly]= NULL   Where [TirePly]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [MaxTirePressure]= NULL   Where [MaxTirePressure]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [MinRimWidth]= NULL   Where [MinRimWidth]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [MaxRimWidth]= NULL   Where [MaxRimWidth]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [OverAllTireDiameter]= NULL   Where [OverAllTireDiameter]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [style]= NULL   Where [style]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [manufacturerPartNumber]= NULL   Where [manufacturerPartNumber]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [weight]= NULL   Where [weight]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [ShippingWeight]= NULL   Where [ShippingWeight]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TireCode1]= NULL   Where [TireCode1]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TireCode2]= NULL   Where [TireCode2]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [TireCode3]= NULL   Where [TireCode3]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [loadRange]= NULL   Where [loadRange]= 'NULL'
UPDATE WTU_Tires_Data_NTD   SET [treadWearWarranty]= NULL   Where [treadWearWarranty]= 'NULL'


INSERT   INTO  DBO.[WTU_Tires_Data_MERGED]
SELECT  
	CAST(t.[ManufacturerID] as Int) as [ManufacturerID],	t.[Manufacturer] as	[Manufacturer],
	t.[Vendor] as [Vendor], 	ISNULL(t.[Model], '')  as [Model],
	ISNULL(t.[SKU], '') as [SKU],		t.[VendorSKU] as [VendorSKU],
	t.[UPCCode] as [UPCCode],	 ISNULL(t.[SizeCode], '') as [SizeCode],
	t.[TireType] as [TireType],	 CAST(ISNULL(t.[TireWidth], 0) as Float) as [TireWidth],
	t.[AspectRatio] as [AspectRatio],	t.[Construction] as  [Construction],
	CAST(ISNULL(t.[RimDiameter], 0) as Float) as [RimDiameter],	
	CAST(ISNULL(t.[TreadDepth],0) as Float) as [TreadDepth],
	t.[UTQG] as [UTQG],  	CAST(t.[TreadWear] as Int) as [TreadWear],
	t.[TractionRating] as  [TractionRating],	t.[TemperatureRating] as [TemperatureRating],
	ISNULL(t.[SeasonDesignation], '') as [SeasonDesignation],	
	ISNULL(t.[RunFlat], 'RUNFLAT') as [RunFlat],
	t.[SidewallType] as [SidewallType], 	t.[LoadIndexDisplay] as [LoadIndexDisplay],
	t.[LoadIndex] as [LoadIndex],	 t.[SpeedRating] as [SpeedRating],
	t.[TirePly] as [TirePly],	 CURRENT_TIMESTAMP as [dataSet_timestamp],
	t.[MaxTirePressure] as [MaxTirePressure], 	t.[MinRimWidth] as [MinRimWidth],
	t.[MaxRimWidth] as [MaxRimWidth],	 t.[OverAllTireDiameter] as [OverAllTireDiameter],
	t.[style] as [style],	 t.[manufacturerPartNumber] as [manufacturerPartNumber],
	CAST(t.[weight] as Float) as [weight],	 
	CAST(t.[ShippingWeight] as Float) as [ShippingWeight],
	t.[TireCode1] as [TireCode1],	t.[TireCode2] as [TireCode2],
	t.[TireCode3] as [TireCode3],	t.[loadRange] as [loadRange],
	t.[treadWearWarranty] as [treadWearWarranty]
  FROM  Gravy.dbo.[WTU_Tires_Data_NTD] t


SELECT * from  DBO.[WTU_Tires_Data_MERGED]


-----------  FOR DISTRIBUTION  TABLE  -----------------

DROP TABLE  [WTU_Tires_Data_Distribution]

Select * from  dbo.[WTU_Tires_Data_Distribution]

  ---  REMOVED DUPLICATES..   NOW  13,903  Records  -----

--Select * into dbo.[WTU_Tires_Data_Distribution_Old]
--  from [WTU_Tires_Data_Distribution]

--  DELETE from dbo.[WTU_Tires_Data_Distribution]

--  INSERT INTO dbo.[WTU_Tires_Data_Distribution]
--    SELECT  DISTINCT * from  [WTU_Tires_Data_Distribution_Old]

UPDATE dbo.[WTU_Tires_Data_Distribution]
 Set Vendor = 'Distribution'

 SELECT * from [WTU_Tires_Data_Distribution] Where model is NULL  --  124 records

--DROP TABLE  dbo.[WTU_Tires_Data_Distribution_Old]



UPDATE [WTU_Tires_Data_Distribution]   SET [ManufacturerID]= NULL   Where [ManufacturerID]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [Manufacturer]= NULL   Where [Manufacturer]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [Vendor]= NULL   Where [Vendor] = 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [Model]= NULL   Where [Model]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [SKU]= NULL   Where [SKU]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [VendorSKU]= NULL   Where [VendorSKU]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [UPCCode]= NULL   Where [UPCCode]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [SizeCode]= NULL   Where [SizeCode]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TireType]= NULL   Where [TireType]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TireWidth]= NULL   Where [TireWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [AspectRatio]= NULL   Where [AspectRatio]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [Construction]= NULL   Where [Construction]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [RimDiameter]= NULL   Where [RimDiameter]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TreadDepth]= NULL   Where [TreadDepth]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [UTQG]= NULL   Where [UTQG]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TreadWear]= NULL   Where [TreadWear]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TractionRating]= NULL   Where [TractionRating]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TemperatureRating]= NULL   Where [TemperatureRating]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [SeasonDesignation]= NULL   Where [SeasonDesignation]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [RunFlat]= NULL   Where [RunFlat]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [SidewallType]= NULL   Where [SidewallType]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [LoadIndexDisplay]= NULL   Where [LoadIndexDisplay]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [LoadIndex]= NULL   Where [LoadIndex]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [SpeedRating]= NULL   Where [SpeedRating]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TirePly]= NULL   Where [TirePly]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [MaxTirePressure]= NULL   Where [MaxTirePressure]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [MinRimWidth]= NULL   Where [MinRimWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [MaxRimWidth]= NULL   Where [MaxRimWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [OverAllTireDiameter]= NULL   Where [OverAllTireDiameter]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [style]= NULL   Where [style]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [manufacturerPartNumber]= NULL   Where [manufacturerPartNumber]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [weight]= NULL   Where [weight]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [ShippingWeight]= NULL   Where [ShippingWeight]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TireCode1]= NULL   Where [TireCode1]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TireCode2]= NULL   Where [TireCode2]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [TireCode3]= NULL   Where [TireCode3]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [loadRange]= NULL   Where [loadRange]= 'NULL'
UPDATE [WTU_Tires_Data_Distribution]   SET [treadWearWarranty]= NULL   Where [treadWearWarranty]= 'NULL'


Select distinct [TireWidth], [RimDiameter], [TreadDepth],
   [weight], [ShippingWeight]  from  [WTU_Tires_Data_Distribution]


UPDATE [WTU_Tires_Data_Distribution]
  SET  [TreadDepth] = Replace(TreadDepth, '/32', '')
    Where [TreadDepth] like '%/32'


INSERT   INTO  DBO.[WTU_Tires_Data_MERGED]
SELECT  
	CAST(t.[ManufacturerID] as Int) as [ManufacturerID],	t.[Manufacturer] as	[Manufacturer],
	t.[Vendor] as [Vendor], 	ISNULL(t.[Model], '')  as [Model],
	ISNULL(t.[SKU], '') as [SKU],		t.[VendorSKU] as [VendorSKU],
	t.[UPCCode] as [UPCCode],	 ISNULL(t.[SizeCode], '') as [SizeCode],
	t.[TireType] as [TireType],	 CAST(ISNULL(t.[TireWidth], 0) as Float) as [TireWidth],
	t.[AspectRatio] as [AspectRatio],	t.[Construction] as  [Construction],
	CAST(ISNULL(t.[RimDiameter], 0) as Float) as [RimDiameter],	
	CAST(ISNULL(t.[TreadDepth],0) as Float) as [TreadDepth],
	t.[UTQG] as [UTQG],  	CAST(t.[TreadWear] as Int) as [TreadWear],
	t.[TractionRating] as  [TractionRating],	t.[TemperatureRating] as [TemperatureRating],
	ISNULL(t.[SeasonDesignation], '') as [SeasonDesignation],	
	ISNULL(t.[RunFlat], 'RUNFLAT') as [RunFlat],
	t.[SidewallType] as [SidewallType], 	t.[LoadIndexDisplay] as [LoadIndexDisplay],
	t.[LoadIndex] as [LoadIndex],	 t.[SpeedRating] as [SpeedRating],
	t.[TirePly] as [TirePly],	 CURRENT_TIMESTAMP as [dataSet_timestamp],
	t.[MaxTirePressure] as [MaxTirePressure], 	t.[MinRimWidth] as [MinRimWidth],
	t.[MaxRimWidth] as [MaxRimWidth],	 t.[OverAllTireDiameter] as [OverAllTireDiameter],
	t.[style] as [style],	 t.[manufacturerPartNumber] as [manufacturerPartNumber],
	CAST(t.[weight] as Float) as [weight],	 
	CAST(t.[ShippingWeight] as Float) as [ShippingWeight],
	t.[TireCode1] as [TireCode1],	t.[TireCode2] as [TireCode2],
	t.[TireCode3] as [TireCode3],	t.[loadRange] as [loadRange],
	t.[treadWearWarranty] as [treadWearWarranty]
  FROM  Gravy.dbo.[WTU_Tires_Data_Distribution] t



----------------------------------------------------
-----------  FOR FASTCO  TABLE  -----------------

DROP TABLE  [WTU_Tires_Data_Fastco]

Select * from  dbo.[WTU_Tires_Data_Fastco]    -- 6,999 Records

Select * into dbo.[WTU_Tires_Data_Fastco_Old]
  from [WTU_Tires_Data_Fastco]

 ----  REMOVED DUPLICATES..   NOW  13,903  Records  -----
 --DELETE from dbo.[WTU_Tires_Data_Fastco]

 --INSERT INTO [WTU_Tires_Data_Fastco]
 --   SELECT DISTINCT * from  [WTU_Tires_Data_Fastco_Old]


UPDATE dbo.[WTU_Tires_Data_Fastco]
 Set Vendor = 'Fastco'

 SELECT * from [WTU_Tires_Data_Fastco]  Where SKU is NULL  --  124 records




UPDATE [WTU_Tires_Data_Fastco]   SET [ManufacturerID]= NULL   Where [ManufacturerID]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [Manufacturer]= NULL   Where [Manufacturer]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [Vendor]= NULL   Where [Vendor] = 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [Model]= NULL   Where [Model]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [SKU]= NULL   Where [SKU]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [VendorSKU]= NULL   Where [VendorSKU]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [UPCCode]= NULL   Where [UPCCode]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [SizeCode]= NULL   Where [SizeCode]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TireType]= NULL   Where [TireType]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TireWidth]= NULL   Where [TireWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [AspectRatio]= NULL   Where [AspectRatio]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [Construction]= NULL   Where [Construction]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [RimDiameter]= NULL   Where [RimDiameter]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TreadDepth]= NULL   Where [TreadDepth]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [UTQG]= NULL   Where [UTQG]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TreadWear]= NULL   Where [TreadWear]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TractionRating]= NULL   Where [TractionRating]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TemperatureRating]= NULL   Where [TemperatureRating]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [SeasonDesignation]= NULL   Where [SeasonDesignation]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [RunFlat]= NULL   Where [RunFlat]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [SidewallType]= NULL   Where [SidewallType]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [LoadIndexDisplay]= NULL   Where [LoadIndexDisplay]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [LoadIndex]= NULL   Where [LoadIndex]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [SpeedRating]= NULL   Where [SpeedRating]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TirePly]= NULL   Where [TirePly]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [MaxTirePressure]= NULL   Where [MaxTirePressure]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [MinRimWidth]= NULL   Where [MinRimWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [MaxRimWidth]= NULL   Where [MaxRimWidth]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [OverAllTireDiameter]= NULL   Where [OverAllTireDiameter]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [style]= NULL   Where [style]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [manufacturerPartNumber]= NULL   Where [manufacturerPartNumber]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [weight]= NULL   Where [weight]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [ShippingWeight]= NULL   Where [ShippingWeight]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TireCode1]= NULL   Where [TireCode1]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TireCode2]= NULL   Where [TireCode2]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [TireCode3]= NULL   Where [TireCode3]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [loadRange]= NULL   Where [loadRange]= 'NULL'
UPDATE [WTU_Tires_Data_Fastco]   SET [treadWearWarranty]= NULL   Where [treadWearWarranty]= 'NULL'


INSERT   INTO  DBO.[WTU_Tires_Data_MERGED]
SELECT  
	CAST(t.[ManufacturerID] as Int) as [ManufacturerID],	t.[Manufacturer] as	[Manufacturer],
	t.[Vendor] as [Vendor], 	ISNULL(t.[Model], '')  as [Model],
	ISNULL(t.[SKU], '') as [SKU],		t.[VendorSKU] as [VendorSKU],
	t.[UPCCode] as [UPCCode],	 ISNULL(t.[SizeCode], '') as [SizeCode],
	t.[TireType] as [TireType],	 CAST(ISNULL(t.[TireWidth], 0) as Float) as [TireWidth],
	t.[AspectRatio] as [AspectRatio],	t.[Construction] as  [Construction],
	CAST(ISNULL(t.[RimDiameter], 0) as Float) as [RimDiameter],	
	CAST(ISNULL(t.[TreadDepth],0) as Float) as [TreadDepth],
	t.[UTQG] as [UTQG],  	CAST(t.[TreadWear] as Int) as [TreadWear],
	t.[TractionRating] as  [TractionRating],	t.[TemperatureRating] as [TemperatureRating],
	ISNULL(t.[SeasonDesignation], '') as [SeasonDesignation],	
	ISNULL(t.[RunFlat], 'RUNFLAT') as [RunFlat],
	t.[SidewallType] as [SidewallType], 	t.[LoadIndexDisplay] as [LoadIndexDisplay],
	t.[LoadIndex] as [LoadIndex],	 t.[SpeedRating] as [SpeedRating],
	t.[TirePly] as [TirePly],	 CURRENT_TIMESTAMP as [dataSet_timestamp],
	t.[MaxTirePressure] as [MaxTirePressure], 	t.[MinRimWidth] as [MinRimWidth],
	t.[MaxRimWidth] as [MaxRimWidth],	 t.[OverAllTireDiameter] as [OverAllTireDiameter],
	t.[style] as [style],	 t.[manufacturerPartNumber] as [manufacturerPartNumber],
	CAST(t.[weight] as Float) as [weight],	 
	CAST(t.[ShippingWeight] as Float) as [ShippingWeight],
	t.[TireCode1] as [TireCode1],	t.[TireCode2] as [TireCode2],
	t.[TireCode3] as [TireCode3],	t.[loadRange] as [loadRange],
	t.[treadWearWarranty] as [treadWearWarranty]
  FROM  Gravy.dbo.[WTU_Tires_Data_Fastco] t



--------------------  ANALYSIS AND UPDATE  --------------------------

-- DELETE/ UPDATE IRRELEVANT RECORDS FOR  SKU in ('190549-99', '217110', '3317','7.47E+11')

UPDATE DBO.[WTU_Tires_Data_MERGED]
  SET SKU =  Trim(Replace(manufacturerPartNumber, '()', ''))
  Select * from DBO.[WTU_Tires_Data_MERGED]
  Where Vendor = 'Distribution'  And Model = 'Daka M/T III' 
  And Manufacturer = 'Mark Ma'

DELETE From DBO.[WTU_Tires_Data_MERGED]
  Where SKU = '190549-99' And Model = 'MR-W562' And Manufacturer = 'Mirage'
  AND Vendor = 'Distribution'  And OverAllTireDiameter is NULL

DELETE From DBO.[WTU_Tires_Data_MERGED]
  Where SKU = '217110' And Model = 'Ridge Grappler' And Manufacturer = 'Nitto'
  AND Vendor = 'Distribution'  And OverAllTireDiameter is NULL

DELETE From DBO.[WTU_Tires_Data_MERGED]
  Where SKU = '3317' And Model = 'Tiger Paw Ice & Snow 3 (DOT)' 
  And Vendor = 'Distribution'  And  Manufacturer = 'Uniroyal' 

UPDATE DBO.[WTU_Tires_Data_MERGED]
  SET [RunFlat] =  '0'
  Where  [RunFlat] like  '%RUNFLAT%'



----DROP TABLE  dbo.[WTU_Tires_Data_MERGED_BACKUP]
---- Select * into dbo.[WTU_Tires_Data_MERGED_BACKUP]  -- At 8:02 PM IST 14-09
---- from [WTU_Tires_Data_MERGED]

Select * from  dbo.[WTU_Tires_Data_Prioritized]

 ----Select * into dbo.[WTU_Tires_Data_Prioritized_BACKUP]  -- At 9:08 PM IST 14-09
 ----from [WTU_Tires_Data_Prioritized]

DELETE From DBO.[WTU_Tires_Data_Prioritized]   ---  IGNORE STOX DATA NOW
  Where  Vendor = 'Stox' 


---- FASTCO DATA REIMPORTED  FOR SIZECODE   -------

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = t.Size_Code
  from [dbo].[temp_fastco_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.ManufacturerID = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.vendor = 'Fastco'  And s.Sizecode = ''

---- WHEELPROS DATA REIMPORTED  FOR SIZECODE   -------

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = t.SizeCode
  from dbo.[temp_tireinv_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.Sizecode = ''  And t.SizeCode iS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = Trim(LEFT(Sizecode, charindex('GRIP', Sizecode)-1))
    where sizecode like '%GRIP%'


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = t.SizeCode
  from dbo.[temp_tireinv_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.Sizecode = ''  And t.SizeCode iS NOT NULL

	dbo.[temp_tireinv_reference]


--Select * from  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
--  where sizecode like '%GRIP%'

 -- UPDATE dbo.[temp_tireinv_reference]
 --   SET ManufacturerID = '2606'
	--Where Manufacturer = 'Fuel Tires'

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' )
  Where PartDescription IS NOT NULL  AND  Substring(PartDescription,4,1) = '/'   

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Replace(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ), 'LT', '')
  Where PartDescription like 'LT%'  AND  Substring(PartDescription,6,1) = '/'   

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Replace(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ), 'P', '')
  Where PartDescription like 'P%'  AND  Substring(PartDescription,5,1) = '/'   

UPDATE dbo.[temp_tireinv_reference]
  Set PartDescription = Replace(PartDescription, 'KEVLAR', ' KEVLAR')
  Where PartDescription like '%KEVLAR GRIPPER%'

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Replace(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ), 'P', '')
  Where PartDescription like '%GRIPPER%'  AND  Substring(PartDescription,3,1) = 'X'   

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Replace(PartDescription,'-14','R14')
  Where PartDescription like '%GRIPPER%'  AND  Sizecode like '%-14' 

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Replace(PartDescription,'-15','R15')
  Where PartDescription like '%GRIPPER%'  AND  Sizecode  like '%-15' 

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ))
  Where PartDescription like '%LT%'  AND  Substring(PartDescription,3,1) = 'X'   

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ))
  Where PartDescription like 'LT%'  AND  Substring(PartDescription,5,1) = 'X'   

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 2,';' ))
  Where (PartDescription like 'SANDSLINGER%' OR PartDescription like 'PRO-RIDER%' 
         OR PartDescription like 'BLADE%' OR PartDescription like 'LO-PRO%' )    

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 3,';' ))
  Where (PartDescription like 'SAND SLINGER%' OR PartDescription like 'FUSION ST%' 
         OR PartDescription like 'HAMMER TIRE%' OR PartDescription like 'PRO RIDER%' )    

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 2,';' ))
  Where PartDescription like 'AT%BKT%'     

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 1,';' ))
  Where PartDescription like '%BKT%'     

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 2,';' ))
  Where PartDescription like 'AT %'     

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = '35X12.50R22'
  Where SKU= 'RFXT351250R22XL'  And ManufacturerID = '2606'

UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = '22X9.5X12'
  Where SKU= 'FA-831'  And ManufacturerID = '929'


UPDATE dbo.[temp_tireinv_reference]
  Set SizeCode = Trim(dbo.splitPosition(Replace(PartDescription,' ',';'), 3,';' ))   
   where SKU in 
   ( select distinct  SKU from [Gravy].DBO.[WTU_Tires_Data_Prioritized]  
   where  Sizecode in ('R/T', 'TIRE', 'XL') )

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = t.SizeCode
  from dbo.[temp_tireinv_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.Sizecode in ('R/T', 'TIRE', 'XL' )  
     And t.SizeCode iS NOT NULL

UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim( Replace(PartDescription, 'Sizecode', ''))
  Where charindex(Sizecode, PartDescription)>0  

UPDATE dbo.[temp_tireinv_reference]
  Set Model = PartDescription
  Where Model is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim( Replace(Model, Sizecode, ''))
  Where charindex(Sizecode, Model)>0  

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Replace(Sizecode, '/',''),'ZR',''))
  Where Sizecode like '%/%ZR%'

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Replace(Sizecode, '/',''),'R',''))
  Where Sizecode like '%/%R%'

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(TireCode3,'Z',''))
  Where TireCode3 like '%Z%'

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( [dbo].[Extract_Digits_Only](SizeCode) )
  Where  SizeCode like '%X%' and TireCode3 is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( [dbo].[Extract_Digits_Only](TireCode3) )

UPDATE  [Gravy].DBO.[temp_tireinv_reference]
  Set Sizecode = Trim(LEFT(Sizecode, charindex('GRIP', Sizecode)-1))
    where sizecode like '%GRIP%'

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Sizecode,'X',''))
  Where Sizecode like '%X%' And TireCode3 is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Sizecode,'-',''))
  Where Sizecode like '%-%' And TireCode3 is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Replace(Sizecode,'-',''), 'X', ''))
  Where Sizecode like '%X%-%' And TireCode3 is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set TireCode3 = Trim( Replace(Sizecode,'.',''))
  Where Sizecode like '%.%' And TireCode3 is NULL

UPDATE dbo.[temp_tireinv_reference]
  Set Model = 'PRO-RIDER 4 PLY BIAS'
  Where SKU = 'FA-824' And ManufacturerID = '929'

UPDATE dbo.[temp_tireinv_reference]
  Set Model = CASE
  When SKU = 'FA-827'  Then 'FUSION ST BIAS'
  When SKU = 'FA-828'  Then 'HAMMER TIRE'
  When SKU = 'FA-831'  Then 'EFX HAMMER TIRE'
  When SKU = 'FA-825'  Then 'FUSION ST DOT RA'
  When SKU = 'F28037330'  Then 'Wildpeak A/T3W'
  When SKU IN ('FA-829', 'FA-830')  Then 'HAMMER TIRE'
  When SKU IN ('FA-806', 'FA-817')  Then 'BLADE'
  When SKU IN ('MF-24-10-12', 'MF-24-8-12')  Then 'MOTOFORCE BIAS'
  Else Model End
  WHERE ManufacturerID = '929'

UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim( Replace(Model, Tirecode3, ''))
  Where charindex(Tirecode3, Model)>0  



UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim(replace(Model, 'A ', ''))
  Where Model like 'A %'

UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim(replace(Model, 'P A ', ''))
  Where Model like 'P A %'

UPDATE dbo.[temp_tireinv_reference]
  Set Model = Trim(RIGHT(Model, charindex(')', Model)+1))
  Where Model like '%(%)%'


UPDATE dbo.[temp_tireinv_reference]
  Set Model = 'Azenis'
  Where PartDescription like '%(%)%'

UPDATE dbo.[temp_tireinv_reference]
  Set Model = 'NT01'
  Where SKU = 'N371-560' And ManufacturerID = '402'


  UPDATE  [Gravy].DBO.[temp_tireinv_reference]
  Set Sizecode = Trim(LEFT(Sizecode, charindex('GRIP', Sizecode)-1))
    where sizecode like '%GRIP%'


Select TireCode3, * from  dbo.[temp_tireinv_reference] t 
Where PartDescription like '%(%)%'
order by PartDescription

Select distinct SKU, Manufacturer, Model from  dbo.[temp_tireinv_reference] t 
  order by Manufacturer

------------  UPDATE FROM  Google SHEET  --------- temp_tires_google_sheet ----

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE SIZECODE 
  Set Model = t.Model
  from dbo.[temp_tires_google_sheet] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.Model = ''  And t.Model iS NOT NULL


------------  UPDATE MODEL FROM  WHEELPROS  ---- temp_tires_google_sheet ----

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Model = t.Model
  from dbo.[temp_tireinv_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.Model = ''  And t.Model iS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE SIZECODE 
  Set Model = '121Q PAT X/T'
  Where manufacturerID = 1877  and SKU = 'M22229005'  and Model = ''


select * from dbo.[temp_tireinv_reference]  where manufacturerID is NULL


--------- NEW Google Sheet For MODELS -- Temp_Tires _Model Wheelpros --

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Model = t.Model
  from dbo.[Temp_Tires _Model Wheelpros] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where  t.Model iS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Model = t.Model
  from dbo.[Temp_Tires_Model_Wheelpros] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where  t.Model iS NOT NULL and s.vendor = 'WheelPros'


Select * from  dbo.[Temp_Tires_Model_Wheelpros]   
  where Sizecode is NULL   -- PartDescription like '%GRIPPER%'


Select * from  dbo.[temp_tireinv_reference]   
  where Sizecode is NULL   -- PartDescription like '%GRIPPER%'
  order by Sizecode, PartDescription   --  356  Sizecode Still Missing  in WheelPros. 

------------------------------------------------


  ----  1,280 SKU's From FASTCO in Prioritized Table, And Not in 107 Old TAble

 SELECT *  FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized] 
   where len(SizeCode) > 0 AND manufacturerPartNumber NOT in
  ( SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022] ) 
   And  charindex(CAST(Tirewidth As Varchar(50)), Sizecode) = 0 
   OR charindex(AspectRatio, Sizecode) = 0 
      OR  charindex(RimDiameter, Sizecode) = 0 )
   order by Construction, Vendor

   -- TireType can be same as SeasonDesignation ?

   -- And vendor = 'Fastco' ,  Tirewidth , AspectRatio, Construction, RimDiameter
   ----  NULL TireType - 1906
   ----  NULL Tirewidth - 689
   ----  NULL AspectRatio - 2101
   ----  NULL Construction - 
   ----  NULL  Model - 689

select distinct Vendor, Model, ManufacturerID, Manufacturer, SKU, Sizecode
   from  [Gravy].DBO.[WTU_Tires_Data_Prioritized]  
   Where manufacturerPartNumber NOT in
  ( SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022] ) 
    And  Model = ''      -- Sizecode = '' 
   Order by Vendor

--------------  BACKUP OF  PRIORITIZED  TABLE --- 16-SEPT-12:30AM -------

--SELECT * INTO [Gravy].DBO.[WTU_Tires_Data_Prioritized_BACK]
--  From [Gravy].DBO.[WTU_Tires_Data_Prioritized]

ALTER TABLE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  ADD  SIZECODE_BACK  varchar(255)

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  SET SIZECODE_BACK = SIZECODE

  select * from  [Gravy].DBO.[WTU_Tires_Data_Prioritized]


-------  WORK ON SIZECODE, ASPECT RATION, TIREWIDTH  -------

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized] 
 SET Tirecode3 = concat(LOADINDEX, SPEEDRATING)

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized] 
 SET Sizecode = Trim(LEFT(Sizecode, charindex('(', Sizecode)-1))
    where sizecode like '%(%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = Trim( Replace(Sizecode, Tirecode3, ''))
  Where charindex(Tirecode3, Sizecode)>0  

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = Replace(Sizecode, '  ', ' ')
  Where Sizecode like '%  %'

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Sizecode = Replace(Sizecode, ' ', '')
  Where sizecode like '% / %'

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = 'TR171 TT', 
       LOADINDEX= '106' ,  SPEEDRATING= 'A8'
  Where manufacturer = 'BKT'  and SKU = '94004362'


------------------------------------------------
----  CREATE NEW TEMP TABLE FOR SIZECODES, ASPECTRATIO.. 
SELECT * INTO  [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022]) 

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 1,';' ))
  Where Substring(sizecode,4,1) = '/'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = Replace(Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 1,';' )), 'LT', '')
  Where Substring(sizecode,6,1) = '/' And Sizecode like 'LT%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = 0    Where TireWidth < 17

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = 305 , AspectRatio = '35' , RimDiameter = 24
  Where SKU = '305-3524AMP/CA2' And Manufacturer = 'AMP Tires'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = Replace(Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'x', ';'),
           'R',';'), 1,';' )), 'LT', '')
  Where Substring(sizecode,5,1) = 'x' And Sizecode like 'LT%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set TireWidth = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'x', ';'),
           'R',';'), 1,';' ))
  Where Substring(sizecode,3,1) = 'x' And TireWidth = 0

  UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set Construction = 'B', TireWidth = 11.2 , RimDiameter = 24
  Where manufacturer = 'BKT'  and SKU = '94004362'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'x', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,3,1) = 'x' And AspectRatio is Null

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'x', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,3,1) = 'x' And Sizecode like '%x%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,4,1) = '/' And AspectRatio is Null

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,6,1) = '/' And AspectRatio is Null
     And Sizecode like 'LT%/%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,6,1) = '/' And AspectRatio is Null
     And Sizecode like 'LT%/%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  RimDiameter = 14
  Where SKU = '4530900000' And Manufacturer = 'Continental'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,5,1) = '/' And AspectRatio is Null
     And Sizecode like '%/%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'x', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,5,1) = 'x' And AspectRatio is Null
     And Sizecode like '%x%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = Replace(AspectRatio, 'Z','')
   Where AspectRatio like '%Z'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = ROUND(AspectRatio,1)
  Where AspectRatio is Not NULL

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set AspectRatio = concat(AspectRatio, '.0')
  Where AspectRatio is Not NULL and AspectRatio not like '%.%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set Tirecode2 = Trim(dbo.splitPosition(Replace(Sizecode,'R',';'), 2,';' ))
  Where  RimDiameter = 0  And Sizecode like '%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter =  CAST(Trim(LEFT(TireCode2,2)) as float)
  Where  RimDiameter = 0  And TireCode2 is NOT NULL

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter =  14, TireWidth = 11, Construction = 'R',
      AspectRatio = ''
  Where  sku = 'MG-28-11-14'  And manufacturer = 'EFX'


UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter = 15, Construction = 'D'
  Where  sku in ('SS-32-11-15','SS-32-14-15') And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter = 15, Construction = 'D'
  Where  sku in ('SS-33-11-15','SS-33-13-15') And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter = 14, Construction = 'D'
  Where  sku in ('SS-27-10-14','SS-27-13-14') And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set RimDiameter = 15, Construction = 'R'
  Where  sku in ('MVR-33-95-15') And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set Construction = 'D'  Where   sizecode = 'T145/70D17'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  Construction = 'D',
    RimDiameter = CAST(Trim(RIGHT(sizecode,2)) as float)
  Where  RimDiameter = 0  And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  AspectRatio = NULL
  Where  sku = '4530900000'  And manufacturer = 'Continental'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  AspectRatio = NULL, RimDiameter = 0
  Where  sku = 'MG-28-11-14'  And manufacturer = 'EFX'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  Construction = 'R'
   Where Construction IS NULL and SizeCode like '%R%'

UPDATE [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]
  Set  Construction = 'R'
   Where Construction like '%P+%S+%' and manufacturer = 'AMP Tires'


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set TireWidth = t.TireWidth ,  AspectRatio = t.AspectRatio , 
	  RimDiameter = t.RimDiameter , Construction = t.Construction
  from  [Gravy].DBO.[TEMP_WTU_Tires_Sizecode] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.ManufacturerID = s.ManufacturerID  AND  t.SKU = s.SKU 
  --where  t.Model iS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set TireCode3 = NULL

  -------------------------------------------------------
select distinct manufacturer, model, SKU, sizecode, TireWidth, 
  AspectRatio, RimDiameter, Construction
 from [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]  
  --Where sizecode like 'P%' 
  order by Construction

Select * from [Gravy].DBO.[TEMP_WTU_Tires_Sizecode]  
  Order by Sizecode


select distinct vendor, manufacturer, SKU, sizecode, sizecode_Back, TireWidth, 
  AspectRatio, RimDiameter, Construction, LoadIndex, Speedrating

select distinct vendor,manufacturerID, Manufacturer,SKU,LoadIndex,Speedrating
 from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
  AND  ( LoadIndex IS NULL  OR  Speedrating IS NULL )
  Order  by Speedrating, LoadIndex

--TireWidth = 'before / mark in mm'  --AspectRAtio = 'After / and before R'
--RimDiameter = 'After R in cm ? '  --Construction = 'R for Radial'

 ---------------  UPDATE NULL LoadIndex, Speedrating ------- 
 ---- NULL LoadIndex - 695  records
  ---- NULL Speedrating - 722  records

--UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]  SET TireCode3 = CASE
--	When Manufacturer = 'Bridgestone' And SKU = '12752'  Then '88;T'
--	When Manufacturer = 'Cooper' And SKU = '90000039833'  Then '107;V'
--	When Manufacturer = 'Cooper' And SKU = '90000039922'  Then '105;H'
--	When Manufacturer = 'Cooper' And SKU = '90000039934'  Then '109;H'
--	When Manufacturer = 'Cooper' And SKU = '90000039936'  Then '114;H'
--	When Manufacturer = 'Cooper' And SKU = '90000040168'  Then '93;V'
--	When Manufacturer = 'EFX' And SKU = 'MG-28-11-14'  Then '88;T'
--	Else TireCode3 End
--   Where LoadIndex IS NULL  AND  Speedrating IS NULL

--------- NEW Google Sheet For LoadIndex, SpeedRating --

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set LoadIndex = t.LoadIndex
  from dbo.[TEMP_Google_Speedrating_Loadrating] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.ManufacturerID = s.ManufacturerID  AND  t.SKU = s.SKU 
  where  s.LoadIndex iS NULL


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Speedrating = t.Speedrating
  from dbo.[TEMP_Google_Speedrating_Loadrating] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.ManufacturerID = s.ManufacturerID  AND  t.SKU = s.SKU 
  where  s.Speedrating iS NULL


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = dbo.FirstLetterCap(Manufacturer)

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'General'
   Where  Manufacturer = 'General Tire'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'Nitto'
   Where  Manufacturer = 'Nitto Utv'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'BFGoodrich'
   Where  Manufacturer = 'Bfgoodrich'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'EFX'  Where  Manufacturer = 'Efx'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'BKT'  Where  Manufacturer = 'Bkt'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
  Set Manufacturer = 'AMP Tires'  Where  Manufacturer = 'Amp Tires'


--------------  BACKUP OF  PRIORITIZED  TABLE --- 19-SEPT-10:30AM -------

--SELECT * INTO [Gravy].DBO.[WTU_Tires_Data_Prioritized_BACK2]
--  From [Gravy].DBO.[WTU_Tires_Data_Prioritized]


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set SeasonDesignation = CASE
	When Model like '%All Season%'  Then 'All Seasons'
	When Model like '%Winter%'  Then 'Winter'
	When Model like '%Snow%'  Then 'Winter'
	When Model like '%Ice%'  Then 'Winter'
	When Model like '%Frost%'  Then 'Winter'
	--When Manufacturer in ('Nitto') And Model in ('NT555RII') Then 'All Seasons'
	Else  SeasonDesignation  End
	Where  SeasonDesignation = '' 

-----------------  MODELS UPDATE-  CASES   ------------

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = 'Ice LEOPARD'	Where Model = 'iceLEOPARD'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = Replace(Model, 'Snowleopard', 'Snow leopard')
	Where Model like '%Snowleopard%'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = Replace(Model, 'Ultra Grip', 'UltraGrip')
	Where Model like '%UltraGrip %'


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = dbo.FirstLetterCap(Model)
	 Where Model not like '%Contact%' And Model Not like '%Cross%'

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = Replace(Model, 'Sp Sport', 'SP Sport')
	Where Model like '%Sp Sport%'


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = CASE
	When Model like '% Tr'  Then Replace(Model, ' Tr', ' TR')
	When Model like '% Tx'  Then Replace(Model, ' Tx', ' TX')
	When Model like '% Lt'  Then Replace(Model, ' Lt', ' LT')
	When Model like '% Ht'  Then Replace(Model, ' Ht', ' HT')
	When Model like '% At'  Then Replace(Model, ' At', ' AT')
	When Model like '% At2'  Then Replace(Model, ' At', ' AT')
	When Model like '% At51'  Then Replace(Model, ' At', ' AT')
	When Model like '% Ta31'  Then Replace(Model, ' Ta', ' TA')
	When Model like '% Ha32'  Then Replace(Model, ' Ha', ' HA')
	When Model like '% Hd'  Then Replace(Model, ' Hd', ' HD')
	When Model like '% Hts'  Then Replace(Model, ' Hts', ' HTS')
	When Model like '% Id'  Then Replace(Model, ' Id', ' ID')
	When Model like '% Lx'  Then Replace(Model, ' Lx', ' LX')
	When Model like '% Ev'  Then Replace(Model, ' Ev', ' EV')
	When Model like '% Xc'  Then Replace(Model, ' Xc', ' XC')
	Else Model End


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE MODEL 
	Set Model = CASE
	When Model = 'Tr171'  Then 'TR171'
	When Model like '% Rft'  Then Replace(Model, ' Rft', ' RFT')
	When Model like '% Xlt'  Then Replace(Model, ' Xlt', ' XLT')
	When Model like '% Le'  Then Replace(Model, ' Le', ' LE')
	When Model like '% Le'  Then Replace(Model, ' Le', ' LE')
	When Model like '% Srx'  Then Replace(Model, ' Srx', ' SRX')
	Else Model End


---------  update  seasons FROM Google Sheet -- [dbo].[Temp_SesonDesignation]

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE SIZECODE 
  Set SeasonDesignation = t.SeasonDesignation
  from dbo.[WTU_Tires_Data_Prioritized_BACK2] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.[ManufacturerID] = s.ManufacturerID  AND  t.SKU = s.SKU 
  where t.SeasonDesignation  IS NOT NULL


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE SIZECODE 
  Set SeasonDesignation = t.SeasonDesignation
  from  [dbo].[Temp_SesonDesignation]  t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.SeasonDesignation = '' and t.SeasonDesignation IS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE SIZECODE 
  Set SeasonDesignation = 'All Season'
  Where  SeasonDesignation = ''

--------------------  ALTER COLUMN   ------------------------
--DROP TABLE Gravy.dbo.[WTU_Tires_Data_Prioritized_BACK]
--SELECT * INTO [Gravy].DBO.[WTU_Tires_Data_Prioritized_BACK3]
--  From [Gravy].DBO.[WTU_Tires_Data_Prioritized]


ALTER TABLE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
ALTER COLUMN RimDiameter  Float  NULL

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  SET RimDiameter = NULL
  Where RimDiameter = 0

------------------------------------------------
---------  IMPORT  NEW STOX VENDOR  EXCEL FILE --------

select distinct Brand  from  dbo.[TEMP_TIRES_STOX_Catalogue]
Select * from  dbo.[TEMP_TIRES_STOX_Catalogue]  where Brand is NULL

SELECT * INTO DBO.[WTU_Tires_Data_STOX]
  from  DBO.[WTU_Tires_Data_MERGED]  Where 0 = 1

ALTER TABLE [Gravy].DBO.[WTU_Tires_Data_STOX]
ALTER COLUMN RimDiameter  Float  NULL


INSERT   INTO  DBO.[WTU_Tires_Data_STOX]   
	SELECT  
	NULL as [ManufacturerID],	t.[Brand] as [Manufacturer],
	'STOX' as [Vendor], 	ISNULL(t.[Description], '')  as [Model],
	ISNULL(t.[ProductNo], '') as [SKU],		NULL as [VendorSKU],
	NULL as [UPCCode],	 ISNULL(t.[Dimension], '') as [SizeCode],
	t.[ProductType] as [TireType],	 NULL as [TireWidth],
	NULL as [AspectRatio],	NULL as  [Construction],
	NULL as [RimDiameter],	CAST(ISNULL(t.[TreadDepth],0) as Float) as [TreadDepth],
	NULL  as [UTQG],  	NULL  as [TreadWear],
	NULL  as  [TractionRating],	 NULL  as [TemperatureRating],
	'' as [SeasonDesignation],	 ISNULL(t.[RunFlat], '') as [RunFlat],
	t.[SidewallDescription] as [SidewallType], 	NULL as [LoadIndexDisplay],
	t.[LoadIndex] as [LoadIndex],	 t.[SpeedRating] as [SpeedRating],
	NULL as [TirePly],	 CURRENT_TIMESTAMP as [dataSet_timestamp],
	NULL as [MaxTirePressure], 	NULL as [MinRimWidth],
	NULL  as [MaxRimWidth],	 NULL  as [OverAllTireDiameter],
	NULL as [style],	 t.[AXProductNo] as [manufacturerPartNumber],
	NULL as [weight],	 	NULL as [ShippingWeight],	NULL as [TireCode1],
	NULL  as [TireCode2],	NULL as [TireCode3],	NULL as [loadRange],
	NULL as [treadWearWarranty]
  FROM  Gravy.dbo.[TEMP_TIRES_STOX_Catalogue] t
  Where t.Brand is NOT NULL


SELECT Distinct SKU, manufacturer, manufacturerPartNumber from  [Gravy].DBO.[WTU_Tires_Data_STOX]  order by 3 -- 27,168 Rows

SELECT  distinct manufacturer  
 from  [Gravy].DBO.[WTU_Tires_Data_STOX] order by 1

UPDATE  [Gravy].DBO.[WTU_Tires_Data_STOX]   --- UPDATE SIZECODE 
  Set manufacturerID = t.manufacturerID
  from dbo.[107Attributes_09132022] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_STOX] s
  ON t.[Manufacturer] = s.Manufacturer 
  where s.[ManufacturerID]  IS  NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_STOX]   --- UPDATE SIZECODE 
  Set manufacturerID = t.manufacturerID
  from dbo.[WTU_Tires_Data_Prioritized] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_STOX] s
  ON t.[Manufacturer] = s.Manufacturer 
  where t.[Manufacturer]  IS NOT NULL

UPDATE  [Gravy].DBO.[WTU_Tires_Data_STOX]   --- UPDATE SIZECODE 
  Set manufacturerPartNumber = concat('(',ManufacturerID, ')', SKU)
  Where ManufacturerID is NOT NULL


ALTER TABLE [Gravy].DBO.[WTU_Tires_Data_STOX]
ADD  [SIZECODE_BACK] [varchar](255) NULL

--INSERT   INTO  DBO.[WTU_Tires_Data_Prioritized] 
--Select * from [Gravy].DBO.[WTU_Tires_Data_STOX] t
-- Where t.manufacturerID  is NULL  

INSERT   INTO  DBO.[WTU_Tires_Data_Prioritized]
SELECT  
	CAST(t.[ManufacturerID] as Int) as [ManufacturerID],	t.[Manufacturer] as	[Manufacturer],
	t.[Vendor] as [Vendor], 	ISNULL(t.[Model], '')  as [Model],
	ISNULL(t.[SKU], '') as [SKU],		t.[VendorSKU] as [VendorSKU],
	t.[UPCCode] as [UPCCode],	 ISNULL(t.[SizeCode], '') as [SizeCode],
	t.[TireType] as [TireType],	 CAST(ISNULL(t.[TireWidth], 0) as Float) as [TireWidth],
	t.[AspectRatio] as [AspectRatio],	t.[Construction] as  [Construction],
	CAST(ISNULL(t.[RimDiameter], 0) as Float) as [RimDiameter],	
	CAST(ISNULL(t.[TreadDepth],0) as Float) as [TreadDepth],
	t.[UTQG] as [UTQG],  	CAST(t.[TreadWear] as Int) as [TreadWear],
	t.[TractionRating] as  [TractionRating],	t.[TemperatureRating] as [TemperatureRating],
	ISNULL(t.[SeasonDesignation], '') as [SeasonDesignation],	
	ISNULL(t.[RunFlat], '') as [RunFlat],
	t.[SidewallType] as [SidewallType], 	t.[LoadIndexDisplay] as [LoadIndexDisplay],
	t.[LoadIndex] as [LoadIndex],	 t.[SpeedRating] as [SpeedRating],
	t.[TirePly] as [TirePly],	 CURRENT_TIMESTAMP as [dataSet_timestamp],
	t.[MaxTirePressure] as [MaxTirePressure], 	t.[MinRimWidth] as [MinRimWidth],
	t.[MaxRimWidth] as [MaxRimWidth],	 t.[OverAllTireDiameter] as [OverAllTireDiameter],
	t.[style] as [style],	 t.[manufacturerPartNumber] as [manufacturerPartNumber],
	CAST(t.[weight] as Float) as [weight],	 
	CAST(t.[ShippingWeight] as Float) as [ShippingWeight],
	t.[TireCode1] as [TireCode1],	t.[TireCode2] as [TireCode2],
	t.[TireCode3] as [TireCode3],	t.[loadRange] as [loadRange],
	t.[treadWearWarranty] as [treadWearWarranty],
	t.[SIZECODE_BACK] as [SIZECODE_BACK]
  FROM  [Gravy].DBO.[WTU_Tires_Data_STOX] t
   Where t.manufacturerID  is NOT NULL
   --Where t.manufacturerID  is NULL

----SELECT * INTO DBO.[WTU_Tires_Data_STOX_BACK]
----  from  DBO.[WTU_Tires_Data_STOX]  

DELETE From [Gravy].DBO.[WTU_Tires_Data_STOX]
  Where manufacturerPartNumber in
 (SELECT distinct manufacturerPartNumber 
     FROM [Gravy].[dbo].[WTU_Tires_Data_Prioritized]) 

DELETE From [Gravy].DBO.[WTU_Tires_Data_STOX]
  Where manufacturerPartNumber in
 (SELECT distinct manufacturerPartNumber 
     FROM [Gravy].[dbo].[107Attributes_09132022]) 

UPDATE dbo.[WTU_Tires_Data_STOX]
  Set Model = Trim( Replace(Model, Sizecode, ''))
  Where vendor = 'STOX' and charindex(Sizecode, Model)>0  

UPDATE dbo.[WTU_Tires_Data_Prioritized]
  Set Sizecode_BACK = Trim(Model)
  Where vendor = 'STOX'

--UPDATE dbo.[WTU_Tires_Data_Prioritized]
--  Set Model = 'Firestone Wide Oval'    Where vendor = 'STOX' and Sku = '54890'

--UPDATE dbo.[WTU_Tires_Data_Prioritized]
--  Set Model = 'Silvertown Radial'    Where vendor = 'STOX' and Sku = '579785'


--DELETE FROM [Gravy].[dbo].[WTU_Tires_Data_Prioritized]
--   Where vendor = 'STOX'  And  manufacturer = 'Odessa'

--DELETE  FROM [Gravy].[dbo].[WTU_Tires_Data_Prioritized]
--  Where Vendor = 'STOX'  and SKU in ('COM', 'COMA','COMB','COMM')

UPDATE dbo.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = Trim(dbo.splitPosition(Replace(Model,' ',';'), 1,';' ))
  Where Vendor = 'STOX'  And SizeCode = ''     

UPDATE dbo.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = CASE 
  When Manufacturer = 'Carlisle' And SKU in ('995189761','995192711')  Then '18X8.50'

  Else TireCode1  End
  Where Vendor = 'STOX'  and sizecode = '' 


------------- UPDATE From temp_tires_reupload -- 23-Sept
----  For vendor = 'STOX',  loadIndex, SpeedRating.

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE loadindex 
  Set loadindex = t.loadindex
  from dbo.[temp_tires_reupload] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.vendor = 'STOX'  


UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE loadindex 
  Set SpeedRating = t.SpeedRating
  from dbo.[temp_tires_reupload] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.vendor = 'STOX'  


  DELETE s  From [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
    INNER JOIN dbo.[temp_tires_reupload] t
	ON CAST(t.[ManufacturerID] as Int) = s.ManufacturerID  AND  t.SKU = s.SKU
  where s.vendor = 'STOX'  And t.Notes = 'DISC'
 

--UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]   --- UPDATE loadindex 
--  Set TireCode1 = NULL, TireCode2 = NULL, TireCode3 = NULL

select * from  dbo.[temp_tires_reupload]  where  Notes = 'DISC'


----------------  27-SEPT-2022  -----  CLEAN  MODEL  --  STOX VENDOR  --------

SELECT wtu.manufacturerid, wtu.SKU, wtu. Manufacturer, wtu.model, wtu.SizeCode, vp.*, 
case when vp.Name IS not null then 0 
  else 1 end pendingNewProduct  
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized] wtu
  left join (Select distinct p.name, p.productid, v.variantid, v.SKUSuffix, v.ManufacturerPartNumber 
  from V10.partsengine.dbo.product p
  left join V10.partsengine.dbo.productvariant v
  on p.ProductID = v.productid where p.Published = 1 
  and p.deleted = 0 and v.published=1 and v.deleted = 0)  vp 
   on wtu.manufacturerPartNumber = vp.ManufacturerPartNumber

-----  CLEAN  MODEL  --  STOX VENDOR  --------

----UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
----  Set Model = Sizecode_Back
----  Where   Vendor = 'STOX' 

----SELECT * INTO [Gravy].DBO.[WTU_Tires_Data_Prioritized_27SEP]
----  FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]  


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim( Replace(Model, Sizecode, ''))
  Where   Vendor = 'STOX'  and  charindex(Sizecode, Model)>0  

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode3 = NULL      Where Vendor = 'STOX'   

UPDATE  [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode3 = concat(LoadIndex, SpeedRating)
  Where Vendor = 'STOX'   

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim( Replace(Model, TireCode3, ''))
  Where   Vendor = 'STOX'  and  charindex(TireCode3, Model)>0  

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim( Replace(Model, Manufacturer, ''))
  Where   Vendor = 'STOX'  and  charindex(Manufacturer, Model)>0  

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim( Replace(Model, 'OODRICH', ''))
  Where   Vendor = 'STOX'  and  Model like '%OODRICH%'  


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = Model
  Where Vendor = 'STOX'  and  Model like '% %'
   And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(RIGHT(Model, (len(Model) - charindex(' ', Model))))
  Where Vendor = 'STOX'  and  Model like '% %'
   And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim( Replace(Model, '(TL)', ''))
  Where   Vendor = 'STOX'  and  Model like '%(TL)%'  

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = Model
  Where Vendor = 'STOX'  and  Model like '/%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Trim(RIGHT(Model, (len(Model) - charindex(' ', Model))))
  Where   Vendor = 'STOX'  and  Model like '/%'  

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = 'Duration 30'
  Where   Vendor = 'STOX'  and  Model = '30'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = 'Solar 4XS+'
  Where   Vendor = 'STOX'  and  Model = '4XS+'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = Concat('Continental ', Model)
  Where   Vendor = 'STOX'  and  Model like '4X4%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = Model
  Where Vendor = 'STOX'  And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(RIGHT(Model, (len(Model) - charindex(' ', Model))))
  Where Vendor = 'STOX'  
   And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model = 'MAXMILER PRO'
  Where   Vendor = 'STOX'  and  Model = '94/92T  MAXMILER PRO'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(Replace(Model, '4 PLY', ''))
  Where   Vendor = 'STOX'  and  Manufacturer = 'Planet Distribution'
     and  Model like '4 PLY%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(Replace(Model, '6 PLY', ''))
  Where   Vendor = 'STOX'  and  Manufacturer = 'Planet Distribution'
     and  Model like '6 PLY%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(Replace(Model, '(TT)', ''))
  Where   Vendor = 'STOX'  and  Manufacturer = 'Carlisle'
     and  Model like '%(TT)%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  'WHEELBARROW 2P'
  Where   Vendor = 'STOX'  and  Manufacturer = 'Carlisle'
     and  Model= '- 8  WHEELBARROW 2P'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  'WHEELBARROW 2P'
  Where   Vendor = 'STOX'  and  Manufacturer = 'Primex'
     and  Model like '%BOSSGRIP %'
	 And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  Trim(RIGHT(Model, (len(Model) - charindex(' ', Model))))
  Where Vendor = 'STOX'  
   And  SUBSTRING(Model,1,1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Model =  'CARLISLE SPORT TRAIL LH'
  Where   Vendor = 'STOX'  and  Manufacturer = 'Planet Distribution'
     and  SKU = 'A2/T84FC'

 UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireCode1 = Model
  Where Vendor = 'STOX'  And  Model like '%/%' and Model Not like '%/S%'
   And  SUBSTRING(Model,(charindex('/', Model)+1),1) IN ('0','1','2','3','4','5','6','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When  Manufacturer = 'Mirage'  And Model like '%WT172%'  Then 'WT172'
  When  Manufacturer = 'Mirage'  And Model like '%FTL323%'  Then 'FTL323'
  When  Manufacturer = 'Nexen'  And Model like '%ROAD%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('ROAD', Model)+1)))
  When  Manufacturer = 'Nexen'  And Model like '%WIN%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('WIN', Model)+1)))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Mirage', 'Nexen')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model = Replace(Model, 'M ', ' ')
  Where Manufacturer = 'Toyo'  And Model like '%M %'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When  Manufacturer = 'Triangle'  And Model like '%BSW%'  Then 'LL01 BSW'
  When  Manufacturer = 'Triangle'  And Model like '% TR%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex(' TR', Model)+1)))
  When  Manufacturer = 'Toyo'  And Model like '%OPEN COUNTRY A/T%'  Then  'OPEN COUNTRY A/T III'
  When  Manufacturer = 'Toyo'  And Model like '%OPEN COUNTRY M/T%'  Then  'OPEN COUNTRY M/T'
  When  Manufacturer = 'Toyo'  And Model like '% M%'  Then trim(dbo.searchtext(replace(Model,' ','; '),'%M%',default))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Toyo', 'Triangle')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When  SizeCode_Back like '%AGILEX%'  Then  Concat('Agilex ', Model)
  When  SizeCode_Back like '%ADVANTEX%'  Then  Concat('Advantex ', Model)
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Triangle')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Replace(Model, '   ', ' ')
   Where  Vendor = 'STOX'  and  Model like '%   %'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Replace(Model, '  ', ' ')
   Where  Vendor = 'STOX'  and  Model like '%  %'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model = Replace(Model, 'XL ', '')
  Where   Vendor = 'STOX'  And  Model like 'XL %'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model = Trim(Replace(Replace(Model, 'SS LRC', ''), 'SS LRD', ''))
  Where   Vendor = 'STOX'  And  Manufacturer in ('Carlisle') And Model like 'SS LR%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Model like '%MUD-TERRAIN%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('MUD', Model)+1)))
  When Model like '%ALL-TERRAIN%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('ALL', Model)+1)))
  When Model = 'BF WINTER T A KSI'  Then  'WINTER T A KSI'
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('BFG')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set Model =  Trim(dbo.splitPosition(Replace(Model, '(', ';('), 1,';' ))
    Where  Vendor = 'STOX'  and  Model like '%(%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Model like '%DYNAPRO%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('DYNAPRO', Model)+1)))
  When Model like '%VANTRA%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('Vantra', Model)+1)))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Hankook')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Model like 'LRA %'  Then  Trim(Replace(Model, 'LRA ', ''))
  When Model like 'LRB %'  Then  Trim(Replace(Model, 'LRB ', ''))
  When Model like 'LRC %'  Then  Trim(Replace(Model, 'LRC ', ''))
  When Model like 'LRD %'  Then  Trim(Replace(Model, 'LRD ', ''))
  When Model like 'LRE %'  Then  Trim(Replace(Model, 'LRE ', ''))
  When Model like 'LRF %'  Then  Trim(Replace(Model, 'LRF ', ''))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Carlisle')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Sku = '99537081'  Then  'Knoby Solid'
  When Sku = '99588394'  Then  'Field Trax'
  When Sku = '995193501'  Then  'SPORT TRAIL LR'
  When Sku = '10483005'  Then  'Trailer'
  When Sku = '99575324'  Then  'TURF TRAC R/S'
  When Sku = 'CT345220'  Then  'TERRENA A/T'
  When Model like 'NHS LRB %'  Then  Trim(Replace(Model, 'NHS LRB ', ''))
  When Model like 'NHS IND. %'  Then  Trim(Replace(Model, 'NHS IND.', ''))
  When Model like 'NHS %'  Then  Trim(Replace(Model, 'NHS ', ''))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Carlisle')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model =  'NORDFROST 200 A CLOUS' 
  Where   Vendor = 'STOX'  and  Manufacturer in ('Gislaved')
     And  Model = 'NORDFROST 200 A CLOUS N.'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Sku = '13.421.8057'  Then  'CAMSO LOADMASTER L2 TL'
  When Sku = '8.652.8038'  Then  'SKS 332 GRIPPER'
  When Model like 'LRE %'  Then  Trim(Replace(Model, 'LRE ', ''))
  When Model like 'LRF %'  Then  Trim(Replace(Model, 'LRF ', ''))
  When Model like 'LRG %'  Then  Trim(Replace(Model, 'LRG ', ''))
  When Model like 'LRH %'  Then  Trim(Replace(Model, 'LRH ', ''))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Solideal')

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model =   Trim(Replace(Model, 'UN ', ''))
  Where  Vendor = 'STOX'  and  Manufacturer in ('Uniroyal') And Model like 'UN %'

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model =   Concat(Model, ' Sport')
  Where  Vendor = 'STOX'  and  Manufacturer in ('Triangle') And Model like 'TR%'
    And  SizeCode_Back  like '%SPORT%'


  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
  Set Model =  Trim(Replace(Model, '107H', ''))
  Where  Vendor = 'STOX'  and  Manufacturer in ('Aplus') And Model like '107H%'

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set Model =  CASE 
   WHEN  Model like '%NOIR'  THEN  Trim(Replace(Model, 'NOIR', ''))
   WHEN  SKU in ('0523013')  THEN  'TL LRH HDW2'
   ELSE  MODEL  END
   Where  Vendor = 'STOX'  and  Manufacturer in ('Continental') 
   
  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set Model =  CASE 
   WHEN  Model like '%NOIR'  THEN  Trim(Replace(Model, 'NOIR', ''))
   WHEN  Model like '%OWL'  THEN  Trim(Replace(Model, 'OWL', ''))
   WHEN  Model like '%CD'  THEN  Trim(Replace(Model, 'CD', ''))
   WHEN  SKU in ('0450979')  THEN  'GRABBER A/TX'
   WHEN  SKU in ('0450925')  THEN  'GRABBER HTS60'
   ELSE  MODEL  END
   Where  Vendor = 'STOX'  and  Manufacturer in ('General') 

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set Model =  CASE 
   WHEN  Model like 'LRB%'  THEN  Trim(Replace(Model, 'LRB', ''))
   WHEN  Model like 'LRC%'  THEN  Trim(Replace(Model, 'LRC', ''))
   WHEN  Model like 'LRD%'  THEN  Trim(Replace(Model, 'LRD', ''))
   WHEN  Model like 'LRE%'  THEN  Trim(Replace(Model, 'LRE', ''))
   WHEN  Model like 'LRF%'  THEN  Trim(Replace(Model, 'LRF', ''))
   WHEN  Model like 'LRG%'  THEN  Trim(Replace(Model, 'LRG', ''))
   WHEN  Model like 'LRH%'  THEN  Trim(Replace(Model, 'LRH', ''))
   ELSE  MODEL  END
   Where  Vendor = 'STOX'  and  Manufacturer in ('Planet Distribution') 

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
    Set Model =   'Power King LPT'
   Where  Vendor = 'STOX'  and  Manufacturer in ('Triangle') And  SKU in ('QQ31')


  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set Model =  CASE 
   WHEN  SKU in ('T1334500')  THEN  'TM100'
   WHEN  SKU in ('T10895900')  THEN  'TM600PT'
   WHEN  SKU in ('T0732900')  THEN  'TM700'
   WHEN  SKU in ('T0734000')  THEN  'TM700PT'
   WHEN  SKU in ('T1467300')  THEN  'T412'
   WHEN  SKU in ('T1467000')  THEN  'T63'
   ELSE  MODEL  END
   Where  Vendor = 'STOX'  and  Manufacturer in ('Trelleborg') 


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Model like '%SNOWKING%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('SNOWKING', Model)+1)))
  When Model like '%MATE%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('MATE', Model)+1)))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Techking')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   Set Model =  CASE
  When Model like '%SOLARUS%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('SOLARUS', Model)+1)))
  When Model like '%HAULER%'  Then  Trim(RIGHT(Model, (len(Model) - CharIndex('HAULER', Model)+1)))
  Else Model End
  Where   Vendor = 'STOX'  and  Manufacturer in ('Starfire')

  UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
     Set Model =  Trim(Replace(Model, 'TL 2*', ''))
   Where  Vendor = 'STOX'  and  Manufacturer in ('Techking') 
     And  Model like  'TL 2*%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Trim(RIGHT(Model, (len(Model) - CharIndex('RM', Model)+1)))
  Where   Vendor = 'STOX'  and  Manufacturer in ('Roadmaster')
    And  Model Like  '% RM%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Trim(RIGHT(Model, (len(Model) - CharIndex('HAKKA', Model)+1)))
  Where   Vendor = 'STOX'  and  Manufacturer in ('Nokian')
    And  Model Like  '% HAKKA%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model = 'BOSSGRIP R-4'
   Where Manufacturer = 'Primex'  And  SKU= '103260'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set Model = Case
  When Manufacturer = 'RSSW'  And  SKU= 'KIT111B'  Then  'INSTALLATION KIT'
  When Manufacturer = 'Kumho'  And  SKU= '2304083'  Then  'ROAD VENTURE AT51'
  When Manufacturer = 'Nokian'  And  SKU= 'T429129'  Then  'WR C3'
  Else Model End
   WHERE Vendor = 'STOX' 

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Trim(RIGHT(Model, (len(Model) -3)))
  Where   Vendor = 'STOX'  And  Model Like  'LR%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Model =  Trim(Replace(Model, dbo.searchtext(replace(Model,' ','; '),'%/%',default), ''))
   Where  Vendor = 'STOX'  And Substring(Model,1,1) in ('1','9') And Model like '%/%'


-------------  BACKUP OF MODEL in TIRECODE3  -----------
----UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
----     Set TIRECODE3 = Model,  TIRECODE1 = NULL, TIRECODE2 = NULL
----	 Where  Vendor = 'STOX' 


------------  UPDATE ---  STOX  SIZECODE,  ASPECT RATIO, Etc..  ---- 28-SEP-2022 -------
---- SIZECODE ,  Tirewidth , AspectRatio, Construction, RimDiameter

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set  Construction = 'R'
   Where Construction in ('2P+2S+1N', '3P+2S+2N')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set  Construction = 'D'    Where Construction in ('B')


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Sizecode =  Trim(RIGHT(Sizecode, (len(Sizecode) - 2)))
  Where   Vendor = 'STOX'  And  (Sizecode Like  'ST%' OR  Sizecode Like  'LT%' )

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Sizecode =  Trim(RIGHT(Sizecode, (len(Sizecode) - 1)))
  Where   Vendor = 'STOX'  And  (Sizecode Like  'T%' OR  Sizecode Like  'P%' )

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set Sizecode =  Trim(RIGHT(Sizecode, (len(Sizecode) - 2)))
  Where   Vendor = 'STOX'  
  And  (Sizecode Like 'IF%' OR  Sizecode Like 'HL%' OR  Sizecode Like 'AT%' )

---------  TAKE 
UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
   Set TireCode1 = Sizecode_Back
   WHERE Vendor = 'STOX'  And SizeCode = ''


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set SizeCode =  Trim(dbo.splitPosition(Replace(TIRECODE1, ' ', ';'), 1,';' ))
    Where  Vendor = 'STOX'  And  SizeCode = ''
	And SUBSTRING(TIRECODE1,1,1) IN ('1','2','3','4','5','7','8','9')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set SizeCode =  '18X8.50'
    Where  Vendor = 'STOX'  And  SizeCode = '18' And TireCode1 like '18 X 8.50%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set SizeCode =  '8.25X16.5'
    Where  Vendor = 'STOX'  And  SizeCode = '8.25' And TireCode1 like '8.25 X 16.5%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set SizeCode =  '4.80-8'
    Where  Vendor = 'STOX'  And  SizeCode = '4.80' And TireCode1 like '4.80 - 8%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
	Set SizeCode =  Trim(Replace(dbo.splitPosition(Replace(TIRECODE1, ' ', ';'), 1,';' ),'AT',''))
    Where  Vendor = 'STOX'  And  SizeCode = ''
	And SUBSTRING(TIRECODE1,1,2) IN ('AT')

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    Set SizeCode = Case
  When Manufacturer = 'Primex'  And  SKU= '103260'  Then  '10-16.5'
  When Manufacturer = 'Divers'  And  SKU= 'FCA77100'  Then  '5X112'
  When Manufacturer = 'Divers'  And  SKU= '06292'  Then  '25X10R12'
  When Manufacturer = 'Divers'  And  SKU= '531065'  Then  '22X11-9'
  When Manufacturer = 'RSSW'  And  SKU= 'KIT111B'  Then  '1/2-20'
  When Manufacturer = 'RSSW'  And  SKU= 'AVW863C'  Then  '18X8 5-112'
  When Manufacturer = 'RSSW'  And  SKU= 'AMA855CG'  Then  '18X7.5 5-41/2'
  When Manufacturer = 'Carlisle'  And  SKU= '10483005'  Then  '4.80-8'
  When Manufacturer = 'Carlisle'  And  SKU= '99575324'  Then  '18X6.50-8'
  Else SizeCode End
   WHERE Vendor = 'STOX'  And SizeCode = ''

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
  Set SizeCode =  trim(dbo.searchtext(replace(TIRECODE1,' ',';'),'%X%',default))
  Where  Vendor = 'STOX'   And SizeCode = '' 
	And  TIRECODE1 like '%ROUE%X%'   

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
   Set SizeCode = '6-139.7'
  Where Vendor = 'STOX'  And Manufacturer = 'Palmar'  And  SKU = 'H69441T'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]    
   Set SizeCode = '9.5-16'
  Where Vendor = 'STOX'  And Manufacturer = 'Planet Distribution'  And  SKU = 'E3/K916R'


DELETE From  [Gravy].DBO.[WTU_Tires_Data_Prioritized] 
   WHere Vendor = 'STOX'  And Manufacturer = 'Divers'  And  SKU = 'EM445FLB' And SizeCode = ''

----UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]   
----   Set Sizecode =  Trim(RIGHT(Sizecode, (len(Sizecode) - 2)))
----  Where   Vendor = 'STOX'  And  Sizecode Like 'LT%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireWidth = Trim(dbo.splitPosition(Replace(Sizecode, '/', ';'), 1,';' ))
  Where Substring(sizecode,4,1) = '/' And TireWidth = 0
     And Vendor = 'STOX'  And  Sizecode like '%/%R%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireWidth = Trim(dbo.splitPosition(Replace(Sizecode, 'X', ';'), 1,';' ))
  Where Substring(sizecode,3,1) = 'X' And TireWidth = 0
     And Vendor = 'STOX'  And  Sizecode like '%X%R%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,4,1) = '/' And AspectRatio is Null
     And Vendor = 'STOX'  And  Sizecode like '%/%R%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'X', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,3,1) = 'X' And AspectRatio is Null
     And Vendor = 'STOX'  And  Sizecode like '%X%R%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Construction = 'R'
  Where  Construction is Null  And Vendor = 'STOX'  And  Sizecode like '%/%R%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Construction = 'R'
  Where  Construction is Null  And Vendor = 'STOX'  And  Sizecode like '%X%R%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set TireWidth = Trim(dbo.splitPosition(Replace(Sizecode, '/', ';'), 1,';' ))
  Where Substring(sizecode,4,1) = '/' And TireWidth = 0 
     And Vendor = 'STOX'  And  Sizecode like '%/%D%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'D',';'), 2,';' ))
  Where Substring(sizecode,4,1) = '/' And AspectRatio is Null
     And Vendor = 'STOX'  And  Sizecode like '%/%D%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set Construction = 'D'
  Where  Construction is Null  And Vendor = 'STOX'  And  Sizecode like '%/%D%'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set AspectRatio = Replace(AspectRatio, 'Z', '')
   Where  Vendor = 'STOX'  And  AspectRatio like '%Z'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set RimDiameter = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'R', ';'),' ',';'), 2,';' ))
  Where  RimDiameter = 0  And Vendor = 'STOX'  And  Sizecode like '%/%R% %'

UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set RimDiameter = Trim(dbo.splitPosition(Replace(Sizecode, 'R', ';'), 2,';' ))
  Where  RimDiameter = 0  And Vendor = 'STOX'  And  Sizecode like '%/%R%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set RimDiameter = Trim(dbo.splitPosition(Replace(Sizecode, 'R', ';'), 2,';' ))
  Where  RimDiameter = 0  And Vendor = 'STOX'  And  Sizecode like '%X%R%'


UPDATE [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Set RimDiameter = Trim(dbo.splitPosition(Replace(Sizecode, 'D', ';'), 2,';' ))
  Where  RimDiameter = 0  And Vendor = 'STOX'  And  Sizecode like '%/%D%'

--------  STOX TABLE BACKUP  -----  DELETE FROM CURRENT  ------

----SELECT * INTO  [Gravy].DBO.[WTU_Tires_Data_Prioritized_STOX] 
----  FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
----  WHERE Vendor = 'STOX'


----  DELETE   FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
----  WHERE Vendor = 'STOX'


---------------------------------------------------------------

SELECT distinct Manufacturer, ManufacturerID, Model, SKU, Sizecode, Sizecode_back, AspectRatio, TireWidth, RimDiameter, Construction, LoadIndex, SpeedRating 
SELECT count(*)     -- distinct TireWidth
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]  
     Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])




 Where  TireWIdth <  10   order by Manufacturer

SELECT distinct Manufacturer, ManufacturerID, Model, SKU, Sizecode, Sizecode_back, AspectRatio, TireWidth, RimDiameter, Construction, LoadIndex, SpeedRating 



  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
 and  Vendor = 'STOX'    --And SizeCode like '%/%ZR%'
 Order By  AspectRAtio



 Select *
   from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
   Where Construction in ('D')


SELECT distinct Sizecode, (len(SizeCode) - CharIndex('R', SizeCode)) as Rem 
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
 and  Vendor = 'STOX'    And SizeCode like '%R% %'
 Order By  Rem




Select Distinct manufacturer, manufacturerID, SKU, Sizecode_BACK, Sizecode
  FROM [Gravy].[dbo].[WTU_Tires_Data_Prioritized]
  Where Vendor = 'STOX'  Order by Sizecode 


SELECT Distinct  vendor   
 from  [Gravy].DBO.[WTU_Tires_Data_STOX]  Where manufacturer = 'Odessa'
  Where  manufacturerID  is NULL   order by Model   -- 4,801 is NULL
  ---- TOtal  27,162             --  10,233  Common SKU's


SELECT top 100 *  from  [Gravy].DBO.[WTU_Tires_Data_STOX] 
SELECT top 100 *  from  [Gravy].DBO.[WTU_Tires_Data_Prioritized] 



--SELECT distinct Manufacturer, ManufacturerID, vendor, Model, Style, Sku, SeasonDesignation  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
SELECT distinct Manufacturer, Model, SeasonDesignation  
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
 and SeasonDesignation = ''  Order By Manufacturer, model



SELECT top 2000 * from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022]) 
  --and SKU = 'MH-28-10-14'
  Order by  Manufacturer


--SELECT Distinct SKu, Manufacturer, sizecode_back, LoadIndex
SELECT top 100 *
  from [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where manufacturerPartNumber NOT in
 (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022]) 
  Order by 1    --- LoadIndex


---------------------------  SELECT  ANALYSIS  -----------------------

Select count(*)  from  DBO.[WTU_Tires_Data_MERGED]   --  45,872
Select distinct Vendor, count(*) as Count   from  DBO.[WTU_Tires_Data_MERGED]
   group by Vendor
 

Select  t.* from  DBO.[WTU_Tires_Data_MERGED] t,
( Select distinct Vendor, SKU, count(*) as Count   from  DBO.[WTU_Tires_Data_MERGED]
   group by  Vendor, SKU   having count(*) > 1 order by vendor ) tmp
  

Select  t.* from  DBO.[WTU_Tires_Data_MERGED] t  INNER JOIN  
(Select distinct Manufacturer, SKU, count(*) as Count   from  DBO.[WTU_Tires_Data_MERGED]
    group by Manufacturer, SKU  having count(*) > 1 ) tmp
    ON t.SKU = tmp.SKU  and t.Manufacturer = tmp.Manufacturer 
	order by  t.Manufacturer , t.SKU


-- DROP TABLE -- WTU_Tires_Data_MERGED
-- Select * INTO WTU_Tires_Data_MERGED
-- From  dbo.[107Attributes_09132022]  where 1 = 0

Select distinct Manufacturer from  DBO.[WTU_Tires_Data_MERGED]
   Where ManufacturerID is NULL

Select distinct Manufacturer, ManufacturerID from  DBO.[WTU_Tires_Data_MERGED]
   Where  Vendor = 'Distribution'


Select top 1000 SKU, Model, manufacturer, manufacturerPartNumber  from DBO.[WTU_Tires_Data_MERGED]  Where  Vendor = 'Distribution' order by SKU
  
   --Where  Vendor = 'Distribution' And  Charindex(SKU, manufacturerPartNumber) > 0 

Select * from  DBO.[WTU_Tires_Data_Prioritized]  
   --Where RunFlat Not in ('1', '0', 'N','Y')
   --Where  manufacturerPartNumber  like '()%'   order by Vendor, SKU
   Where  Vendor = 'Stox' order by SKU

--select top 1000 * from  dbo.[107Attributes_09132022]

SELECT * FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  where manufacturerPartNumber not in
  (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
  and UPCCODE is NULL 
  order by vendor,sku

---  NOT FILLED -- UPCCODE,  

 SELECT *  FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized] 
   where manufacturerPartNumber in
  (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022]) 
  order by Manufacturer

  SELECT distinct vendor  FROM [Gravy].[dbo].[107Attributes_09132022]

----  Total NEW record - 3,186
--  Blank  SizeCode - 2,067
--  NULL UPCCODE - 1,982 
--   NULL TireType - 1,906

SELECT * FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  Where vendor = 'Fastco' order by SKU

ALTER TABLE Gravy.[dbo].[temp_Fastco original]
  ADD ManuID Int  -- ADD ManuID Varchar(255)

-------------------------------------------------

SELECT * FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  where manufacturerPartNumber not in
  (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])
  order by vendor

SELECT * FROM [Gravy].DBO.[WTU_Tires_Data_Prioritized]
  where vendor = 'Fastco'    ----  3,515 Records


select distinct ManufacturerID, Manufacturer, SKU, SizeCode 
from  [dbo].[temp_fastco_reference]
ManufacturerID, Model, SKU, SizeCode 


select t.ManufacturerID, t.Manufacturer, t.SKU, t.Size_Code, s.ManufacturerID, s.SKU,
   s.sizecode
  from [dbo].[temp_fastco_reference] t
  INNER JOIN  [Gravy].DBO.[WTU_Tires_Data_Prioritized] s
  ON t.ManufacturerID = s.ManufacturerID  AND  t.SKU = s.SKU 
  where s.vendor = 'Fastco'




/****** FROM JACKSON  - 14-SEPT  ******/

 --SELECT * FROM (
	--	SELECT ROW_NUMBER() over (partition by manufacturerid,sku order by DataFullfillment_Order desc) RowNum,* FROM (
	--			SELECT LEN(concat(
	--				  [Model]
	--				  ,[UPCCode]
	--				  ,[SizeCode]
	--				  ,[TireType]
	--				  ,[TireWidth]
	--				  ,[AspectRatio]
	--				  ,[Construction]
	--				  ,[RimDiameter]
	--				  ,[TreadDepth]
	--				  ,[UTQG]
	--				  ,[TreadWear]
	--				  ,[TractionRating]
	--				  ,[TemperatureRating]
	--				  ,[SeasonDesignation]
	--				  ,[RunFlat]
	--				  ,[SidewallType]
	--				  ,[LoadIndexDisplay]
	--				  ,[LoadIndex]
	--				  ,[SpeedRating]
	--				  ,[TirePly]
	--				  ,[MaxTirePressure]
	--				  ,[MinRimWidth]
	--				  ,[MaxRimWidth]
	--				  ,[OverAllTireDiameter]
	--				  ,[style]
	--				  ,[weight]
	--				  ,[ShippingWeight]
	--				  ,[TireCode1]
	--				  ,[TireCode2]
	--				  ,[TireCode3]
	--				  ,[loadRange]
	--				  ,[treadWearWarranty])) DataFullfillment_Order,*
	--			  FROM [Gravy].DBO.[WTU_Tires_Data_MERGED]
	--		) M 
 -- ) N   Order by DataFullfillment_Order, SKU, ManufacturerID

   where RowNum = 1

----------------------------------------------------

	----[TireWidth] [float] NULL,
	----[AspectRatio] [varchar](20) NULL,
	----[Construction] [varchar](20) NULL,
	----[RimDiameter] [float] NOT NULL,
	--[TreadDepth] [float] NULL,
	----[LoadIndex] [varchar](255) NULL,
	----[SpeedRating] [varchar](255) NULL,

--CREATE TABLE [dbo].[107Attributes_09132022](
--	[ManufacturerID] [int] NULL,
--	[Manufacturer] [varchar](255) NOT NULL,
--	[Vendor] [varchar](255) NOT NULL,
--	[Model] [varchar](max) NOT NULL,
--	[SKU] [varchar](255) NOT NULL,
--	[VendorSKU] [varchar](255) NULL,
--	[UPCCode] [varchar](255) NULL,
--	[SizeCode] [varchar](255) NOT NULL,
--	[TireType] [varchar](255) NULL,
--	[TireWidth] [float] NULL,
--	[AspectRatio] [varchar](20) NULL,
--	[Construction] [varchar](20) NULL,
--	[RimDiameter] [float] NOT NULL,
--	[TreadDepth] [float] NULL,
--	[UTQG] [varchar](255) NULL,
--	[TreadWear] [int] NULL,
--	[TractionRating] [varchar](10) NULL,
--	[TemperatureRating] [varchar](10) NULL,
--	[SeasonDesignation] [varchar](255) NOT NULL,
--	[RunFlat] [nchar](10) NOT NULL,
--	[SidewallType] [varchar](255) NULL,
--	[LoadIndexDisplay] [varchar](100) NULL,
--	[LoadIndex] [varchar](255) NULL,
--	[SpeedRating] [varchar](255) NULL,
--	[TirePly] [varchar](255) NULL,
--	[dataSet_timestamp] [datetime] NOT NULL,
--	[MaxTirePressure] [varchar](255) NULL,
--	[MinRimWidth] [varchar](255) NULL,
--	[MaxRimWidth] [varchar](255) NULL,
--	[OverAllTireDiameter] [varchar](255) NULL,
--	[style] [varchar](255) NULL,
--	[manufacturerPartNumber] [varchar](255) NULL,
--	[weight] [float] NULL,
--	[ShippingWeight] [float] NULL,
--	[TireCode1] [varchar](255) NULL,
--	[TireCode2] [varchar](255) NULL,
--	[TireCode3] [varchar](255) NULL,
--	[loadRange] [varchar](255) NULL,
--	[treadWearWarranty] [varchar](255) NULL
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

update   [gravy].[dbo].[WTU_Tires_Data_Prioritized] 
  set RimDiameter = CAST( dbo.splitPosition (Replace(Replace(SizeCode,'ZR',';'),'/', ';'), 2, ';') as Float )
 where Manufacturer in ('Zeta', 'Kapsen','Landsail','Mazzini') and RimDiameter is null
   And  Sizecode like '%/%ZR%'

update   [gravy].[dbo].[WTU_Tires_Data_Prioritized] 
  set RimDiameter = CAST( dbo.splitPosition (Replace(Replace(SizeCode,'R',';'),'/', ';'), 2, ';') as Float )
 where Manufacturer in ('Zeta', 'Kapsen','Landsail','Mazzini') and RimDiameter is null
   And  Sizecode like '%/%R%'

update   [gravy].[dbo].[WTU_Tires_Data_Prioritized] 
  set RimDiameter = CAST( dbo.splitPosition (Replace(Replace(Replace(SizeCode,'R',';'),
      '/', ';'),' ', ';'), 3, ';') as Float )
 where Manufacturer in ('Zeta', 'Kapsen','Landsail','Mazzini') 
   And  Sizecode like '%/%R%'




 select distinct SizeCode, Rimdiameter  from [gravy].[dbo].[WTU_Tires_Data_Prioritized]
   where Manufacturer in ('Zeta', 'Kapsen','Landsail','Mazzini')  and RimDiameter is null

----  WORK ON 14-OCT-2022 -  EXTRACT  RIM DIAMETER

select * from  [gravy].[dbo].[WTC_TiresSheet_14OCT2022] 
 Order by Rimdiameter

UPDATE [gravy].[dbo].[WTC_TiresSheet_14OCT2022]  
  Set  Rimdiameter = NULL   Where  Rimdiameter = 'NULL'

UPDATE [gravy].[dbo].[WTC_TiresSheet_14OCT2022]  
  Set  TireCode1 = NULL   Where  TireCode1 = 'NULL'

UPDATE [gravy].[dbo].[WTC_TiresSheet_14OCT2022]  
  Set  Sizecode = Replace(Sizecode, 'ZR', 'R')   Where  Sizecode like '%ZR%'

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Tirecode1 = Trim(dbo.splitPosition(Replace(Sizecode,'R',';'), 2,';' ))
  Where  RimDiameter is NULL  And  Sizecode like '%R%'

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Tirecode1 = Trim(dbo.splitPosition(Replace(Tirecode1,' ',';'), 1,';' ))
  Where  RimDiameter is NULL  And  Tirecode1 like '% %'

------  CORRECTION  ----------
UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set  Sizecode = '295/40R21 11Y XL' ,  TireCode1 = '21'
  Where  Rows = '7560'

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set  Sizecode = '27X10X14R 8PLY' ,  TireCode1 = '14'
  Where  Rows = '12839'


UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Tirecode1 = Trim(Replace(Tirecode1,'LT',''))
  Where  RimDiameter is NULL  And  Tirecode1 like '%LT%'

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Tirecode1 = Trim(Replace(Tirecode1,'C',''))
  Where  RimDiameter is NULL  And  Tirecode1 like '%C%'

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Tirecode1 = Trim(Replace(Tirecode1,'XL',''))
  Where  RimDiameter is NULL  And  Tirecode1 like '%XL%'

----UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]  Set   TireCode1 = Case
----	When  Rows = '14370'  Then  '18'
----	When Tirecode1 like '%F%' Then  Replace(TireCode1, 'F', '')
----	When Tirecode1 like '%PLY%' Then  NULL
----	Else TireCode1 End
----  Where  RimDiameter is NULL
 
UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set Rimdiameter = Tirecode1 
  Where  RimDiameter is NULL  And  Tirecode1 IS NOT NULL


ALTER TABLE [gravy].[dbo].[WTC_TiresSheet_14OCT2022]
  ADD  RowNum  INT

UPDATE [Gravy].DBO.[WTC_TiresSheet_14OCT2022]
  Set RowNum  =  CAST(Rows as INT)

-----------------------------------------------------

  select *  from  [gravy].[dbo].[WTC_TiresSheet_14OCT2022]   -- order by  RowNum
  --Where Rimdiameter  is NULL  and  Tirecode1 is like 
  Where Rimdiameter  is  NULL  order by  RowNum


Select distinct sku from [Gravy].DBO.[WTU_Tires_Data_Prioritized] where TireType is null
and SKU in (Select distinct sku from [Gravy].[dbo].[107Attributes_09132022] where TireType is not null)


Select distinct TireType from [Gravy].[dbo].[107Attributes_09132022] where TireType is not null

Select distinct sku from TEMP_WTC_TiresSheet_Ref where -- TireType is null  and
  SKU in (Select distinct sku from [Gravy].[dbo].[107Attributes_09132022] where TireType is not null) 


----  distinct sku from [Gravy].[dbo].[107Attributes_09132022]  --  30,689  Rows
----  distinct sku from TEMP_WTC_TiresSheet_Ref    -- 19,497  Rows

select manufacturer, SKU,  Model  From
[gravy].[dbo].[WTU_Tires_Data_Prioritized]  
   where manufacturerPartNumber not in
  (SELECT manufacturerPartNumber FROM [Gravy].[dbo].[107Attributes_09132022])  Order by 1,2

select manufacturerPartNumber, manufacturer, SKU,  Model 
  FROM [Gravy].[dbo].[107Attributes_09132022]  
    where  manufacturer = 'Nitto'  Order by 2,3


select manufacturerPartNumber, manufacturer, SKU,  Model
  From  [gravy].[dbo].[WTU_Tires_Data_Prioritized] where  manufacturer = 'Nitto' order by 3


-----------  NEW TIRES DATA  ---- 21-NOV-2022 -------  


Select *  from dbo.[New-Tires_Nov]


UPDATE [Gravy].DBO.[New-Tires_Nov]
  Set AspectRatio = Trim(dbo.splitPosition(Replace(Replace(Sizecode, '/', ';'),
           'R',';'), 2,';' ))
  Where Substring(sizecode,4,1) = '/' And AspectRatio is Null  And  Sizecode like '%/%R%'

UPDATE [Gravy].DBO.[New-Tires_Nov]
  Set RimDiameter = Trim(dbo.splitPosition(Replace(Replace(Sizecode, 'R', ';'),' ',';'), 2,';' ))
  Where  RimDiameter is NULL   And  Sizecode like '%/%R% %'

UPDATE [Gravy].DBO.[New-Tires_Nov]
  Set RimDiameter = Replace(RimDiameter,'C','')
  Where  RimDiameter  like '%C%'

UPDATE [Gravy].DBO.[New-Tires_Nov]    Set SpeedRating = CASE
  When Sizecode like '%H'  Then  'H'
  When Sizecode like '%T'  Then  'T'
  When Sizecode like '%V'  Then  'V'
  When Sizecode like '%Q'  Then  'Q'
  When Sizecode like '%R'  Then  'R'
  When Sizecode like '%S'  Then  'S'     End
  Where  SpeedRating is NULL


UPDATE [Gravy].DBO.[New-Tires_Nov]    
   Set LoadIndex = CASE
    When Sizecode like '%XL %' Then  dbo.splitPosition(replace(Sizecode, 'XL ',';'), 2,';' )
    When Sizecode like '% %' Then  dbo.splitPosition(replace(Sizecode, ' ',';'), 2,';' )
	End
	Where LoadIndex is NULL


UPDATE [Gravy].DBO.[New-Tires_Nov]    
   Set LoadIndex = Trim(Replace(LoadIndex, SpeedRating, ''))
   Where charindex(SpeedRating, LoadIndex) > 0



Select *  from dbo.[New-Tires_Nov]  


