import requests
import os
import json
import boto3
import base64


def lambda_handler(event, context):


  payload = event
  request_body = {
        "name": "Nakul Thorat",
        "subnet": os.getenv(subnetId, default=None)
        "emailID": "thoratnakul@gmail.com",
        
    }
 
  request_headers = {
        "X-Siemens-Auth": "test",
        "Content-Type": "application/json"
    }

  response = requests.post('https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data',
                             headers=request_headers,
                             data=json.dumps(request_body))

  
  if response.status_code == 200:
    print(response.status_code)
    
    return {
      'statusCode': 200,
      'body': json.dumps({'message': 'Request sent successfully.'}),
    }
  else:
    print(response.status_code)
    
    return {
      'statusCode': response.status_code,
      'body': json.dumps({'message': 'The request failed.'}),
    }



