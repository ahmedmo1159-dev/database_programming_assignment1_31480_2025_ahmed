# Database Programming Assignment I: CTEs & SQL Window Functions Project

## Business Problem & Scenario
This project implements a Sales and Employee Management System designed to track employee performance, hierarchy, customer orders, and regional revenue patterns. The primary goal is to leverage advanced analytical SQL queries to simplify data processing, discover high-value customers, evaluate sales agent efficiency, and understand organizational structure performance.

## Database Schema
The database consists of three related tables:
1. **Employees**: Tracks employee identities, their operational roles, and hierarchical reporting lines.
2. **Customers**: Contains customer profile information and location.
3. **Sales**: Logs transactional details, connecting sales agents to customers with precise purchase timestamps and financial amounts.

---

## Part A: Common Table Expressions (CTEs)

### 1. Simple CTE
Retrieves essential data directly from the employees' record table to list personnel and their designated operational assignments.
```sql
WITH Simple_CTE AS (
    SELECT EmployeeID, Name, Role FROM Employees
)
SELECT * FROM Simple_CTE;
```
* **Business Value:** Provides a clean, isolated perspective of the workforce without exposing complex transactional records.

### 2. Multiple CTEs
Combines aggregations of total performance metrics per sales agent with distinct personnel identifiers.
```sql
WITH Total_Sales_CTE AS (
    SELECT EmployeeID, SUM(Amount) AS Total_Amount FROM Sales GROUP BY EmployeeID
),
Emp_Info_CTE AS (
    SELECT EmployeeID, Name FROM Employees
)
SELECT e.Name, s.Total_Amount 
FROM Emp_Info_CTE e 
JOIN Total_Sales_CTE s ON e.EmployeeID = s.EmployeeID;
```
* **Business Value:** Enables upper management to quickly cross-reference individual names directly against cumulative corporate revenue generation.

### 3. Recursive CTE
Traverses the internal reporting structure to map organizational hierarchy levels from the executive down to field sales agents.
```sql
SELECT EmployeeID, Name, ManagerID, LEVEL as Lvl
FROM Employees
START WITH ManagerID IS NULL
CONNECT BY PRIOR EmployeeID = ManagerID;
```
* **Business Value:** Essential for corporate compliance, auditing reporting paths, and assessing spans of control.

### 4. CTE with Aggregation
Summarizes customer engagement parameters by measuring purchase habits, computing average transactions, and order frequency.
```sql
WITH Sales_Agg_CTE AS (
    SELECT CustomerID, AVG(Amount) AS Avg_Spent, COUNT(SaleID) AS Total_Orders 
    FROM Sales GROUP BY CustomerID
)
SELECT * FROM Sales_Agg_CTE;
```
* **Business Value:** Assists marketing departments in isolating high-value accounts from casual buyers to adjust tailored incentive programs.

### 5. CTE Combined with JOIN Operations
Bridges specific transactional sales orders with localized consumer registration files.
```sql
WITH Customer_Sales_CTE AS (
    SELECT SaleID, CustomerID, Amount FROM Sales
)
SELECT c.CustomerName, s.Amount 
FROM Customers c 
JOIN Customer_Sales_CTE s ON c.CustomerID = s.CustomerID;
```
* **Business Value:** Connects real-time transactional velocity directly to client identities, tracking immediate corporate cash flows.

---

## Part B: SQL Window Functions

### 1. Ranking Functions
Applies positional indices (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `PERCENT_RANK`) on transactions based on size.
```sql
SELECT 
    SaleID, EmployeeID, Amount,
    ROW_NUMBER() OVER (ORDER BY Amount DESC) AS Row_Num,
    RANK() OVER (ORDER BY Amount DESC) AS Rnk,
    DENSE_RANK() OVER (ORDER BY Amount DESC) AS Dense_Rnk,
    PERCENT_RANK() OVER (ORDER BY Amount DESC) AS Pct_Rnk
FROM Sales;
```
* **Business Value:** Establishes performance leaderboards for sales rewards and isolates outlying maximum transactions.

### 2. Aggregate Window Functions
Computes inline statistical summaries (`SUM`, `AVG`, `MIN`, `MAX`) grouped across individual staff members.
```sql
SELECT 
    SaleID, EmployeeID, Amount,
    SUM(Amount) OVER (PARTITION BY EmployeeID) AS Total_Sales,
    AVG(Amount) OVER (PARTITION BY EmployeeID) AS Avg_Sales,
    MIN(Amount) OVER (PARTITION BY EmployeeID) AS Min_Sale,
    MAX(Amount) OVER (PARTITION BY EmployeeID) AS Max_Sale
FROM Sales;
```
* **Business Value:** Monitors employee consistency over time, providing direct baselines for internal operational performance evaluation.

### 3. Navigation Functions
Fetches preceding (`LAG`) and succeeding (`LEAD`) values inside chronological transactional sales rows.
```sql
SELECT 
    SaleID, SaleDate, Amount,
    LAG(Amount, 1, 0) OVER (ORDER BY SaleDate) AS Previous_Sale_Amount,
    LEAD(Amount, 1, 0) OVER (ORDER BY SaleDate) AS Next_Sale_Amount
FROM Sales;
```
* **Business Value:** Performs horizontal trend analysis to monitor real-time growth or contraction vectors across transaction events.

### 4. Distribution Functions
Categorizes revenue profiles into distinct analytical groups (`NTILE`) and maps statistical distribution positions (`CUME_DIST`).
```sql
SELECT 
    SaleID, Amount,
    NTILE(2) OVER (ORDER BY Amount DESC) AS Tile_Group,
    CUME_DIST() OVER (ORDER BY Amount DESC) AS Cumulative_Dist
FROM Sales;
```
* **Business Value:** Segregates business revenue distributions into percentiles to define tier structures for product classifications.

---

## Analysis and Findings

### 1. Descriptive Analysis (What Happened?)
The system recorded major active transactions distributed between distinct field agents. Client accounts in Kigali registered immediate engagement spikes, generating major transactional values up to 7,000. 

### 2. Diagnostic Analysis (Why Did It Happen?)
Higher revenue performance is heavily associated with specific sales team personnel. High transaction amounts are tied to focused corporate buyer profiles, while lower volumes correspond to minor regional retailers who place small, spread-out orders.

### 3. Prescriptive Analysis (What Actions Should Be Taken?)
Management should transition lower-performing agents into targeted client mentorship tracks led by top performers. Sales frameworks must deploy distinct strategic efforts to convert occasional single-purchase client profiles into consistent contract agreements.

---

## Academic Integrity Statement
I hereby declare that this submission is my own original work. No part of this project has been copied from external internet repositories, classmates, or unauthorized sources in accordance with university regulations.

## References
- Oracle Documentation: Database SQL Language Reference.
- Course Materials: C11665 - DPR400210 Database Programming Lectures by Eric Maniraguha.# database_programming_assignment1_31480_2025_ahmed
