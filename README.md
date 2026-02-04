# Cloud Infrastructure Management

#  AWS Infrastructure: Automatización y Almacenamiento Seguro

Este proyecto implementa una arquitectura cloud profesional utilizando **Terraform** (Infrastructure as Code). Se enfoca en el despliegue de un servidor web escalable integrado con un sistema de almacenamiento de objetos, garantizando la seguridad mediante el uso estricto de **IAM Roles**.

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

┌──────────────────────────────────────────────────────────┐
│                      AWS Cloud (VPC)                     │
│                                                          │
│   ┌────────────────┐          ┌──────────────────────┐   │
│   │   Security     │          │    S3 Bucket         │   │
│   │   Group        │          │ (Portfolio Storage)  │   │
│   │ (Port 80 HTTP) │          └──────────▲───────────┘   │
│   └────────┬───────┘                     │               │
│            │          (IAM Role Access)  │               │
│   ┌────────▼────────┐           ┌────────┴──────────┐    │
│   │  EC2 Instance   │◄──────────┤   IAM Role        │    │
│   │ (Nginx Server)  │           │ (PassRole Policy) │    │
│   └─────────────────┘           └───────────────────┘    │
│                                                          │
└──────────────────────────────────────────────────────────┘

