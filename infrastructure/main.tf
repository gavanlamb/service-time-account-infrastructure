// ECR
resource "aws_ecr_repository" "api" {
  name = var.api_ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = local.default_tags
}
resource "aws_ecr_lifecycle_policy" "api" {
  repository = aws_ecr_repository.api.name
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last ${var.number_of_images_to_keep} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.number_of_images_to_keep}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

resource "aws_ecr_repository" "migration" {
  name = var.migration_ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = local.default_tags
}
resource "aws_ecr_lifecycle_policy" "migration" {
  repository = aws_ecr_repository.migration.name
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last ${var.number_of_images_to_keep} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.number_of_images_to_keep}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

resource "aws_ecr_repository" "integration_tests" {
  name = var.integration_tests_ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = local.default_tags
}
resource "aws_ecr_lifecycle_policy" "integration_tests" {
  repository = aws_ecr_repository.integration_tests.name
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last ${var.number_of_images_to_keep} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.number_of_images_to_keep}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
