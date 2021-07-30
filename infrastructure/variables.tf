variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "api_ecr_name" {
  type = string
}
variable "migration_ecr_name" {
  type = string
}
variable "number_of_images_to_keep" {
  type = number
  default = 200
}

locals {
  default_tags = {
    Application = "Time"
    Team = "Expensely"
    ManagedBy = "Terraform"
  }
}
