-- =========================================

-- RESPUESTAS A CONSULTAS DE NEGOCIO
-- Proyecto: Challenge SQL - Mercado Libre
-- Base de datos: meli_challenge

-- =========================================


-- usamos la base de datos creada anteriormente

USE meli_challenge;



-- =========================================
-- 1. Usuarios que cumplen años hoy y vendieron más de 1500 órdenes en enero 2020
-- =========================================


-- CTE: prefiltrar órdenes realizadas en enero 2020
WITH ventas_enero_2020 AS (
    SELECT
        o.order_id,
        i.vendedor_id
    FROM `order` o
    JOIN item i ON o.item_id = i.item_id
    WHERE o.fecha_venta >= '2020-01-01'
      AND o.fecha_venta < '2020-02-01'
)

-- Query final: aplicar filtro por cumpleaños y agrupar correctamente
SELECT
    c.customer_id,
    c.nombre,
    c.apellido,
    c.email,
    COUNT(ve.order_id) AS total_ventas
FROM ventas_enero_2020 ve
JOIN customer c ON ve.vendedor_id = c.customer_id
WHERE DATE_FORMAT(c.fecha_nacimiento, '%m-%d') = DATE_FORMAT(CURDATE(), '%m-%d')
GROUP BY
    c.customer_id,
    c.nombre,
    c.apellido,
    c.email
HAVING COUNT(ve.order_id) > 1500;




-- =========================================
-- 2. TOP 5 vendedores por mes (categoría Celulares) - año 2020
-- Consulta optimizada y simplificada con ROW_NUMBER()
-- =========================================

WITH ventas_mensuales AS (
    SELECT
        DATE_FORMAT(o.fecha_venta, '%Y-%m') AS mes_anio,
        c.customer_id,
        c.nombre,
        c.apellido,
        COUNT(DISTINCT o.order_id) AS total_ordenes,
        SUM(o.cantidad) AS productos_vendidos,
        SUM(o.monto_total) AS monto_total_transaccionado,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_FORMAT(o.fecha_venta, '%Y-%m')
            ORDER BY SUM(o.monto_total) DESC
        ) AS ranking
    FROM `order` o
    JOIN item i ON o.item_id = i.item_id
    JOIN customer c ON i.vendedor_id = c.customer_id
    JOIN category cat ON i.category_id = cat.category_id
    WHERE
        o.fecha_venta >= '2020-01-01' AND o.fecha_venta < '2021-01-01'
        AND cat.nombre = 'Celulares'
    GROUP BY
        DATE_FORMAT(o.fecha_venta, '%Y-%m'),
        c.customer_id,
        c.nombre,
        c.apellido
)

SELECT
    mes_anio,
    customer_id,
    nombre,
    apellido,
    total_ordenes,
    productos_vendidos,
    monto_total_transaccionado
FROM ventas_mensuales
WHERE ranking <= 5
ORDER BY mes_anio, ranking;






-- =========================================
-- 3. Stored Procedure: Cargar snapshot diario de ítems
-- Reprocesable: elimina primero los registros del día si ya existen
-- =========================================


DELIMITER $$

DROP PROCEDURE IF EXISTS cargar_snapshot_item$$

CREATE PROCEDURE cargar_snapshot_item (
    IN p_fecha DATE
)

BEGIN
   
	-- Paso 1: eliminar snapshot del día si ya existe
    DELETE FROM item_daily_snapshot
    WHERE fecha_snapshot = p_fecha;

    -- Paso 2: insertar los ítems con su precio y estado actual
    INSERT INTO item_daily_snapshot (item_id, fecha_snapshot, precio, estado)
    SELECT
        i.item_id,
        p_fecha,
        i.precio,
        i.estado
    FROM item i;
    
END$$


DELIMITER ;



