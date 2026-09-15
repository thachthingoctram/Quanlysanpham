-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: productdb
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CategoryId` int NOT NULL,
  `CategoryName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerId` int NOT NULL,
  `CustomerName` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeId` int NOT NULL,
  `EmployeeName` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Position` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `importdetail`
--

DROP TABLE IF EXISTS `importdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importdetail` (
  `ImportDetailId` int NOT NULL,
  `ImportId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(18,2) NOT NULL,
  `Subtotal` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ImportDetailId`),
  KEY `FK_ImportDetail_ImportReceipt` (`ImportId`),
  KEY `FK_ImportDetail_Product` (`ProductId`),
  CONSTRAINT `FK_ImportDetail_ImportReceipt` FOREIGN KEY (`ImportId`) REFERENCES `importreceipt` (`ImportId`),
  CONSTRAINT `FK_ImportDetail_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`),
  CONSTRAINT `CK_ImportDetail_Quantity` CHECK ((`Quantity` > 0)),
  CONSTRAINT `CK_ImportDetail_Subtotal` CHECK ((`Subtotal` >= 0)),
  CONSTRAINT `CK_ImportDetail_UnitPrice` CHECK ((`UnitPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `importdetail`
--

LOCK TABLES `importdetail` WRITE;
/*!40000 ALTER TABLE `importdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `importdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `importreceipt`
--

DROP TABLE IF EXISTS `importreceipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importreceipt` (
  `ImportId` int NOT NULL,
  `SupplierId` int NOT NULL,
  `EmployeeId` int NOT NULL,
  `WarehouseId` int NOT NULL,
  `ImportDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(18,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`ImportId`),
  KEY `FK_ImportReceipt_Supplier` (`SupplierId`),
  KEY `FK_ImportReceipt_Employee` (`EmployeeId`),
  KEY `FK_ImportReceipt_Warehouse` (`WarehouseId`),
  CONSTRAINT `FK_ImportReceipt_Employee` FOREIGN KEY (`EmployeeId`) REFERENCES `employee` (`EmployeeId`),
  CONSTRAINT `FK_ImportReceipt_Supplier` FOREIGN KEY (`SupplierId`) REFERENCES `supplier` (`SupplierId`),
  CONSTRAINT `FK_ImportReceipt_Warehouse` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`WarehouseId`),
  CONSTRAINT `CK_ImportReceipt_TotalAmount` CHECK ((`TotalAmount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `importreceipt`
--

LOCK TABLES `importreceipt` WRITE;
/*!40000 ALTER TABLE `importreceipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `importreceipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetail`
--

DROP TABLE IF EXISTS `orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetail` (
  `OrderDetailId` int NOT NULL,
  `OrderId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(18,2) NOT NULL,
  `Subtotal` decimal(18,2) NOT NULL,
  PRIMARY KEY (`OrderDetailId`),
  KEY `FK_OrderDetail_Order` (`OrderId`),
  KEY `FK_OrderDetail_Product` (`ProductId`),
  CONSTRAINT `FK_OrderDetail_Order` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`),
  CONSTRAINT `FK_OrderDetail_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`),
  CONSTRAINT `CK_OrderDetail_Quantity` CHECK ((`Quantity` > 0)),
  CONSTRAINT `CK_OrderDetail_Subtotal` CHECK ((`Subtotal` >= 0)),
  CONSTRAINT `CK_OrderDetail_UnitPrice` CHECK ((`UnitPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetail`
--

LOCK TABLES `orderdetail` WRITE;
/*!40000 ALTER TABLE `orderdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderId` int NOT NULL,
  `CustomerId` int NOT NULL,
  `EmployeeId` int NOT NULL,
  `OrderDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `Status` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`OrderId`),
  KEY `FK_Orders_Customer` (`CustomerId`),
  KEY `FK_Orders_Employee` (`EmployeeId`),
  CONSTRAINT `FK_Orders_Customer` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`),
  CONSTRAINT `FK_Orders_Employee` FOREIGN KEY (`EmployeeId`) REFERENCES `employee` (`EmployeeId`),
  CONSTRAINT `CK_Orders_TotalAmount` CHECK ((`TotalAmount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductId` int NOT NULL,
  `CategoryId` int NOT NULL,
  `ProductName` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Unit` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ImportPrice` decimal(18,2) NOT NULL,
  `SellingPrice` decimal(18,2) NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Status` varchar(30) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`ProductId`),
  KEY `FK_Product_Category` (`CategoryId`),
  CONSTRAINT `FK_Product_Category` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`CategoryId`),
  CONSTRAINT `CK_Product_ImportPrice` CHECK ((`ImportPrice` >= 0)),
  CONSTRAINT `CK_Product_SellingPrice` CHECK ((`SellingPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `SupplierId` int NOT NULL,
  `SupplierName` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`SupplierId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `WarehouseId` int NOT NULL,
  `WarehouseName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`WarehouseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouseproduct`
--

DROP TABLE IF EXISTS `warehouseproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouseproduct` (
  `WarehouseId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`WarehouseId`,`ProductId`),
  KEY `FK_WarehouseProduct_Product` (`ProductId`),
  CONSTRAINT `FK_WarehouseProduct_Product` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`),
  CONSTRAINT `FK_WarehouseProduct_Warehouse` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`WarehouseId`),
  CONSTRAINT `CK_WarehouseProduct_Quantity` CHECK ((`Quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouseproduct`
--

LOCK TABLES `warehouseproduct` WRITE;
/*!40000 ALTER TABLE `warehouseproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `warehouseproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'productdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-15 11:05:36
