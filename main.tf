## CA Root creation and configuration
# Enable pki backends
resource "vault_mount" "pki_root" {
  path                  = "pki_root"
  type                  = "pki"
  description           = "PKI for Root Certificate Authority"
  max_lease_ttl_seconds = 157680000
}

# Creating the Root CA certificate
resource "vault_pki_secret_backend_root_cert" "this" {
  backend              = vault_mount.pki_root.path
  type                 = "internal"
  common_name          = "example.com"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = "Technical Dept"
  organization         = "My Organization"
  country              = "France"

  depends_on = [vault_mount.pki_root]
}

# Import Root CA certificate if you are certificate
# resource "vault_pki_secret_backend_config_ca" "this" {
#   backend    = vault_mount.pki_root.path
#   pem_bundle = file("${path.root}/ca_certificates.pem")

#   depends_on = [vault_mount.pki_root]
# }

# Creation of the role for Root CA
resource "vault_pki_secret_backend_role" "root-role" {
  backend         = vault_mount.pki_root.path
  name            = "pki-root-role"
  allowed_domains = ["example.com"]
}

# Adding AIA and CDP to Root CA certificate configuration
resource "vault_pki_secret_backend_config_urls" "this" {
  backend                 = vault_mount.pki_root.path
  issuing_certificates    = ["${var.vault_addr}/v1/pki_root/ca"]
  crl_distribution_points = ["${var.vault_addr}/v1/pki_root/crl"]

  depends_on = [vault_mount.pki_root]
}
