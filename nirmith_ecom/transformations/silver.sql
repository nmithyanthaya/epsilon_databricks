create streaming table nirmith_silver.sales_cleaned_pl
(constraint valid_order_id EXPECT (order_id is not null) on violation drop row)
as
select distinct * from stream sales_pl;



-- Create and populate the target table.
CREATE OR REFRESH STREAMING TABLE nirmith_silver.product_cleaned_pl;

CREATE FLOW product_flow AS AUTO CDC INTO
  nirmith_silver.product_cleaned_pl
FROM
  stream(products_pl)
KEYS
  (product_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  seqNum
COLUMNS * EXCEPT
  (operation, seqNum, _rescued_data,ingestion )
STORED AS
  SCD TYPE 1;


  
CREATE OR REFRESH STREAMING TABLE nirmith_silver.customers_cleaned_pl;

CREATE FLOW customer_flow AS AUTO CDC INTO
  nirmith_silver.customers_cleaned_pl
FROM
  stream(customers_pl)
KEYS
  (customer_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  sequenceNum
COLUMNS * EXCEPT
  (operation, sequenceNum, _rescued_data,ingestion )
STORED AS
  SCD TYPE 2;

