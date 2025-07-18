CREATE DATABASE projectkms_db;

select * from KMS$
----Product category with the highest sales----

SELECT [Product Category], SUM(Sales) AS TotalSales
FROM KMS$
GROUP BY [Product Category]
ORDER BY TotalSales DESC; 

----Top 3 and Bottom 3 regions in terms of sales----

SELECT Region, SUM(Sales) AS TotalSales
FROM KMS$
GROUP BY Region
ORDER BY TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
 
----Bottom 3----

SELECT Region, SUM(Sales) AS TotalSales
FROM KMS$
GROUP BY Region
ORDER BY TotalSales ASC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

----Total sales of appliances in Ontario---

SELECT SUM(Sales) AS OntarioApplianceSales
FROM KMS$
WHERE [Product Category] = 'Appliances' AND Province = 'Ontario';

----Recommendation to improve revenue from bottom 10 customer----

SELECT [Customer Name], SUM(Sales) AS TotalSales
FROM KMS$
GROUP BY [Customer Name]
ORDER BY TotalSales ASC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY; 

---- Shipping method with the highest shipping cost----

SELECT [Ship Mode], SUM([Shipping Cost]) AS Totalshippingcost
FROM KMS$
GROUP BY [Ship Mode]
ORDER BY Totalshippingcost	DESC;

----Most valuable customers and what they purchase----

SELECT [Customer Name],[Product Category], SUM(Profit) AS TotalProfit
FROM KMS$
GROUP BY [Customer Name], [Product Category]
ORDER BY TotalProfit DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

----Small business customer with the highest sales----

SELECT [Customer Name], SUM(Sales) AS TotalSales
FROM KMS$
WHERE [Customer Segment] = 'Small Business'
GROUP BY [Customer Name]
ORDER BY TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

---- Corporate customer with most orders (2009–2012)----

SELECT [Customer Name], SUM(Sales) AS TotalSales
FROM KMS$
WHERE [Customer Segment] = 'Corporate' AND YEAR ([Order Date]) BETWEEN 2009 AND 2012 
GROUP BY [Customer Name]
ORDER BY TotalSales DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

 ----Most profitable consumer customer----

 SELECT [Customer Name], SUM(Profit) AS TotalProfit
FROM KMS$
WHERE [Customer Segment] = 'Consumer'
GROUP BY [Customer Name]
ORDER BY TotalProfit DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

----Customers who returned items and their segment----

SELECT DISTINCT [Customer Name], [Customer Segment], Sales, Profit
FROM KMS$
WHERE Profit < 0
ORDER BY Profit;

----Was shipping cost justified by order priority----

SELECT [Order Priority], [Ship Mode], COUNT(*) AS OrderCount, SUM([Shipping Cost]) AS TotalShippingCost
FROM KMS$
GROUP BY [Order Priority], [Ship Mode]
ORDER BY [Order Priority], [Ship Mode];
