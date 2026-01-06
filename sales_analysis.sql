sales_analysis.sql

/* 
Sales Performance Analysis using SQL
Author: Ramanan
*/

-- 1. Monthly Revenue Trend
SELECT
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 2. Top 10 Products by Revenue
SELECT
  product_name,
  SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product_name
ORDER BY total_revenue DESC
FETCH FIRST 10 ROWS ONLY;

-- 3. Revenue by Region
SELECT
  region,
  SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY region
ORDER BY total_revenue DESC;

-- 4. Category-wise Revenue
SELECT
  category,
  SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC;

-- 5. Revenue Contribution of Top 3 Products
WITH product_revenue AS (
  SELECT
    product_name,
    SUM(revenue) AS total_revenue
  FROM sales_data
  GROUP BY product_name
)
SELECT
  product_name,
  ROUND(
    total_revenue * 100 /
    (SELECT SUM(total_revenue) FROM product_revenue),
    2
  ) AS revenue_percentage
FROM product_revenue
ORDER BY total_revenue DESC
FETCH FIRST 3 ROWS ONLY;

