SELECT 
    flattened_tx.VALUE:x:hash::string AS transaction_hash,
    input.value:sequence::int AS sequence,
    input.value:prev_out:addr::string AS input_address,
    input.value:prev_out:spent::boolean AS spent,
    input.value:prev_out:tx_index::int AS prev_tx_index,
    input.value:prev_out:value::int AS input_value_satoshis,
    input.value:prev_out:n::int AS prev_output_index,
    input.value:prev_out:script::string AS prev_script_sig
FROM {{source('bitcoin_transdb', 'UNCONFIRMED_TRANSACTIONS')}},
LATERAL FLATTEN(input => parse_json(src)) AS flattened_tx,
LATERAL FLATTEN(input => flattened_tx.VALUE:x:inputs) AS input