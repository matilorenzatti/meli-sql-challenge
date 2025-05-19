# 🧠 Resolución del Challenge Técnico – SQL Mercado Libre

Este documento explica paso a paso cómo se resolvió el desafío técnico propuesto para la posición de **Analista de Datos**. Se detallan las decisiones tomadas, la estructura del proyecto, y las estrategias de optimización aplicadas tanto a nivel de modelado como de consultas SQL.

---

## 🔧 Estructura general del proyecto

El proyecto está compuesto por tres scripts principales:

| Script | Descripción |
|--------|-------------|
| `drop_tables.sql` | Limpia completamente las tablas del modelo para permitir un reinicio desde cero. |
| `create_tables.sql` | Crea todas las tablas del modelo relacional, con claves primarias, claves foráneas e índices estratégicos ya incluidos. |
| `respuestas_negocio.sql` | Contiene la resolución de las tres preguntas de negocio solicitadas. Incluye consultas optimizadas, uso de CTEs y una stored procedure reutilizable. |

Este enfoque modular permite mantener el entorno ordenado, reproducible y escalable.

---

## 🧱 Modelo relacional y diseño

Se diseñó un modelo de datos relacional simple pero sólido, respetando las entidades mencionadas en la consigna:

- `customer`
- `category`
- `item`
- `order`
- `item_daily_snapshot`

### ✔️ Consideraciones del modelo:
- Se usó una estructura **en tercera forma normal (3FN)**.
- Se evitaron datos derivados innecesarios.
- Se agregaron **índices en columnas clave** (como `fecha_venta`, `estado`, `vendedor_id`, etc.) que se utilizan para filtrado o join frecuente.
- Los índices se declararon **dentro del `CREATE TABLE`** por compatibilidad con versiones anteriores de MySQL y para asegurar performance sin errores de duplicación.

---

## 🚨 ¿Por qué usar `drop_tables.sql`?

El script `drop_tables.sql` elimina todas las tablas respetando el orden lógico (de hijas a padres), y desactiva temporalmente las claves foráneas. Esto permite ejecutar los scripts sin errores si se necesita reiniciar el entorno.

Esto es útil para:
- Testing iterativo
- Evitar conflictos al reimportar estructuras
- Reprocesos totales

---

## 📊 Respuesta a las preguntas de negocio

### 🟩 1. Usuarios que cumplen años hoy y vendieron más de 1500 órdenes en enero 2020

#### ✔️ ¿Cómo se resolvió?
- Se usó una **variable** (`@hoy_md`) con `DATE_FORMAT(CURDATE(), '%m-%d')` para evitar repetir funciones dentro del `WHERE`.
- Se utilizó un **CTE (`ventas_enero_2020`)** para prefiltrar las órdenes del mes de enero 2020, reduciendo la cantidad de datos antes del join.
- Se realizó el `JOIN` con `customer` sobre `vendedor_id`.
- Se aplicó un `GROUP BY` completo con todos los campos del `SELECT`.

#### 🎯 ¿Por qué esta estructura?
- **Evita cálculos innecesarios** en cada fila.
- Reduce el volumen de datos en joins.
- Mejora el tiempo de respuesta total de la query.

---

### 🟩 2. Top 5 vendedores por mes en categoría "Celulares" – Año 2020

#### ✔️ ¿Cómo se resolvió?
- Se utilizó una **CTE (`ventas_mensuales`)** para agrupar ventas por mes y vendedor.
- Se aplicó una función de ventana: `ROW_NUMBER() OVER (PARTITION BY mes ORDER BY monto_total DESC)` para calcular el ranking.
- Se filtró `ranking <= 5` en la query principal para obtener el top 5.
- Se utilizó `DATE_FORMAT(o.fecha_venta, '%Y-%m')` para generar el mes-año ordenado cronológicamente.

#### 🎯 ¿Por qué esta estructura?
- `ROW_NUMBER()` permite seleccionar el top N sin subconsultas anidadas ni complicaciones.
- Filtrar por `fecha_venta BETWEEN '2020-01-01' AND '2021-01-01'` mantiene el uso del índice en esa columna.
- `DATE_FORMAT` solo se aplica donde no afecta el uso de índices (fuera del `WHERE`).

---

### 🟩 3. Poblar la tabla `item_daily_snapshot` (precio y estado al final del día)

#### ✔️ ¿Cómo se resolvió?
- Se implementó una **stored procedure** llamada `cargar_snapshot_item(IN p_fecha DATE)`.
- La stored procedure:
  1. Elimina previamente los registros para `fecha_snapshot = p_fecha` → hace el proceso **reprocesable**.
  2. Inserta todos los ítems activos con su `precio` y `estado` actuales.
- Se puede llamar fácilmente desde backend: `CALL cargar_snapshot_item(CURDATE());`

#### 🎯 ¿Por qué esta estructura?
- Encapsular la lógica en un procedimiento permite:
  - Automatización (cron jobs, procesos ETL)
  - Reutilización
  - Mayor claridad y control

---

## ⚙️ Buenas prácticas aplicadas

| Práctica | Justificación |
|----------|---------------|
| `CTE` (`WITH`) | Aumenta legibilidad y permite subsegmentar lógica |
| Filtros por rango (`fecha >= ... AND < ...`) | Preserva uso de índices |
| Separación de scripts | Mantenimiento limpio, ejecutable por partes |
| Índices aplicados a campos clave | Mejora performance en joins y filtros |
| Stored procedure para carga de snapshot | Reprocesable, reutilizable y automatizable |
| `ROW_NUMBER()` | Ranking eficiente sin subconsultas |

---

## ✅ Conclusión

Este proyecto fue resuelto con foco en:

- 🧠 Pensamiento analítico
- ⚡ Optimización de consultas
- 🧱 Diseño de modelo relacional sólido
- ♻️ Reproducibilidad y mantenimiento del entorno

Las soluciones se adaptan a un entorno de datos real, priorizando la escalabilidad, legibilidad y rendimiento.

---

# DER en MIRO:

Pueden ver en el siguiente enlace el DER realizado en MIRO:

🔗 [Ver DER en Miro](https://miro.com/app/board/uXjVIzvsUlw=/?share_link_id=325692261536)
