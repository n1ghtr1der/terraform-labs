variable "project_name" {
  type = string
  description = "Project Name"
}
variable "environment" {
  type = string
  description = "Environment name"
  default = "dev"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
# Cognito user pool variables
variable "sms_auth_message" {
  type = string
  description = "SMS Authentication Message"
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "only_admin_creates_users" {
  type = bool
  default = false
}
variable "email_invite_template_subject" {
  type = string
  description = "Invite e-mail subject"
  default = ""
}
variable "email_invite_template_message" {
  type = string
  description = "Invite e-mail message"
  default = ""
}
variable "sms_invite_message" {
  type = string
  description = "Invite SMS message"
  default = ""
}
variable "uses_custom_email" {
  type = bool
  description = "Defines if a custom e-mail will be used to send messages to users"
  default = false
}
variable "custom_email_address" {
  type = string
  description = "Custom e-mail address to send messages to users"
}
variable "custom_email_ses_arn" {
  type = string
  description = "Custom e-mail addres SES arn"
}
variable "mfa_email_message" {
  type = string
  description = "MFA e-mail message"
}
variable "mfa_email_subject" {
  type = string
  description = "MFA e-mail subject"
}
variable "uses_mfa" {
  type = bool
  description = "Defines if user pool will use MFA"
  default = false
}
variable "activate_deletion_protection" {
  type = bool
  description = "Defines if user deletion protection will be enabled"
  default = false
}

# Cognito IAM permissions
variable "sns_arns" {
  type = list(string)
  description = "SNS topics that cognito user pool needs to have access"
  default = []
}

# Cognito user pool client
variable "uses_oauth" {
  type = bool
  default = false
}
variable "oauth_flows" {
  type = list(string)
  description = "OAuth flows permited: ['code', 'implicit', 'client_credentials']"
  default = []
}
variable "oauth_scopes" {
  type = list(string)
  description = "OAuth scopes permited: ['phone', 'email', 'openid', 'profile']"
  default = []
}
variable "callback_urls" {
  type = list(string)
  description = "URLs that the user will be redirected to after sign in"
  default = []
}
variable "logout_urls" {
  type = list(string)
  description = "URLs that the user will be redirected to after sign out"
  default = []
}
variable "access_token_validity_hours" {
  type = number
  default = 1
}
variable "id_token_validity_hours" {
  type = number
  default = 1
}
variable "refresh_token_validity_hours" {
  type = number
  default = 1
}
variable "enable_token_revocation" {
  type = bool
  default = false
}
variable "cognito_domain_name" {
  type = string
  description = "Cognito domain name"
}
variable "certificate_arn" {
  type = string
  description = "ACM Certificate ARN"
}

# Route 53
variable "zone_id" {
  type = string
  description = "Route 53 zone ID"
}