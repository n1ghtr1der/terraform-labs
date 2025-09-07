resource "aws_cognito_user_pool" "this" {
  name = "${var.project_name}-${var.environment}"
  deletion_protection = local.deletion_protection

  mfa_configuration = local.mfa_config
  
  sms_authentication_message = var.sms_auth_message
  sms_configuration {
    external_id = "${var.project_name}-${var.environment}-sms"
    sns_caller_arn = aws_iam_role.cognito_role.arn
    sns_region = var.region
  }

  username_attributes = ["email"] # check possilibility to turn it into variable later
  auto_verified_attributes = ["email"] # check possilibility to turn it into variable later

  admin_create_user_config {
    allow_admin_create_user_only = var.only_admin_creates_users
    invite_message_template {
      email_subject = var.email_invite_template_subject
      email_message = var.email_invite_template_message
      sms_message = var.sms_invite_message
    }
  }

  email_configuration {
    email_sending_account = var.uses_custom_email ? "DEVELOPER" : "COGNITO_DEFAULT"
    from_email_address = var.uses_custom_email ? var.custom_email_address : null
    source_arn = var.uses_custom_email ? var.custom_email_ses_arn : null
  }

  email_mfa_configuration {
    message = local.mfa_config ? var.mfa_email_message : null # The value of this variable should contain {####}, it is the mfa code
    subject = local.mfa_config ? var.mfa_email_subject : null
  }

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  lifecycle {
    ignore_changes = [ schema ]
  }
}


resource "aws_cognito_user_pool_client" "this" {
  name = "${var.project_name}-${var.environment}"
  user_pool_id = aws_cognito_user_pool.this.id
  generate_secret = false
  prevent_user_existence_errors = "ENABLED"

  allowed_oauth_flows_user_pool_client = var.uses_oauth
  allowed_oauth_flows = var.uses_oauth ? var.oauth_flows : null
  allowed_oauth_scopes = var.uses_oauth ? var.oauth_scopes : null
  supported_identity_providers = ["COGNITO"]
  
  callback_urls = var.uses_oauth ? var.callback_urls : null # URLs from the apps the will use this cognito
  logout_urls = var.uses_oauth ? var.logout_urls : null

  # Token configuration
  access_token_validity = var.access_token_validity_hours
  id_token_validity = var.id_token_validity_hours
  refresh_token_validity = var.refresh_token_validity_hours
  token_validity_units {
    access_token = "hours"
    id_token = "hours"
    refresh_token = "hours"
  }

  enable_token_revocation = var.enable_token_revocation
  enable_propagate_additional_user_context_data = false
}

resource "aws_cognito_user_pool_domain" "this" {
  domain = var.cognito_domain_name
  user_pool_id = aws_cognito_user_pool.this.id
  certificate_arn = var.certificate_arn
}