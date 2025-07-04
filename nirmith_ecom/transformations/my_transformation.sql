--Pipeline ( Streaming and materiliazed view )

create streaming table sales_pl
select *, current_date() as ingestion from stream read_files (
  's3://jpmctraining/pipeline_input/sales',
  format => 'csv'
);


create streaming table products_pl
select *, current_date() as ingestion from stream read_files (
  's3://jpmctraining/pipeline_input/products',
  format => 'csv'
);

create streaming table customers_pl
select *, current_date() as ingestion from stream read_files (
  's3://jpmctraining/pipeline_input/customers',
  format => 'csv'
);