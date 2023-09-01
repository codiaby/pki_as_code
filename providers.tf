terraform {
  required_version = ">= 0.14.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.18.0"
    }
  }
}

provider "vault" {
  address          = var.vault_addr
  skip_child_token = true
  skip_tls_verify  = true
  token            = var.vault_token
}