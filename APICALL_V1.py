import asyncio
import websockets
import json
import boto3
# WebSocket API URL
WEBSOCKET_URL = "wss://ws.blockchain.info/inv"
s3 = boto3.client('s3')
messages =[]

async def connect_to_websocket():
    # Connect to the WebSocket server
    async with websockets.connect(WEBSOCKET_URL) as ws:  # Changed 'websocket' to 'ws'
        print("Connected to WebSocket!")

        # Example: Send a ping message
        await ws.send(json.dumps({"op": "ping"}))  # Use 'ws' here
        print("Ping sent!")

        # Example: Subscribe to unconfirmed transactions
        await ws.send(json.dumps({"op": "unconfirmed_sub"}))  # Use 'ws' here
        print("Subscribed to unconfirmed transactions!")

        # Listen for incoming messages
        try:
            while True:
                message = await ws.recv()
                # Use 'ws' here
                data = json.loads(message)
                 # Append the received data to the messages list 
                messages.append(data) 

                if len(message)>=500:
                    json_data = json.dumps(data, indent=4)
                    s3.put_object(Bucket = "dataclutster", Key = "transcations.json",Body =json_data )
                    print(f"Uploaded {len(messages)} messages to S3 bucket")
                # print("Received message:", json.dumps(data, indent=4))
                    messages.clear()
        except websockets.ConnectionClosed as e:
            print("WebSocket connection closed:", e)


# Run the async function
asyncio.run(connect_to_websocket())



