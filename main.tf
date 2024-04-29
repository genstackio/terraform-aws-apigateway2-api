resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = var.protocol
  description   = var.name
  target        = var.lambda_arn

  route_selection_expression = local.isWebsocket ? "$request.body.action" : null

  dynamic "cors_configuration" {
    for_each = var.cors ? [var.cors_config] : []
    content {
      allow_credentials = var.cors_config.allow_credentials
      allow_headers     = var.cors_config.allow_headers
      allow_methods     = var.cors_config.allow_methods
      allow_origins     = var.cors_config.allow_origins
      expose_headers    = var.cors_config.expose_headers
      max_age           = var.cors_config.max_age
    }
  }
}
resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

module "ws_utils" {
  count             = local.isWebsocket ? 1 : 0
  source            = "./modules/websocket-utils"
  apigw_id          = aws_apigatewayv2_api.api.id
  lambda_arn        = var.lambda_arn
  lambda_invoke_arn = var.lambda_invoke_arn
  name              = var.name
  throttling_burst_limit = var.throttling_burst_limit
  throttling_rate_limit  = var.throttling_rate_limit
}