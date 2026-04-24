#DEFAULT NETWORK
resource "google_compute_network" "default" {
  name                    = "default"
  description             = "Default network for the project"
  auto_create_subnetworks = "true"
  routing_mode            = "REGIONAL"
}

# Create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.vm_name}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# create public subnet
resource "google_compute_subnetwork" "network_subnet" {
  name          = "${var.vm_name}-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network       = google_compute_network.vpc.name
  region        = var.gcp_region
  stack_type    = "IPV4_ONLY"
  #  ipv6_access_type = "EXTERNAL"
}
/*
resource "google_compute_address" "static_internal_ip" {
  name         = "wireguard-ip"
  subnetwork   = google_compute_subnetwork.network_subnet.name
  region       = var.gcp_region
  address_type = "INTERNAL"
  # Optional: Specify a custom internal IP address
  #address = "192.168.100.198"
}
*/
