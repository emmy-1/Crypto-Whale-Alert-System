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
FROM {{source('bitcoin_transdb', 'UNCONFIRMED_TRANSACTIONS')}},
LATERAL FLATTEN(input => parse_json(src)) AS flattened