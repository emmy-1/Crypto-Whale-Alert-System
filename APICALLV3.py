import asyncio
import websockets
import json
import boto3
from botocore.exceptions import ClientError

# WebSocket API URL
WEBSOCKET_URL = "wss://ws.blockchain.info/inv"
s3 = boto3.client('s3')
bucket_name = 'dataclutster'  # Ensure this is the correct bucket name
file_name = 'transactions.json'  # Desired file name in S3


async def keepalive(ws):
    while True:
        await asyncio.sleep(30)  # Send a ping every 30 seconds
        try:
            await ws.ping()  # Send a ping to keep the connection alive
        except Exception as e:
            print("Error sending ping:", e)
            break


async def connect_to_websocket():
    async with websockets.connect(WEBSOCKET_URL) as ws:
        print("Connected to WebSocket!")

        # Example: Subscribe to unconfirmed transactions
        await ws.send(json.dumps({"op": "unconfirmed_sub"}))
        print("Subscribed to unconfirmed transactions!")

        # Listen for incoming messages
        try:
            while True:
                message = await ws.recv()  # Receive a message
                data = json.loads(message)  # Parse the JSON message

                # # Read existing data from S3
                # try:
                #     existing_data = s3.get_object(Bucket=bucket_name, Key=file_name)
                #     existing_messages = json.loads(existing_data['Body'].read().decode('utf-8'))
                # except ClientError as e:
                #     if e.response['Error']['Code'] == 'NoSuchKey':
                #         # If the file does not exist, start with an empty list
                #         existing_messages = []
                #     else:
                #         print("Error reading from S3:", e)
                #         existing_messages = []

                # # Append the new message to the existing messages
                # existing_messages.append(data)

                # Convert the updated list of messages to JSON
                json_data = json.dumps(data, indent=4)
                with open('transacation.json', 'w') as json_file:
                    json_file.write(json_data)

                # # Upload the updated JSON data to S3
                # s3.put_object(Bucket=bucket_name, Key=file_name, Body=json_data)
                # print(f"Uploaded {len(existing_messages)} messages to S3 bucket '{bucket_name}' as '{file_name}'")

        except websockets.ConnectionClosed as e:
            print("WebSocket connection closed:", e)

# Run the async function
asyncio.run(connect_to_websocket())