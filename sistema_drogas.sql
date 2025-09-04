-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 21-06-2025 a las 01:16:28
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14
CREATE DATABASE sistema_drogas;
USE sistema_drogas;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_drogas`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `insertar_1000_drogas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_1000_drogas` ()   BEGIN
    DECLARE i INT DEFAULT (SELECT MAX(id) + 1 FROM drogas); -- Comenzar desde el siguiente ID disponible
    DECLARE max_id INT DEFAULT i + 999; -- Insertar hasta 1000 registros
    -- Resto del procedimiento igual...
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `drogas`
--

DROP TABLE IF EXISTS `drogas`;
CREATE TABLE IF NOT EXISTS `drogas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo_id` int NOT NULL,
  `nombre_cientifico` varchar(100) DEFAULT NULL,
  `forma_consumo` enum('Oral','Inhalado','Inyectado','Fumado','Tópico','Otro') DEFAULT NULL,
  `riesgo_adiccion` enum('Bajo','Moderado','Alto','Muy alto') DEFAULT NULL,
  `descripcion` text,
  `efectos_principales` text,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` int DEFAULT NULL,
  `modificado_por` int DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  KEY `drogas_creado_por_fk` (`creado_por`),
  KEY `drogas_modificado_por_fk` (`modificado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `drogas`
--

INSERT INTO `drogas` (`id`, `nombre`, `tipo_id`, `nombre_cientifico`, `forma_consumo`, `riesgo_adiccion`, `descripcion`, `efectos_principales`, `fecha_creacion`, `creado_por`, `modificado_por`, `fecha_modificacion`) VALUES
(1, 'Cocaína', 1, 'Benzoylmethylecgonine', '', 'Muy alto', 'Estimulante poderoso derivado de la hoja de coca', 'Euforia, energía aumentada, disminución del apetito', '2025-05-13 00:55:23', NULL, NULL, NULL),
(2, 'Heroína', 4, 'Diamorphine', '', 'Muy alto', 'Opiáceo altamente adictivo', 'Euforia, alivio del dolor, sedación', '2025-05-13 00:55:23', NULL, NULL, NULL),
(3, 'LSD', 3, 'Lysergic acid diethylamide', 'Oral', 'Bajo', 'Alucinógeno poderoso', 'Alucinaciones, alteración de la percepción del tiempo', '2025-05-13 00:55:23', NULL, NULL, NULL),
(4, 'Marihuana', 5, 'Cannabis sativa', '', 'Moderado', 'Derivado de la planta de cannabis', 'Relajación, alteración de la percepción, aumento del apetito', '2025-05-13 00:55:23', NULL, NULL, NULL),
(6, 'Nicotina', 7, 'Nicotiana tabacum', 'Fumado', 'Alto', 'Estimulante leve del tabaco', 'Aumento de la alerta, relajación', '2025-05-13 00:55:23', NULL, NULL, NULL),
(11, 'Droga-11-DEP', 2, 'Chem-11-Depress', 'Tópico', 'Alto', 'Descripción de la droga 11. Alto riesgo de adicción.', 'Efectos principales incluyen aumento de energía, alerta.', '2025-06-21 01:05:48', NULL, NULL, NULL),
(12, 'Droga-12-CAN', 5, 'Chem-12-Cannab', 'Oral', 'Bajo', 'Descripción de la droga 12. Bajo riesgo de adicción.', 'Efectos principales incluyen cambios en el apetito.', '2025-06-21 01:05:48', NULL, NULL, NULL),
(13, 'LSD', 3, 'dietilamida de ácido lisérgico', 'Inyectado', 'Alto', 'El LSD es una sustancia psicodélica semisintética conocida por sus potentes efectos alucinógenos. Actúa principalmente sobre los receptores de serotonina (5-HT2A) en el cerebro, alterando la percepción, el estado de ánimo y la cognición. Sus efectos varían según la dosis, el contexto y la predisposición del usuario', 'Perceptivos:\r\n\r\nAlucinaciones visuales (colores intensos, patrones geométricos, distorsión de formas).\r\n\r\nSinestesia (mezcla de sentidos, ej.: \"ver\" sonidos o \"oír\" colores).\r\n\r\nAlteración de la percepción del tiempo (el tiempo parece acelerarse o detenerse).\r\n\r\nCognitivos y emocionales:\r\n\r\nPensamiento introspectivo o filosófico.\r\n\r\nEuforia, pero también riesgo de ansiedad o paranoia (\"mal viaje\").\r\n\r\nSensación de conexión con el entorno o disolución del ego (\"experiencia mística\").', '2025-06-19 15:13:19', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_efectos`
--

DROP TABLE IF EXISTS `droga_efectos`;
CREATE TABLE IF NOT EXISTS `droga_efectos` (
  `droga_id` int NOT NULL,
  `efecto_id` int NOT NULL,
  `intensidad` enum('Leve','Moderado','Fuerte') DEFAULT NULL,
  `tiempo_inicio` varchar(50) DEFAULT NULL,
  `duracion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`droga_id`,`efecto_id`),
  KEY `efecto_id` (`efecto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `droga_efectos`
--

INSERT INTO `droga_efectos` (`droga_id`, `efecto_id`, `intensidad`, `tiempo_inicio`, `duracion`) VALUES
(1, 1, 'Fuerte', 'Minutos', '30-60 minutos'),
(1, 4, 'Fuerte', 'Minutos', '1-2 horas'),
(1, 6, 'Moderado', 'Minutos', 'Hasta varias horas'),
(1, 8, 'Fuerte', 'Minutos', '1-2 horas'),
(2, 1, 'Fuerte', 'Minutos', '4-6 horas'),
(2, 2, 'Fuerte', 'Minutos', '4-6 horas'),
(2, 9, 'Fuerte', 'Uso prolongado', 'Crónico'),
(4, 1, 'Moderado', 'Minutos', '2-4 horas'),
(4, 5, 'Leve', 'Minutos', '2-4 horas'),
(4, 7, 'Moderado', 'Minutos', '2-4 horas'),
(11, 2, 'Moderado', 'Horas', '24 horas'),
(11, 15, 'Fuerte', 'Uso prolongado', '30-60 minutos'),
(11, 32, 'Leve', 'Minutos', '1-2 horas'),
(11, 39, 'Fuerte', 'Minutos', 'Crónico'),
(11, 45, 'Fuerte', 'Minutos', '24 horas'),
(12, 2, 'Moderado', 'Inmediato', '24 horas'),
(12, 15, 'Fuerte', 'Horas', '30-60 minutos'),
(12, 32, 'Fuerte', 'Uso prolongado', '30-60 minutos'),
(12, 39, 'Moderado', 'Horas', '4-6 horas'),
(12, 45, 'Leve', 'Minutos', '1-2 horas'),
(13, 1, 'Moderado', 'Automaticamente ', '6'),
(13, 2, 'Fuerte', 'Horas', '1-2 horas'),
(13, 4, 'Leve', '', ''),
(13, 6, 'Leve', '', ''),
(13, 15, 'Fuerte', 'Horas', '4-6 horas'),
(13, 32, 'Leve', 'Inmediato', '30-60 minutos'),
(13, 39, 'Fuerte', 'Inmediato', '4-6 horas'),
(13, 45, 'Moderado', 'Inmediato', '24 horas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_riesgos`
--

DROP TABLE IF EXISTS `droga_riesgos`;
CREATE TABLE IF NOT EXISTS `droga_riesgos` (
  `droga_id` int NOT NULL,
  `riesgo_id` int NOT NULL,
  `probabilidad` enum('Baja','Media','Alta') DEFAULT NULL,
  PRIMARY KEY (`droga_id`,`riesgo_id`),
  KEY `riesgo_id` (`riesgo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `droga_riesgos`
--

INSERT INTO `droga_riesgos` (`droga_id`, `riesgo_id`, `probabilidad`) VALUES
(1, 1, 'Alta'),
(1, 2, 'Alta'),
(1, 3, 'Alta'),
(1, 6, 'Alta'),
(2, 1, 'Alta'),
(2, 2, ''),
(2, 4, 'Alta'),
(11, 4, 'Baja'),
(11, 6, 'Baja'),
(11, 7, 'Alta'),
(11, 8, 'Media'),
(11, 21, 'Alta'),
(12, 4, 'Media'),
(12, 6, 'Alta'),
(12, 7, 'Media'),
(12, 8, 'Baja'),
(12, 21, 'Baja'),
(13, 4, 'Baja'),
(13, 6, 'Baja'),
(13, 7, 'Baja'),
(13, 8, 'Baja'),
(13, 21, 'Media');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_tratamientos`
--

DROP TABLE IF EXISTS `droga_tratamientos`;
CREATE TABLE IF NOT EXISTS `droga_tratamientos` (
  `droga_id` int NOT NULL,
  `tratamiento_id` int NOT NULL,
  `recomendado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`droga_id`,`tratamiento_id`),
  KEY `tratamiento_id` (`tratamiento_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `droga_tratamientos`
--

INSERT INTO `droga_tratamientos` (`droga_id`, `tratamiento_id`, `recomendado`) VALUES
(1, 1, 1),
(1, 3, 1),
(1, 4, 1),
(2, 1, 1),
(2, 2, 1),
(2, 4, 1),
(11, 4, 0),
(11, 10, 0),
(11, 20, 0),
(12, 4, 1),
(12, 10, 0),
(12, 20, 1),
(13, 1, 1),
(13, 4, 1),
(13, 5, 1),
(13, 10, 0),
(13, 20, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `efectos`
--

DROP TABLE IF EXISTS `efectos`;
CREATE TABLE IF NOT EXISTS `efectos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `categoria` enum('Físico','Psicológico','Social','Comportamental') DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `efectos`
--

INSERT INTO `efectos` (`id`, `nombre`, `categoria`, `descripcion`) VALUES
(1, 'Euforia', 'Psicológico', 'Sensación intensa de felicidad o bienestar'),
(2, 'Sedación', 'Físico', 'Reducción de la actividad física y mental'),
(3, 'Alucinaciones', 'Psicológico', 'Percepciones de cosas que no existen'),
(4, 'Aumento de energía', 'Físico', 'Sensación de mayor energía y alerta'),
(5, 'Deterioro motor', 'Físico', 'Reducción de la coordinación y habilidades motoras'),
(6, 'Ansiedad', 'Psicológico', 'Sensación de nerviosismo o miedo'),
(7, 'Aumento del apetito', 'Físico', 'Hambre aumentada'),
(8, 'Taquicardia', 'Físico', 'Aumento del ritmo cardíaco'),
(9, 'Dependencia', 'Comportamental', 'Necesidad compulsiva de consumir la sustancia'),
(10, 'Insomnio', 'Físico', 'Dificultad para conciliar el sueño'),
(11, 'Paranoia', 'Psicológico', 'Sensación excesiva de desconfianza'),
(12, 'Sudoración', 'Físico', 'Aumento en la producción de sudor'),
(13, 'Temblores', 'Físico', 'Movimientos involuntarios'),
(14, 'Náuseas', 'Físico', 'Sensación de malestar estomacal'),
(15, 'Vómitos', 'Físico', 'Expulsión forzada del contenido estomacal'),
(16, 'Diarrea', 'Físico', 'Evacuaciones intestinales líquidas frecuentes'),
(17, 'Sequedad bucal', 'Físico', 'Disminución de la producción de saliva'),
(18, 'Pupilas dilatadas', 'Físico', 'Aumento del tamaño de las pupilas'),
(19, 'Pupilas contraídas', 'Físico', 'Disminución del tamaño de las pupilas'),
(20, 'Hipertensión', 'Físico', 'Aumento de la presión arterial'),
(21, 'Hipotensión', 'Físico', 'Disminución de la presión arterial'),
(22, 'Dolor de cabeza', 'Físico', 'Malestar en la región craneal'),
(23, 'Mareos', 'Físico', 'Sensación de inestabilidad'),
(24, 'Desorientación', 'Psicológico', 'Confusión sobre tiempo, lugar o persona'),
(25, 'Pérdida de memoria', 'Psicológico', 'Dificultad para recordar información'),
(26, 'Dificultad para concentrarse', 'Psicológico', 'Problemas para mantener la atención'),
(27, 'Habla arrastrada', 'Físico', 'Dificultad para articular palabras'),
(28, 'Coordinación reducida', 'Físico', 'Deterioro de las habilidades motoras'),
(29, 'Convulsiones', 'Físico', 'Actividad eléctrica anormal en el cerebro'),
(30, 'Coma', 'Físico', 'Pérdida prolongada de la consciencia'),
(31, 'Depresión respiratoria', 'Físico', 'Disminución de la frecuencia respiratoria'),
(32, 'Hipertermia', 'Físico', 'Aumento peligroso de la temperatura corporal'),
(33, 'Hipotermia', 'Físico', 'Disminución peligrosa de la temperatura corporal'),
(34, 'Agresión', 'Comportamental', 'Comportamiento violento o hostil'),
(35, 'Impulsividad', 'Comportamental', 'Tendencia a actuar sin pensar'),
(36, 'Comportamiento arriesgado', 'Comportamental', 'Toma de decisiones peligrosas'),
(37, 'Aislamiento', 'Social', 'Retiro de interacciones sociales'),
(38, 'Problemas laborales', 'Social', 'Dificultades en el ámbito laboral'),
(39, 'Problemas familiares', 'Social', 'Conflictos con miembros de la familia'),
(40, 'Delirios', 'Psicológico', 'Creencias falsas fijas'),
(41, 'Ideación suicida', 'Psicológico', 'Pensamientos sobre suicidio'),
(42, 'Psicosis', 'Psicológico', 'Pérdida de contacto con la realidad'),
(43, 'Manía', 'Psicológico', 'Estado de ánimo anormalmente elevado'),
(44, 'Pánico', 'Psicológico', 'Ataques de miedo intenso'),
(45, 'Despersonalización', 'Psicológico', 'Sensación de estar separado del cuerpo'),
(46, 'Desrealización', 'Psicológico', 'Sensación de que el entorno no es real'),
(47, 'Flashbacks', 'Psicológico', 'Reexperimentación de efectos pasados'),
(48, 'Tolerancia', 'Físico', 'Necesidad de dosis mayores para mismo efecto'),
(49, 'Síndrome de abstinencia', 'Físico', 'Síntomas al discontinuar el uso'),
(50, 'Disfunción sexual', 'Físico', 'Problemas con la función sexual'),
(51, 'Problemas menstruales', 'Físico', 'Alteraciones en el ciclo menstrual'),
(52, 'Infertilidad', 'Físico', 'Dificultad para concebir'),
(53, 'Defectos congénitos', 'Físico', 'Anomalías en el desarrollo fetal'),
(54, 'Problemas de crecimiento', 'Físico', 'Alteraciones en el desarrollo físico'),
(55, 'Envejecimiento prematuro', 'Físico', 'Signos de envejecimiento antes de tiempo'),
(56, 'Problemas dentales', 'Físico', 'Daño a dientes y encías'),
(57, 'Caída del cabello', 'Físico', 'Pérdida anormal de cabello'),
(58, 'Problemas cutáneos', 'Físico', 'Alteraciones en la piel'),
(59, 'Infecciones', 'Físico', 'Mayor susceptibilidad a enfermedades');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

DROP TABLE IF EXISTS `registro_actividad`;
CREATE TABLE IF NOT EXISTS `registro_actividad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `accion` varchar(50) NOT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  `registro_id` int DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(45) DEFAULT NULL,
  `detalles` text,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riesgos`
--

DROP TABLE IF EXISTS `riesgos`;
CREATE TABLE IF NOT EXISTS `riesgos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `categoria` enum('Físico','Mental','Social','Legal','Económico') DEFAULT NULL,
  `descripcion` text,
  `gravedad` enum('Baja','Media','Alta','Muy alta') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `riesgos`
--

INSERT INTO `riesgos` (`id`, `nombre`, `categoria`, `descripcion`, `gravedad`) VALUES
(1, 'Sobredosis', 'Físico', 'Consumo excesivo que puede llevar a la muerte', 'Muy alta'),
(2, 'Adicción', 'Mental', 'Dependencia psicológica y física', 'Alta'),
(3, 'Problemas cardíacos', 'Físico', 'Daño al sistema cardiovascular', 'Alta'),
(4, 'Problemas hepáticos', 'Físico', 'Daño al hígado', 'Alta'),
(5, 'Problemas pulmonares', 'Físico', 'Daño a los pulmones', 'Alta'),
(6, 'Problemas legales', 'Legal', 'Consecuencias por posesión o consumo', 'Media'),
(7, 'Problemas económicos', 'Económico', 'Gastos excesivos en la sustancia', 'Media'),
(8, 'Aislamiento social', 'Social', 'Pérdida de relaciones personales', 'Media'),
(9, 'Daño renal', 'Físico', 'Deterioro de la función renal', 'Alta'),
(10, 'Problemas gastrointestinales', 'Físico', 'Trastornos del sistema digestivo', 'Media'),
(11, 'Accidentes', 'Físico', 'Mayor riesgo de sufrir accidentes', 'Alta'),
(12, 'Violencia', 'Social', 'Comportamiento violento hacia otros', 'Alta'),
(13, 'Abuso sexual', 'Social', 'Mayor riesgo de sufrir o cometer abuso', 'Muy alta'),
(14, 'Problemas académicos', 'Social', 'Deterioro del rendimiento escolar', 'Media'),
(15, 'Desempleo', 'Económico', 'Pérdida de empleo o dificultad para conseguir', 'Alta'),
(16, 'Deudas', 'Económico', 'Acumulación de obligaciones financieras', 'Media'),
(17, 'Pérdida de propiedades', 'Económico', 'Venta o pérdida de bienes', 'Alta'),
(18, 'Homelessness', 'Social', 'Pérdida de vivienda estable', 'Alta'),
(19, 'Problemas de custodia', 'Legal', 'Pérdida de custodia de hijos', 'Muy alta'),
(20, 'Encarcelamiento', 'Legal', 'Privación de libertad', 'Muy alta'),
(21, 'Multas', 'Legal', 'Sanciones económicas', 'Media'),
(22, 'Servicio comunitario', 'Legal', 'Obligación de realizar trabajo no remunerado', 'Baja'),
(23, 'Pérdida de licencia', 'Legal', 'Revocación de permisos (conducir, etc.)', 'Media'),
(24, 'Daño cerebral', 'Físico', 'Deterioro cognitivo permanente', 'Muy alta'),
(25, 'Neuropatía', 'Físico', 'Daño a los nervios periféricos', 'Alta'),
(26, 'Problemas de visión', 'Físico', 'Deterioro de la capacidad visual', 'Alta'),
(27, 'Pérdida auditiva', 'Físico', 'Deterioro de la capacidad auditiva', 'Alta'),
(28, 'Osteoporosis', 'Físico', 'Disminución de la densidad ósea', 'Alta'),
(29, 'Artritis', 'Físico', 'Inflamación de las articulaciones', 'Media'),
(30, 'Enfermedades autoinmunes', 'Físico', 'Alteración del sistema inmunológico', 'Alta'),
(31, 'Cáncer', 'Físico', 'Desarrollo de neoplasias malignas', 'Muy alta'),
(32, 'Enfermedades infecciosas', 'Físico', 'Contagio de VIH, hepatitis, etc.', 'Muy alta'),
(33, 'Desnutrición', 'Físico', 'Deficiencias nutricionales', 'Media'),
(34, 'Deshidratación', 'Físico', 'Pérdida excesiva de líquidos', 'Alta'),
(35, 'Problemas metabólicos', 'Físico', 'Alteraciones en el metabolismo', 'Media'),
(36, 'Trastornos del sueño', 'Físico', 'Alteraciones en los patrones de sueño', 'Media'),
(37, 'Problemas de tiroides', 'Físico', 'Disfunción de la glándula tiroides', 'Alta'),
(38, 'Problemas de crecimiento', 'Físico', 'Alteraciones en el desarrollo físico', 'Alta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_drogas`
--

DROP TABLE IF EXISTS `tipos_drogas`;
CREATE TABLE IF NOT EXISTS `tipos_drogas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  `legal` tinyint(1) DEFAULT '0',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipos_drogas`
--

INSERT INTO `tipos_drogas` (`id`, `nombre`, `descripcion`, `legal`, `fecha_creacion`) VALUES
(1, 'Estimulantes', 'Aceleran el sistema nervioso central', 0, '2025-05-13 00:55:23'),
(2, 'Depresores', 'Enlentecen el sistema nervioso central', 0, '2025-05-13 00:55:23'),
(3, 'Alucinógenos', 'Alteran la percepción de la realidad', 0, '2025-05-13 00:55:23'),
(4, 'Opiáceos', 'Derivados del opio, usados como analgésicos', 0, '2025-05-13 00:55:23'),
(5, 'Cannabinoides', 'Derivados del cannabis', 1, '2025-05-13 00:55:23'),
(6, 'Alcohol', 'Depresor del SNC legal en muchos países', 1, '2025-05-13 00:55:23'),
(7, 'Tabaco', 'Estimulante leve legal en muchos países', 1, '2025-05-13 00:55:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens_acceso`
--

DROP TABLE IF EXISTS `tokens_acceso`;
CREATE TABLE IF NOT EXISTS `tokens_acceso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_expiracion` timestamp NULL DEFAULT NULL,
  `valido` tinyint(1) DEFAULT '1',
  `dispositivo` varchar(100) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `usuario_id` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tokens_acceso`
--

INSERT INTO `tokens_acceso` (`id`, `usuario_id`, `token`, `fecha_creacion`, `fecha_expiracion`, `valido`, `dispositivo`, `ip`) VALUES
(1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', '2025-06-10 22:23:22', '2025-06-10 23:23:22', 1, 'Web Browser', '192.168.1.1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

DROP TABLE IF EXISTS `tratamientos`;
CREATE TABLE IF NOT EXISTS `tratamientos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` enum('Farmacológico','Terapia','Grupo de apoyo','Internamiento','Otro') DEFAULT NULL,
  `descripcion` text,
  `efectividad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tratamientos`
--

INSERT INTO `tratamientos` (`id`, `nombre`, `tipo`, `descripcion`, `efectividad`) VALUES
(1, 'Terapia cognitivo-conductual', 'Terapia', 'Enfocada en cambiar patrones de pensamiento', 'Alta'),
(2, 'Metadona', 'Farmacológico', 'Sustituto de opiáceos para desintoxicación', 'Moderada'),
(3, 'Grupos de apoyo', 'Grupo de apoyo', 'Comunidades como Narcóticos Anónimos', 'Moderada'),
(4, 'Internamiento', 'Internamiento', 'Tratamiento residencial intensivo', 'Alta'),
(5, 'Terapia familiar', 'Terapia', 'Involucra a la familia en el tratamiento', 'Moderada'),
(6, 'Buprenorfina', 'Farmacológico', 'Medicamento para tratar la adicción a opiáceos', 'Alta'),
(7, 'Naltrexona', 'Farmacológico', 'Bloquea los efectos de opiáceos y alcohol', 'Moderada'),
(8, 'Disulfiram', 'Farmacológico', 'Causa malestar al consumir alcohol', 'Moderada'),
(9, 'Acamprosato', 'Farmacológico', 'Reduce el deseo de beber alcohol', 'Moderada'),
(10, 'Terapia dialéctica conductual', 'Terapia', 'Enfocada en regulación emocional', 'Alta'),
(11, 'Terapia de aceptación y compromiso', 'Terapia', 'Enfocada en valores personales', 'Moderada'),
(12, 'Terapia motivacional', 'Terapia', 'Aumenta la motivación para el cambio', 'Moderada'),
(13, 'Terapia de manejo de contingencias', 'Terapia', 'Refuerzo positivo por abstinencia', 'Alta'),
(14, 'Programa de 12 pasos', 'Grupo de apoyo', 'Modelo de recuperación espiritual', 'Moderada'),
(15, 'Terapia de pareja', 'Terapia', 'Enfocada en relaciones de pareja', 'Moderada'),
(16, 'Terapia ocupacional', 'Terapia', 'Enfocada en habilidades laborales', 'Moderada'),
(17, 'Terapia recreativa', 'Terapia', 'Uso de actividades recreativas', 'Baja'),
(18, 'Terapia con animales', 'Terapia', 'Interacción con animales de terapia', 'Baja'),
(19, 'Terapia artística', 'Terapia', 'Expresión a través del arte', 'Baja'),
(20, 'Terapia musical', 'Terapia', 'Uso de la música para la recuperación', 'Baja'),
(21, 'Hospitalización parcial', 'Internamiento', 'Programa diurno intensivo', 'Alta'),
(22, 'Desintoxicación ambulatoria', 'Internamiento', 'Desintoxicación sin internamiento', 'Moderada'),
(23, 'Comunidad terapéutica', 'Internamiento', 'Vivienda supervisada a largo plazo', 'Alta'),
(24, 'Tratamiento dual', 'Internamiento', 'Para adicción y salud mental', 'Alta'),
(25, 'Terapia de aversión', 'Terapia', 'Asocia droga con estímulos desagradables', 'Baja');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `rol` enum('admin','editor','consulta') NOT NULL DEFAULT 'consulta',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimo_login` timestamp NULL DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password_hash`, `email`, `rol`, `fecha_creacion`, `ultimo_login`, `activo`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@sistema.com', 'admin', '2025-06-10 22:22:06', NULL, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `drogas`
--
ALTER TABLE `drogas`
  ADD CONSTRAINT `drogas_creado_por_fk` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `drogas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_drogas` (`id`),
  ADD CONSTRAINT `drogas_modificado_por_fk` FOREIGN KEY (`modificado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `droga_efectos`
--
ALTER TABLE `droga_efectos`
  ADD CONSTRAINT `droga_efectos_ibfk_1` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`),
  ADD CONSTRAINT `droga_efectos_ibfk_2` FOREIGN KEY (`efecto_id`) REFERENCES `efectos` (`id`);

--
-- Filtros para la tabla `droga_riesgos`
--
ALTER TABLE `droga_riesgos`
  ADD CONSTRAINT `droga_riesgos_ibfk_1` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`),
  ADD CONSTRAINT `droga_riesgos_ibfk_2` FOREIGN KEY (`riesgo_id`) REFERENCES `riesgos` (`id`);

--
-- Filtros para la tabla `droga_tratamientos`
--
ALTER TABLE `droga_tratamientos`
  ADD CONSTRAINT `droga_tratamientos_ibfk_1` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`),
  ADD CONSTRAINT `droga_tratamientos_ibfk_2` FOREIGN KEY (`tratamiento_id`) REFERENCES `tratamientos` (`id`);

--
-- Filtros para la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD CONSTRAINT `registro_actividad_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tokens_acceso`
--
ALTER TABLE `tokens_acceso`
  ADD CONSTRAINT `tokens_acceso_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
