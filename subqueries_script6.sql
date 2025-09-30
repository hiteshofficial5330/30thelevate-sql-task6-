-- SQL DEVELOPER INTERNSHIP - TASK 6
-- Objective: Use subqueries in SELECT, WHERE, and FROM.

USE ecommerce_db_task6;

-- Query 1: Subquery in a WHERE clause with IN
-- Question: Find the names of all customers who have placed an order.
-- The inner query gets the list of CustomerIDs from the Orders table.
-- The outer query then finds the customers matching that list.
SELECT FirstName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);

-- Query 2: Scalar Subquery in a WHERE clause
-- Question: Find the product with the highest price.
-- The inner query finds the maximum price, which is a single (scalar) value.
-- The outer query then finds the product that has this price.
SELECT ProductName, Price
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

-- Query 3: Subquery in a FROM clause (Derived Table)
-- Question: Find all orders with a total amount greater than the average of all orders.
-- The inner query first calculates the average total amount.
-- We use this average in the outer query's WHERE clause to filter the orders.
SELECT OrderID, TotalAmount
FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- Query 4: Correlated Subquery with EXISTS
-- Question: Find all customers who have placed at least one order. (Similar to Q1, but uses EXISTS)
-- The EXISTS operator checks if the subquery returns any rows.
-- The subquery is 'correlated' because it refers to the Customers table from the outer query (C.CustomerID).
SELECT FirstName
FROM Customers C
WHERE EXISTS (SELECT 1 FROM Orders O WHERE O.CustomerID = C.CustomerID);

-- Query 5: Subquery in a SELECT clause (Scalar Correlated Subquery)
-- Question: For each customer, show their name and the total number of orders they've placed.
-- The subquery is executed for each customer row to calculate their specific order count.
SELECT
    C.FirstName,
    (SELECT COUNT(*) FROM Orders O WHERE O.CustomerID = C.CustomerID) AS NumberOfOrders
FROM Customers C;
