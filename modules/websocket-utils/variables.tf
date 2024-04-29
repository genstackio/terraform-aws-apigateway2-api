variable "apigw_id" {
  type = string
}
variable "name" {
  type = string
}
variable "lambda_invoke_arn" {
  type = string
}
variable "lambda_arn" {
  type = string
}
variable "throttling_burst_limit" {
  type    = number
  default = 2000
}
variable "throttling_rate_limit" {
  type    = number
  default = 1000
}