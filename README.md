# 🛒 Mercado Libre – Data Challenge

## 📌 Descripción del Proyecto

Este proyecto es la resolución de un **challenge técnico para el puesto de Analista de Datos en Mercado Libre**. El desafío consiste en diseñar un modelo de datos relacional y generar consultas SQL a partir de un escenario realista de e-commerce.

Se trabaja sobre las principales entidades de una plataforma marketplace: usuarios, productos, categorías y órdenes de compra. A partir de este modelo, se debe responder a requerimientos analíticos y operativos del negocio.

---

## 🎯 Objetivo del Challenge

El objetivo general es:

- Diseñar un **DER (Diagrama Entidad-Relación)** que represente el modelo de datos propuesto.
- Crear las tablas correspondientes mediante un script SQL (`create_tables.sql`).
- Resolver 3 consultas analíticas específicas en SQL (`respuestas_negocio.sql`).
- Desarrollar una solución **ordenada, clara y reprocesable**, con buenas prácticas de modelado, nomenclatura y lógica SQL.

---

## 📋 Enunciado resumido

El modelo se basa en las siguientes entidades principales:

- **Customer:** representa usuarios (compradores o vendedores).
- **Item:** publicaciones de productos.
- **Category:** jerarquía y nombre de categorías.
- **Order:** transacciones individuales (cada ítem comprado genera una orden).

Se solicita además una tabla adicional que registre **snapshots diarios** del estado y precio de cada ítem al final del día, con la capacidad de **reprocesarse sin duplicaciones**.

---

## 🧩 Consultas a resolver

1. Listar usuarios que cumplan años hoy y hayan superado las 1500 ventas durante enero 2020.
2. Para cada mes del 2020, obtener el top 5 de vendedores en la categoría "Celulares", con nombre, ventas, cantidad de productos y monto total transaccionado.
3. Poblar una tabla de snapshot diario de ítems con precio y estado al final del día, de forma reprocesable.

---

## 🧠 Criterios técnicos evaluados

- Interpretación del modelo de negocio.
- Correcto diseño del modelo relacional.
- Limpieza, claridad y performance de los scripts SQL.
- Documentación y estructura del entregable.
- Capacidad de anticiparse a problemas y aportar valor agregado.

---

## 📁 Estructura del Repositorio

```text
CHALLENGE SQL MERCADO LIBRE/
|
├── README.md ← Descripción general del proyecto (este archivo)
|
├── docs/
│   ├── DER.png ← Imagen del Diagrama Entidad–Relación
│   └── explicacion_modelo.md ← Detalles y decisiones de diseño del modelo
|
├── sql/
│   ├── create_tables.sql ← Script DDL para crear las tablas
│   └── respuestas_negocio.sql ← Consultas SQL que resuelven el desafío
|
└── extras/ ← (opcional) Scripts o mejoras complementarias
```

---

## 📎 Acceso al DER

El Diagrama Entidad-Relación fue diseñado en Miro y está disponible en el siguiente enlace:

🔗 [Ver DER en Miro](https://miro.com/app/board/uXxxxxx)



---

## ✅ Notas Finales

Este repositorio fue desarrollado como parte de un desafío técnico para el puesto de Analista de Datos en Mercado Libre.

Se priorizó la claridad del modelo de datos, la simplicidad y eficiencia de las consultas SQL, y una estructura profesional del repositorio para facilitar su revisión, ejecución y escalabilidad.

🧠 Además de cumplir con los requisitos mínimos, se incorporaron buenas prácticas de nomenclatura, diseño reproducible y documentación clara para facilitar el análisis y mantenimiento del proyecto.

---

📫 Para cualquier comentario o devolución técnica, no dudes en contactarme.

```text
matilorenzatti99@gmail.com
```
