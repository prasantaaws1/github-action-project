variable "sg_id" {
  type        = string
  }

variable "subnet" {
  type        = list(string)
}

variable "ec2_names" {
  type        = list(string)
  default = ["Server1","Server2"]
}

  
