# SQL Practical Assignment (Questions 6–10)

This repository contains solutions to SQL practical questions focused on
database design, data manipulation, joins, window functions, and analytical
queries. The assignment uses a custom E-commerce database and the Sakila
sample database (for analytical queries).

---

## 📂 Contents

- `EcommerceDB.sql`  
  Contains database creation, table definitions, data insertion, and query
  solutions for Questions 6 to 9.

- `Sakila_Queries.sql`  
  Contains analytical SQL queries written for the Sakila sample database
  (Question 10).

- `README.md`  
  Project documentation and explanation.

---

## 🧩 Question Coverage

### ✅ Question 6
- Created `EcommerceDB`
- Designed tables:
  - Categories
  - Products
  - Customers
  - Orders
- Applied:
  - Primary Keys
  - Foreign Keys
  - NOT NULL & UNIQUE constraints
- Inserted sample records into all tables

### ✅ Question 7
- Generated a report showing:
  - CustomerName
  - Email
  - TotalNumberOfOrders
- Included customers with **zero orders**
- Used `LEFT JOIN`, `GROUP BY`, and `COUNT()`

### ✅ Question 8
- Retrieved product details along with category name
- Displayed:
  - ProductName
  - Price
  - StockQuantity
  - CategoryName
- Sorted results by CategoryName and ProductName

### ✅ Question 9
- Used **CTE (Common Table Expression)** and **Window Function**
- Identified **top 2 most expensive products** in each category
- Used `ROW_NUMBER()` with `PARTITION BY`

### ✅ Question 10 (Sakila Database – Analytical Queries)
- Identified top 5 customers by total spending
- Found top 3 movie categories by rental count
- Calculated films available and never rented per store
- Analyzed monthly revenue for the year 2023
- Identified customers with more than 10 rentals in the last 6 months

> ⚠️ **Note:**  
> Sakila database is a sample database and may not be available in all MySQL
> environments. The queries are written according to the official Sakila schema
> and are provided for analytical and learning purposes.

---

## 🛠 Tools & Technologies Used

- MySQL 8.x
- MySQL Workbench
- SQL (DDL, DML, Joins, CTEs, Window Functions)

---

## 🎯 Learning Outcomes

- Database schema design
- Data integrity using constraints
- Complex joins and aggregations
- Analytical SQL using window functions
- Real-world reporting queries

---

## 👤 Author

**AJ**  
SQL & Data Analytics Learner  

---

## 📌 How to Use

1. Clone or download the repository
2. Open `.sql` files in MySQL Workbench
3. Execute EcommerceDB queries directly
4. Sakila queries require Sakila sample database (optional)

---

## ⭐ Acknowledgement

This project was completed as part of a SQL practical assignment to strengthen
database and analytical query skills.
