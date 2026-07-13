SELECT
    Count(*) AS Total_Transactions,
    Sum(quantity) AS Total_Quantity_Sold
FROM Sales;


SELECT TOP 5
    p.product_name,
    SUM(s.quantity) AS Total_Qty
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Qty DESC;

SELECT 
    r.sales_region, 
    SUM(s.quantity) AS Qty_By_Region
FROM Sales s
JOIN Stores st ON s.store_id = st.store_id
JOIN Region r ON st.region_id = r.region_id
GROUP BY r.sales_region;



