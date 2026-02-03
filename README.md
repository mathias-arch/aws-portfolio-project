# Cloud Infrastructure Management

Este repositorio contiene la arquitectura base para el proyecto **Antigravity**, enfocada en la gestión segura de recursos en AWS mediante Infraestructura como Código (IaC). 

El objetivo principal ha sido desplegar un entorno controlado y auditable, priorizando la seguridad de acceso y la eficiencia en el despliegue de recursos.

## 🛠️ Tecnologías Utilizadas

* **Cloud:** Amazon Web Services (AWS)
* **IaC:** Terraform
* **Seguridad:** IAM Roles & Policies (Principio de menor privilegio)
* **Control de Versiones:** Git & GitHub

## 🏗️ Implementación Técnica

Hasta el momento, el proyecto incluye:

1. **Aprovisionamiento Automático:** Configuración de instancias EC2 mediante Terraform, permitiendo un despliegue repetible y documentado.
2. **Seguridad Robusta (IAM):** En lugar de utilizar credenciales de usuario (Access Keys), el servidor utiliza un **IAM Role** específico (`Role-CloudManager-Proyecto`). Esto elimina el riesgo de filtración de claves y sigue las mejores prácticas de seguridad de AWS.
3. **Gestión de Estado:** Implementación de `terraform.tfstate` para mantener la sincronización entre el código y los recursos reales en la nube.
4. **Acceso Seguro:** Configuración de túneles SSH para la comunicación segura entre el servidor de gestión y el repositorio de código.

## 📋 Próximos Pasos

* [ ] Automatización de la capa de servidor web (Nginx/Apache).
* [ ] Implementación de Security Groups restrictivos para tráfico HTTP/HTTPS.
* [ ] Configuración de alertas de presupuesto para optimización de costes.

---
*Desarrollado como parte del ecosistema Antigravity para la gestión de entornos corporativos.*
