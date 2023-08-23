import requests
import os
import json
import boto3
import base64


def lambda_handler(event, context):


  payload = event
  request_body = {
        "name": "Nakul Thorat",
        "subnet": os.environ['subnetId'],
        "emailID": "thoratnakul@gmail.com"
        
    }
 
  request_headers = {
        "Content-Type": "application/json",
        "X-Siemens-Auth": "test"
    }

  response = requests.post('https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data',
                             headers=request_headers,
                             data=json.dumps(request_body))

  
  print(response)


