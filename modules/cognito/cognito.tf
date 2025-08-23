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