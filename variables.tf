variable "version" {
  type    = "string"
  default = "0.10.2"
}

variable "logging-bucket" {
  type = "string"
}

variable "config-bucket" {
  type = "string"
}

variable "data-bucket" {
  type = "string"
}

variable "lambda-bucket" {
  type = "string"
}

variable "domain" {
  type = "string"
}
