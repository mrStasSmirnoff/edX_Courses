/*Use CHOOSE() and MONTH() to get the season in which each order was shipped from the Orders table. You should select the order ID, shipped date, and then the season aliased as ShippedSeason. You can copy and paste the below into your query.*/

SELECT OrderID, ShippedDate, CHOOSE(MONTH(ShippedDate),'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Autumn', 'Autumn', 'Autumn', 'Winter') AS ShippedSeason
FROM Orders
WHERE ShippedDate IS NOT NULL;


/*Using the Suppliers table, select the company name and use a simple IIF expression to display 'outdated' if a company has a fax number, or 'modern' if it doesn't. Alias the result of the IIF expression to Status.*/

SELECT CompanyName,
    CASE
       WHEN Fax IS NULL THEN 'modern'
     ELSE 'outdated'
   END AS Status
FROM Suppliers;


/*
Select from the Customers, Orders, and Order Details tables. Note that you need to use [Order Details] since the table name contains whitespace.
Use GROUP BY and ROLLUP() to get the total quantity ordered by all countries, while maintaining the total per country in your result set.
Your first column should be the country, and the second column the total quantity ordered by that country, aliased as TotalQuantity.
*/

SELECT c.Country, SUM(od.quantity) as TotalQuantity
FROM Customers as c
JOIN ORDERS as o
ON c.customerid = o.customerid
JOIN [Order Details] as od
ON o.orderid = od.orderid
GROUP BY ROLLUP(c.Country)

/*
Convert the following query to be pivoted, using PIVOT().

SELECT CategoryID, AVG(UnitPrice)
FROM Products
GROUP BY CategoryID;
*/

SELECT 'Average Unit Price' as 'Per Category', [1], [2], [3], [4], [5], [6], [7], [8]
FROM (
    SELECT CategoryId,
    AVG(UnitPrice) as UnitPrice
    FROM Products
    GROUP BY CategoryID) as SourceTable
PIVOT(AVG(UnitPrice) for CategoryID in ([1], [2], [3], [4], [5], [6], [7], [8])) as PivotTable;


/*
Insert into the Region table the region ID 5 and the description 'Space'.
Then, in a second query, select the newly inserted data from the table using a WHERE clause.
Note: When you execute a query and the result is fetched, the database will be rolled back to its initial state. This means that you can click "Run Code" repeatedly, starting with a clean slate every time.

*/

INSERT INTO REGION(RegionID, RegionDescription) 
VALUES(5, 'Space')
SELECT * 
FROM Region 
WHERE RegionID = 5

/*
Update the region descriptions in the Region table to be all uppercase, using SET and UPPER().
Next, select all data from the table to view your updates.

*/

UPDATE Region
SET regiondescription = upper(regiondescription)
SELECT * FROM Region