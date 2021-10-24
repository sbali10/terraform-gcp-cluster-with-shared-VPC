###Creating new subnet and adding this subnet to the VPC on sb-management project

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
name = var.subnetwork_name
ip_cidr_range = var.ip_range_nodes
region = var.region
network = var.vpc_network
secondary_ip_range {
range_name = var.subnet_range_name1
ip_cidr_range = var.ip_range_pods
}
secondary_ip_range {
range_name = var.subnet_range_name2
ip_cidr_range = var.ip_range_services
}
}


###Sharing sb-management VPC to devdmz project

resource "google_compute_shared_vpc_host_project" "host" {
project = var.vpc_network_host_project
}

resource "google_compute_shared_vpc_service_project" "service1" {
host_project = google_compute_shared_vpc_host_project.host.project
service_project = var.project

}

###Creating serviceaccount

resource "google_service_account" "service_account" {
project = var.project
account_id = "devdmz-serviceaccount"
}

###Creating service account to connect ndoes on cluster

resource "google_compute_instance" "devdmz-jumpbox" {
name = var.jumpbox_node_name
machine_type = var.jumpbox_machine_type
zone = var.zone
project = var.project
address = "10.247.136.70"

 boot_disk {
initialize_params {
image = var.jumpbox_image
}
}
network_interface {
network = "default" #var.vpc_network
#subnetwork = var.subnetwork_name

}
}


###GKE cluster create

provider "google" {
credentials = file("intertech-management-61016f0a31d8.json")
region = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
host = "https://${module.gke.endpoint}"
token = data.google_client_config.default.access_token
cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
source = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
project_id = var.project_id
name = var.k8s_cluster_name
regional = true
region = var.region
network = var.vpc_network
network_project_id = var.vpc_network_host_project_id
subnetwork = var.subnetwork_name
ip_range_pods = var.subnet_range_name1
ip_range_services = var.subnet_range_name2
create_service_account = false
enable_private_endpoint = true
enable_private_nodes = true
master_ipv4_cidr_block = var.ip_range_subnet

node_pools = [
{
name = "node-pool"
machine_type = var.machine_type
min_count = var.node_min_count
max_count = var.node_max_count
disk_size_gb = var.node_disk_size_gb
},
]
master_authorized_networks = [
{
cidr_block = var.ip_range_subnet
display_name = "VPC"
},
]
}