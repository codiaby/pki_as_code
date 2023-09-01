# This denotes the start of the configuration section for Vault. All values
# contained in this section pertain to Vault.
vault {
  # This is the address of the Vault leader. The protocol (http(s)) portion
  # of the address is required.
  address      = "http://vault:8200"

  # This value can also be specified via the environment variable VAULT_TOKEN.
  # I am using the admin token created earlier
  token        = "XXXXXXXXXXXXXXXXXXXXXXXXXX"

  unwrap_token = false

  renew_token  = false
}

# This block defines the configuration for a template. Unlike other blocks,
# this block may be specified multiple times to configure multiple templates.
template {
  # This is the source file on disk to use as the input template. This is often
  # called the "consul-template template".
  source      = "/opt/consul/templates/agent.crt.tpl"

  # This is the destination path on disk where the source template will render.
  # If the parent directories do not exist, consul-template will attempt to
  # create them, unless create_dest_dirs is false.
  // destination = "/opt/consul/agent-certs/agent.crt"
  destination = "/opt/consul/ssl/certificate.pem"

  # This is the permission to render the file. If this option is left
  # unspecified, consul-template will attempt to match the permissions of the
  # file that already exists at the destination path. If no file exists at that
  # path, the permissions are 0644.
  perms       = 0700

  # This is the optional command to run when the template is rendered. The
  # command will only run if the resulting template changes.
  command     = "sh -c 'echo Good certificate created 👍 👍 👍 !!!'"
}

template {
  source      = "/opt/consul/templates/agent.key.tpl"
  destination = "/opt/consul/ssl/private.pem"
  perms       = 0700
  command     = "sh -c 'echo Good private key created 👍 👍 👍 !!!'"
}

// template {
//   source      = "/opt/consul/templates/ca.crt.tpl"
//   destination = "/opt/consul/agent-certs/ca.crt"
//   command     = "sh -c 'date && consul reload'"
// }