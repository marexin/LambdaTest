# Lambda S3 Bucket Upload Test

This repo contains terraform code for deploying simple lambda function and associated resources.

## Infrastructure
The Terraform code is located in 'infra' directory and it contains comments for each resource to shortly describe why the resource is created.
Environment variables for Terraform are located in infra/envs/dev.tfvars file. By adding additional tfvars files you can add new environments. 

The created Lambda function will be triggered when CSV file is uploaded into files directory of S3 bucket: lambda-layers-dev.
When Lambda is triggered it will print message to CloudWatch logs that a file was uploaded to the S3 bucket.

This project creates lambda layer by creating a zip file and uploading it to S3 bucket. The layer zip file can have a maximum unzipped size 250 MB. If it contains a lot of packages that have bigger size then it's better to create the layer using a Docker image (up to 10 GB)

## Backend resources
In order to deploy this code, you need to first create backend resources in your account: S3 bucket 'lambda-layers-dev-tf-state' and DynamoDB table: 'lambda-layers-dev-tf-state-lock'. These resources are for storing and managing TF state file (in real project this would ideally be done automatically with dedicated remote-state module). Configuration for these resources is in backends directory: infra/backends/dev.backend.tfvars

## Pipeline
Part of the project is also simple Github Actions pipeline containing all necessary steps to test and deploy this solution. It is stored in .github/workflows directory. This pipeline requires credentials for AWS account into which solution should be deployed. You can update credentials in 'Configure AWS Credentials' step. Additionally you can commnent/uncomment various Terrafrom steps, based on whether you want to just see Terraform Plan, Apply (deploy) the solution or delete all resources.



## Manual Deployment
If you want to deploy manually using command line use these steps:
```
cd infra
terraform init -backend-config="backends/dev.backend.tfvars"
terraform plan -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars
```

If you want to delete deployed resources use the destroy command:
```
terraform destroy -var-file=envs/dev.tfvars
```


