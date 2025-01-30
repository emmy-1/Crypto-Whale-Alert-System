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

-- general Transaction table
SELECT 
    flattened.VALUE:op::string as type,
    flattened.VALUE:x:hash::string AS hash_number,
    flattened.VALUE:x:lock_time::int AS lock_time,
    flattened.VALUE:x:ver::int AS version,
    flattened.VALUE:x:size::int AS byte_size,
    flattened.VALUE:x:time::int AS time,
    flattened.VALUE:x:tx_index::int AS tx_index,
    flattened.VALUE:x:vin_sz::int AS no_ofinput_transaction,
    flattened.VALUE:x:vout_sz::int AS on_ofoutput_transaction,
    flattened.VALUE:x:relayed_by::string AS ip_address_node
FROM unconfirmed_transactions,
LATERAL FLATTEN(input => parse_json(src)) AS flattened;



-- Input table
SELECT 
    flattened_tx.VALUE:x:hash::string AS transaction_hash,
    input.value:sequence::int AS sequence,
    input.value:prev_out:addr::string AS input_address,
    input.value:prev_out:spent::boolean AS spent,
    input.value:prev_out:tx_index::int AS prev_tx_index,
    input.value:prev_out:value::int AS input_value_satoshis,
    input.value:prev_out:n::int AS prev_output_index,
    input.value:prev_out:script::string AS prev_script_sig
FROM unconfirmed_transactions,
LATERAL FLATTEN(input => parse_json(src)) AS flattened_tx,
LATERAL FLATTEN(input => flattened_tx.VALUE:x:inputs) AS input;  -- This remains unchanged






--output transactions
SELECT 
    flattened_tx.VALUE:x:hash::string AS transaction_hash,
    output.value:spent::BOOLEAN AS spent,
    output.value:tx_index::INT AS type,
    output.value:addr::string AS output_address,
    output.value:value::int AS bitcoin,
    output.value:n::int AS output_index,
    output.value:script::string AS script_pub_key

FROM unconfirmed_transactions,
LATERAL FLATTEN(input => parse_json(src)) AS flattened_tx,
LATERAL FLATTEN(input => flattened_tx.VALUE:x:out) AS output;



