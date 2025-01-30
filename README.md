# Crypto-Whale-Alert-System.
This system tracks large cryptocurrency transactions (whale activity) and predicts their potential impact on the market. It sends real-time alerts to users, helping them stay ahead of price movements.


# Abstract

## What Are Crypto Whales
These are entities or individuals that hold a substantial percentage of the total supply of a given cryptocurrency. e.g To put this in perspective, someone who has $1 million worth of an asset with a market capitalization of $100 million is a whale, while someone who holds $1 million worth of an asset with a market capitalization of $30 billion may not be considered a whale

<details>
  <summary> Dataset</summary>
This JSON represents an **unconfirmed Bitcoin transaction (UTX event)**. Below is a breakdown of its structure and details:

---

### **Top-Level Key (`op`)**
- `"op": "utx"` → Indicates that this is an unconfirmed Bitcoin transaction event.

---

### **Transaction Details (`x` Object)**

#### **General Information**
- `"lock_time": 0` → The transaction is not time-locked and can be confirmed immediately.
- `"ver": 2` → Bitcoin transaction version.
- `"size": 255` → The transaction size in bytes.
- `"time": 1738198045` → Unix timestamp when the transaction was relayed.
- `"tx_index": 0` → Unique transaction identifier (set to `0`, possibly placeholder).
- `"vin_sz": 1` → The transaction has **1 input**.
- `"vout_sz": 3` → The transaction has **3 outputs**.
- `"hash": "42bfe2a11bfe4c26aeabfb36a96f838e3260b4f190502721cd095e31242f69b3"`  
  → The unique **transaction ID** (TXID).
- `"relayed_by": "0.0.0.0"` → The IP address of the node that relayed this transaction (masked or unavailable).

---

### **Inputs (`inputs` array)**
The transaction spends funds from a **single input**, meaning it is using one previous unspent output (UTXO).

#### **Input 0**
- `"sequence": 4294967295` → The maximum sequence number, meaning the transaction is not time-locked.
- `"prev_out"` → Details of the previous UTXO being spent:
  - `"spent": true` → This output has already been spent in this transaction.
  - `"tx_index": 0"` → Placeholder for the transaction index.
  - `"type": 0` → Standard transaction type.
  - `"addr": "bc1q2z0sujksq98gdcch88jre7zdhhup8ycjjhu7pl"`  
    → The **Bitcoin address** that originally held the funds.
  - `"value": 23,653,744` (satoshis) → The **amount being spent** (≈ 0.236 BTC).
  - `"n": 1` → Index of the output in the previous transaction.
  - `"script": "0014509f0e4ad0014e86e31739e43cf84dbdf8139312"`  
    → A SegWit script (P2WPKH or P2WSH).

---

### **Outputs (`out` array)**
The transaction sends funds to **three different outputs**.

#### **Output 0**
- `"spent": false` → This output has not yet been spent.
- `"tx_index": 0"` → Transaction index (placeholder).
- `"type": 0"` → Standard transaction type.
- `"addr": "36T3zzwKSPJSur6584wbNmsi7sFK5Bm1Up"`  
  → Bitcoin address receiving **2,859 satoshis** (≈ 0.00002859 BTC).
- `"value": 2,859` → Amount sent.
- `"n": 0` → Index of this output in the transaction.
- `"script": "a91434348a02926cc6c559abcceb088f38d20355525a87"`  
  → A **P2SH (Pay-to-Script-Hash) script**.

#### **Output 1**
- `"spent": false` → This output has not yet been spent.
- `"tx_index": 0"` → Placeholder.
- `"type": 0"` → Standard transaction type.
- `"addr": "bc1q8m8u6ez8csvwss6m49zwk6ccj7ercmltlrjeu5"`  
  → Bitcoin address receiving **3,396 satoshis** (≈ 0.00003396 BTC).
- `"value": 3,396` → Amount sent.
- `"n": 1` → Index of this output.
- `"script": "00143ecfcd6447c418e8435ba944eb6b1897b23c6feb"`  
  → A SegWit **P2WPKH (Pay-to-Witness-Public-Key-Hash) script**.

#### **Output 2 (Change Address)**
- `"spent": false` → This output has not yet been spent.
- `"tx_index": 0"` → Placeholder.
- `"type": 0"` → Standard transaction type.
- `"addr": "bc1q2z0sujksq98gdcch88jre7zdhhup8ycjjhu7pl"`  
  → **Change address** (same as input address, meaning sender is keeping the remaining balance).
- `"value": 23,646,905` (satoshis) → **Most of the BTC (≈ 0.236 BTC) is returned to the sender.**
- `"n": 2"` → Output index.
- `"script": "0014509f0e4ad0014e86e31739e43cf84dbdf8139312"`  
  → SegWit **P2WPKH script**.

---

### **Summary**
- The transaction **spends 0.23653744 BTC** from a SegWit address (`bc1q2z0...`).
- The outputs are:
  - **0.00002859 BTC** sent to a **P2SH** address (`36T3zz...`).
  - **0.00003396 BTC** sent to a **SegWit** address (`bc1q8m...`).
  - **0.23646905 BTC** **returned to the sender** (`bc1q2z0...`), acting as change.
- This suggests the transaction **likely involves a small payment, with most BTC returned as change**.

</details>
