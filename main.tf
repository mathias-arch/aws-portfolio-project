terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Esto solo lee la información de mi servidor actual
data "aws_instance" "mi_servidor" {
  instance_id = "i-0fa18c3062c6a3472"
}

output "estado_servidor" {
  value = data.aws_instance.mi_servidor.instance_state
}

