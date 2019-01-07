module "lambda" {
  lambda-bucket  = "${var.lambda-bucket}"
  lambda-version = "${chomp(file("${path.module}/version"))}"
  function-name  = "madlibrarian_lambda_${var.data-bucket}"

  environment-variables = {
    S3_BUCKET = "${var.config-bucket}"
    S3_KEY    = "config.yaml"
  }

  access-policy-document = "${data.aws_iam_policy_document.lambda_perms.json}"
  trust-policy-document  = "${data.aws_iam_policy_document.lambda_assume.json}"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.madlibrarian_lambda.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
