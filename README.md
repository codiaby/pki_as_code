# Build your own certificates authority (CA) with Vault PKI

like everywhere else, certificate management is a pain. There are tools to simplify/centralize this.

In tasks, **docker compose** will run services :
  - **Vault** as your PKI
  - **consul-template** as regenerate automate to certificate
  - **nginx** for tests
## Prerequisites

To perform the tasks described, you need:
  - **terraform** : 1.4.0 or above
  - **docker compose** : 2.20 or above

## Installation

1. Clone project and run 

```shell
git clone https://github.com/codiaby/pki_as_code.git && cd pki_as_code
```

2. run **vault server**

```shell
docker compose up -d vault
```
3. access UI: http://127.0.0.1:8200 or vault-address + port

Put 1 into **key shares** and 1 into **Key threshold**

If you are this error : 
```
Error

failed to initialize barrier: failed to persist keyring: mkdir /vault-data/core: permission denied
```

Give right into `data` directory as root
```shell
sudo chmod -R 777 data
```
Now download keys or copy and store keys

4. Copy `vault_url` and `vault_token` into `terraform.tfvars`

```json
vault_addr  = "http://127.0.0.1:8200"
vault_token = "XXXXXXXXXXXXXXXXXXXXXXXXXX"
```

5. Create your pki using `terraform`

```shell
terraform init && terraform plan && terraform apply
```
