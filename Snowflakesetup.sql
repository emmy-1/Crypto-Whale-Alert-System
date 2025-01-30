USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE DATABASE Bitcoin_Transcations;

GRANT USAGE ON WAREHOUSE bitcon_compute TO ROLE ACCOUNTADMIN;
GRANT ALL ON DATABASE Bitcoin_Transcations TO ROLE ACCOUNTADMIN;
GRANT ROLE ACCOUNTADMIN TO USER DIGIT;


USE SCHEMA bitcoin_transcations.public;

CREATE OR REPLACE TABLE unconfirmed_transactions (
    SRC VARIANT
);
CREATE OR REPLACE WAREHOUSE bitcon_compute WITH
    WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 100
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED=TRUE;

USE WAREHOUSE bitcon_compute;

CREATE STORAGE INTEGRATION snowflake
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::043309364582:role/snowflake'
  STORAGE_ALLOWED_LOCATIONS = ('s3://dataclutster');

DESC INTEGRATION snowflake;

CREATE OR REPLACE STAGE recent_transactions
    url = 's3://dataclutster/transactions.json'
    STORAGE_INTEGRATION = snowflake;

LIST @recent_transactions;

COPY INTO unconfirmed_transactions
    FROM @recent_transactions
    FILE_FORMAT = (TYPE = JSON);

select * from unconfirmed_transactions;

SELECT 
    flattened.VALUE:op::string as type,
    flattened.VALUE:x:lock_time::int AS lock_time,
    flattened.VALUE:x:ver::int AS version
FROM unconfirmed_transactions,
LATERAL FLATTEN(input => parse_json(src)) AS flattened;