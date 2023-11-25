import boto3
import gunicorn
import sqlalchemy as db
import os

def lambda_handler(event, context):
    print('File was uploaded to S3 bucket')
