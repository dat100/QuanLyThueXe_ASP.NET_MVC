USE [master]
GO
CREATE DATABASE [QLTX]
 CONTAINMENT = NONE
 ON PRIMARY 
(NAME = N'QLTX_Data', FILENAME = N'C:\..........\QLTX_Data.mdf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)   /***điền đường dẫn vào chỗ còn trống***/
LOG ON 
(NAME = N'QLTX_Log', FILENAME = N'C:\..........\QLTX_Log.ldf', SIZE = 50MB, MAXSIZE = 100MB, FILEGROWTH = 10%)   /***điền đường dẫn vào chỗ còn trống***/
GO

ALTER DATABASE [QLTX] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLTX].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLTX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLTX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLTX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLTX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLTX] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLTX] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLTX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLTX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLTX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLTX] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLTX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLTX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLTX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLTX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLTX] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLTX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLTX] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLTX] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLTX] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLTX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLTX] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLTX] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLTX] SET RECOVERY FULL 
GO
ALTER DATABASE [QLTX] SET  MULTI_USER 
GO
ALTER DATABASE [QLTX] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLTX] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLTX] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLTX] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLTX] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLTX] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLTX', N'ON'
GO
ALTER DATABASE [QLTX] SET QUERY_STORE = ON
GO
ALTER DATABASE [QLTX] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QLTX]
GO

/******dang nhap******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[login](
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_login] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/******khach hang******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[CustomerID] [int] NOT NULL,
	[CustomerName] [nchar](30) NOT NULL,
	[Gender] [nvarchar](3) NOT NULL,
	[Country] [nchar](20) NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/******xe******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[ProductID] [int] NOT NULL,
	[ProductName] [nchar](20) NOT NULL,
	[UnitPrice] [money] NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/******hoa don******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/******nhan vien******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[EmployeeID] [int] NOT NULL,
	[EmployeeName] [nchar](30) NOT NULL,
	[Gender] [nvarchar](3) NOT NULL,
	[Country] [nchar](20) NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT [dbo].[login] ([Username], [Password]) VALUES (N'1', N'1')

INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'1', N'Khach Hang A', N'Nam', N'Binh Duong')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'2', N'Khach Hang B', N'Nam', N'Thanh Hoa')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'3', N'Khach Hang C', N'Nu', N'Da Lat')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'4', N'Khach Hang D', N'Nu', N'Ca Mau')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'5', N'Khach Hang E', N'Nam', N'Quang Ngai')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'6', N'Khach Hang F', N'Nam', N'Tra Vinh')
INSERT [dbo].[customer] ([CustomerID], [CustomerName], [Gender], [Country]) VALUES (N'7', N'Khach Hang G', N'Nu', N'Vung Tau')
GO

INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'1', N'Honda', 500.0000)
INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'2', N'Yamaha', 700.0000)
INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'3', N'Suzuki', 600.0000)
INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'4', N'Triumph', 500.0000)
INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'5', N'Ducati', 800.0000)
INSERT [dbo].[product] ([ProductID], [ProductName], [UnitPrice]) VALUES (N'6', N'Kawasaki', 700.0000)
GO

INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'1', N'7', N'1', CAST(N'2023-01-01' AS DateTime), N'6', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'2', N'6', N'3', CAST(N'2023-02-02' AS DateTime), N'5', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'3', N'5', N'2', CAST(N'2023-03-03' AS DateTime), N'4', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'4', N'4', N'4', CAST(N'2023-04-04' AS DateTime), N'3', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'5', N'3', N'1', CAST(N'2023-05-05' AS DateTime), N'2', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'6', N'2', N'3', CAST(N'2023-06-06' AS DateTime), N'1', N'1')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'7', N'1', N'2', CAST(N'2023-07-07' AS DateTime), N'6', N'2')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'8', N'7', N'4', CAST(N'2023-08-08' AS DateTime), N'5', N'2')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'9', N'6', N'1', CAST(N'2023-09-09' AS DateTime), N'4', N'2')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'10', N'5', N'3', CAST(N'2023-10-10' AS DateTime), N'3', N'2')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'11', N'4', N'2', CAST(N'2023-11-11' AS DateTime), N'2', N'2')
INSERT [dbo].[order] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [ProductID], [Quantity]) VALUES (N'12', N'3', N'4', CAST(N'2023-12-12' AS DateTime), N'1', N'2')
GO

INSERT [dbo].[employee] ([EmployeeID], [EmployeeName], [Gender], [Country]) VALUES (1, N'Nhan Vien A', N'Nam',   N'TPHCM')
INSERT [dbo].[employee] ([EmployeeID], [EmployeeName], [Gender], [Country]) VALUES (2, N'Nhan Vien B', N'Nu', N'Ha Noi')
INSERT [dbo].[employee] ([EmployeeID], [EmployeeName], [Gender], [Country]) VALUES (3, N'Nhan Vien C', N'Nam', N'Dong Nai')
INSERT [dbo].[employee] ([EmployeeID], [EmployeeName], [Gender], [Country]) VALUES (4, N'Nhan Vien D', N'Nu', N'Binh Phuoc')
GO


ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[product] ([ProductID])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_product]
GO

ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_employee]
GO

ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[customer] ([CustomerID])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_customer]
GO

USE [master]
GO
ALTER DATABASE [QLTX] SET  READ_WRITE 
GO

