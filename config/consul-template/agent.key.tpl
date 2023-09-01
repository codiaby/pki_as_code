{{ with secret "pki_intermediate/issue/role-cert" "common_name=test.example.com" "ttl=10m"}}
{{ .Data.private_key }}
{{ end }}