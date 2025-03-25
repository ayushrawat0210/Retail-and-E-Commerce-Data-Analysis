# Retail-E-Commerce-Data-Analysis

## 🛍️ Multi-Category Product Sales Dataset (30K Rows)  

This dataset contains **30,000 rows of product data** for different categories: **Watches, Cars, Bikes, and Shoes**.  
It is designed for **SQL practice**, covering **basic, intermediate, and advanced queries** to enhance data analysis skills.  

## 📊 **Dataset Overview**  

| Column Name        | Description |
|-------------------|-------------|
| **Category**       | Product category (Watch, Car, Bike, Shoe) |
| **Product_Name**   | Name of the product |
| **Brand**         | Famous brands for each category |
| **Price**         | Product price (numeric) |
| **Manufacture_Year** | Year the product was manufactured |
| **Rating**        | Customer rating (1 to 5) |
| **Stock_Quantity** | Available stock count |
| **Seller_Location** | City where the product is sold |
| **Sales_Count**   | Total units sold |
| **Discount_Percentage** | Discount applied (%) |

---

## 🔹 **SQL Table Creation**  

Before importing the dataset, create the **`products`** table in SQL:

```sql
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Product_Name VARCHAR(255) NOT NULL,
    Brand VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    Manufacture_Year INT,
    Rating DECIMAL(2,1),
    Stock_Quantity INT,
    Seller_Location VARCHAR(100),
    Sales_Count INT,
    Discount_Percentage DECIMAL(5,2)
);

🔹 Import Data into SQL

1️⃣ Convert Excel to CSV
Save your Excel file as CSV UTF-8 to avoid encoding issues.

2️⃣ Load CSV into MySQL

LOAD DATA INFILE '/path/to/products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

📂 Files Included
products_dataset.csv → The dataset (30K rows)

SQL_queries_solutions.sql → SQL solutions for all 45 queries

README.md → Documentation

📢 Contributing
If you improve the dataset or add more SQL queries, feel free to create a pull request. 😊

🔹 Star ⭐ this repository if you found it useful!

🚀 Happy Querying!
