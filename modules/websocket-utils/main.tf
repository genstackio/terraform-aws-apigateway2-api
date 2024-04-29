resource "aws_apigatewayv2_integration" "ws_api_integration" {
  api_id                    = var.apigw_id
  integration_type          = "AWS_PROXY"
  integration_uri           = var.lambda_invoke_arn
  credentials_arn           = aws_iam_role.ws_api_gateway_role.arn
  content_handling_strategy = "CONVERT_TO_TEXT"
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration_response" "ws_api_integration_response" {
  api_id                   = var.apigw_id
  integration_id           = aws_apigatewayv2_integration.ws_api_integration.id
  integration_response_key = "/200/"
}

resource "aws_apigatewayv2_route" "ws_api_default_route" {
  api_id    = var.apigw_id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.ws_api_integration.id}"
}

resource "aws_apigatewayv2_route_response" "ws_api_default_route_response" {
  api_id             = var.apigw_id
  route_id           = aws_apigatewayv2_route.ws_api_default_route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route" "ws_api_connect_route" {
  api_id    = var.apigw_id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.ws_api_integration.id}"
}

resource "aws_apigatewayv2_route_response" "ws_api_connect_route_response" {
  api_id             = var.apigw_id
  route_id           = aws_apigatewayv2_route.ws_api_connect_route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route" "ws_api_disconnect_route" {
  api_id    = var.apigw_id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.ws_api_integration.id}"
}

resource "aws_apigatewayv2_route_response" "ws_api_disconnect_route_response" {
  api_id             = var.apigw_id
  route_id           = aws_apigatewayv2_route.ws_api_disconnect_route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route" "ws_api_message_route" {
  api_id    = var.apigw_id
  route_key = "MESSAGE"
  target    = "integrations/${aws_apigatewayv2_integration.ws_api_integration.id}"
}

resource "aws_apigatewayv2_route_response" "ws_api_message_route_response" {
  api_id             = var.apigw_id
  route_id           = aws_apigatewayv2_route.ws_api_message_route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_stage" "ws_api_message_stage_default" {
  api_id      = var.apigw_id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    data_trace_enabled = true
    throttling_rate_limit = var.throttling_rate_limit
    throttling_burst_limit = var.throttling_burst_limit
  }

  depends_on = [aws_apigatewayv2_integration.ws_api_integration]
}