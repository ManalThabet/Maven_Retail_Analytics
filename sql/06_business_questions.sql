use RETAIL_Graduation_Project
-- Q1: What is the total number of transactions and quantity sold?
SELECT
    COUNT(*)       AS Total_Transactions,
    SUM(quantity)  AS Total_Quantity_Sold
FROM Sales;

-- Q2: What are the top 5 best-selling products by quantity?
SELECT TOP 5
    p.product_name,
    SUM(s.quantity) AS Total_Qty_Sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Qty_Sold DESC;

-- Q3: What is the total revenue by country?
SELECT
    st.store_country,
    SUM(s.quantity * p.product_retail_price) AS Total_Revenue
FROM Sales s
JOIN Products p  ON s.product_id  = p.product_id
JOIN Stores  st  ON s.store_id    = st.store_id
GROUP BY st.store_country
ORDER BY Total_Revenue DESC;

-- Q4: What is the revenue by region?
SELECT
    r.sales_region,
    SUM(s.quantity * p.product_retail_price) AS Revenue_By_Region
FROM Sales s
JOIN Products p ON s.product_id  = p.product_id
JOIN Stores  st ON s.store_id    = st.store_id
JOIN Region   r ON st.region_id  = r.region_id
GROUP BY r.sales_region
ORDER BY Revenue_By_Region DESC;

-- Q5: What is the monthly revenue for 1997 vs 1998?
SELECT
    YEAR(transaction_date)  AS Year,
    MONTH(transaction_date) AS Month,
    SUM(s.quantity * p.product_retail_price) AS Monthly_Revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY Year, Month;

-- Q6: What is the Year-over-Year growth?
WITH YearlyRevenue AS (
    SELECT
        YEAR(s.transaction_date) AS Year,
        SUM(s.quantity * p.product_retail_price) AS Total_Revenue
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    GROUP BY YEAR(s.transaction_date)
)
SELECT
    y1.Year,
    y1.Total_Revenue,
    y2.Total_Revenue AS Prev_Year_Revenue,
    ROUND(
        (y1.Total_Revenue - y2.Total_Revenue) / y2.Total_Revenue * 100
    , 2) AS YoY_Growth_Pct
FROM YearlyRevenue y1
LEFT JOIN YearlyRevenue y2 ON y1.Year = y2.Year + 1
ORDER BY y1.Year;

-- Q7: What is the total return rate?
SELECT
    SUM(r.quantity)                                        AS Total_Returns,
    SUM(s.quantity)                                        AS Total_Sales,
    ROUND(
        CAST(SUM(r.quantity) AS FLOAT) / SUM(s.quantity) * 100
    , 2)                                                   AS Return_Rate_Pct
FROM Sales s, Returns r;

-- Q8: Which products have the highest return rate?
SELECT TOP 5
    p.product_name,
    SUM(r.quantity) AS Total_Returns
FROM Returns r
JOIN Products p ON r.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Returns DESC;


-- Q9: What is the revenue by customer occupation?
SELECT
    c.occupation,
    SUM(s.quantity * p.product_retail_price) AS Revenue_By_Occupation
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products  p ON s.product_id  = p.product_id
GROUP BY c.occupation
ORDER BY Revenue_By_Occupation DESC;

-- Q10: Who are the top 10 customers by revenue?
SELECT TOP 10
    c.first_name + ' ' + c.last_name AS Customer_Name,
    c.occupation,
    SUM(s.quantity * p.product_retail_price) AS Total_Revenue
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products  p ON s.product_id  = p.product_id
GROUP BY c.first_name, c.last_name, c.occupation
ORDER BY Total_Revenue DESC;

-- Q11: What is the average order value?
SELECT
    ROUND(
        SUM(s.quantity * p.product_retail_price) / COUNT(*)
    , 2) AS Avg_Order_Value
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

-- Q12: Which region underperforms?
SELECT
    r.sales_region,
    SUM(s.quantity * p.product_retail_price) AS Revenue,
    COUNT(*) AS Transactions
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
JOIN Stores  st ON s.store_id   = st.store_id
JOIN Region   r ON st.region_id = r.region_id
GROUP BY r.sales_region
ORDER BY Revenue ASC;
