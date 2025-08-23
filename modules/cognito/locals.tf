locals {
  mfa_config = var.uses_mfa ? "ON" : "OFF"
  deletion_protection = var.activate_deletion_protection ? "ACTIVE" : "INACTIVE"
}