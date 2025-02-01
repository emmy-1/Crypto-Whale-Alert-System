
SELECT 
    flattened_tx.VALUE:x:hash::string AS transaction_hash,
    output.value:spent::BOOLEAN AS spent,
    output.value:tx_index::INT AS type,
    output.value:addr::string AS output_address,
    output.value:value::int AS bitcoin,
    output.value:n::int AS output_index,
    output.value:script::string AS script_pub_key

FROM {{source('bitcoin_transdb', 'UNCONFIRMED_TRANSACTIONS')}},
LATERAL FLATTEN(input => parse_json(src)) AS flattened_tx,
LATERAL FLATTEN(input => flattened_tx.VALUE:x:out) AS output