# Database Programming - Advanced SQL Project (Assignment I)

## 1. Assignment Overview
This assignment demonstrates advanced SQL programming techniques by designing an E-Commerce Platform relational schema and applying Common Table Expressions (CTEs) along with SQL Window Functions for complex business data analysis and analytical reporting.

## 2. Oracle Environment
- **Oracle Version:** Oracle Database 19c Enterprise Edition
- **Operating System:** Windows / Linux Environment
- **Tools Used:** SQL*Plus, Oracle SQL Developer, GitHub

## 3. Database Schema & ER Diagram
The system is built on a realistic business case using three interconnected tables: `Customers`, `Orders`, and `Order_Items`.

### Entity Relationship Diagram
![ER Diagram](ER_Diagram.png)

---

## 4. Task Documentation

### Part A: Common Table Expressions (CTEs)
1. **Simple CTE:** Filters high-value luxury products above $500 to assist the marketing team.
2. **Multiple CTEs:** Isolates 'Electronics' category first, then performs total revenue calculation.
3. **Recursive CTE:** Generates a continuous sequence of fiscal months for financial forecasting.
4. **CTE with Aggregation:** Groups metrics to compute the platform's average shopping basket order value.
5. **CTE combined with JOIN:** Merges individual customer registries with operational order volumes to map top buyers.

### Part B: SQL Window Functions
1. **Ranking Functions:** Employs `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, and `PERCENT_RANK()` to tier product price points within specific domains.
2. **Aggregate Window Functions:** Computes cumulative sums, moving averages, and local category margins (`MIN`/`MAX`) concurrently.
3. **Navigation Functions:** Utilizes `LAG()` and `LEAD()` to map financial baseline progressions against adjacent tier metrics.
4. **Distribution Functions:** Segregates inventory profiles into equal pricing buckets utilizing `NTILE()` and `CUME_DIST()`.

---

## 5. Challenges and Solutions
- **Challenge:** Handling relational integrity mapping and recursive depth limits during the recursive sequence evaluation.
- **Solution:** Configured structured constraints on the operational loop anchor `WHERE MonthNumber < 6` to securely terminate execution bounds.

## 6. Lessons Learned
- Mastery of analytical database abstraction methods using isolating sub-query blocks.
- Practical experience translating descriptive analytical tracking demands into active transactional code.

## 7. Academic Integrity Statement
I confirm that this assignment represents my own original practical work, schema designs, and documentation. All external resources and concepts utilized have been properly acknowledged in accordance with university regulations.
