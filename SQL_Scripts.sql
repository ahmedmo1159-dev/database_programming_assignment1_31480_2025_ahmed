-- =====================================================
-- DATABASE PROGRAMMING ASSIGNMENT I
-- Course: Database Programming
-- Student: Ahmed
-- Business Scenario: E-Commerce Platform
-- =====================================================

-- ===========================================
-- CREATE TABLES
-- ===========================================

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Country VARCHAR2(50)
);

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    OrderDate DATE,
    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE Order_Items (
    ItemID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    ProductName VARCHAR2(100),
    Category VARCHAR2(50),
    Quantity NUMBER,
    Price NUMBER(10,2),
    CONSTRAINT fk_order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);

-- ===========================================
-- INSERT DATA INTO CUSTOMERS
-- ===========================================

INSERT INTO Customers VALUES (1,'Ali','Rwanda');
INSERT INTO Customers VALUES (2,'Mona','Kenya');
INSERT INTO Customers VALUES (3,'Ahmed','Uganda');
INSERT INTO Customers VALUES (4,'Eric','Rwanda');

-- ===========================================
-- INSERT DATA INTO ORDERS
-- ===========================================

INSERT INTO Orders VALUES (101,1,DATE '2026-06-01');
INSERT INTO Orders VALUES (102,2,DATE '2026-06-03');
INSERT INTO Orders VALUES (103,3,DATE '2026-06-05');
INSERT INTO Orders VALUES (104,4,DATE '2026-06-07');

-- ===========================================
-- INSERT DATA INTO ORDER ITEMS
-- ===========================================

INSERT INTO Order_Items VALUES (1,101,'Laptop','Electronics',1,1200);
INSERT INTO Order_Items VALUES (2,101,'Mouse','Electronics',2,30);
INSERT INTO Order_Items VALUES (3,102,'Chair','Furniture',4,120);
INSERT INTO Order_Items VALUES (4,103,'Phone','Electronics',2,800);
INSERT INTO Order_Items VALUES (5,104,'Desk','Furniture',1,300);

COMMIT;
-- ===========================================
-- PART A : COMMON TABLE EXPRESSIONS (CTEs)
-- ===========================================

-- 1. Simple CTE
WITH Simple_CTE AS (
    SELECT CustomerID, CustomerName, Country
    FROM Customers
)
SELECT * FROM Simple_CTE;

------------------------------------------------

-- 2. Multiple CTEs
WITH CustomerOrders AS (
    SELECT CustomerID, COUNT(*) TotalOrders
    FROM Orders
    GROUP BY CustomerID
),
CustomerInfo AS (
    SELECT CustomerID, CustomerName
    FROM Customers
)
SELECT c.CustomerName, o.TotalOrders
FROM CustomerInfo c
JOIN CustomerOrders o
ON c.CustomerID = o.CustomerID;

------------------------------------------------

-- 3. Recursive CTE
WITH Numbers (Num) AS (
    SELECT 1 FROM DUAL
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 5
)
SELECT * FROM Numbers;

------------------------------------------------

-- 4. CTE with Aggregation
WITH Sales AS (
    SELECT SUM(Price * Quantity) TotalSales
    FROM Order_Items
)
SELECT * FROM Sales;

------------------------------------------------

-- 5. CTE with JOIN
WITH CustomerSales AS (
    SELECT c.CustomerName,
           o.OrderID
    FROM Customers c
    JOIN Orders o
    ON c.CustomerID = o.CustomerID
)
SELECT *
FROM CustomerSales;
-- ===========================================
-- PART B : WINDOW FUNCTIONS
-- ===========================================

-- 1. ROW_NUMBER()
SELECT ProductName,
       Price,
       ROW_NUMBER() OVER(ORDER BY Price DESC) AS Row_Num
FROM Order_Items;

------------------------------------------------

-- 2. RANK()
SELECT ProductName,
       Price,
       RANK() OVER(ORDER BY Price DESC) AS Ranking
FROM Order_Items;

------------------------------------------------

-- 3. DENSE_RANK()
SELECT ProductName,
       Price,
       DENSE_RANK() OVER(ORDER BY Price DESC) AS Dense_Ranking
FROM Order_Items;

------------------------------------------------

-- 4. PERCENT_RANK()
SELECT ProductName,
       Price,
       PERCENT_RANK() OVER(ORDER BY Price) AS Percent_Rank
FROM Order_Items;

------------------------------------------------

-- 5. SUM() OVER()
SELECT ProductName,
       Price,
       SUM(Price) OVER() AS Total_Price
FROM Order_Items;

------------------------------------------------

-- 6. AVG() OVER()
SELECT ProductName,
       Price,
       AVG(Price) OVER() AS Average_Price
FROM Order_Items;

------------------------------------------------

-- 7. MIN() OVER()
SELECT ProductName,
       Price,
       MIN(Price) OVER() AS Minimum_Price
FROM Order_Items;

------------------------------------------------

-- 8. MAX() OVER()
SELECT ProductName,
       Price,
       MAX(Price) OVER() AS Maximum_Price
FROM Order_Items;

------------------------------------------------

-- 9. LAG()
SELECT ProductName,
       Price,
       LAG(Price) OVER(ORDER BY Price) AS Previous_Price
FROM Order_Items;

------------------------------------------------

-- 10. LEAD()
SELECT ProductName,
       Price,
       LEAD(Price) OVER(ORDER BY Price) AS Next_Price
FROM Order_Items;

------------------------------------------------

-- 11. NTILE()
SELECT ProductName,
       Price,
       NTILE(4) OVER(ORDER BY Price DESC) AS Quartile
FROM Order_Items;

------------------------------------------------

-- 12. CUME_DIST()
SELECT ProductName,
       Price,
       CUME_DIST() OVER(ORDER BY Price) AS Cumulative_Distribution
FROM Order_Items;
