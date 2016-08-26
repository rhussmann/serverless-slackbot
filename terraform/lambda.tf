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

resource "aws_lambda_function" "test_lambda" {
    filename = "../src/archive.zip"
    function_name = "lambda_function_name"
    role = "${aws_iam_role.iam_for_lambda.arn}"
    handler = "simpleService.handler"
    source_code_hash = "${base64sha256(file("../src/archive.zip"))}"
    runtime = "nodejs4.3"
}
