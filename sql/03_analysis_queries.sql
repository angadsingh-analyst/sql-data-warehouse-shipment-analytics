-- 03_analysis_queries.sql
-- Analytical SQL queries for the shipment analytics warehouse.

-- 1. Shipper with the highest number of shipments in 2024
SELECT
    s.ship_name,
    COUNT(f.shipment_id) AS total_shipments
FROM ship_fact f
JOIN dim_shipper s ON f.shipper_id = s.shipper_id
JOIN dim_date d ON f.date_id = d.date_id
WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
GROUP BY s.ship_name
ORDER BY total_shipments DESC
FETCH FIRST 1 ROWS ONLY;

-- 2. Total recorded shipping cost by month in 2024
SELECT
    TRIM(TO_CHAR(d.ship_date, 'Month')) AS month_name,
    EXTRACT(MONTH FROM d.ship_date) AS month_number,
    ROUND(SUM(f.ship_cost), 2) AS total_shipping_cost
FROM ship_fact f
JOIN dim_date d ON f.date_id = d.date_id
WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
GROUP BY TRIM(TO_CHAR(d.ship_date, 'Month')), EXTRACT(MONTH FROM d.ship_date)
ORDER BY month_number;

-- 3. Total shipment value by month in 2024 using quantity multiplied by product cost
SELECT
    TRIM(TO_CHAR(d.ship_date, 'Month')) AS month_name,
    EXTRACT(MONTH FROM d.ship_date) AS month_number,
    ROUND(SUM(f.quantity * p.product_cost), 2) AS total_shipment_value
FROM ship_fact f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
GROUP BY TRIM(TO_CHAR(d.ship_date, 'Month')), EXTRACT(MONTH FROM d.ship_date)
ORDER BY month_number;

-- 4. Product with the highest shipment value in May 2024
SELECT
    p.product_name,
    ROUND(SUM(f.quantity * p.product_cost), 2) AS total_value
FROM ship_fact f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_id = d.date_id
WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
  AND EXTRACT(MONTH FROM d.ship_date) = 5
GROUP BY p.product_name
ORDER BY total_value DESC
FETCH FIRST 1 ROWS ONLY;

-- 5. Best-performing shipper by month in 2024
WITH shipper_monthly_value AS (
    SELECT
        s.ship_name,
        TRIM(TO_CHAR(d.ship_date, 'Month')) AS month_name,
        EXTRACT(MONTH FROM d.ship_date) AS month_number,
        ROUND(SUM(f.quantity * p.product_cost), 2) AS total_value,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM d.ship_date)
            ORDER BY SUM(f.quantity * p.product_cost) DESC
        ) AS monthly_rank
    FROM ship_fact f
    JOIN dim_shipper s ON f.shipper_id = s.shipper_id
    JOIN dim_date d ON f.date_id = d.date_id
    JOIN dim_product p ON f.product_id = p.product_id
    WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
    GROUP BY
        s.ship_name,
        TRIM(TO_CHAR(d.ship_date, 'Month')),
        EXTRACT(MONTH FROM d.ship_date)
)
SELECT ship_name, month_name, total_value
FROM shipper_monthly_value
WHERE monthly_rank = 1
ORDER BY month_number;

-- 6. Most valuable customer in 2024
SELECT
    c.customer_name,
    ROUND(SUM(f.quantity * p.product_cost), 2) AS total_value
FROM ship_fact f
JOIN dim_customer c ON f.customer_id = c.customer_id
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_date d ON f.date_id = d.date_id
WHERE EXTRACT(YEAR FROM d.ship_date) = 2024
GROUP BY c.customer_name
ORDER BY total_value DESC
FETCH FIRST 1 ROWS ONLY;
