# AWS Cloud Infrastructure Automation
## Infrastructure as Code (IaC) | CI/CD Pipeline | AWS Certified Approach

[![Terraform Version](https://img.shields.io/badge/Terraform-1.5.0+-623CE4.svg?style=flat&logo=terraform)](https://www.terraform.io/)
[![AWS Architecture](https://img.shields.io/badge/AWS-Architecture-FF9900.svg?style=flat&logo=amazon-aws)](https://aws.amazon.com/)
[![CI/CD Status](https://img.shields.io/badge/GitHub%20Actions-Automated-2088FF.svg?style=flat&logo=github-actions)](https://github.com/features/actions)

### Descripción del Proyecto

Este proyecto representa el despliegue de una arquitectura web profesional en **Amazon Web Services (AWS)** utilizando un enfoque moderno de **DevOps**. Se ha priorizado la seguridad, la persistencia de datos y la automatización total del ciclo de vida de la infraestructura.

La solución utiliza **Terraform** para definir los recursos y **GitHub Actions** para el despliegue continuo (CD), garantizando que la infraestructura sea replicable, auditable y eficiente en costes.

## Índice
* [Descripción del Proyecto](#-descripción-del-proyecto)
* [Objetivos del Proyecto](#-objetivos-del-proyecto)
* [Tecnologías Utilizadas](#-tecnologías-utilizadas)
* [Arquitectura del Sistema](#-arquitectura-del-sistema)
* [Desafíos Técnicos y Soluciones](#-desafíos-técnicos-y-soluciones)
* [Conclusiones y Aprendizajes](#-conclusiones-y-aprendizajes)

---

## Descripción del Proyecto
Este proyecto despliega automáticamente un entorno de servidor web **Nginx** sobre instancias **EC2**, conectado de forma nativa a un **Bucket S3** para persistencia de datos. 

Toda la infraestructura se gestiona como código, lo que permite despliegues predecibles, repetibles y optimizados para el control de costes dentro de la Capa Gratuita de AWS [cite: 2026-02-01].

---

## Objetivos del Proyecto
* [x] **Automatización Total:** Despliegue de infraestructura mediante Terraform CLI.
* [x] **Seguridad Granular:** Implementación de roles de IAM para eliminar el uso de Access Keys.
* [x] **Gestión de Redes:** Configuración de Security Groups para acceso HTTP seguro (Puerto 80).
* [x] **Control de Versiones:** Aplicación de mejores prácticas de Git, incluyendo filtrado de datos sensibles vía `.gitignore`.

---

## Arquitectura del Sistema

┌─────────────────────────────┐      ┌──────────────────────────────────────────┐
│      WORKSTATION (Local)    │      │           GITHUB ECOSYSTEM               │
│   (EC2 CloudManager)        │      │                                          │
│                             │      │   ┌───────────────┐   ┌──────────────┐   │
│   $ terraform apply         │──────┼──▶│  Repository   │──▶│   Actions    │   │
│   $ git push origin main    │      │   │ (Source Code) │   │ (CI/CD Work) │   │
│                             │      │   └───────────────┘   └───────┬──────┘   │
└─────────────────────────────┘      │           ▲                   │          │
                                     │           │    ┌──────────────▼──────┐   │
                                     │           └────┤   GitHub Secrets    │   │
                                     │                │ (AWS_ACCESS_KEYS)   │   │
                                     └────────────────└─────────────────────┘───┘
                                                                     │
                                     Deploy & Sync with Remote State │
                                                                     ▼
┌───────────────────────────────────────────────────────────────────────────────┐
│                                  AWS CLOUD                                    │
│                                                                               │
│   ┌──────────────────────┐          ┌─────────────────────────────────────┐   │
│   │   STATE MANAGEMENT   │          │         VPC & NETWORKING            │   │
│   │  (S3: Remote State)  │◀─────────┼──────┐                              │   │
│   │ [Locking & Version]  │          │      │      ┌───────────────────┐   │   │
│   └──────────────────────┘          │      │      │  Security Group   │   │   │
│                                     │      │      │  (Allow 80, 22)   │   │   │
│   ┌──────────────────────┐          │      │      └─────────┬─────────┘   │   │
│   │   ASSETS & LOGS      │          │      │                │             │   │
│   │  (S3: Portfolio)     │◀─────────┼──────┼──────┐         ▼             │   │
│   │ [Static Content]     │          │      │      ┌───────────────────┐   │   │
│   └──────────────────────┘          │      │      │    EC2 INSTANCE   │   │   │
│               ▲                     │      └─────▶│   (Nginx Server)  │   │   │
│               │                     │             └─────────┬─────────┘   │   │
│               └─────────────────────┼───────────────────────┘             │   │
│                (IAM Role Access)    │                       │             │   │
│                                     │             ┌─────────▼─────────┐   │   │
│                                     │             │  AWS CloudWatch   │   │   │
│                                     │             │ (Metrics & Logs)  │   │   │
│                                     │             └───────────────────┘   │   │
└─────────────────────────────────────┴─────────────────────────────────────┘


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

#### Paso 1: Inicialización del Entorno
Prepara el directorio y descarga los proveedores necesarios de AWS.
```bash
terraform init
