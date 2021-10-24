variable "k8s_cluster_name" {
default = "sb-private-gke-devdmz"
}

variable "project" {
default = "sb-devdmz"
}

variable "project_id" {
default = "sb-devdmz"
}

variable "gcp_credentials" {
default = "sb-management-61016f0a31d8.json" #apply ederken cloud shellde proje altına json eklediğinden path böyle verildi, ancak tfsservice kullanıcısı ile buildserver23 üzerinde çalıştırılacağında yandakiş şekilde değiştirilmelidir "E:\GCPKey\sb-management-ac9b62257087.json"
}

variable "jumpbox_node_name" {
default = "sb-devdmz-jumpbox"
}

variable "jumpbox_machine_type" {
default = "g1-small"
}

variable "jumpbox_image" {
default = "ubuntu-2004-focal-v20210510" #ubuntu_containerd tercih edilebilir
}

variable "region" {
default = "europe-west3"
}

variable "zone" {
default = "europe-west3-c"
}

variable "subnetwork_name" {
default = "sb-devdmz-subnet-1"
}

#variable "subnetwork" {
# default = "projects/sb-management/regions/europe-west3/subnetworks/sb-devdmz-subnet-1"
#}
#
variable "initial_node_count" {
default = 15
}

variable "machine_type" {
default = "e2-medium"
}

variable "image" {
default = "debian-cloud/debian-9" #ubuntu_containerd tercih edilebilir
}

variable "vpc_network" {
default = "sb-management-network" #sandbox için asm-test, devdmz projesi için default olarak kalmalıdır
}

variable "vpc_network_host_project" {
default = "sb-management"
}

variable "vpc_network_host_project_id" {
default = "sb-management"
}

variable "subnet_range_name1" { #sb-management projesinde, VPC networklerde sb-devdmz-subnet-1 altında görülebilir
default = "tf-test-secondary-range-update1"
}

variable "subnet_range_name2" { #sb-management projesinde, VPC networklerde sb-devdmz-subnet-1 altında görülebilir
default = "tf-test-secondary-range-update2"
}

variable "ip_range_subnet" {
default = "10.247.137.0/28"
}

variable "ip_range_nodes" {
default = "10.247.136.0/24"
}

variable "ip_range_pods" {
default = "10.247.0.0/17"
}

variable "ip_range_services" {
default = "10.247.128.0/21"
}

variable "node_min_count" {
default = 1
}

variable "node_max_count" {
default = 3
}

variable "node_disk_size_gb" {
default = 30
}

variable "ip_range_services_name" {
default = "ip-range-services"
}

variable "service_account_roles" {
description = "Additional roles to be added to the service account."
type = list(string)
default = []
}