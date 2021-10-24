provider "google" {
credentials = file("intertech-management-61016f0a31d8.json")
# project = "intertech-devdmz"
region = "europe-west3"
zone = "europe-west3-c"
}

#data "google_client_config" "current" {}

#provider "kubernetes" {
# config_path = "~/.kube/config"
# config_context = "my-context"
#}