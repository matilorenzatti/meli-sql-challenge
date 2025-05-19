-- =========================================
-- RESET SCHEMA - meli_challenge
-- Elimina todas las tablas en orden seguro
-- Para ejecutar antes de recrear toda la estructura
-- =========================================

-- Usar la base de datos
USE meli_challenge;

-- Este script nos permite eliminar las tablas forzando que no verifique los foreing keys
-- luego podemos crearlas nuevamente sin problemas con el otro script llamado create_tables.sql

-- Desactivar validación temporal de claves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar tablas en orden inverso (de hijas a padres)
DROP TABLE IF EXISTS item_daily_snapshot;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS customer;

-- Reactivar validación de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;
