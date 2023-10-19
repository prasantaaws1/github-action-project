variable "vpc_cidr" {
    type = string
}

variable "subnet_cidr" {
  type        = list(string)
}

variable "subnet_names" {
  type        = list(string)
  default     = ["public_subnet_1","public_subnet_2"]
}
