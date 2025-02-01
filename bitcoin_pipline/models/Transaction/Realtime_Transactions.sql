SELECT
    Trans.hash_number as hash_number,
    Trans.lock_time as locktime,
    Trans.time as timestamp,
    Trans.byte_size as bytesize,
    Trans.no_ofinput_transaction as no_ofinput_transaction,
    Trans.on_ofoutput_transaction as on_ofoutput_transaction,
    IT.input_address as input_wallet,
    IT.input_value_satoshis as bitcoin_sent,
    OT.output_address as Output_wallet,
    OT.bitcoin as Output_bitcoin_balance,
from
{{ref('Transcation_details')}} AS Trans
JOIN 
{{ref('Input_transactions')}} as IT
On 
IT.transaction_hash = Trans.hash_number
JOIN 
{{ref('output_transactions')}} as OT
ON OT.transaction_hash = IT.transaction_hash