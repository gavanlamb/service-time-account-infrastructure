variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "application_name" {
  type = string
  default = "Time"
}

variable "number_of_images_to_keep" {
  type = number
  default = 200
}

locals {
  api_ecr_name = "${lower(var.application_name)}-api"
  migrator_ecr_name = "${lower(var.application_name)}-migrator"
  
  default_tags = {
    Service = var.application_name
    Application = "Expensely"
    Team = "Tracker"
    ManagedBy = "Terraform"
    Environment = var.environment
  }
}
