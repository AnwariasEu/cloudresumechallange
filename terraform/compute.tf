resource "aws_lambda_function" "update-and-retrieve" {
  functionname = "lambda-update-and-retrieve"
  filename = "../lambda/dynamodb_get_set_anwariascloudchallenge.py"
  # role =
  # handler =
  # source_code_hash =
  runtime = "python3.9"
  # environment {}
}