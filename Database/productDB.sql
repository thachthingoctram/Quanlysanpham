DROP DATABASE IF EXISTS productdb;

CREATE DATABASE productdb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE productdb;

CREATE TABLE Category (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT UQ_Category_Name
        UNIQUE (CategoryName)
) ENGINE=InnoDB;

CREATE TABLE Supplier (
    SupplierId INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(150) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Address VARCHAR(255),

    CONSTRAINT UQ_Supplier_Phone
        UNIQUE (Phone),

    CONSTRAINT UQ_Supplier_Email
        UNIQUE (Email)
) ENGINE=InnoDB;

CREATE TABLE Customer (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(150) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Address VARCHAR(255),

    CONSTRAINT UQ_Customer_Phone
        UNIQUE (Phone),

    CONSTRAINT UQ_Customer_Email
        UNIQUE (Email)
) ENGINE=InnoDB;

CREATE TABLE Employee (
    EmployeeId INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(150) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Position VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT UQ_Employee_Phone
        UNIQUE (Phone),

    CONSTRAINT UQ_Employee_Email
        UNIQUE (Email),

    CONSTRAINT CK_Employee_Status
        CHECK (Status IN ('Active', 'Inactive'))
) ENGINE=InnoDB;

CREATE TABLE Warehouse (
    WarehouseId INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Description VARCHAR(255),
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT UQ_Warehouse_Name
        UNIQUE (WarehouseName),

    CONSTRAINT CK_Warehouse_Status
        CHECK (Status IN ('Active', 'Inactive'))
) ENGINE=InnoDB;

CREATE TABLE Product (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryId INT NOT NULL,
    ProductName VARCHAR(150) NOT NULL,
    Unit VARCHAR(30) NOT NULL DEFAULT 'Cái',
    ImportPrice DECIMAL(18,2) NOT NULL,
    SellingPrice DECIMAL(18,2) NOT NULL,
    Description VARCHAR(255),
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId),

    CONSTRAINT CK_Product_ImportPrice
        CHECK (ImportPrice >= 0),

    CONSTRAINT CK_Product_SellingPrice
        CHECK (SellingPrice >= 0),

    CONSTRAINT CK_Product_Status
        CHECK (Status IN ('Active', 'Inactive')),

    CONSTRAINT CK_Product_Price
        CHECK (SellingPrice >= ImportPrice),

    INDEX IX_Product_Category (CategoryId),
    INDEX IX_Product_Name (ProductName)
) ENGINE=InnoDB;

CREATE TABLE WarehouseProduct (
    WarehouseId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,

    PRIMARY KEY (WarehouseId, ProductId),

    CONSTRAINT FK_WarehouseProduct_Warehouse
        FOREIGN KEY (WarehouseId)
        REFERENCES Warehouse(WarehouseId),

    CONSTRAINT FK_WarehouseProduct_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),

    CONSTRAINT CK_WarehouseProduct_Quantity
        CHECK (Quantity >= 0),

    INDEX IX_WarehouseProduct_Product (ProductId)
) ENGINE=InnoDB;

CREATE TABLE Orders (
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT NOT NULL,
    EmployeeId INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT FK_Orders_Customer
        FOREIGN KEY (CustomerId)
        REFERENCES Customer(CustomerId),

    CONSTRAINT FK_Orders_Employee
        FOREIGN KEY (EmployeeId)
        REFERENCES Employee(EmployeeId),

    CONSTRAINT CK_Orders_TotalAmount
        CHECK (TotalAmount >= 0),

    CONSTRAINT CK_Orders_Status
        CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),

    INDEX IX_Orders_Customer (CustomerId),
    INDEX IX_Orders_Employee (EmployeeId),
    INDEX IX_Orders_Date (OrderDate)
) ENGINE=InnoDB;

CREATE TABLE OrderDetail (
    OrderDetailId INT AUTO_INCREMENT PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_OrderDetail_Order
        FOREIGN KEY (OrderId)
        REFERENCES Orders(OrderId),

    CONSTRAINT FK_OrderDetail_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),

    CONSTRAINT CK_OrderDetail_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_OrderDetail_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_OrderDetail_Subtotal
        CHECK (Subtotal >= 0),

    CONSTRAINT UQ_OrderDetail_Order_Product
        UNIQUE (OrderId, ProductId),

    INDEX IX_OrderDetail_Product (ProductId)
) ENGINE=InnoDB;

CREATE TABLE ImportReceipt (
    ImportId INT AUTO_INCREMENT PRIMARY KEY,
    SupplierId INT NOT NULL,
    EmployeeId INT NOT NULL,
    WarehouseId INT NOT NULL,
    ImportDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,

    CONSTRAINT FK_ImportReceipt_Supplier
        FOREIGN KEY (SupplierId)
        REFERENCES Supplier(SupplierId),

    CONSTRAINT FK_ImportReceipt_Employee
        FOREIGN KEY (EmployeeId)
        REFERENCES Employee(EmployeeId),

    CONSTRAINT FK_ImportReceipt_Warehouse
        FOREIGN KEY (WarehouseId)
        REFERENCES Warehouse(WarehouseId),

    CONSTRAINT CK_ImportReceipt_TotalAmount
        CHECK (TotalAmount >= 0),

    INDEX IX_ImportReceipt_Supplier (SupplierId),
    INDEX IX_ImportReceipt_Employee (EmployeeId),
    INDEX IX_ImportReceipt_Warehouse (WarehouseId),
    INDEX IX_ImportReceipt_Date (ImportDate)
) ENGINE=InnoDB;

CREATE TABLE ImportDetail (
    ImportDetailId INT AUTO_INCREMENT PRIMARY KEY,
    ImportId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_ImportDetail_ImportReceipt
        FOREIGN KEY (ImportId)
        REFERENCES ImportReceipt(ImportId),

    CONSTRAINT FK_ImportDetail_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),

    CONSTRAINT CK_ImportDetail_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_ImportDetail_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_ImportDetail_Subtotal
        CHECK (Subtotal >= 0),

    CONSTRAINT UQ_ImportDetail_Receipt_Product
        UNIQUE (ImportId, ProductId),

    INDEX IX_ImportDetail_Product (ProductId)
) ENGINE=InnoDB;