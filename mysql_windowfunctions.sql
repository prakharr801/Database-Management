
CREATE TABLE SalesData (
    SaleID INT PRIMARY KEY,
    SalesPerson VARCHAR(50),
    Region VARCHAR(50),
    SaleDate DATE,
    Amount DECIMAL(10,2)
);


INSERT INTO SalesData VALUES
(1, 'Amit', 'North', '2025-01-01', 5000),
(2, 'Amit', 'North', '2025-01-05', 3000),
(3, 'Neha', 'South', '2025-01-02', 7000),
(4, 'Rahul', 'East', '2025-01-04', 6000),
(5, 'Neha', 'South', '2025-01-08', 4000),
(6, 'Amit', 'North', '2025-01-10', 2000),
(7, 'Rahul', 'East', '2025-01-12', 8000),
(8, 'Priya', 'West', '2025-01-03', 9000),
(9, 'Priya', 'West', '2025-01-07', 10000),
(10, 'Amit', 'North', '2025-01-15', 1500);

-- 1. Row Number for each sale by date
SELECT 
    SaleID, SalesPerson, Amount, 
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM SalesData;

-- 2. Rank sales by amount (highest first)
SELECT 
    SaleID, SalesPerson, Amount,
    RANK() OVER (ORDER BY Amount DESC) AS SaleRank
FROM SalesData;

-- 3. Dense rank sales by amount
SELECT 
    SaleID, SalesPerson, Amount,
    DENSE_RANK() OVER (ORDER BY Amount DESC) AS DenseSaleRank
FROM SalesData;

-- 4. Running total of sales by salesperson
SELECT 
    SalesPerson, SaleDate, Amount,
    SUM(Amount) OVER (PARTITION BY SalesPerson ORDER BY SaleDate) AS RunningTotal
FROM SalesData;

-- 5. Total sales per salesperson (repeated for each row)
SELECT 
    SalesPerson, SaleDate, Amount,
    SUM(Amount) OVER (PARTITION BY SalesPerson) AS TotalSales
FROM SalesData;

-- 6. Average sale amount per region
SELECT 
    Region, SaleDate, Amount,
    AVG(Amount) OVER (PARTITION BY Region) AS AvgRegionSale
FROM SalesData;

-- 7. Previous sale amount for each salesperson
SELECT 
    Sale
