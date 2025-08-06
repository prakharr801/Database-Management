CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Neha', 'Mumbai'),
(3, 'Rahul', 'Kolkata'),
(4, 'Priya', 'Delhi');

INSERT INTO Orders VALUES
(101, 1, '2025-01-01', 5000),
(102, 1, '2025-01-05', 3000),
(103, 2, '2025-01-03', 7000),
(104, 3, '2025-01-04', 6000),
(105, 2, '2025-01-07', 4000),
(106, 4, '2025-01-08', 9000),
(107, 4, '2025-01-10', 10000);

-- 1. View: All customer details
CREATE VIEW vw_all_customers AS
SELECT * FROM Customers;

-- 2. View: All order details
CREATE VIEW vw_all_orders AS
SELECT * FROM Orders;

-- 3. View: Orders with customer names
CREATE VIEW vw_orders_with_customers AS
SELECT o.OrderID, c.Name AS CustomerName, o.OrderDate, o.Amount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 4. View: Total orders amount per customer
CREATE VIEW vw_total_orders_per_customer AS
SELECT c.CustomerID, c.Name, SUM(o.Amount) AS TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;

-- 5. View: Customers from Delhi only
CREATE VIEW vw_customers_delhi AS
SELECT * FROM Customers WHERE City = 'Delhi';

-- 6. View: Orders above 5000
CREATE VIEW vw_large_orders AS
SELECT * FROM Orders WHERE Amount > 5000;

-- 7. View: Top 3 highest order amounts
CREATE VIEW vw_top_3_orders AS
SELECT * FROM Orders
ORDER BY Amount DESC
LIMIT 3;

-- 8. View: Customers with no orders
CREATE VIEW vw_customers_no_orders AS
SELECT c.CustomerID, c.Name
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 9. View: Average order amount per customer
CREATE VIEW vw_avg_order_per_customer AS
SELECT c.CustomerID, c.Name, AVG(o.Amount) AS AvgOrder
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;

-- 10. View: Orders placed in January 2025
CREATE VIEW vw_orders_jan_2025 AS
SELECT * FROM Orders
WHERE MONTH(OrderDate) = 1 AND YEAR(OrderDate) = 2025;
