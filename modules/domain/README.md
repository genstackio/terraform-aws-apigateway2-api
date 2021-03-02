# AWS API Gateway v2 API Domain Terraform module

Terraform module which creates a domain mapping resources for an existing API Gateway v2 on AWS.

## Usage

```hcl
module "api-domain" {
  source = "genstackio/apigateway2-api/aws//modules/domain"

  api    = "id-of-the-api"
  stage  = "name-of-the-api-stage"
  dns    = "api.mydomain.com"
  zone   = "id-of-the-route53-zone"
}
```
