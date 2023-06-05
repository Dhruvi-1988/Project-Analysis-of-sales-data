CREATE VIEW CustomerOrder
AS 
SELECT Orders.OrderID,
		Orders.CustomerID,
	   Orders.EmployeeID,
	   Orders.OrderDate,
	   Orders.OrderDate,
	   Orders.ShipCountry,
	   Od.OrderID,
	   Od.ProductID,
	   Od.UnitPrice,
	   Od.Quantity,
	   Od.Discount,
	   (((Od.UnitPrice*Quantity*(1-Discount))/100)*100) AS ExtendedPrice,
	   Customers.CustomerID,
	   Customers.CompanyName as Customer_CompanyName,
	   Customers.Country as CustomerCountry
FROM Customers 
	JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
	JOIN "Order Details" Od ON Orders.OrderID = Od.OrderID; 
	
SELECT * FROM CustomerOrder;

CREATE VIEW ProductDetail
AS 
SELECT p.ProductID,
		p.ProductName,
		p.SupplierID,
		p.CategoryID,
		c.CategoryID,
		c.CategoryName,
		s.SupplierID,
		s.CompanyName AS Supplier
FROM Categories c 
JOIN Products p ON c.CategoryID = p.CategoryID 
JOIN Suppliers s ON s.SupplierID = p.SupplierID; 
		
SELECT * FROM ProductDetail;	

CREATE VIEW EmployeeInfo
AS 
SELECT e.employeeID, e.FirstName, e.LastName, e.firstName ||" "|| e.lastname as EmployeeName,e.country as employeecountry,
r.regiondescription
FROM Employees e 
INNER JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID 
INNER JOIN Territories t ON t.TerritoryID = et.TerritoryID 
INNER JOIN Regions r ON r.RegionID = t.RegionID
GROUP BY e.EmployeeID;

SELECT * FROM EmployeeInfo;

SELECT co.OrderID, co.OrderDate, co.ProductID, pd.ProductName, pd.CategoryName, pd.Supplier,
co.CustomerID, co.Customer_CompanyName , co.CustomerCountry, ei.EmployeeID, ei.EmployeeName, ei.FirstName, ei.LastName,ei.employeecountry,
ei.RegionDescription, co.UnitPrice, co.Quantity, co.Discount, co.ExtendedPrice 
FROM ProductDetail pd 
INNER JOIN CustomerOrder co 
ON pd.ProductID = co.ProductID
INNER JOIN EmployeeInfo ei 
ON ei.EmployeeID = co.EmployeeID;
