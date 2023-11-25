# archive_file is used to create a zip file for lambda function
data "archive_file" "python_lambda_package" {  
  type        = "zip"  
  source_file = "${path.module}/../lambda/s3.py"
  output_path = "${var.project_name}-${var.environment}.zip"
}

# create lambda function
resource "aws_lambda_function" "test" {
  filename         = "${var.project_name}-${var.environment}.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  function_name    = "${var.project_name}-${var.environment}"
  role             = aws_iam_role.lambda.arn
  handler          = "s3.lambda_handler"
  runtime          = "python3.9"
  layers           = [aws_lambda_layer_version.test.arn]
}

# allow s3 bucket to invoke lambda function
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda.arn
}

# when file is uploaded to s3 bucket, trigger lambda function
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.lambda.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "files/"
    filter_suffix       = ".csv"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

# create log group for lambda function
resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${aws_lambda_function.test.function_name}"
}
