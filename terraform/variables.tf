variable "project_id" {
  type    = string
  default = "gcp-2022-1-phase2-mikhalskyi"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
    type = string
    default = "europe-west1-b"
}

variable "vpc_name" {
    type = string
    default = "petclinic-vpc"
}

variable "subnet_name" {
    type = string
    default = "petclinic-eu-west1"
}

variable "network_tags" {
  type    = list(any)
  default = ["ssh", "icmp", "http"]
}