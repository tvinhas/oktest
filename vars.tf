# Environment

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

# Network
variable "vpc_cidr" {
  description = "VPC Supernet in CIDR notation"
  default = "10.10.0.0/20"
}

variable "vpc_azs" {
  description = "VPC Availability Zones"
  default = [
    "us-east-1a", 
    "us-east-1b"
  ]
}

variable "private_subnets" {
  description = "Private VPC subnets"
  default = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]
}

variable "public_subnets" {
  description = "Public VPC subnets"
  default = [
    "10.10.3.0/24",
    "10.10.4.0/24"
  ]
}
