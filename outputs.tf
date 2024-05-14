output "endpoint" {
  value = aws_apigatewayv2_api.api.api_endpoint
}
output "execution_arn" {
  value = aws_apigatewayv2_api.api.execution_arn
}
output "arn" {
  value = aws_apigatewayv2_api.api.arn
}
output "dns" {
  value = replace(replace(aws_apigatewayv2_api.api.api_endpoint, "/^https?://([^/]*).*/", "$1"), "/^wss://([^/]*).*/", "$1")
}
output "id" {
  value = aws_apigatewayv2_api.api.id
}
output "stage" {
  value = "$default"
}