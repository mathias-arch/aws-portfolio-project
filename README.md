# AWS Cloud Infrastructure Automation
## Infrastructure as Code (IaC) | CI/CD Pipeline | AWS Certified Approach

[![Terraform Version](https://img.shields.io/badge/Terraform-1.5.0+-623CE4.svg?style=flat&logo=terraform)](https://www.terraform.io/)
[![AWS Architecture](https://img.shields.io/badge/AWS-Architecture-FF9900.svg?style=flat&logo=amazon-aws)](https://aws.amazon.com/)
[![CI/CD Status](https://img.shields.io/badge/GitHub%20Actions-Automated-2088FF.svg?style=flat&logo=github-actions)](https://github.com/features/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat&logo=opensourceinitiative&logoColor=white)](https://opensource.org/licenses/MIT)

### Descripción del Proyecto

Este proyecto representa el despliegue de una arquitectura web profesional en **Amazon Web Services (AWS)** utilizando un enfoque moderno de **DevOps**. Se ha priorizado la seguridadd, la persistencia de datos y la automatización total del ciclo de vida de la infraestructura.

La solución utiliza **Terraform** para definir los recursos y **GitHub Actions** para el despliegue continuo (CD), garantizando que la infraestructura sea replicable, auditable y eficiente en costes.

---

## Objetivos del Proyecto
* [x] **Automatización Total:** Despliegue de infraestructura mediante Terraform CLI.
* [x] **Seguridad Granular:** Implementación de roles de IAM para eliminar el uso de Access Keys.
* [x] **Gestión de Redes:** Configuración de Security Groups para acceso HTTP seguro (Puerto 80).
* [x] **Control de Versiones:** Aplicación de mejores prácticas de Git, incluyendo filtrado de datos sensibles vía `.gitignore`.

---

## Tecnologías Utilizadas
* **Cloud:** AWS (EC2, S3, IAM, VPC, CloudWatch)
* **IaC:** Terraform
* **CI/CD:** GitHub Actions
* **Servidor:** Nginx

---

## Arquitectura del Sistema

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/72a73190-10aa-4ec3-9f3f-6c194b5f2596" />


### Arquitectura Técnica Detallada

#### 1. Core de Computación (EC2)
- **Instancia:** Amazon EC2 tipo `t3.micro` (Nitro System) con **Amazon Linux 2023**.
- **User Data (Automated Provisioning):** Script de Bash ejecutado en el arranque para la instalación automática de un servidor **Nginx**, asegurando que el servicio esté disponible inmediatamente tras el despliegue.

#### 2. Gestión de Estado y Persistencia (S3 Backend)
- **S3 Bucket:** Se utiliza un bucket dedicado (`portfolio-storage-mathias-2026`) para dos funciones críticas:
  - **Almacenamiento de archivos:** Repositorio para activos del proyecto.
  - **Remote State:** El archivo `terraform.tfstate` se almacena de forma remota en S3. Esto evita la pérdida de sincronización y permite una gestión profesional de la infraestructura.

#### 3. Capas de Seguridad (IAM & Networking)
- **IAM Roles:** Implementación de **IAM Instance Profiles**. La instancia no utiliza claves estáticas; asume un rol con permisos mínimos necesarios para interactuar con S3.
- **Seguridad Perimetral:** Grupos de Seguridad (Firewall) configurados para permitir tráfico exclusivo en los puertos 80 (HTTP) y 22 (SSH).
- **Control de Secretos:** Integración de **GitHub Secrets** para manejar las credenciales de AWS, evitando cualquier exposición en el código fuente.

---

### Guía de Despliegue y Comandos

Para replicar este proyecto, se han seguido los siguientes pasos técnicos desde la terminal de control (**CloudManager**):


### 1. Inicialización y Configuración
Prepara el directorio de trabajo y establece la conexión con el backend remoto.
* **Comando:** `terraform init`
* **Objetivo:** Descarga los proveedores de AWS y sincroniza el estado con el **Bucket S3**.

---

### 2. Validación de Infraestructura
Asegura que el código cumple con los estándares de sintaxis de HCL.
* **Comando:** `terraform validate`
* **Objetivo:** Detectar errores de configuración antes de la fase de planificación.

---

### 3. Planificación Estratégica (FinOps)
Auditoría de los recursos que se van a aprovisionar para evitar cargos inesperados.
* **Comando:** `terraform plan`
* **Objetivo:** Previsualizar cambios en **EC2, VPC y S3** garantizando que se mantienen dentro de la **Capa Gratuita**.

---

### 4. Ejecución del Despliegue (IaC)
Aprovisionamiento real de la arquitectura en la nube de AWS.
* **Comando:** `terraform apply -auto-approve`
* **Objetivo:** Levantar el servidor **Nginx**, configurar los **Security Groups** (Puertos 80, 22) y asignar el **IAM Role** correspondiente.

---

### 5. Automatización de Cambios (CI/CD)
Ciclo de vida GitOps para la actualización continua del portfolio.
 **Comandos:**
* git add .
* git commit -m "feat: actualización de infraestructura"
* git push origin main

---


### Roadmap de futuras mejoras:
* Implementación de **SSL/TLS** mediante AWS Certificate Manager (ACM).
* Configuración de una base de datos **Amazon RDS** (Free Tier).
* Migración de la carga de trabajo a **Amazon ECS (Fargate)** para contenedores.

---

##  Licencia

Este proyecto está bajo la **Licencia MIT**. Puedes consultar los términos legales en el siguiente enlace:

 [Consultar Licencia MIT del Proyecto](./LICENSE)


