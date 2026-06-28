-- ==========================================================
-- DATABASE PROGRAMMING ASSIGNMENT I
-- Course: Database Programming
-- Business Scenario: E-Commerce Platform
-- Oracle Database 19c
-- ==========================================================

-- Drop tables (optional)
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Order_Items'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Orders'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Customers'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100) NOT NULL,
    Country VARCHAR2(50)
);

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER NOT NULL,
    OrderDate DATE,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE Order_Items (
    ItemID NUMBER PRIMARY KEY,
    OrderID NUMBER NOT NULL,
    ProductName VARCHAR2(100),
    Category VARCHAR2(50),
    Quantity NUMBER,
    Price NUMBER(10,2),
    CONSTRAINT fk_items_order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);

-- =========================
-- INSERT DATA
-- =========================

INSERT INTO Customers VALUES (1,'Ali','Rwanda');
INSERT INTO Customers VALUES (2,'Mona','Kenya');
INSERT INTO Customers VALUES (3,'Ahmed','Uganda');
INSERT INTO Customers VALUES (4,'Eric','Rwanda');

INSERT INTO Orders VALUES (101,1,DATE '2026-06-01');
INSERT INTO Orders VALUES (102,2,DATE '2026-06-02');
INSERT INTO Orders VALUES (103,3,DATE '2026-06-03');
INSERT INTO Orders VALUES (104,4,DATE '2026-06-04');

INSERT INTO Order_Items VALUES (1,101,'Laptop','Electronics',1,1200);
INSERT INTO Order_Items VALUES (2,101,'Mouse','Electronics',2,30);
INSERT INTO Order_Items VALUES (3,102,'Chair','Furniture',4,120);
INSERT INTO Order_Items VALUES (4,103,'Phone','Electronics',2,800);
INSERT INTO Order_Items VALUES (5,104,'Desk','Furniture',1,300);

COMMIT;

-- =========================
-- PART A : CTE
-- =========================

-- 1. Simple CTE
WITH CustomerList AS (
    SELECT CustomerID, CustomerName, Country
    FROM Customers
)
SELECT * FROM CustomerList;

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

-- 3. Recursive CTE (Oracle)
WITH Numbers (Num) AS (
    SELECT 1 FROM dual
    UNION ALL
    SELECT Num + 1 FROM Numbers WHERE Num < 5
)
SEARCH DEPTH FIRST BY Num SET ord
SELECT Num FROM Numbers;

-- 4. CTE with Aggregation
WITH Sales AS (
    SELECT SUM(Price*Quantity) TotalSales
    FROM Order_Items
)
SELECT * FROM Sales;

-- 5. CTE with JOIN
WITH CustomerSales AS (
SELECT c.CustomerName,o.OrderID,o.OrderDate
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
)
SELECT * FROM CustomerSales;

-- =========================
-- PART B : WINDOW FUNCTIONS
-- =========================

SELECT ProductName,Price,
ROW_NUMBER() OVER(ORDER BY Price DESC) Row_Num
FROM Order_Items;

SELECT ProductName,Price,
RANK() OVER(ORDER BY Price DESC) Ranking
FROM Order_Items;

SELECT ProductName,Price,
DENSE_RANK() OVER(ORDER BY Price DESC) Dense_Ranking
FROM Order_Items;

SELECT ProductName,Price,
PERCENT_RANK() OVER(ORDER BY Price) Percent_Rank
FROM Order_Items;

SELECT ProductName,Price,
SUM(Price) OVER() Total_Price
FROM Order_Items;

SELECT ProductName,Price,
AVG(Price) OVER() Average_Price
FROM Order_Items;

SELECT ProductName,Price,
MIN(Price) OVER() Minimum_Price
FROM Order_Items;

SELECT ProductName,Price,
MAX(Price) OVER() Maximum_Price
FROM Order_Items;

SELECT ProductName,Price,
LAG(Price) OVER(ORDER BY Price) Previous_Price
FROM Order_Items;

SELECT ProductName,Price,
LEAD(Price) OVER(ORDER BY Price) Next_Price
FROM Order_Items;

SELECT ProductName,Price,
NTILE(4) OVER(ORDER BY Price DESC) Quartile
FROM Order_Items;

SELECT ProductName,Price,
CUME_DIST() OVER(ORDER BY Price) Cumulative_Distribution
FROM Order_Items;
