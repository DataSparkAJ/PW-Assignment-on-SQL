-- =========================================================
-- SQL Practical Question Answers (6 – 10)
-- =========================================================
-- =========================================================
-- Question 6: Create ECommerceDB, Tables and Insert Records
-- =========================================================

CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Data into Categories
INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

-- Insert Data into Products
INSERT INTO Products VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

-- Insert Data into Customers
INSERT INTO Customers VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

-- Insert Data into Orders
INSERT INTO Orders VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 4, '2023-09-24', 120.00),
(1006, 3, '2023-06-19', 20.00);

-- =========================================================
-- Question 7: Customer Order Report
-- =========================================================

SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberOfOrders
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Email
ORDER BY c.CustomerName;


-- =========================================================
-- Question 8: Product Information with Category
-- =========================================================

SELECT
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
JOIN Categories c
ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName;

-- =========================================================
-- Question 9: Top 2 Most Expensive Products in Each Category
-- =========================================================

WITH RankedProducts AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName
            ORDER BY p.Price DESC
        ) AS rn
    FROM Products p
    JOIN Categories c
    ON p.CategoryID = c.CategoryID
)
SELECT
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE rn <= 2;

-- =========================================================
-- Question 10: Sakila Database Analysis
-- =========================================================

USE sakila;

-- 1. Top 5 Customers by Total Amount Spent
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    SUM(p.amount) AS total_amount_spent
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_amount_spent DESC
LIMIT 5;

-- 2. Top 3 Movie Categories by Rental Count
SELECT
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY rental_count DESC
LIMIT 3;

-- 3. Films Available and Never Rented per Store
SELECT
    s.store_id,
    COUNT(i.inventory_id) AS total_films,
    SUM(
        CASE 
            WHEN r.rental_id IS NULL THEN 1
            ELSE 0
        END
    ) AS never_rented_films
FROM store s
JOIN inventory i ON s.store_id = i.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;

-- 4. Total Revenue per Month for 2023
SELECT
    MONTH(payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY MONTH(payment_date)
ORDER BY month;

-- 5. Customers with More Than 10 Rentals in Last 6 Months
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(r.rental_id) > 10;
