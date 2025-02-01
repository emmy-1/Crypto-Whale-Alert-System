SELECT
    Trans.type as Transaction_Type,
    Trans.hash_number as hash_number,
    Trans.lock_time as locktime,
    Trans.version as version,
    Trans.byte_size as bytesize,
    Trans.tx_index as tx_index,
    Trans.no_ofinput_transaction as no_ofinput_transaction,
    Trans.on_ofoutput_transaction as on_ofoutput_transaction,
    IT.sequence as transaction_sequence,
    IT.input_address as wallet_address,
    IT.input_value_satoshis as Wallet_amount,
    IT.spent as Spent,
    IT.prev_output_index as prev_output_index,
    IT.prev_tx_index as prev_tx_index,
    IT.prev_script_sig as prev_script_sig,
    OT.output_address as Output_wallet,
    OT.bitcoin as Output_bitcoin_balance,
    OT.spent as out_spent,
    OT.type as type,
    OT.output_index as output_index,
    OT.script_pub_key as script_pub_key
    
from
{{ref('Transcation_details')}} AS Trans
JOIN 
{{ref('Input_transactions')}} as IT
On 
IT.transaction_hash = Trans.hash_number
JOIN 
{{ref('output_transactions')}} as OT
ON OT.transaction_hash = IT.transaction_hash