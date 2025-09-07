resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.environment}"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls         = true
  block_public_policy       = true
  ignore_public_acls        = true
  restrict_public_buckets   = true
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
    count = var.enable_lifecycle ? 1 : 0
    bucket = aws_s3_bucket.this.id
    rule {
      id     = "bucket-lifecycle"
      status = "Enabled"

      transition {
        days = var.lifecycle_days_to_standard_ia
        storage_class = "STANDARD_IA"
      }

      transition {
        days = var.lifecycle_days_to_glacier
        storage_class = "GLACIER"
      }

      expiration {
        days = var.lifecycle_days_to_delete
      }
    }
}