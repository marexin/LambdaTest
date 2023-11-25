# Lambda S3 Bucket Upload Test

This repo contains terraform code to deploy simple lambda function and associated resources.

Lambda will be triggered when CSV file is uploaded into files directory in S3 bucket: lambda-layers-dev

Lambda will print message to CloudWatch logs that the file was uploaded to the S3 bucket.

In order to deploy this code, you need to first create S3 bucket 'lambda-layers-dev-tf-state' and DynamoDB table: 'lambda-layers-dev-tf-state-lock' for storing and managing TF state file (in real project this would idealy be done automatically with dedicated remote-state module)

Part of the project is also simple Github Actions pipeline containing necessary steps to test and deploy this solution. This pipeline requires credentials for AWS account into which solution should be deployed.

Terraform code contains comments for each resource to shortly describe why the resource is created.
