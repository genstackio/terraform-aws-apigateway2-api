# AWS API Gateway v2 API Terraform module

Terraform module which creates API Gateway v2 resources on AWS.

## Usage

```hcl
module "api" {
  source     = "genstackio/apigateway2-api/aws"

  name       = "my-api-name"
  lambda_arn = "arn:the-arn-of-the-lambda-here"
}