
------ year and month extraction FROM date------
SELECT year(sales_date)
FROM real_state

ALTER table real_state
ADD  year varchar(20)

ALTER table real_state
ADD month varchar(20)

UPDATE real_state
SET year = year(sales_date),month = DATENAME(MONTH,sales_date)


----rounding of sales ratio -----
UPDATE real_state
SET Sales_Ratio = ROUND(Sales_Ratio,2)

---- updating NULL values of residental type and property type as 'Not Define'
SELECT * FROM 
real_state
WHERE Property_Type IS NULL and Residential_Type IS NULL

UPDATE real_state
SET Residential_Type ='Not Define'
WHERE Residential_Type ='Not define'

UPDATE real_state
SET Residential_Type ='Not Define'
WHERE Residential_Type IS NULL

------checking distinct property type and residental type---
SELECT DISTINCT(Property_Type) 
FROM real_state
SELECT DISTINCT(Residential_Type) 
FROM real_state

---- checking distinct town-----------
SELECT DISTINCT(Town)
FROM real_state
ORDER BY Town

----Updating unkown town as  'Not Define'
UPDATE real_state
SET Town ='Not Define'
WHERE Town= '***Unknown***'

SELECT * FROM real_state

CREATE VIEW RealState AS
SELECT Serial_Number,year,month,Town,Address,Assessed_Value,Sales,Property_Type,Residential_Type
FROM real_state
GO

SELECT * FROM RealState
------ checking total number of property by property types

SELECT Property_Type,COUNT(Serial_Number) as total_Property_count
FROM RealState
GROUP BY Property_Type
ORDER BY total_Property_count DESC


------ checking total number of property by Residental types
SELECT Residential_Type,COUNT(Serial_Number) as total_residental_count
FROM RealState
GROUP BY Residential_Type
ORDER BY total_residental_count DESC


---checking total sales of property by property types
 
 SELECT Property_Type,SUM(CAST(Sales AS BIGINT)) AS Total_Sales
 FROM RealState
 GROUP BY Property_Type
 ORDER BY Total_Sales DESC

  ---checking total sales of property by Residental types
 
 SELECT Residential_Type,SUM(CAST(Sales AS BIGINT)) AS Total_Sales
 FROM RealState
 GROUP BY Residential_Type
 ORDER BY Total_Sales DESC

 ----Checking total sales of property type and residental type  in year
 SELECT year,Property_Type,SUM(Sales) AS Total_sales_Property
 FROM RealState
 WHERE Property_Type <> 'Not Defined'
 GROUP BY year,Property_Type
 ORDER BY year


 ---total sales in year
  SELECT year,SUM(Sales) AS Total_Sales
 FROM RealState
 WHERE Property_Type <> 'Not Defined'
 GROUP BY year
 ORDER BY year 

 -- top five year with highest sale
  SELECT TOP 5 year,SUM(Sales) AS Total_Sales
 FROM RealState
 WHERE Property_Type <> 'Not Defined'
 GROUP BY year
 ORDER BY year DESC


 ---sales group by month and year of 2021

SELECT year,month ,sum(sales) AS total_sales
FROM RealState
GROUP BY year,month
ORDER BY year desc,month asc


----max,min and avg sales of each property type 
SELECT year,Property_Type,MAX(SALES) AS Maximum_sales,MIN(Sales) AS Minimum_sales, ROUND(AVG(sales),2) AS Average_sales
FROM RealState
WHERE Property_Type <> 'Not Defined'
GROUP BY year,Property_Type
order by year,Maximum_sales desc


----max,min and avg sales of each residential type 
SELECT Residential_Type,MAX(SALES) AS Maximum_sales,MIN(Sales) AS Minimum_sales, ROUND(AVG(sales),2) AS Average_sales
FROM RealState
WHERE Residential_Type <> 'Not Defined'
GROUP BY Residential_Type

