terraform {
  backend "s3" {
    bucket = "mi-portfolio-state-storage-unique" # El nombre que creaste arriba
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1" 
}

# 1. Creamos el Bucket de S3 (El almacén)
resource "aws_s3_bucket" "datos_portfolio" {
  bucket = "portfolio-storage-mathias-2026" # Debe ser un nombre único en todo el mundo
}

# 2. Tu Servidor EC2 con Instalación Automática
resource "aws_instance" "servidor_web" {
  ami           = "ami-0c101f26f147fa7fd" # Amazon Linux 2023
  instance_type = "t3.micro"
  iam_instance_profile = "Role-CloudManager-Proyecto" # El rol que ya creaste

  # Esto instala Nginx automáticamente al encenderse
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Servidor Cloud de Mathias - Sistema de Archivos Activo</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "EC2-Portfolio-Server"
  }
}
