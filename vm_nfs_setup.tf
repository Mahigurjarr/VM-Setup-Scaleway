  terraform {
    required_providers {
      scaleway = {
        source = "scaleway/scaleway"
      }
    }
    required_version = ">= 0.13"
  }
  provider "scaleway" {
    project_id	    = ${{ secrets.project_id }}
    zone            = "fr-par-1"
    region          = "fr-par"
  }
  resource "scaleway_instance_ip" "public_ip" {}
  resource "scaleway_instance_server" "my-instance" {
    type  = "PLAY2-PICO"
    image = "ubuntu_jammy"
    name = var.name
    tags = [ "terraform instance", "nfs-instance" ]

    ip_id = scaleway_instance_ip.public_ip.id
    root_volume {
      size_in_gb = 10
    }

    
  }
  
 output "Public_IP" {
    value = scaleway_instance_ip.public_ip.address
  }
