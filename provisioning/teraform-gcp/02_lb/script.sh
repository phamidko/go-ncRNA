

gcloud container clusters get-credentials glb-demo-eu --region europe-west2
ZONE_PRINTER_NEG_EU=$(kubectl get service zone-printer -o json | jq '.metadata.annotations["cloud.google.com/neg-status"] | fromjson | .network_endpoint_groups["80"]')
HELLO_APP_NEG_EU=$(kubectl get service hello-app -o json | jq '.metadata.annotations["cloud.google.com/neg-status"] | fromjson | .network_endpoint_groups["80"]')

gcloud container clusters get-credentials glb-demo-us --region us-central1
ZONE_PRINTER_NEG_US=$(kubectl get service zone-printer -o json | jq '.metadata.annotations["cloud.google.com/neg-status"] | fromjson | .network_endpoint_groups["80"]')
HELLO_APP_NEG_US=$(kubectl get service hello-app -o json | jq '.metadata.annotations["cloud.google.com/neg-status"] | fromjson | .network_endpoint_groups["80"]')

cp terraform.tfvars.template terraform.tfvars

sed -i.bak "s|ZONE_PRINTER_NEG_EU|$ZONE_PRINTER_NEG_EU|g" terraform.tfvars
sed -i.bak "s|ZONE_PRINTER_NEG_US|$ZONE_PRINTER_NEG_US|g" terraform.tfvars
sed -i.bak "s|HELLO_APP_NEG_EU|$HELLO_APP_NEG_EU|g" terraform.tfvars
sed -i.bak "s|HELLO_APP_NEG_US|$HELLO_APP_NEG_US|g" terraform.tfvars
rm -f terraform.tfvars.bak


ADDRESS=$(terraform output glb_demo_address)
ADDRESS=34.102.164.130
INSTANCE=$(kubectl get nodes -o json | jq -r '.items[0].metadata.name')
ZONE=$(kubectl get nodes -o json | jq -r '.items[0].metadata.labels["failure-domain.beta.kubernetes.io/zone"]')
gcloud compute ssh $INSTANCE --zone $ZONE --command "curl $ADDRESS"

gcloud container clusters get-credentials glb-demo-us --region us-central1