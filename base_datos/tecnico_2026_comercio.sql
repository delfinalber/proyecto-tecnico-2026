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

-- --------------------------------------------------------
--
-- Datos de ejemplo (15 registros por tabla)
--

INSERT INTO `cliente` (`id_cliente`, `identificacion_cliente`, `nom_cliente`, `direccion_cliente`, `pais_cliente`, `telefono_cliente`, `fecha_pedido_cliente`, `vendedor_cliente`, `region_cliente`) VALUES
(1, 101001, 'Ana Torres', 'Calle 10 #12-34', 'Colombia', 3001112233, '2026-03-01', 'Carlos Mendez', 'Andina'),
(2, 101002, 'Luis Rojas', 'Carrera 5 #20-11', 'Colombia', 3001112244, '2026-03-02', 'Paula Diaz', 'Caribe'),
(3, 101003, 'Maria Lopez', 'Av. Central 45-21', 'Colombia', 3001112255, '2026-03-03', 'Jorge Pineda', 'Pacifico'),
(4, 101004, 'Pedro Ramirez', 'Calle 8 #30-17', 'Colombia', 3001112266, '2026-03-04', 'Carolina Ruiz', 'Orinoquia'),
(5, 101005, 'Sofia Martinez', 'Transversal 3 #18-40', 'Colombia', 3001112277, '2026-03-05', 'Diego Mora', 'Amazonia'),
(6, 101006, 'Camilo Herrera', 'Calle 22 #9-77', 'Colombia', 3001112288, '2026-03-06', 'Carlos Mendez', 'Andina'),
(7, 101007, 'Valentina Castro', 'Carrera 14 #11-09', 'Colombia', 3001112299, '2026-03-07', 'Paula Diaz', 'Caribe'),
(8, 101008, 'Andres Gomez', 'Calle 60 #4-52', 'Colombia', 3001112300, '2026-03-08', 'Jorge Pineda', 'Pacifico'),
(9, 101009, 'Laura Nino', 'Av. Sur 15-33', 'Colombia', 3001112311, '2026-03-09', 'Carolina Ruiz', 'Orinoquia'),
(10, 101010, 'Miguel Silva', 'Calle 90 #2-18', 'Colombia', 3001112322, '2026-03-10', 'Diego Mora', 'Amazonia'),
(11, 101011, 'Daniela Acosta', 'Carrera 27 #6-91', 'Colombia', 3001112333, '2026-03-11', 'Carlos Mendez', 'Andina'),
(12, 101012, 'Juan Perez', 'Diagonal 12 #44-20', 'Colombia', 3001112344, '2026-03-12', 'Paula Diaz', 'Caribe'),
(13, 101013, 'Paola Fuentes', 'Calle 16 #7-64', 'Colombia', 3001112355, '2026-03-13', 'Jorge Pineda', 'Pacifico'),
(14, 101014, 'Ricardo Leon', 'Av. Norte 100-55', 'Colombia', 3001112366, '2026-03-14', 'Carolina Ruiz', 'Orinoquia'),
(15, 101015, 'Natalia Cruz', 'Carrera 19 #8-73', 'Colombia', 3001112377, '2026-03-15', 'Diego Mora', 'Amazonia');

INSERT INTO `producto` (`id_producto`, `nom_producto`, `precio_unidad_producto`, `numero_existencia_producto`, `categoria_producto`, `descuento_producto`, `cantidad_total_existente_producto`) VALUES
(1, 'Arroz 1kg', 4500, 120, 'Granos', 5, 120),
(2, 'Azucar 1kg', 4200, 100, 'Despensa', 3, 100),
(3, 'Cafe 500g', 9800, 80, 'Bebidas', 8, 80),
(4, 'Leche 1L', 3800, 150, 'Lacteos', 2, 150),
(5, 'Pan tajado', 5200, 90, 'Panaderia', 4, 90),
(6, 'Huevos x12', 11000, 70, 'Proteinas', 6, 70),
(7, 'Aceite 1L', 12500, 60, 'Despensa', 5, 60),
(8, 'Sal 500g', 2200, 140, 'Despensa', 1, 140),
(9, 'Pasta 500g', 3600, 130, 'Despensa', 2, 130),
(10, 'Atun lata', 7600, 95, 'Enlatados', 7, 95),
(11, 'Galletas 200g', 3400, 110, 'Snacks', 3, 110),
(12, 'Jugo 1L', 4900, 85, 'Bebidas', 4, 85),
(13, 'Detergente 500g', 6800, 75, 'Aseo', 5, 75),
(14, 'Jabon barra', 2600, 125, 'Aseo', 2, 125),
(15, 'Papel higienico x4', 8900, 65, 'Hogar', 6, 65);

INSERT INTO `factura` (`id_factura`, `id_cliente`, `fecha_pedido_factura`, `subtotal_factura`, `descuento_factura`, `region_factura`, `vendedor_factura`) VALUES
(1, 1, '2026-03-01', 9000, 450, 'Andina', 'Carlos Mendez'),
(2, 2, '2026-03-02', 12600, 378, 'Caribe', 'Paula Diaz'),
(3, 3, '2026-03-03', 19600, 1568, 'Pacifico', 'Jorge Pineda'),
(4, 4, '2026-03-04', 11400, 228, 'Orinoquia', 'Carolina Ruiz'),
(5, 5, '2026-03-05', 15600, 624, 'Amazonia', 'Diego Mora'),
(6, 6, '2026-03-06', 22000, 1320, 'Andina', 'Carlos Mendez'),
(7, 7, '2026-03-07', 25000, 1250, 'Caribe', 'Paula Diaz'),
(8, 8, '2026-03-08', 6600, 66, 'Pacifico', 'Jorge Pineda'),
(9, 9, '2026-03-09', 14400, 288, 'Orinoquia', 'Carolina Ruiz'),
(10, 10, '2026-03-10', 15200, 1064, 'Amazonia', 'Diego Mora'),
(11, 11, '2026-03-11', 10200, 306, 'Andina', 'Carlos Mendez'),
(12, 12, '2026-03-12', 14700, 588, 'Caribe', 'Paula Diaz'),
(13, 13, '2026-03-13', 13600, 680, 'Pacifico', 'Jorge Pineda'),
(14, 14, '2026-03-14', 7800, 156, 'Orinoquia', 'Carolina Ruiz'),
(15, 15, '2026-03-15', 17800, 1068, 'Amazonia', 'Diego Mora');

INSERT INTO `elementos_linea` (`id_elementos_linea`, `id_factura`, `id_producto`, `precio_unidad_elementos_linea`, `cantidad_elemnetos_linea`, `precio_ampliado_elementos_linea`, `nombre_producto_elemnetos_linea`, `total_elementos_linea`, `cantidad_existencia_elemnetos_linea`, `fecha_pedido_elementos_linea`) VALUES
(1, 1, 1, 4500, 2, 9000, 'Arroz 1kg', 9000, 120, '2026-03-01'),
(2, 2, 2, 4200, 3, 12600, 'Azucar 1kg', 12600, 100, '2026-03-02'),
(3, 3, 3, 9800, 2, 19600, 'Cafe 500g', 19600, 80, '2026-03-03'),
(4, 4, 4, 3800, 3, 11400, 'Leche 1L', 11400, 150, '2026-03-04'),
(5, 5, 5, 5200, 3, 15600, 'Pan tajado', 15600, 90, '2026-03-05'),
(6, 6, 6, 11000, 2, 22000, 'Huevos x12', 22000, 70, '2026-03-06'),
(7, 7, 7, 12500, 2, 25000, 'Aceite 1L', 25000, 60, '2026-03-07'),
(8, 8, 8, 2200, 3, 6600, 'Sal 500g', 6600, 140, '2026-03-08'),
(9, 9, 9, 3600, 4, 14400, 'Pasta 500g', 14400, 130, '2026-03-09'),
(10, 10, 10, 7600, 2, 15200, 'Atun lata', 15200, 95, '2026-03-10'),
(11, 11, 11, 3400, 3, 10200, 'Galletas 200g', 10200, 110, '2026-03-11'),
(12, 12, 12, 4900, 3, 14700, 'Jugo 1L', 14700, 85, '2026-03-12'),
(13, 13, 13, 6800, 2, 13600, 'Detergente 500g', 13600, 75, '2026-03-13'),
(14, 14, 14, 2600, 3, 7800, 'Jabon barra', 7800, 125, '2026-03-14'),
(15, 15, 15, 8900, 2, 17800, 'Papel higienico x4', 17800, 65, '2026-03-15');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
