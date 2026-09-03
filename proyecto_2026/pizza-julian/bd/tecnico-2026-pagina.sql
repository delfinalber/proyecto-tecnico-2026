-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-09-2026 a las 14:14:23
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tecnico-2026-pagina`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formulario-contacto`
--

CREATE TABLE `formulario-contacto` (
  `id_formulario` int(11) NOT NULL,
  `correo_formulario` varchar(150) NOT NULL,
  `nombre_formulario` varchar(150) NOT NULL,
  `telefono_formulario` bigint(13) NOT NULL,
  `mensaje_formulario` text NOT NULL,
  `fecha-formulario` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `formulario-contacto`
--

INSERT INTO `formulario-contacto` (`id_formulario`, `correo_formulario`, `nombre_formulario`, `telefono_formulario`, `mensaje_formulario`, `fecha-formulario`) VALUES
(1, 'delfin.alber@gmail.com', 'Prueba Automatica', 3132345685, 'Mensaje de prueba desde agente', '2026-08-28 14:37:37'),
(2, 'delfin.alber@gmail.com', 'DANNA LISETH PULIDO ZABALETA', 3132345685, 'Hola', '2026-08-28 14:40:29'),
(3, 'delfin.alber@gmail.com', 'ALBER DELFIN PEÑA ORTIGOZA', 3132345685, 'Hola un saludo', '2026-08-28 14:48:52'),
(4, 'g46113026@gmail.com', 'CUALQUIERA', 3213386504, 'Hola checho estamos en el Tecnico Programando con PHP.', '2026-09-02 18:30:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inicio`
--

CREATE TABLE `inicio` (
  `id_inicio` int(11) NOT NULL,
  `banner_inicio` varchar(200) NOT NULL,
  `carru-1` varchar(200) NOT NULL,
  `carru-2` varchar(200) NOT NULL,
  `carru-3` varchar(200) NOT NULL,
  `url_video_inicio` varchar(200) NOT NULL,
  `acor1_titulo_inicio` varchar(150) NOT NULL,
  `acor1_texto_inicio` varchar(500) NOT NULL,
  `acor2_titulo_inicio` varchar(150) NOT NULL,
  `acor2_texto_inicio` varchar(500) NOT NULL,
  `acor3_titulo_inicio` varchar(150) NOT NULL,
  `acor3_texto_inicio` varchar(500) NOT NULL,
  `acor4_titulo_inicio` varchar(150) NOT NULL,
  `acor4_texto_inicio` varchar(500) NOT NULL,
  `acor5_titulo_inicio` varchar(150) NOT NULL,
  `acor5_texto_inicio` varchar(500) NOT NULL,
  `colapsar1_titulo_inicio` varchar(150) NOT NULL,
  `colapsar1_texto_inicio` varchar(500) NOT NULL,
  `colapsar2_titulo_inicio` varchar(150) NOT NULL,
  `colapsar2_texto_inicio` varchar(500) NOT NULL,
  `colapsar3_titulo_inicio` varchar(150) NOT NULL,
  `colapsar3_texto_inicio` varchar(500) NOT NULL,
  `numero_whatsapp` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `inicio`
--

INSERT INTO `inicio` (`id_inicio`, `banner_inicio`, `carru-1`, `carru-2`, `carru-3`, `url_video_inicio`, `acor1_titulo_inicio`, `acor1_texto_inicio`, `acor2_titulo_inicio`, `acor2_texto_inicio`, `acor3_titulo_inicio`, `acor3_texto_inicio`, `acor4_titulo_inicio`, `acor4_texto_inicio`, `acor5_titulo_inicio`, `acor5_texto_inicio`, `colapsar1_titulo_inicio`, `colapsar1_texto_inicio`, `colapsar2_titulo_inicio`, `colapsar2_texto_inicio`, `colapsar3_titulo_inicio`, `colapsar3_texto_inicio`, `numero_whatsapp`) VALUES
(1, './img-inicio/inicio_6a996047b12d05.26024555.png', './img-inicio/inicio_6a996047b17a36.67873678.jpeg', './img-inicio/inicio_6a996047b19aa0.72194725.jpeg', './img-inicio/inicio_6a996047b1c323.69193053.jpeg', 'https://youtu.be/WidvoXBsDbI?si=PajjaLQf9DErYaQd', 'Margarita (Margherita)', 'La reina de las pizzas. Salsa de tomate, mozzarella fresca, albahaca y aceite de oliva Delfin.', 'Cuatro Quesos (Quattro Formaggi)', 'Una mezcla de quesos fundidos, usualmente mozzarella, gorgonzola (azul), fontina y parmesano.', 'Napolitana', 'Salsa de tomate, anchoas, ajo, orégano y aceite de oliva (tradicionalmente no lleva queso).', 'Mexicana', 'Incluye carne molida o chorizo, frijoles negros, jalapeños, cebolla y un toque de aguacate o cilantro.', 'Barbacoa (BBQ)', 'Sustituye la salsa de tomate por salsa barbacoa, acompañada de pollo, carne picada, cebolla y bacon.', 'Vegetariana', 'Cubierta de vegetales frescos o salteados, como pimientos, cebolla, champiñones, aceitunas y tomates cherry.', 'Cuatro Estaciones (Quattro Stagioni)', 'Dividida en cuatro secciones, cada una representando una estación con ingredientes distintos (por ejemplo: alcachofas, champiñones, jamón y albahaca).', 'Funghi (Champiñones)', 'Base de mozzarella con abundantes hongos salteados, a veces con un toque de aceite de trufa.', 573132345685);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `formulario-contacto`
--
ALTER TABLE `formulario-contacto`
  ADD PRIMARY KEY (`id_formulario`);

--
-- Indices de la tabla `inicio`
--
ALTER TABLE `inicio`
  ADD PRIMARY KEY (`id_inicio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `formulario-contacto`
--
ALTER TABLE `formulario-contacto`
  MODIFY `id_formulario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `inicio`
--
ALTER TABLE `inicio`
  MODIFY `id_inicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
