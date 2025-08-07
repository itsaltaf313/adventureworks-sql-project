--project 
---Project: Querying Customer Details in AdventureWorks Database

---by Altaf shaikh
--Perform the following with help of the above database:

---a. Get all the details from the person table including email ID, phone
---number and phone number type

SELECT 
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    ph.PhoneNumber,
    pt.Name AS PhoneNumberType
FROM Person.Person p
JOIN Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
JOIN Person.PhoneNumberType pt ON ph.PhoneNumberTypeID = pt.PhoneNumberTypeID;

--b. Get the details of the sales header order made in May 2011
select *from Sales.SalesOrderHeader
SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-05-01' AND '2011-05-31';

---c. Get the details of the sales details order made in the month of May
--2011
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    soh.TotalDue,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE MONTH(soh.OrderDate) = 5
  AND YEAR(soh.OrderDate) = 2011
ORDER BY soh.OrderDate;


---d. Get the total sales made in May 2011
SELECT 
    SUM(TotalDue) AS TotalSalesInMay2011
FROM Sales.SalesOrderHeader
WHERE MONTH(OrderDate) = 5
  AND YEAR(OrderDate) = 2011;




---e. Get the total sales made in the year 2011 by month order by
--increasing sales
SELECT 
    MONTH(OrderDate) AS SalesMonth,
    SUM(TotalDue) AS TotalMonthlySales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011
GROUP BY MONTH(OrderDate)
ORDER BY TotalMonthlySales ASC;

--f. Get the total sales made to the customer with FirstName='Gustavo' 
--and LastName ='Achong'
SELECT 
    p.FirstName,
    p.LastName,
    SUM(soh.TotalDue) AS TotalSalesToCustomer
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE p.FirstName = 'Gustavo'
  AND p.LastName = 'Achong'
GROUP BY p.FirstName, p.LastName;

