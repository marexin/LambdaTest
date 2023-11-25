# Lambda S3 Bucket Upload Test

This repo contains terraform code to deploy simple lambda function and associated resources.

Lambda will be triggered when CSV file is uploaded into files directory in S3 bucket: lambda-layers-dev

Lambda will print message to CloudWatch logs that the file was uploaded to the S3 bucket.

Environment variables for Terraform are located in infra/envs/dev.tfvars file. By adding additional tfvars files you can add new environments. 

In order to deploy this code, you need to first create backend resources in your account: S3 bucket 'lambda-layers-dev-tf-state' and DynamoDB table: 'lambda-layers-dev-tf-state-lock'. These resources are for storing and managing TF state file (in real project this would ideally be done automatically with dedicated remote-state module). Configuration for these resources is in backends directory: infra/backends/dev.backend.tfvars

Part of the project is also simple Github Actions pipeline containing necessary steps to test and deploy this solution. This pipeline requires credentials for AWS account into which solution should be deployed. You can update credentials in 'Configure AWS Credentials' step.

The Terraform code in infra directory contains comments for each resource to shortly describe why the resource is created.

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


