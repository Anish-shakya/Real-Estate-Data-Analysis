
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
SELECT Serial_Number,year,month,Town,Address,Assessed_Value,Sales,Property_Type,Residential_Type,Sales_ratio
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
ORDER BY year,Maximum_sales desc


----max,min and avg sales of each residential type 
SELECT Residential_Type,MAX(SALES) AS Maximum_sales,MIN(Sales) AS Minimum_sales, ROUND(AVG(sales),2) AS Average_sales
FROM RealState
WHERE Residential_Type <> 'Not Defined'
GROUP BY Residential_Type

----- checking distinct year
select distinct(year)
from RealState
order by year

--checking total yearly sales --
SELECT year,sum(Sales) As Yearly_Sales
FROM RealState
GROUP BY year
ORDER BY year

--- checking over all sales
SELECT SUM(Sales) AS Overall_Sales
FROM RealState


--checking total sales of 11 years from 1999 to 2010 
SELECT SUM(Sales) AS Yearly_Sales
FROM RealState
where year in ('1999','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010')


--checking total sales of 11 years from 2010 to 2021
SELECT SUM(Sales) AS Yearly_Sales
FROM RealState
WHERE year IN ('2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021')

--checking growth percentage between 2020 to 2021
--total sales for 2020
SELECT SUM(Sales) AS Yearly_Sales
FROM RealState
WHERE year = '2020'

--total sales for 2021
SELECT SUM(Sales) As Yearly_Sales
from RealState
WHERE year = '2021'

--calculating percentage growth in sales from 2020 to 2021
SELECT 
SUM(CASE WHEN year = '2020' THEN Sales ELSE 0 END) AS sales_2020,
SUM(CASE WHEN year ='2021' THEN Sales ELSE 0 END) AS sales_2021,
ROUND(((SUM(CASE WHEN year ='2021' THEN Sales ELSE 0 END) - SUM(CASE WHEN year ='2020' THEN Sales ELSE 0 END))/SUM(CASE WHEN year ='2020' THEN Sales ELSE 0 END)) * 100,1) AS Percentage_Growth	
FROM RealState
WHERE year IN ('2020','2021')
---------------------------------------------------------------------------

