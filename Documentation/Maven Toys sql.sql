--Creating database and schema
CREATE DATABASE maven_toys
CREATE SCHEMA sale

--creating and filling tables tables
CREATE TABLE sale.products (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(100),
product_category VARCHAR(100),
product_cost DECIMAL,
product_price DECIMAL
);

COPY sale.products (product_id, product_name, product_category, product_cost, product_price)
FROM 'C:/Users/llllllllll/Desktop/Maven+Toys+Data/products.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sale.products

CREATE TABLE sale.stores(
store_id SERIAL PRIMARY KEY,
store_name VARCHAR(100),
store_city VARCHAR(50),
store_location VARCHAR(50),
store_open_date DATE
);
	
COPY sale.stores (store_id, store_name, store_city, store_location, store_open_date)
FROM 'C:/Users/llllllllll/Desktop/Maven+Toys+Data/stores.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sale.stores

CREATE TABLE sale.inventory (
store_id INT,
product_id INT,
stock_on_hand INT,
FOREIGN KEY (store_id) REFERENCES sale.stores(store_id),
FOREIGN KEY (product_id) REFERENCES sale.products(product_id)
);

COPY sale.inventory (store_id, product_id, stock_on_hand)
FROM 'C:/Users/llllllllll/Desktop/Maven+Toys+Data/inventory.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sale.inventory

CREATE TABLE sale.sales (
sale_id SERIAL PRIMARY KEY,
date DATE,
store_id INT,
product_id INT,
units INT,
FOREIGN KEY (store_id) REFERENCES sale.stores(store_id),
FOREIGN KEY (product_id) REFERENCES sale.products(product_id)
);

COPY sale.sales (sale_id, date, store_id, product_id, units)
FROM 'C:/Users/llllllllll/Desktop/Maven+Toys+Data/sales.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sale.sales

--Data cleaning

--Inventory table
-- checking for duplicates
SELECT *
FROM sale.inventory
GROUP BY store_id, product_id, stock_on_hand
HAVING count(*) > 1

-- product table
-- checking for duplicates
SELECT product_name, product_category
FROM sale.products
GROUP BY product_name, product_category
HAVING COUNT(*) > 1

--stores table
-- checking for duplicates
SELECT store_name, store_city, Store_location
FROM sale.stores
GROUP BY store_name, store_city, Store_location
HAVING COUNT(*) > 1

--adjusting store names
UPDATE sale.stores
SET store_name = SUBSTRING(store_name, 11)

SELECT * FROM sale.stores

-- KPIs
-- total products
SELECT COUNT(*) AS total_products
FROM sale.products

--number of categories category
SELECT COUNT (DISTINCT product_category) AS num_category
FROM sale.products

--number of stores
SELECT COUNT(*)
FROM sale.stores

--in how many cities can maven toys store be found
SELECT COUNT (DISTINCT store_city) AS num_city
FROM sale.stores

-- total units sold
SELECT SUM(units) AS total_units
FROM sale.sales

-- total stock at hand
SELECT SUM(stock_on_hand) AS total_stock
FROM sale.inventory

-- creating temp table to join product and  sales table
CREATE TEMP TABLE product_sales AS
SELECT p.product_id, p.product_name, p.product_category, 
p.product_cost, p.product_price, s.sale_id, s.date, 
s.store_id, s.units, p.product_cost * s.units AS cost, 
p.product_price * s.units AS price
FROM sale.sales as s
INNER JOIN sale.products p USING (product_id)

SELECT * FROM product_sales

-- total revenue
SELECT SUM(price) AS total_revenue
FROM product_sales

--total cost
SELECT SUM(cost) AS total_cost
FROM product_sales

--gross profit
SELECT SUM(price) - SUM(cost) AS gross_profit
FROM product_sales

--Year over year growth of revenue
WITH summed_revenue AS(
SELECT EXTRACT(year from date) AS year,
SUM(price) AS total_revenue
FROM product_sales
WHERE EXTRACT(month from date) BETWEEN 1 AND 9
GROUP BY EXTRACT(year from date)
)
SELECT p1.total_revenue AS revenue_2017,
p2.total_revenue AS revenue_2018,
ROUND(((p2.total_revenue-p1.total_revenue)/p1.total_revenue) * 100,1) AS YoY
FROM summed_revenue as p1
JOIN summed_revenue as p2 ON p1.year= 2017 AND p2.year = 2018

---OR

WITH sum_revenue_2017 AS(
SELECT EXTRACT(year from date) AS year,
SUM(price) AS total_revenue
FROM product_sales
WHERE EXTRACT(month from date) BETWEEN 1 AND 9 AND EXTRACT(year from date) =2017
GROUP BY EXTRACT(year from date)
),
sum_revenue_2018 AS(
SELECT EXTRACT(year from date) AS year,
SUM(price) AS total_revenue
FROM product_sales
WHERE EXTRACT(month from date) BETWEEN 1 AND 9 AND EXTRACT(year from date) =2018
GROUP BY EXTRACT(year from date)
)
SELECT ((e.total_revenue- s.total_revenue)/s.total_revenue)* 100 AS YOY
FROM sum_revenue_2018 as e
INNER JOIN sum_revenue_2017 as s ON e.year = 2018 AND s.year = 2017

---OR
WITH sum_revenue AS(
SELECT EXTRACT(year from date) AS year,
SUM(price) AS total_revenue
FROM product_sales
WHERE EXTRACT(month from date) BETWEEN 1 AND 9
GROUP BY EXTRACT(year from date)
),
lag_data AS(
SELECT year, total_revenue AS current_year, lag(total_revenue) OVER () AS prev_year
FROM sum_revenue
)
SELECT year, current_year, prev_year, ((current_year-prev_year)/prev_year)* 100 AS YoY
FROM lag_data

--average revenue by location
CREATE TEMP TABLE product_stores AS(
SELECT p.price,p.cost, p.store_id, s.store_name, s.store_location, s.store_city,
p.price - p.cost AS profit
FROM product_sales as p
INNER JOIN sale.stores as s USING (store_id)
) 

SELECT * FROM product_stores

--average revenue by location
SELECT store_location, AVG(price) AS avg_revenue
FROM product_stores
GROUP BY store_location
ORDER BY avg_revenue DESC

--average revenue by city
SELECT store_city, AVG(price) AS avg_revenue
FROM product_stores
GROUP BY store_city
ORDER BY avg_revenue DESC
LIMIT 5

--- top 5 cities by revenue with location in the airport
WITH revenue_by_store AS(
SELECT store_city, AVG(price) AS avg_revenue 
FROM product_stores
GROUP BY store_city
ORDER BY avg_revenue DESC
LIMIT 5
	)
SELECT r.store_city, r.avg_revenue
FROM revenue_by_store as r
INNER JOIN sale.stores as s USING(store_city)
WHERE s.store_location = 'Airport'


--average profit by location
SELECT store_location, AVG(profit) AS avg_profit
FROM product_stores
GROUP BY store_location
ORDER BY avg_profit DESC

--average profit by city
SELECT store_city, AVG(profit) AS avg_profit
FROM product_stores
GROUP BY store_city
ORDER BY avg_profit DESC
LIMIT 5

--- top 5 cities by profit with location in the airport
WITH profit_by_store AS(
SELECT store_city, AVG(profit) AS avg_profit 
FROM product_stores
GROUP BY store_city
ORDER BY avg_profit DESC
LIMIT 5
	)
SELECT p.store_city, p.avg_profit
FROM profit_by_store as p
INNER JOIN sale.stores as s USING(store_city)
WHERE s.store_location = 'Airport'

