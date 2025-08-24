locals {
  domain_name = lookup({ dev = "example.com" }, var.environment, "example.com")
}