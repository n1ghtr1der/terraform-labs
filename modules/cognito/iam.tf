data "aws_iam_policy_document" "assume_by_cognito" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["cognito.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cognito_role" {
  name = "${var.project_name}-${var.environment}-cognito-role"
  assume_role_policy = data.aws_iam_policy_document.assume_by_cognito.json

  tags = merge({
    Name = "${var.project_name}-${var.environment}-cognito-role"
  }, var.tags)
}

resource "aws_iam_role_policy" "sns_policy" {
  name = "${var.project_name}-${var.environment}-sns-policy"
  role = aws_iam_role.cognito_role.id
  policy = templatefile("${path.module}/policies/cognito_policy.json",{
    sns_arns = var.sns_arns
  })
}