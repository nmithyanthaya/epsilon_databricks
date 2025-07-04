-- Join customer_active, sales_cleaned_pl, and product_cleaned_pl tables
create materialized view nirmith_gold.customer_sales AS
SELECT
  c.customer_id,
  c.customer_name,
  c.customer_email,
  c.customer_city,
  c.customer_state,
  p.product_name,
  p.product_category,
  SUM(s.total_amount) AS total_sales,
  COUNT(s.order_id) AS total_orders,
  AVG(s.total_amount) AS avg_order_value
FROM
  nirmith_gold.customer_active ca
JOIN
  nirmith_silver.sales_cleaned_pl s
ON
  ca.customer_id = s.customer_id
JOIN
  nirmith_silver.product_cleaned_pl p
ON
  s.product_id = p.product_id
JOIN
  nirmith_silver.customers_cleaned_pl c
ON
  ca.customer_id = c.customer_id
GROUP BY
all
ORDER BY
  total_sales DESC
LIMIT 10;