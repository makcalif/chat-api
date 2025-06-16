# variables.tf
variable "region" {
  default = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default = "chat-api-lambda"
  type        = string
}
