variable "lambda_name" {
  description = "Name of the lambda to dpeloy"
}

variable "lambda_runtime" {
  description = "What kind of runtime is this lambda"
}

variable "lambda_filename" {
  description = "Zip file with lambda content"
}

variable "lambda_handler" {
  description = "Main function to run in the lambda"
}
