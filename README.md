# go-ncRNA


<img src="./doc/RNA_Lathe and_Eickbush-1997.jpg" />


### Resources
RNA Secondary Structure Visualization Using a Force Directed Graph Layout
http://rna.tbi.univie.ac.at/forna/
## awscli
```bash
aws configure

```
## helm chart
```bash
# 
$ helm create <buildmy-chart>
$ helm install buildmy-chart buildmy-chart/ --values buildmy-chart/values.yaml

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm search repo bitnami
$ helm install my-release bitnami/<chart>
```

## vault key/value server
```
vault server -dev
export VAULT_ADDR=http://127.0.0.1:8200
vault secrets disable secret
vault secrets enable -version=1 -path=secret kv

vault kv put secret/<path> data=<value>
```