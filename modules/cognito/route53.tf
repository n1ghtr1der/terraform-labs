resource "aws_route53_record" "cognito_domain_record" {
  zone_id = var.zone_id
  name = var.cognito_domain_name
  type = "CNAME"
  ttl = 60
  records = [ aws_cognito_user_pool_domain.this.cloudfront_distribution ]
}