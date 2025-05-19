-- =========================================
-- SCHEMA: meli_challenge
-- Proyecto: Challenge Mercado Libre - DER
-- Motor compatible: MySQL / SQL estándar
-- =========================================


-- Con este script, podemos crear las tablas sin problemas

-- En las tablas de ITEM y ORDER, al ser grandes y frecuentemente consultadas
-- vamos a crear indices para mejorar el rendimiento de las consultas :)


-- Crear base de datos y usarla
CREATE DATABASE IF NOT EXISTS meli_challenge;
USE meli_challenge;



-- =========================================
-- Tabla: CUSTOMER
-- =========================================
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    sexo VARCHAR(20) NOT NULL, -- Validar en backend ('Masculino', 'Femenino', 'Otro')
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_alta DATE NOT NULL
);



-- =========================================
-- Tabla: CATEGORY
-- =========================================
CREATE TABLE IF NOT EXISTS category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    path TEXT NOT NULL
);



-- =========================================
-- Tabla: ITEM
-- =========================================
CREATE TABLE IF NOT EXISTS item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE DEFAULT NULL,
    estado VARCHAR(20) NOT NULL, -- Validar en backend ('activo', 'pausado', 'inactivo')
    category_id INT NOT NULL,
    vendedor_id INT NOT NULL,

    -- Claves foráneas
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (vendedor_id) REFERENCES customer(customer_id),

    -- Índices para análisis y consultas frecuentes
    INDEX idx_item_estado (estado),
    INDEX idx_item_fecha_alta (fecha_alta),
    INDEX idx_item_vendedor_id (vendedor_id)
);



-- =========================================
-- Tabla: ORDER
-- =========================================
CREATE TABLE IF NOT EXISTS `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    comprador_id INT NOT NULL,
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    monto_total DECIMAL(12,2) NOT NULL,

    -- Claves foráneas
    FOREIGN KEY (item_id) REFERENCES item(item_id),
    FOREIGN KEY (comprador_id) REFERENCES customer(customer_id),

    -- Índices analíticos
    INDEX idx_order_fecha_venta (fecha_venta),
    INDEX idx_order_item_id (item_id),
    INDEX idx_order_comprador_id (comprador_id)
);



-- =========================================
-- Tabla: ITEM_DAILY_SNAPSHOT
-- =========================================
CREATE TABLE IF NOT EXISTS item_daily_snapshot (
    item_id INT NOT NULL,
    fecha_snapshot DATE NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL, -- Validar en backend

    PRIMARY KEY (item_id, fecha_snapshot),
    FOREIGN KEY (item_id) REFERENCES item(item_id),

    -- Índice de acceso por fecha
    INDEX idx_snapshot_fecha (fecha_snapshot)
);


