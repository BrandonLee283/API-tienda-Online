/*
 Navicat Premium Data Transfer

 Source Server         : BrandonReyes
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : carrito-compras

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 29/05/2023 19:11:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `descripcion_categoria` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_categoria` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (1, 'Telefonia', 'Articulos de telefonia', 1);
INSERT INTO `categorias` VALUES (3, 'Portatiles', 'Equipos de Computo', 1);
INSERT INTO `categorias` VALUES (5, 'Pantallas', 'Televisiones y pantallas', 1);
INSERT INTO `categorias` VALUES (7, 'Audifonos', 'Articulos de audio', 1);
INSERT INTO `categorias` VALUES (9, 'Camaras', 'Articulos de fotografias', 1);

-- ----------------------------
-- Table structure for detalle_venta
-- ----------------------------
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta`  (
  `id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad_venta` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `precioU_venta` float NULL DEFAULT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `correo_cliente` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_detalle_venta`) USING BTREE,
  INDEX `id_venta`(`id_venta`) USING BTREE,
  INDEX `id_producto`(`id_producto`) USING BTREE,
  CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_venta` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of detalle_venta
-- ----------------------------

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `precio_producto` float NULL DEFAULT NULL,
  `imagen_prodcuto` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stock_producto` int(10) NULL DEFAULT NULL,
  `status_producto` tinyint(1) NULL DEFAULT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_producto`) USING BTREE,
  INDEX `id_categ`(`id_categoria`) USING BTREE,
  CONSTRAINT `id_categ` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos
-- ----------------------------
INSERT INTO `productos` VALUES (1, 'Samsung S21 Ultra', 26999, 'celular1', 100, 1, 1);
INSERT INTO `productos` VALUES (3, 'Pixel 6 Pro', 18999, 'celular2', 100, 1, 1);
INSERT INTO `productos` VALUES (5, 'OnePlus 9 Pro', 21999, 'celular3', 100, 1, 1);
INSERT INTO `productos` VALUES (7, 'Xiaomi Mi 11', 26999, 'celular4', 100, 1, 1);
INSERT INTO `productos` VALUES (9, 'iPhone 13 Pro', 24299, 'celular5', 100, 1, 1);
INSERT INTO `productos` VALUES (11, 'MacBook Pro', 27999, 'laptop1', 100, 1, 3);
INSERT INTO `productos` VALUES (13, 'Dell XPS 15', 26999, 'laptop2', 100, 1, 3);
INSERT INTO `productos` VALUES (15, 'HP Spectre x360', 23999, 'laptop3', 100, 1, 3);
INSERT INTO `productos` VALUES (17, 'Lenovo ThinkPad', 27999, 'laptop4', 100, 1, 3);
INSERT INTO `productos` VALUES (19, 'Asus ROG Zephyrus G14', 26999, 'laptop5', 100, 1, 3);
INSERT INTO `productos` VALUES (21, 'LG OLED C1', 34999, 'tv1', 100, 1, 5);
INSERT INTO `productos` VALUES (23, 'Samsung QLED', 29999, 'tv2', 100, 1, 5);
INSERT INTO `productos` VALUES (25, 'Sony BRAVIA XR', 49999, 'tv3', 100, 1, 5);
INSERT INTO `productos` VALUES (27, 'TCL 6-Series', 13999, 'tv4', 100, 1, 5);
INSERT INTO `productos` VALUES (29, 'LG OLED 4K TV', 34999, 'tv5', 100, 1, 5);
INSERT INTO `productos` VALUES (31, 'Apple AirPods Pro', 5499, 'audifonos1', 100, 1, 7);
INSERT INTO `productos` VALUES (33, 'Sony WH', 5999, 'audifonos2', 100, 1, 7);
INSERT INTO `productos` VALUES (35, 'Bose QuietComfort', 5999, 'audifonos3', 100, 1, 7);
INSERT INTO `productos` VALUES (37, 'Jabra Elite 85t', 3999, 'audifonos4', 100, 1, 7);
INSERT INTO `productos` VALUES (39, 'Sennheiser Momentum True 2', 4999, 'audifonos5', 100, 1, 7);

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta`  (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_venta` date NULL DEFAULT NULL,
  `total_venta` float NULL DEFAULT NULL,
  `status_venta` tinyint(1) NULL DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_venta`) USING BTREE,
  INDEX `id_prod`(`id_producto`) USING BTREE,
  CONSTRAINT `id_prod` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of venta
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
