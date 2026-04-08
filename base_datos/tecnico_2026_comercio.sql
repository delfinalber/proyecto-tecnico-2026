-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-04-2026 a las 00:06:22
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tecnico_2026_comercio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `identificacion_cliente` int(11) DEFAULT NULL,
  `nom_cliente` varchar(100) DEFAULT NULL,
  `direccion_cliente` varchar(100) DEFAULT NULL,
  `pais_cliente` varchar(100) DEFAULT NULL,
  `telefono_cliente` bigint(11) DEFAULT NULL,
  `fecha_pedido_cliente` date DEFAULT NULL,
  `vendedor_cliente` varchar(100) DEFAULT NULL,
  `region_cliente` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_linea`
--

CREATE TABLE `elementos_linea` (
  `id_elementos_linea` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio_unidad_elementos_linea` int(10) DEFAULT NULL,
  `cantidad_elemnetos_linea` int(3) DEFAULT NULL,
  `precio_ampliado_elementos_linea` int(10) DEFAULT NULL,
  `nombre_producto_elemnetos_linea` varchar(100) DEFAULT NULL,
  `total_elementos_linea` int(10) DEFAULT NULL,
  `cantidad_existencia_elemnetos_linea` int(3) DEFAULT NULL,
  `fecha_pedido_elementos_linea` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_pedido_factura` date DEFAULT NULL,
  `subtotal_factura` int(10) DEFAULT NULL,
  `descuento_factura` int(10) DEFAULT NULL,
  `region_factura` varchar(100) DEFAULT NULL,
  `vendedor_factura` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nom_producto` varchar(100) DEFAULT NULL,
  `precio_unidad_producto` int(5) DEFAULT NULL,
  `numero_existencia_producto` int(3) DEFAULT NULL,
  `categoria_producto` varchar(100) DEFAULT NULL,
  `descuento_producto` int(5) DEFAULT NULL,
  `cantidad_total_existente_producto` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `identificacion_cliente` (`identificacion_cliente`);

--
-- Indices de la tabla `elementos_linea`
--
ALTER TABLE `elementos_linea`
  ADD PRIMARY KEY (`id_elementos_linea`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `elementos_linea`
--
ALTER TABLE `elementos_linea`
  ADD CONSTRAINT `elementos_linea_ibfk_1` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`),
  ADD CONSTRAINT `elementos_linea_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
