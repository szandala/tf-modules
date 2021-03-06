resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "lambda" {
  filename      = var.lambda_filename
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_handler

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.lambda_filename)

  runtime = var.lambda_runtime

    tags = {
        Name = var.lambda_name
        Creator = "${data.aws_caller_identity.current.account_id}_${data.aws_caller_identity.current.user_id}"
    }

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}
