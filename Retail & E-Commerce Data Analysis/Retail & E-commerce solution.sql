Create schema retail_and_ecommerce;
use retail_and_ecommerce;

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

select * from products;

-- ===============================================Questions=============================================================

-- 1) Retrieve all columns for the first 10 rows in the dataset.

SELECT 
    *
FROM
    products
LIMIT 10;

-- 2) Count the total number of products available.

SELECT 
    COUNT(*) AS Num_of_products
FROM
    products;
 
 -- 3) List all distinct product categories.
 
SELECT DISTINCT
    (category) AS distinct_category
FROM
    products;
    
-- 4) Find the total number of products available in stock.

SELECT 
    SUM(stock_quantity) AS Total_stock
FROM
    products;

-- 5) Retrieve products with a rating of 5.

SELECT 
    *
FROM
    products
WHERE
    rating = 5;
    
-- 6) Find the most expensive product in the dataset.

SELECT 
    *
FROM
    products
ORDER BY price DESC
LIMIT 1;

-- 7) Count how many products have a discount above 30%.

SELECT 
    COUNT(*)
FROM
    products
WHERE
    discount_percentage > 30;
 
--  8) Show all products from the brand 'Nike'.

SELECT 
    *
FROM
    products
WHERE
    brand = 'Nike';
    
-- 9) Get the average price of all products.

SELECT 
    AVG(price) AS average_price
FROM
    products;
    
-- 10) Find the oldest manufactured product.

SELECT 
    *
FROM
    products
ORDER BY manufacture_year ASC
LIMIT 1;

-- 11) Find the top 5 brands with the most products in stock.

SELECT 
    brand, SUM(stock_quantity) AS most_products_in_stock
FROM
    products
GROUP BY brand
ORDER BY most_products_in_stock DESC
LIMIT 5;

-- 12) Retrieve all products sorted by rating (highest to lowest).

SELECT 
    *
FROM
    products
ORDER BY rating DESC;

-- 13) Count how many products are available for each category.

SELECT 
    category, COUNT(*) AS product_availablity
FROM
    products
GROUP BY category;

-- 14) Find the total sales for each product category.

SELECT 
    category, SUM(sales_count) AS Total_sales
FROM
    products
GROUP BY category;

-- 15) Get the average discount for each category.

SELECT 
    category, AVG(discount_percentage) AS average_discount
FROM
    products
GROUP BY category;

-- 16) Find all products where the price is higher than the average price.

SELECT 
    *
FROM
    products
WHERE
    price > (SELECT 
            AVG(price)
        FROM
            products); 
            

-- 17) Retrieve the top 3 cities with the most sales.

SELECT 
    seller_location, SUM(sales_count) AS Most_sales
FROM
    products
GROUP BY seller_location
ORDER BY most_sales DESC
LIMIT 3;

-- 18) Find the percentage of products with stock greater than 100.

SELECT 
    COUNT(*) * 100.0 / (SELECT 
            COUNT(*)
        FROM
            products) AS stock_percentage
FROM
    products
WHERE
    stock_quantity > 100;
    
-- 19) Find the total revenue for each product category.

SELECT 
    category, SUM(price * sales_count) AS Total_revenue
FROM
    products
GROUP BY category;

-- 20) Identify the cheapest and most expensive product for each category.

SELECT 
    category,
    MIN(price) AS Cheapest_product,
    MAX(price) AS Most_expensive_product
FROM
    products
GROUP BY category;

-- 21) Find all products that were manufactured after 2020 and have a rating above 4.

SELECT 
    *
FROM
    products
WHERE
    Manufacture_Year > 2020 AND rating > 4.0;
    
-- 22) Find brands with an average product price above $500.

SELECT 
    brand, AVG(price) AS Avg_price
FROM
    products
GROUP BY brand
HAVING Avg_price > 500;

-- 23) Find the best-selling product.

SELECT 
    *
FROM
    products
ORDER BY Sales_Count DESC
LIMIT 1;

-- 24) Find products where the stock quantity is lower than the sales count.

SELECT 
    *
FROM
    products
WHERE
    Stock_Quantity < Sales_Count;
    
-- 25) Find the brand with the highest total revenue.

SELECT 
    brand, SUM(price * sales_count) AS total_revenue
FROM
    products
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 1;

-- 26) Find the total revenue contribution of each brand within its category.

SELECT Category, Brand, 
       SUM(Price * Sales_Count) AS Brand_Revenue, 
       SUM(SUM(Price * Sales_Count)) OVER (PARTITION BY Category) AS Category_Total_Revenue, 
       (SUM(Price * Sales_Count) * 100.0 / SUM(SUM(Price * Sales_Count)) OVER (PARTITION BY Category)) AS Revenue_Percentage 
FROM products 
GROUP BY Category, Brand;

-- 27) Rank products based on their sales count within each category.

SELECT category, product_name, sales_count,
RANK() OVER (PARTITION BY category ORDER BY sales_count) AS rnk
FROM products;

-- 28) Find the top 3 selling products in each category.

SELECT * FROM(
SELECT category,product_name,sales_count,
RANK() OVER (PARTITION BY category ORDER BY sales_count DESC) AS rnk
FROM products) AS ranked
WHERE rnk <= 3;

-- 29) Calculate the cumulative sales count for each product.

SELECT product_name, sales_count,
sum(sales_count) OVER (ORDER BY sales_count) AS cumulative_sales
FROM products;

-- 30) Find the product with the highest price-to-rating ratio.

SELECT 
    *, (price / rating) AS price_rating_ratio
FROM
    products
ORDER BY price_rating_ratio DESC
LIMIT 1;

-- 31) Find the city that has the most high-rated products (rating > 4).

SELECT 
    seller_location, COUNT(*) AS high_rated_product
FROM
    products
WHERE
    rating > 4
GROUP BY seller_location
ORDER BY high_rated_product DESC
LIMIT 1;

-- 32) Determine the sales trend for each year.

SELECT 
    Manufacture_year, SUM(sales_count) AS Yearly_sales
FROM
    products
GROUP BY Manufacture_Year
ORDER BY Manufacture_Year;

-- 33) Find the average discount for each rating level.

SELECT 
    rating, AVG(discount_percentage) AS Avg_discount
FROM
    products
GROUP BY rating
ORDER BY rating DESC;

-- 34) Identify the category with the highest average price per product.

SELECT 
    category, AVG(price) AS Avg_price
FROM
    products
GROUP BY category
ORDER BY Avg_price DESC
LIMIT 1;

-- 35) Find brands where the total stock is more than double the total sales.

SELECT 
    Brand,
    SUM(Stock_Quantity) AS Total_Stock,
    SUM(Sales_Count) AS Total_Sales
FROM
    products
GROUP BY Brand
HAVING SUM(Stock_Quantity) > 2 * SUM(Sales_Count);  # There is no brand whose stock quantity is greater than 2X of sales_count

-- 36) Identify the most frequently sold product per category.

SELECT 
    Category, Product_Name, MAX(sales_count) AS Max_sales
FROM
    products
GROUP BY Category , Product_Name
ORDER BY Max_sales DESC;

-- 37) Find the percentage of products that have received a rating below 3.

SELECT 
    (COUNT(*) * 100.0 / (SELECT 
            COUNT(*)
        FROM
            products)) AS Percentage_Below_3
FROM
    products
WHERE
    Rating < 3;
    
    
-- 38) Determine which year had the highest total sales across all products.

SELECT 
    manufacture_year, SUM(sales_count) AS Highest_sales
FROM
    products
GROUP BY Manufacture_Year
ORDER BY Highest_sales DESC
LIMIT 1;

-- 39) Find the most popular brand based on total sales count.

SELECT 
    brand, SUM(sales_count) AS Total_sales
FROM
    products
GROUP BY brand
ORDER BY Total_sales DESC
LIMIT 1;

-- 40) Find the product that generates the highest revenue.

SELECT 
    Product_Name, (Price * Sales_Count) AS Highest_revenue
FROM
    products
ORDER BY Highest_revenue DESC
LIMIT 1;

-- 41) Determine the percentage contribution of each category to total revenue.

SELECT 
    category,
    SUM(price * sales_count) AS Category_revenue,
    (SUM(price * sales_count) * 100.0 / (SELECT 
            SUM(price * sales_count)
        FROM
            products)) AS revenue_percentage
FROM
    products
GROUP BY category
ORDER BY revenue_percentage DESC;


-- 42) Find all products with stock between 50 and 200 units.

SELECT 
    *
FROM
    products
WHERE
    Stock_Quantity BETWEEN 50 AND 200;
    
    
-- 43) Retrieve all products that have been sold more than 5000 times but have a rating below 4.

SELECT 
    *
FROM
    products
WHERE
    Sales_Count > 5000 AND rating < 4;
    
    
-- 44) Identify the seller location that sells the most expensive products on average.

SELECT 
    seller_location, AVG(price) avg_price
FROM
    products
GROUP BY Seller_Location
ORDER BY avg_price DESC
LIMIT 1;

-- 45) Find the top 3 brands with the highest discounts applied on average.

SELECT 
    brand, AVG(discount_percentage) AS Avg_discount
FROM
    products
GROUP BY brand
ORDER BY Avg_discount DESC
LIMIT 3;

-- ===============================================Done===============================================================














