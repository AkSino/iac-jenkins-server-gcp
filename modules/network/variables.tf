variable "vpc_name" {
  description = "VPC name GCE instance"
  type        = string
}

variable "private_subnet_name" {
  description = "Subnet name GCE instance"
  type        = string
}

variable "public_subnet_name" {
  description = "Subnet name GCE instance"
  type        = string
}

variable "router_name" {
  description = "Router name GCE instance"
  type        = string
}

variable "router_nat_name" {
  description = "Router Nat name GCE instance"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "Subnet CIDR Block GCE instance"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "Subnet CIDR Block GCE instance"
  type        = string
}

variable "allow_internal_firewall_name" {
  description = "Internal Firewall Name"
  type        = string
}

variable "allow_external_firewall_name" {
  description = "External Firewall Name"
  type        = string
}