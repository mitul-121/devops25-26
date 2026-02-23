locals {
  name_suffix = "${var.project_name}-${var.environment}"
}

locals {
  required_tags = {
    project     = var.project_name,
    environment = var.environment
  }
  tags = merge(var.resource_tags, local.required_tags)
}

resource "aws_instance" "app_server" {
  ami           = "ami-0d118c6e63bcb554e" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = "${merge(local.tags, {Name = "app-server-${local.name_suffix}"})}"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-0d118c6e63bcb554e" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

   tags = "${merge(local.tags, {Name = "app-server-${local.name_suffix}"})}"
}