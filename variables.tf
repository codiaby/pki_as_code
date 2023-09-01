variable "vault_addr" {
  type        = string
  description = "URL of Vault"
  default     = "http://localhost:8200"
}

variable "vault_token" {
  type        = string
  description = "Token vault"
  default     = "poiuytreza"
}