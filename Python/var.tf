variable "key_name" {
  default = "abhisheknew"
}

variable "pvt_key" {
  default = "/root/.ssh/python-terra.pem"
}
variable "num" {
default=2
}

variable "aws-region" {
    type = "string"
    default = "us-east-1"
}

variable "myVPC-cidr" {
    type = "string"
    default = "192.168.0.0/16"
}

variable "public_subnet-a-cidr" {
    type = "string"
    default = "192.168.0.0/28"
}


variable "public_subnet-b-cidr" {
    type = "string"
    default = "192.168.0.16/28"
}


variable "private_subnet-a-cidr" {
    type = "string"
    default = "192.168.0.32/28"
}

variable "private_subnet-b-cidr" {
    type = "string"
    default = "192.168.0.48/28"
}

variable "private_subnet-c-cidr" {
    type = "string"
    default = "192.168.0.64/28"
}
variable "private_subnet-d-cidr" {
    type = "string"
    default = "192.168.0.80/28"
}

variable "enable_vpc" {
  description = "if set to true,create new vpc"
  type = bool
 }
variable "AMIS" {
  type = "map"
  default =  {
    us-east-1 = "ami-085925f297f89fce1"
    us-east-2 = "ami-0a54aef4ef3b5f881"
    }
}
