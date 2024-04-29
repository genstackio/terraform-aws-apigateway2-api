data "aws_iam_policy_document" "ws_api_gateway_policy" {
  statement {
    actions = [
      "lambda:InvokeFunction",
    ]
    effect    = "Allow"
    resources = [var.lambda_arn]
  }
}

resource "aws_iam_policy" "ws_api_gateway_policy" {
  name   = "WsAPIGatewayPolicy_${var.name}"
  path   = "/"
  policy = data.aws_iam_policy_document.ws_api_gateway_policy.json
}

resource "aws_iam_role" "ws_api_gateway_role" {
  name = "WsAPIGatewayRole_${var.name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [aws_iam_policy.ws_api_gateway_policy.arn]
}