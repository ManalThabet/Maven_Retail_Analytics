CREATE VIEW View_Final_Analysis AS

SELECT 
    s.transaction_date,
    s.quantity,
    p.product_name,
    p.product_retail_price,
    st.store_name,
    r.sales_region,
    c.customer_city
  
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
JOIN Stores st ON s.store_id = st.store_id
JOIN Region r ON st.region_id = r.region_id
JOIN Customers c On s.customer_id = c.customer_id;
