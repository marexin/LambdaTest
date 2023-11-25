import boto3
import pandas as pd
import os
import io

def lambda_handler(event, context):
    # Will print the message to CloudWatch logs
    print('File was uploaded to S3 bucket')

    # Initialize the S3 client
    s3 = boto3.client('s3')

    # Specify the S3 bucket and object key of the CSV file
    bucket_name = 'lambda-layers-dev'
    file_key = 'files/sample_file.csv'

    try:
        # Read the CSV file from S3
        response = s3.get_object(Bucket=bucket_name, Key=file_key)
        csv_content = response['Body'].read().decode('utf-8')

        # Create a Pandas DataFrame
        df = pd.read_csv(io.StringIO(csv_content))

        # Example: Print the first 5 rows from DataFrame
        print(df.head(5))

        return {
            'statusCode': 200,
            'body': 'File read successfully into DataFrame.'
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': str(e)
        }
