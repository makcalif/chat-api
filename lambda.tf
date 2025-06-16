resource "aws_iam_role" "lambda_exec_role" {
  name = "chat-api-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "api" {
  function_name = var.lambda_function_name
  runtime       = "python3.10"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "main.lambda_handler"  # Change if your entry point differs
  filename      = "${path.module}/deployment-package.zip"  # Make sure to zip your app

  source_code_hash = filebase64sha256("${path.module}/deployment-package.zip")

  timeout = 30
}
