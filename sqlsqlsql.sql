USE [master]
GO
/****** Object:  Database [qlpk1]    Script Date: 11-Dec-18 07:13:52 ******/
CREATE DATABASE [qlpk1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'qlpk1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\qlpk1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'qlpk1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\qlpk1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [qlpk1] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [qlpk1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [qlpk1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [qlpk1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [qlpk1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [qlpk1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [qlpk1] SET ARITHABORT OFF 
GO
ALTER DATABASE [qlpk1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [qlpk1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [qlpk1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [qlpk1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [qlpk1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [qlpk1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [qlpk1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [qlpk1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [qlpk1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [qlpk1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [qlpk1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [qlpk1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [qlpk1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [qlpk1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [qlpk1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [qlpk1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [qlpk1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [qlpk1] SET RECOVERY FULL 
GO
ALTER DATABASE [qlpk1] SET  MULTI_USER 
GO
ALTER DATABASE [qlpk1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [qlpk1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [qlpk1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [qlpk1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [qlpk1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'qlpk1', N'ON'
GO
ALTER DATABASE [qlpk1] SET QUERY_STORE = OFF
GO
USE [qlpk1]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [qlpk1]
GO
/****** Object:  FullTextCatalog [Sthuoc]    Script Date: 11-Dec-18 07:13:53 ******/
CREATE FULLTEXT CATALOG [Sthuoc]WITH ACCENT_SENSITIVITY = ON

GO
/****** Object:  UserDefinedFunction [dbo].[fnc_TongTien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnc_TongTien](@mabn varchar(30))
RETURNS MONEY
BEGIN

	RETURN (SELECT SUM(DonGia)FROM dbo.DichVu WHERE MaDV IN (SELECT DichVu FROM dbo.HoaDon WHERE BenhNhan=@mabn));
			
END;

GO
/****** Object:  Table [dbo].[BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenhNhan](
	[MaBenhNhan] [nvarchar](50) NOT NULL,
	[HoBN] [nvarchar](20) NULL,
	[TenBN] [nvarchar](30) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[GioiTinh] [bit] NULL,
	[Khoa] [nvarchar](50) NOT NULL,
	[Nhom] [nvarchar](50) NOT NULL,
	[BacSi] [varchar](30) NULL,
	[SDT] [int] NOT NULL,
	[NgaySinh] [smalldatetime] NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_BenhNhan] PRIMARY KEY CLUSTERED 
(
	[MaBenhNhan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Deleted_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Deleted_BenhNhan]
	AS SELECT * FROM dbo.BenhNhan WHERE Deleted=1;

GO
/****** Object:  Table [dbo].[PhieuNhapVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhapVien](
	[MaPNV] [nvarchar](50) NOT NULL,
	[TgNV] [smalldatetime] NULL,
	[NgapLap] [smalldatetime] NULL,
	[Khoa] [nvarchar](50) NULL,
	[NguoiLap] [nvarchar](50) NOT NULL,
	[BenhNhan] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NULL,
	[Giuong] [varchar](30) NULL,
 CONSTRAINT [PK_PhieuNhapVien] PRIMARY KEY CLUSTERED 
(
	[MaPNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_LoadBNNT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_LoadBNNT]
AS
             				SELECT dbo.BenhNhan.MaBenhNhan FROM dbo.BenhNhan WHERE Nhom='2' AND
							Deleted=0 AND NOT EXISTS ( SELECT * FROM dbo.PhieuNhapVien WHERE dbo.PhieuNhapVien.MaPNV=MaBenhNhan);
GO
/****** Object:  View [dbo].[v_Current_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[v_Current_BenhNhan] 
  AS
  SELECT * FROM dbo.BenhNhan WHERE Deleted=0;
  
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[MaPhong] [varchar](30) NOT NULL,
	[TenPhong] [nvarchar](50) NULL,
	[Khoa] [nvarchar](50) NULL,
	[SoGiuong] [int] NULL,
 CONSTRAINT [PK_Phong] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_ShowPhong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE VIEW [dbo].[v_ShowPhong]
		AS
        SELECT * FROM dbo.Phong
GO
/****** Object:  Table [dbo].[BenhAn]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenhAn](
	[MaBA] [varchar](30) NOT NULL,
	[NgayLap] [smalldatetime] NULL,
	[KqDieuTri] [nvarchar](50) NULL,
	[NoiDungKham] [nvarchar](50) NULL,
	[TinhTrang] [varchar](50) NULL,
	[HuongDieuTri] [nvarchar](50) NULL,
	[BenhNhan] [nvarchar](50) NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_BenhAn] PRIMARY KEY CLUSTERED 
(
	[MaBA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Select_BenhAnNull]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_Select_BenhAnNull]
AS SELECT * FROM dbo.BenhAn WHERE TinhTrang = ''
GO
/****** Object:  View [dbo].[v_Select_BenhAnNotNull]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Select_BenhAnNotNull]
AS SELECT * FROM dbo.BenhAn WHERE MaBA NOT IN ( SELECT dbo.BenhAn.MaBA FROM
	 dbo.BenhAn WHERE TinhTrang ='');

GO
/****** Object:  View [dbo].[v_NoiTru]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   CREATE VIEW [dbo].[v_NoiTru]
             			  AS
             				SELECT * FROM dbo.BenhNhan WHERE Nhom='2' AND
							Deleted=0 AND NOT EXISTS ( SELECT * FROM dbo.PhieuNhapVien WHERE dbo.PhieuNhapVien.MaPNV=MaBenhNhan);

GO
/****** Object:  Table [dbo].[BacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacSi](
	[MaBS] [varchar](30) NOT NULL,
	[HoBS] [nvarchar](20) NULL,
	[TenBS] [nvarchar](30) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[NgaySinh] [smalldatetime] NULL,
	[GioiTinh] [bit] NULL,
	[SDT] [varchar](11) NULL,
	[Nhom] [nvarchar](50) NULL,
	[Luong] [money] NULL,
	[Khoa] [nvarchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_BacSi] PRIMARY KEY CLUSTERED 
(
	[MaBS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DichVu]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVu](
	[MaDV] [varchar](30) NOT NULL,
	[TenDV] [nvarchar](255) NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[DonGia] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonThuoc]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonThuoc](
	[MaDT] [varchar](30) NOT NULL,
	[SoLuong] [int] NULL,
	[HuongDan] [nvarchar](50) NULL,
	[MaThuoc] [varchar](30) NOT NULL,
	[BenhNhan] [varchar](30) NULL,
 CONSTRAINT [PK_DonThuoc_1] PRIMARY KEY CLUSTERED 
(
	[MaDT] ASC,
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Giuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Giuong](
	[MaGiuong] [varchar](30) NOT NULL,
	[Phong] [varchar](30) NULL,
	[Book] [bit] NULL,
 CONSTRAINT [PK_Giuong] PRIMARY KEY CLUSTERED 
(
	[MaGiuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [varchar](30) NOT NULL,
	[DichVu] [varchar](30) NOT NULL,
	[NgayLap] [smalldatetime] NULL,
	[NguoiLap] [varchar](30) NULL,
	[BenhNhan] [nvarchar](50) NULL,
	[NgayKham] [smalldatetime] NULL,
 CONSTRAINT [PK__HoaDon__F1DDAD732CF89C86] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[DichVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [nvarchar](50) NOT NULL,
	[TenKhoa] [nvarchar](50) NULL,
	[SoBN] [int] NULL,
	[SoPhong] [int] NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [varchar](30) NOT NULL,
	[HoNV] [nvarchar](20) NULL,
	[TenNV] [nvarchar](30) NULL,
	[NgaySinh] [smalldatetime] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [varchar](11) NULL,
	[Luong] [money] NULL,
	[Nhom] [nvarchar](50) NULL,
	[GioiTinh] [bit] NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK__NhanVien__2725D70A170B781B] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomDoiTuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomDoiTuong](
	[MaNhom] [nvarchar](50) NOT NULL,
	[TenNhom] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhomDoiTuong] PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuDieuTri]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDieuTri](
	[MaPDT] [varchar](30) NOT NULL,
	[NgayThang] [smalldatetime] NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[BenhNhan] [nvarchar](50) NOT NULL,
	[NgayLap] [smalldatetime] NOT NULL,
	[NguoiLap] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_PhieuDieuTri] PRIMARY KEY CLUSTERED 
(
	[MaPDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuXetNghiem]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuXetNghiem](
	[MaPXN] [varchar](30) NOT NULL,
	[TenLoaiXN] [nvarchar](50) NULL,
	[NgayXN] [smalldatetime] NULL,
	[KetQua] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](50) NULL,
	[BenhNhan] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_PhieuXetNghiem] PRIMARY KEY CLUSTERED 
(
	[MaPXN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuXuatVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuXuatVien](
	[MaPXV] [varchar](30) NOT NULL,
	[NgayLap] [smalldatetime] NULL,
	[TgDieuTri] [smalldatetime] NULL,
	[Khoa] [nvarchar](50) NULL,
	[BenhNhan] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NULL,
	[NguoiLap] [varchar](30) NULL,
 CONSTRAINT [PK_PhieuXuatVien] PRIMARY KEY CLUSTERED 
(
	[MaPXV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thuoc]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuoc](
	[MaThuoc] [varchar](30) NOT NULL,
	[TenThuoc] [nvarchar](50) NULL,
	[TacDung] [nvarchar](50) NULL,
	[Gia] [money] NULL,
	[SL] [int] NULL,
 CONSTRAINT [PK_Thuoc] PRIMARY KEY CLUSTERED 
(
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UsersName] [varchar](255) NOT NULL,
	[PassWord] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Phone] [varchar](20) NULL,
	[Role] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsersName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[BacSi] ([MaBS], [HoBS], [TenBS], [DiaChi], [NgaySinh], [GioiTinh], [SDT], [Nhom], [Luong], [Khoa], [Deleted]) VALUES (N'1', N'av', N's', N'sdsd', CAST(N'2018-12-05T19:11:00' AS SmallDateTime), 1, N'0987654432', N'1', 100000.0000, N'1', 0)
INSERT [dbo].[BacSi] ([MaBS], [HoBS], [TenBS], [DiaChi], [NgaySinh], [GioiTinh], [SDT], [Nhom], [Luong], [Khoa], [Deleted]) VALUES (N'10', N'f', N'f', N'f', CAST(N'2018-12-14T00:00:00' AS SmallDateTime), 0, N'111', N'1', 100.0000, N'1', 0)
INSERT [dbo].[BacSi] ([MaBS], [HoBS], [TenBS], [DiaChi], [NgaySinh], [GioiTinh], [SDT], [Nhom], [Luong], [Khoa], [Deleted]) VALUES (N'2', N'VA', N'NA', N'DL', NULL, NULL, N'', N'1', NULL, N'2', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'12', CAST(N'2018-12-09T00:49:00' AS SmallDateTime), N'Good', N'X-ray', N'', N'', N'12', 1)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'20', CAST(N'2018-12-08T12:41:00' AS SmallDateTime), N'', N'', N'', N'', N'20', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'21', CAST(N'2018-12-10T21:54:00' AS SmallDateTime), N'Tốt', N'Siêu âm', N'g', N'Tái Khám', N'21', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'22', CAST(N'2018-12-08T01:53:00' AS SmallDateTime), N'', N'', N'', N'', N'22', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'23', CAST(N'2018-12-10T21:54:00' AS SmallDateTime), N'', N'', N'âu co', N'', N'23', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'24', CAST(N'2018-12-10T23:45:00' AS SmallDateTime), N'', N'', N'', N'', N'24', 0)
INSERT [dbo].[BenhAn] ([MaBA], [NgayLap], [KqDieuTri], [NoiDungKham], [TinhTrang], [HuongDieuTri], [BenhNhan], [deleted]) VALUES (N'25', CAST(N'2018-12-10T23:48:00' AS SmallDateTime), N'', N'', N'', N'', N'25', 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'1', N'Nguyễn', N'Văn Tạo', N'Bien Hòa', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'12', N'h


', N'k
hihi
', N'a






', 0, N'1






', N'1', N'1






', 0, CAST(N'2016-10-14T00:00:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'2', N'Nguyễn', N'Văn Tạo', N'Bien Hòa', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'20', N'tt', N't', N't', 0, N'2', N'2', N'2', 1, CAST(N'2018-12-12T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'21', N'dd', N'aa', N'a', 1, N'2', N'1', N'2', 11111, CAST(N'2018-12-07T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'22', N'a', N'a', N'a', 0, N'2', N'2', N'2', 1, CAST(N'2018-12-01T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'23', N'd', N'd', N'd', 1, N'1', N'2', N'1', 1, CAST(N'2018-12-09T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'24', N'x', N'x', N'x', 0, N'1', N'1', N'1', 1, CAST(N'2018-01-02T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'25', N'c', N'c', N'c', 0, N'1', N'1', N'1', 1, CAST(N'2018-12-01T00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'3', N'Nguyễn', N'Văn Tạo', N'Bien Hòa', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'4', N'Nguyễn', N'Văn Tạo', N'Bien Hòa', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'5', N'Nguyễn', N'Thanh Phú', N'Bien Hòa', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 1)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'6', N'Nguyễn', N'Thanh Phú', N'Ninh Thuận', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 0)
INSERT [dbo].[BenhNhan] ([MaBenhNhan], [HoBN], [TenBN], [DiaChi], [GioiTinh], [Khoa], [Nhom], [BacSi], [SDT], [NgaySinh], [Deleted]) VALUES (N'7', N'Nguyễn', N'Văn Huy', N'Vũng Tàu', 1, N'1', N'1', N'1', 8376343, CAST(N'2018-12-05T19:09:00' AS SmallDateTime), 0)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGia]) VALUES (N'1', N'Khám', N'lần', 50000.0000)
INSERT [dbo].[DichVu] ([MaDV], [TenDV], [DonViTinh], [DonGia]) VALUES (N'2', N'Siêu Âm', N'lần', 100000.0000)
INSERT [dbo].[DonThuoc] ([MaDT], [SoLuong], [HuongDan], [MaThuoc], [BenhNhan]) VALUES (N'1', 1, N'ăn trước khi uống', N'1', N'1')
INSERT [dbo].[DonThuoc] ([MaDT], [SoLuong], [HuongDan], [MaThuoc], [BenhNhan]) VALUES (N'1', 0, N'An', N'11', N'1')
INSERT [dbo].[DonThuoc] ([MaDT], [SoLuong], [HuongDan], [MaThuoc], [BenhNhan]) VALUES (N'3', 1, N'k', N'2', N'1')
INSERT [dbo].[Giuong] ([MaGiuong], [Phong], [Book]) VALUES (N'1', N'2', 1)
INSERT [dbo].[Giuong] ([MaGiuong], [Phong], [Book]) VALUES (N'2', N'2', 1)
INSERT [dbo].[Giuong] ([MaGiuong], [Phong], [Book]) VALUES (N'3', N'1', 0)
INSERT [dbo].[Giuong] ([MaGiuong], [Phong], [Book]) VALUES (N'5', N'2', 0)
INSERT [dbo].[HoaDon] ([MaHD], [DichVu], [NgayLap], [NguoiLap], [BenhNhan], [NgayKham]) VALUES (N'1', N'2', NULL, N'1', N'1', CAST(N'2018-02-02T00:00:00' AS SmallDateTime))
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [SoBN], [SoPhong]) VALUES (N'1', N'Nhi', 2, 1)
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [SoBN], [SoPhong]) VALUES (N'2', N'Lâm Sàng', -3, 2)
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [SoBN], [SoPhong]) VALUES (N'3', N'Phụ Sản', 0, 3)
INSERT [dbo].[NhanVien] ([MaNV], [HoNV], [TenNV], [NgaySinh], [DiaChi], [SDT], [Luong], [Nhom], [GioiTinh], [Deleted]) VALUES (N'1', N'nguyễn', N'duy khương', CAST(N'2018-12-07T12:42:00' AS SmallDateTime), N'TpHCM', N'098766223', 100000.0000, N'1', 0, 0)
INSERT [dbo].[NhomDoiTuong] ([MaNhom], [TenNhom]) VALUES (N'1', N'Ngoại')
INSERT [dbo].[NhomDoiTuong] ([MaNhom], [TenNhom]) VALUES (N'2', N'Nội')
INSERT [dbo].[PhieuNhapVien] ([MaPNV], [TgNV], [NgapLap], [Khoa], [NguoiLap], [BenhNhan], [Deleted], [Giuong]) VALUES (N'12', CAST(N'2018-12-19T00:00:00' AS SmallDateTime), CAST(N'2018-12-11T00:00:00' AS SmallDateTime), N'2', N'df', N'20', 0, NULL)
INSERT [dbo].[PhieuNhapVien] ([MaPNV], [TgNV], [NgapLap], [Khoa], [NguoiLap], [BenhNhan], [Deleted], [Giuong]) VALUES (N'20', CAST(N'2018-12-16T00:00:00' AS SmallDateTime), CAST(N'2018-12-09T00:00:00' AS SmallDateTime), N'2', N'', N'20', 1, N'2')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [Khoa], [SoGiuong]) VALUES (N'1', N'Phòng Nhi', N'1', 1)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [Khoa], [SoGiuong]) VALUES (N'2', N'Phòng BS', N'3', 3)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [Khoa], [SoGiuong]) VALUES (N'3', N'Phòng 3', N'2', 0)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [Khoa], [SoGiuong]) VALUES (N'4', N'Phòng Sanh', N'3', 0)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [Khoa], [SoGiuong]) VALUES (N'5', N'Phong YT', N'3', 0)
INSERT [dbo].[Thuoc] ([MaThuoc], [TenThuoc], [TacDung], [Gia], [SL]) VALUES (N'1', N'Thuốc kháng sinh Zinnat 250mg', N'kháng sinh', 135000.0000, 0)
INSERT [dbo].[Thuoc] ([MaThuoc], [TenThuoc], [TacDung], [Gia], [SL]) VALUES (N'11', N'Decox', N'Trị ngứa', 1000000.0000, 3)
INSERT [dbo].[Thuoc] ([MaThuoc], [TenThuoc], [TacDung], [Gia], [SL]) VALUES (N'2', N'Thực phẩm bổ sung ColosMAX Q10', N'Tăng cường', 185000.0000, 0)
INSERT [dbo].[Users] ([UsersName], [PassWord], [Email], [Phone], [Role]) VALUES (N'NA', N'1', NULL, NULL, 0)
INSERT [dbo].[Users] ([UsersName], [PassWord], [Email], [Phone], [Role]) VALUES (N's', N'1', N'', N'', 0)
INSERT [dbo].[Users] ([UsersName], [PassWord], [Email], [Phone], [Role]) VALUES (N'v', N'1', NULL, NULL, 1)
/****** Object:  Index [xoa]    Script Date: 11-Dec-18 07:13:53 ******/
CREATE NONCLUSTERED INDEX [xoa] ON [dbo].[BenhNhan]
(
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  FullTextIndex     Script Date: 11-Dec-18 07:13:53 ******/
CREATE FULLTEXT INDEX ON [dbo].[Thuoc](
[TenThuoc] LANGUAGE 'Vietnamese')
KEY INDEX [PK_Thuoc]ON ([Sthuoc], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)


GO
ALTER TABLE [dbo].[BacSi] ADD  CONSTRAINT [DF__BacSi__Deleted__4316F928]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[BenhAn] ADD  CONSTRAINT [DF__BenhAn__deleted__440B1D61]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[BenhNhan] ADD  CONSTRAINT [DF__BenhNhan__Delete__44FF419A]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Giuong] ADD  DEFAULT ((0)) FOR [Book]
GO
ALTER TABLE [dbo].[Khoa] ADD  CONSTRAINT [DF__Khoa__SoBN__45F365D3]  DEFAULT ((0)) FOR [SoBN]
GO
ALTER TABLE [dbo].[Khoa] ADD  CONSTRAINT [DF__Khoa__SoPhong__46E78A0C]  DEFAULT ((0)) FOR [SoPhong]
GO
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [DF__NhanVien__Delete__47DBAE45]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[PhieuNhapVien] ADD  CONSTRAINT [DF__PhieuNhap__Delet__48CFD27E]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[PhieuXetNghiem] ADD  CONSTRAINT [DF__PhieuXetN__Delet__49C3F6B7]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[PhieuXuatVien] ADD  CONSTRAINT [DF__PhieuXuat__Delet__4AB81AF0]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Phong] ADD  CONSTRAINT [DF__Phong__SoGiuong__4BAC3F29]  DEFAULT ((0)) FOR [SoGiuong]
GO
ALTER TABLE [dbo].[BacSi]  WITH NOCHECK ADD  CONSTRAINT [FK__BacSi__Khoa__4CA06362] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[BacSi] CHECK CONSTRAINT [FK__BacSi__Khoa__4CA06362]
GO
ALTER TABLE [dbo].[BacSi]  WITH NOCHECK ADD  CONSTRAINT [FK__BacSi__Nhom__4D94879B] FOREIGN KEY([Nhom])
REFERENCES [dbo].[NhomDoiTuong] ([MaNhom])
GO
ALTER TABLE [dbo].[BacSi] CHECK CONSTRAINT [FK__BacSi__Nhom__4D94879B]
GO
ALTER TABLE [dbo].[BenhAn]  WITH NOCHECK ADD  CONSTRAINT [FK__BenhAn__BenhNhan__4E88ABD4] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[BenhAn] NOCHECK CONSTRAINT [FK__BenhAn__BenhNhan__4E88ABD4]
GO
ALTER TABLE [dbo].[BenhAn]  WITH NOCHECK ADD  CONSTRAINT [FK__BenhAn__BenhNhan__4F7CD00D] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[BenhAn] NOCHECK CONSTRAINT [FK__BenhAn__BenhNhan__4F7CD00D]
GO
ALTER TABLE [dbo].[DonThuoc]  WITH CHECK ADD FOREIGN KEY([MaThuoc])
REFERENCES [dbo].[Thuoc] ([MaThuoc])
GO
ALTER TABLE [dbo].[Giuong]  WITH CHECK ADD  CONSTRAINT [FK_Giuong_Phong] FOREIGN KEY([Phong])
REFERENCES [dbo].[Phong] ([MaPhong])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Giuong] CHECK CONSTRAINT [FK_Giuong_Phong]
GO
ALTER TABLE [dbo].[HoaDon]  WITH NOCHECK ADD  CONSTRAINT [FK__HoaDon__BenhNhan__5535A963] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[HoaDon] NOCHECK CONSTRAINT [FK__HoaDon__BenhNhan__5535A963]
GO
ALTER TABLE [dbo].[HoaDon]  WITH NOCHECK ADD  CONSTRAINT [FK_HoaDon_DichVu] FOREIGN KEY([DichVu])
REFERENCES [dbo].[DichVu] ([MaDV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] NOCHECK CONSTRAINT [FK_HoaDon_DichVu]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK__NhanVien__Nhom__5812160E] FOREIGN KEY([Nhom])
REFERENCES [dbo].[NhomDoiTuong] ([MaNhom])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK__NhanVien__Nhom__5812160E]
GO
ALTER TABLE [dbo].[PhieuDieuTri]  WITH CHECK ADD  CONSTRAINT [FK_PhieuDieuTri_BenhNhan] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PhieuDieuTri] CHECK CONSTRAINT [FK_PhieuDieuTri_BenhNhan]
GO
ALTER TABLE [dbo].[PhieuNhapVien]  WITH CHECK ADD  CONSTRAINT [FK__PhieuNhap__BenhN__59FA5E80] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[PhieuNhapVien] CHECK CONSTRAINT [FK__PhieuNhap__BenhN__59FA5E80]
GO
ALTER TABLE [dbo].[PhieuNhapVien]  WITH CHECK ADD FOREIGN KEY([Giuong])
REFERENCES [dbo].[Giuong] ([MaGiuong])
GO
ALTER TABLE [dbo].[PhieuNhapVien]  WITH CHECK ADD  CONSTRAINT [FK__PhieuNhapV__Khoa__5BE2A6F2] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[PhieuNhapVien] CHECK CONSTRAINT [FK__PhieuNhapV__Khoa__5BE2A6F2]
GO
ALTER TABLE [dbo].[PhieuXetNghiem]  WITH CHECK ADD  CONSTRAINT [FK__PhieuXetN__BenhN__5CD6CB2B] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[PhieuXetNghiem] CHECK CONSTRAINT [FK__PhieuXetN__BenhN__5CD6CB2B]
GO
ALTER TABLE [dbo].[PhieuXuatVien]  WITH CHECK ADD  CONSTRAINT [FK__PhieuXuat__BenhN__5DCAEF64] FOREIGN KEY([BenhNhan])
REFERENCES [dbo].[BenhNhan] ([MaBenhNhan])
GO
ALTER TABLE [dbo].[PhieuXuatVien] CHECK CONSTRAINT [FK__PhieuXuat__BenhN__5DCAEF64]
GO
ALTER TABLE [dbo].[PhieuXuatVien]  WITH CHECK ADD  CONSTRAINT [FK__PhieuXuatV__Khoa__5EBF139D] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[PhieuXuatVien] CHECK CONSTRAINT [FK__PhieuXuatV__Khoa__5EBF139D]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__5FB337D6] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__5FB337D6]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__60A75C0F] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__60A75C0F]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__619B8048] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__619B8048]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__628FA481] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__628FA481]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__6383C8BA] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__6383C8BA]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__Khoa__6477ECF3] FOREIGN KEY([Khoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__Khoa__6477ECF3]
GO
/****** Object:  StoredProcedure [dbo].[dk]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[dk] @ma VARCHAR(30)
AS BEGIN
      select MaBA
from BenhNhan,BenhAn
where @ma=BenhNhan.BacSi and BenhNhan.MaBenhNhan=BenhAn.BenhNhan and BenhAn.TinhTrang=''
   END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__BenhAn]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__BenhAn]
@maBA  VARCHAR(30)
AS
BEGIN
	DELETE dbo.BenhAn WHERE MaBA=@maBA
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__DT]
@madt  VARCHAR(30)
AS
BEGIN
	DELETE dbo.DonThuoc WHERE MaDT=@madt
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__DV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__DV]
@madv VARCHAR(30)
AS
BEGIN
	DELETE dbo.DichVu WHERE MaDV=@madv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__Phong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__Phong]
@map VARCHAR(30)
AS
BEGIN
	DELETE dbo.Phong WHERE MaPhong=@map
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__PNV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__PNV]
@mapnv VARCHAR(30)

AS
BEGIN
	DELETE dbo.PhieuNhapVien WHERE MaPNV=@mapnv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__PXN]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__PXN]
@mapxn VARCHAR(30)
AS
BEGIN
	DELETE dbo.PhieuXetNghiem 
	WHERE MaPXN=@mapxn
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__PXV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__PXV]
@mapxv VARCHAR(30)

AS
BEGIN
	DELETE dbo.PhieuXuatVien WHERE MaPXV=@mapxv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Delete__Thuoc]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Delete__Thuoc]
@mat  VARCHAR(30)

AS
BEGIN
	DELETE dbo.Thuoc WHERE MaThuoc=@mat
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__BenhAn]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__BenhAn]
@maBA  VARCHAR(30)
AS
BEGIN
	DELETE dbo.BenhAn WHERE MaBA=@maBA
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__DT]
@madt  VARCHAR(30),
@sl INT,
@hd NVARCHAR(50),
@mt VARCHAR(30), 
@bn VARCHAR(30)
AS
BEGIN



INSERT INTO dbo.DonThuoc
        ( MaDT ,
          SoLuong ,
          HuongDan ,
          MaThuoc ,
          BenhNhan
        )

	VALUES
	(   @madt,  -- MaDT - varchar(30)
	   @sl,   -- SoLuong - int
	   @hd, -- HuongDan - nvarchar(50)
	   @mt,
	     @bn -- MaThuoc - varchar(30)
		   )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__DV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__DV]
@madv VARCHAR(30),
@tdv NVARCHAR(255),
@dvt NVARCHAR(50),
@dg MONEY
AS
BEGIN
	INSERT dbo.DichVu
	(
	    MaDV,
	    TenDV,
	    DonViTinh,
	    DonGia
	)
	VALUES
	(   @madv,  -- MaDV - varchar(30)
	    @tdv, -- TenDV - nvarchar(255)
	   @dvt, -- DonViTinh - nvarchar(50)
	   @dg -- DonGia - money
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__Phong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__Phong]
@map VARCHAR(30),
@tp NVARCHAR(50),
@k VARCHAR(30)
AS
BEGIN
	INSERT dbo.Phong
	(
	    MaPhong,
	    TenPhong,
	    Khoa
	)
	VALUES
	(   @map,  -- MaPhong - varchar(30)
	    @tp, -- TenPhong - nvarchar(50)
	   @k   -- Khoa - varchar(30)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__PNV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[usp__Insert__PNV]
 @mapnv VARCHAR(30),
 @tgnv SMALLDATETIME,
 @nl SMALLDATETIME,
 @khoa VARCHAR(30),
 @bn VARCHAR(30),
 @ngl VARCHAR(30),
 @gig VARCHAR(30)
 AS
 BEGIN
 	INSERT dbo.PhieuNhapVien
 	(
 	    MaPNV,
 	    TgNV,
 	    NgapLap,
 	    Khoa,
 	    NguoiLap,
 	    BenhNhan, Giuong
 	)
 	VALUES
 	(   @mapnv,                    -- MaPNV - varchar(30)
 	   @tgnv, -- TgNV - smalldatetime
 	    @nl, -- NgapLap - smalldatetime
 	    @khoa,                    -- Khoa - varchar(30)
 	    @ngl,                    -- NguoiLap - varchar(30)
 	    @bn    ,
		@gig                 -- BenhNhan - varchar(30)
 	    )
 END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__PXN]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__PXN]
@mapxn VARCHAR(30),
@tlxn NVARCHAR(50),
@nxn SMALLDATETIME,
@kq NVARCHAR(50),
@gc NVARCHAR(50),
@bn VARCHAR(30)
AS
BEGIN
	INSERT dbo.PhieuXetNghiem
	(
	    MaPXN,
	    TenLoaiXN,
	    NgayXN,
	    KetQua,
	    GhiChu,
	    BenhNhan
	)
	VALUES
	(  @mapxn,                    -- MaPXN - varchar(30)
	   @tlxn,                   -- TenLoaiXN - nvarchar(50)
	   @nxn, -- NgayXN - smalldatetime
	    @kq,                   -- KetQua - nvarchar(50)
	   @gc,                   -- GhiChu - nvarchar(50)
	   @bn                     -- BenhNhan - varchar(30)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__PXV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__PXV]
@mapxv VARCHAR(30),
@tgdt SMALLDATETIME,
@nl SMALLDATETIME,
@khoa VARCHAR(30),
@bn VARCHAR(30)

AS
BEGIN
	INSERT dbo.PhieuXuatVien
	(
	    MaPXV,
	    NgayLap,
	    TgDieuTri,
	    Khoa,
	    BenhNhan
	)
	VALUES
	(   @mapxv,                    -- MaPXV - varchar(30)
	    @nl, -- NgayLap - smalldatetime
	    @tgdt, -- TgDieuTri - smalldatetime
	   @khoa,                    -- Khoa - varchar(30)
	    @bn                     -- BenhNhan - varchar(30)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Insert__Thuoc]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Insert__Thuoc]
@mat  VARCHAR(30),
@tenth NVARCHAR(50),
@td NVARCHAR(50),
@gia MONEY,
@sl INT

AS
BEGIN
	INSERT dbo.Thuoc
	(
	    MaThuoc,
	    TenThuoc,
	    TacDung,
	    Gia,
	    SL
	)
	VALUES
	(  @mat,   -- MaThuoc - varchar(30)
	    @tenth,  -- TenThuoc - nvarchar(50)
	    @td,  -- TacDung - nvarchar(50)
	    @gia, -- Gia - money
	    @sl    -- SL - int
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__DT]
@madt  VARCHAR(30),
@sl INT,
@hd NVARCHAR(50),
@mt VARCHAR(30)
AS
BEGIN
	UPDATE dbo.DonThuoc SET SoLuong=@sl, HuongDan=@hd,MaThuoc=@mt WHERE MaDT=@madt
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__DV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__DV]
@madv VARCHAR(30),
@tdv NVARCHAR(255),
@dvt NVARCHAR(50),
@dg MONEY
AS
BEGIN
	UPDATE dbo.DichVu SET TenDV=@tdv,DonViTinh=@dvt,DonGia=@dg WHERE MaDV=@madv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__Phong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[usp__Update__Phong]
 @map VARCHAR(30),
 @tp NVARCHAR(50),
 @k VARCHAR(30)
 AS
 BEGIN
 	UPDATE dbo.Phong SET TenPhong=@tp,Khoa=@k WHERE MaPhong=@map
 END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__PNV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__PNV]
@mapnv VARCHAR(30),
@tgnv SMALLDATETIME,
@nl SMALLDATETIME,
@khoa VARCHAR(30),
@bn VARCHAR(30),
@ngl VARCHAR(30)

AS
BEGIN
	UPDATE dbo.PhieuNhapVien SET TgNV=@tgnv,NgapLap=@nl,Khoa=@khoa,NguoiLap=@ngl WHERE MaPNV=@mapnv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__PXN]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__PXN]
@mapxn VARCHAR(30),
@tlxn NVARCHAR(50),
@nxn SMALLDATETIME,
@kq NVARCHAR(50),
@gc NVARCHAR(50),
@bn VARCHAR(30)
AS
BEGIN
	UPDATE dbo.PhieuXetNghiem SET TenLoaiXN=@tlxn,NgayXN=@nxn,KetQua=@kq,GhiChu=@gc,BenhNhan=@bn
	WHERE MaPXN=@mapxn
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__PXV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__PXV]
@mapxv VARCHAR(30),
@tgdt SMALLDATETIME,
@nl SMALLDATETIME,
@khoa VARCHAR(30),
@bn VARCHAR(30)

AS
BEGIN
	UPDATE dbo.PhieuXuatVien SET NgayLap=@nl,TgDieuTri=@tgdt,Khoa=@khoa,BenhNhan=@bn WHERE MaPXV=@mapxv
END

GO
/****** Object:  StoredProcedure [dbo].[usp__Update__Thuoc]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp__Update__Thuoc]
@mat  VARCHAR(30),
@tenth NVARCHAR(50),
@td NVARCHAR(50),
@gia MONEY,
@sl INT

AS
BEGIN
	UPDATE dbo.Thuoc SET TenThuoc=@tenth,TacDung=@td,Gia=@gia,SL=@sl WHERE MaThuoc=@mat
END

GO
/****** Object:  StoredProcedure [dbo].[usp_autoST]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_autoST] @name NVARCHAR(30)
  AS
   BEGIN
       SELECT *  FROM dbo.Thuoc WHERE FREETEXT(TenThuoc,@name);
   END

GO
/****** Object:  StoredProcedure [dbo].[usp_BNChuaDT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[usp_BNChuaDT]
 AS BEGIN
	SELECT MaBenhNhan FROM dbo.BenhNhan WHERE MaBenhNhan NOT IN (SELECT dbo.DonThuoc.BenhNhan FROM dbo.DonThuoc)

 END
GO
/****** Object:  StoredProcedure [dbo].[usp_DangNhap]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[usp_DangNhap]
		@ten NVARCHAR(30), @ma NVARCHAR(30)
		AS
		BEGIN
			SELECT Role FROM dbo.Users WHERE dbo.Users.PassWord=@ma AND UsersName=@ten;
		END	 
GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_BacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Delete_BacSi]
@mabs VARCHAR(30)
AS
BEGIN
	DELETE dbo.BacSi WHERE MaBS=@mabs
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Delete_BenhNhan]
		@mabn VARCHAR(30)
		
		AS
		BEGIN
			ALTER TABLE dbo.BenhAn NOCHECK CONSTRAINT ALL
						ALTER TABLE dbo.HoaDon NOCHECK CONSTRAINT ALL

				DELETE dbo.BenhNhan WHERE MaBenhNhan=@mabn
							ALTER TABLE dbo.BenhAn CHECK CONSTRAINT ALL

			ALTER TABLE dbo.HoaDon CHECK CONSTRAINT ALL
		
				END
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_delete_DT]
@mdt VARCHAR(30)
AS
BEGIN
	DELETE dbo.DonThuoc WHERE MaDT=@mdt
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_HD]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Delete_HD]
@mhd VARCHAR(30),
@dv VARCHAR(30)
AS
BEGIN
	DELETE dbo.HoaDon WHERE MaHD=@mhd AND DichVu=@dv
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_Khoa]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Delete_Khoa]
@mak VARCHAR(30)

AS
BEGIN
	DELETE dbo.Khoa WHERE MaKhoa=@mak
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_NhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Delete_NhanVien]
@manv VARCHAR(30)

AS
BEGIN
	DELETE dbo.NhanVien WHERE MaNV=@manv
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Info]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[usp_Info] @ma VARCHAR(30)
AS BEGIN
	SELECT * FROM dbo.BenhAn WHERE BenhNhan=@ma
END
DROP PROC dbo.usp_Info

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_BacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_BacSi]
@mabs VARCHAR(30),
@hbs NVARCHAR(20),
@tbs NVARCHAR(30),
@dc NVARCHAR(50),
@ns SMALLDATETIME,
@gt BIT
,
@sdt VARCHAR(11),
@nhom VARCHAR(30),
@luong MONEY,
@khoa VARCHAR(30)
AS
BEGIN
	INSERT dbo.BacSi
	(
	    MaBS,
	    HoBS,
	    TenBS,
	    DiaChi,
	    NgaySinh,
	    GioiTinh,
	    SDT,
	    Nhom,
	    Luong,
	    Khoa
	)
	VALUES
	(   @mabs   ,                 -- MaBS - varchar(30)
	   @hbs,                   -- HoBS - nvarchar(20)
	   @tbs,                   -- TenBS - nvarchar(30)
	   @dc,                   -- DiaChi - nvarchar(50)
	    @ns, -- NgaySinh - smalldatetime
	   @gt,                  -- GioiTinh - bit
	   @sdt,                    -- SDT - varchar(11)
	    @nhom,                    -- Nhom - varchar(30)
	    @luong,                  -- Luong - money
	    @khoa                     -- Khoa - varchar(30)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_BenhNhan]
@mabn VARCHAR(30),
@hbn NVARCHAR(20),
@tbn NVARCHAR(30),
@dc NVARCHAR(50),
@gt BIT,
@khoa VARCHAR(30),
@nhom VARCHAR(30),
@bs VARCHAR(30),
@sdt INT ,
@ns SMALLDATETIME

AS
BEGIN
	INSERT dbo.BenhNhan
	(
	    MaBenhNhan,
	    HoBN,
	    TenBN,
	    DiaChi,
	    GioiTinh,
	    Khoa,
	    Nhom,
	    BacSi,
	    SDT,
	    NgaySinh
	)
	VALUES
	(   @mabn,                   -- MaBenhNhan - varchar(30)
	   @hbn,                  -- HoBN - nvarchar(20)
	    @tbn,                  -- TenBN - nvarchar(30)
	    @dc,                  -- DiaChi - nvarchar(50)
	   @gt,                 -- GioiTinh - bit
	    @khoa,                   -- Khoa - varchar(30)
	    @nhom,                   -- Nhom - varchar(30)
	    @bs,                   -- BacSi - varchar(30)
	   @sdt,                    -- SDT - int
	   @ns -- NgaySinh - smalldatetime
	    )
END
GO
/****** Object:  StoredProcedure [dbo].[usp_insert_DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_insert_DT]
@mdt VARCHAR(30),
@sl INT,
@hd NVARCHAR(50),
@mt VARCHAR(30),
@bn VARCHAR(30)
AS
BEGIN
	INSERT dbo.DonThuoc
	(
	    MaDT,
	    SoLuong,
	    HuongDan,
	    MaThuoc,
		BenhNhan
	)
	VALUES
	(   @mdt,  -- MaDT - varchar(30)
	    @sl,   -- SoLuong - int
	    @hd, -- HuongDan - nvarchar(50)
	    @mt,
		@bn   -- MaThuoc - varchar(30)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Giuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Insert_Giuong] @maG VARCHAR(30), @maP VARCHAR(300)
AS
 BEGIN
   INSERT dbo.Giuong
           ( MaGiuong, Phong )
   VALUES  ( @maG, -- MaGiuong - varchar(30)
             @maP -- Phong - varchar(30)
             
             )
 END
 
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_HD]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_HD]
@mhd VARCHAR(30),
@nl SMALLDATETIME,
@ngl VARCHAR(30),
@bn VARCHAR(30),

@nk SMALLDATETIME,
@dv VARCHAR(30)
AS
BEGIN
	INSERT dbo.HoaDon
	(
	    MaHD,DichVu,
	    NgayLap,
	    NguoiLap,
	    BenhNhan,
	   
	    NgayKham
	)
	VALUES
	(   @mhd, @dv ,                  -- MaHD - varchar(20)
	    @nl, -- NgayLap - smalldatetime
	    @ngl,                    -- NguoiLap - varchar(30)
	    @bn,                    -- BenhNhan - varchar(30)
	     -- TongTien - money
	    @nk -- NgayKham - smalldatetime
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Khoa]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_Khoa]
@mak VARCHAR(30),
@tk NVARCHAR(50)

AS
BEGIN
	INSERT dbo.Khoa
	(
	    MaKhoa,
	    TenKhoa
	)
	VALUES
	(   @mak, -- MaKhoa - varchar(30)
	   @tk  -- TenKhoa - nvarchar(50)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_NhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_NhanVien]
@manv VARCHAR(30),
@hnv NVARCHAR(20),
@tnv NVARCHAR(30),
@ns SMALLDATETIME,
@dc NVARCHAR(50),
@sdt VARCHAR(11),
@luong MONEY,
@gt BIT,
@nhom VARCHAR(30)
AS
BEGIN
	INSERT dbo.NhanVien
	(
	    MaNV,
	    HoNV,
	    TenNV,
	    NgaySinh,
	    DiaChi,
	    SDT,
	    Luong,
	    Nhom,
	    GioiTinh
	)
	VALUES
	(   @manv,                    -- MaNV - varchar(30)
	   @hnv,                   -- HoNV - nvarchar(20)
	    @tnv,                   -- TenNV - nvarchar(30)
	    @ns, -- NgaySinh - smalldatetime
	   @dc,                   -- DiaChi - nvarchar(50)
	   @sdt,                    -- SDT - varchar(11)
	   @luong,                  -- Luong - money
	    @nhom,                    -- Nhom - varchar(30)
	    @gt                  -- GioiTinh - bit
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Nhom]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_Nhom]
@manhom VARCHAR(30),
@tn NVARCHAR(50)
AS
BEGIN
	INSERT dbo.NhomDoiTuong
	(
	    MaNhom,
	    TenNhom
	)
	VALUES
	(   @manhom ,-- MaNhom - varchar(30)
	    @tn -- TenNhom - nvarchar(50)
	    )
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Restore_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   CREATE PROCEDURE [dbo].[usp_Restore_BenhNhan] @ma VARCHAR(30)
   AS
    BEGIN
		UPDATE dbo.BenhNhan SET Deleted =0  WHERE MaBenhNhan=@ma;
		UPDATE dbo.BenhAn SET deleted=0 WHERE BenhNhan=@ma;
    END
GO
/****** Object:  StoredProcedure [dbo].[usp_Select_BacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Select_BacSi]
AS
BEGIN
	SELECT * FROM dbo.BacSi
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Select_BenhAnNotNull]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Select_BenhAnNotNull] @ma VARCHAR(30)
AS BEGIN 
	


	select dbo.BenhAn.MaBA, dbo.BenhAn.NgayLap, dbo.BenhAn.KqDieuTri, dbo.BenhAn.NoiDungKham, dbo.BenhAn.TinhTrang, dbo.BenhAn.HuongDieuTri, dbo.BenhAn.BenhNhan, dbo.BenhAn.deleted
		FROM BenhNhan,BenhAn
		where @ma=BenhNhan.BacSi AND BenhNhan.MaBenhNhan=BenhAn.BenhNhan and LEN(BenhAn.TinhTrang)>=1 AND BenhAn.deleted=0
	 
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Select_BenhAnNull]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Select_BenhAnNull] @ma VARCHAR(30)
AS
BEGIN
    select dbo.BenhAn.MaBA, dbo.BenhAn.NgayLap, dbo.BenhAn.KqDieuTri, dbo.BenhAn.NoiDungKham, dbo.BenhAn.TinhTrang,dbo.BenhAn.HuongDieuTri, dbo.BenhAn.BenhNhan, dbo.BenhAn.deleted
		FROM BenhNhan,BenhAn
		where @ma=BenhNhan.BacSi and BenhNhan.MaBenhNhan=BenhAn.BenhNhan and BenhAn.TinhTrang ='' AND BenhAn.deleted =0;
END


GO
/****** Object:  StoredProcedure [dbo].[usp_Select_Khoa]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Select_Khoa]
AS BEGIN
       SELECT * FROM 
	   dbo.Khoa
   END
GO
/****** Object:  StoredProcedure [dbo].[usp_Select_NhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Select_NhanVien]

AS
BEGIN
	SELECT * FROM dbo.NhanVien
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Select_Nhom]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Select_Nhom]
AS

BEGIN
    SELECT * FROM
    dbo.NhomDoiTuong
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ShowDT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	 CREATE PROC [dbo].[usp_ShowDT] 
	 AS BEGIN
	SELECT * FROM dbo.DonThuoc 

 END
GO
/****** Object:  StoredProcedure [dbo].[usp_ShowGiuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROC [dbo].[usp_ShowGiuong] @ma VARCHAR(30)
  AS 
  BEGIN 
	SELECT * FROM dbo.Giuong WHERE
     Phong=@ma
  END

GO
/****** Object:  StoredProcedure [dbo].[usp_ShowPhong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [dbo].[usp_ShowPhong] @ma NVARCHAR(30)
		AS
        BEGIN
		SELECT * FROM dbo.Phong WHERE Khoa=@ma
		end
GO
/****** Object:  StoredProcedure [dbo].[usp_ShowPNV]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROC [dbo].[usp_ShowPNV] @maG varchar(30)
   AS
    BEGIN
        SELECT * FROM
         dbo.PhieuNhapVien WHERE Giuong=@maG AND Deleted =0
    END
GO
/****** Object:  StoredProcedure [dbo].[usp_UndoBenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	  CREATE PROCEDURE [dbo].[usp_UndoBenhNhan] @ma VARCHAR(30)
	  AS
	  BEGIN
		UPDATE dbo.BenhNhan SET Deleted=0 WHERE MaBenhNhan=@ma;
		IF EXISTS(SELECT * FROM dbo.BenhAn WHERE BenhNhan=@ma)
			UPDATE dbo.BenhAn SET deleted=0 WHERE BenhNhan=@ma;
	  END
GO
/****** Object:  StoredProcedure [dbo].[usp_Update_BacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Update_BacSi]
@mabs VARCHAR(30),
@hbs NVARCHAR(20),
@tbs NVARCHAR(30),
@dc NVARCHAR(50),
@ns SMALLDATETIME,
@gt BIT,
@sdt VARCHAR(11),
@nhom VARCHAR(30),
@luong MONEY,
@khoa VARCHAR(30)
AS
BEGIN
	UPDATE dbo.BacSi SET HoBS=@hbs,TenBS=@tbs,DiaChi=@dc,NgaySinh=@ns,GioiTinh=@gt,SDT=@sdt,Nhom=@nhom,Luong=@luong,Khoa=@khoa
	WHERE MaBS=@mabs
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_BenhAn]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Update_BenhAn] @MaBA VARCHAR(50),
 		          @KqDieuTri nVARCHAR(50),
 		          @NoiDungKham nVARCHAR(50) ,
 		          @TinhTrang NVARCHAR(50),
 		          @HuongDieuTri NVARCHAR(50)
AS 
BEGIN
    UPDATE dbo.BenhAn SET  KqDieuTri=@KqDieuTri, NoiDungKham=@NoiDungKham , TinhTrang=@TinhTrang, HuongDieuTri=@HuongDieuTri
	WHERE MaBA=@MaBA
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Update_BenhNhan]
@mabn VARCHAR(30),
@hbn NVARCHAR(20),
@tbn NVARCHAR(30),
@dc NVARCHAR(50),
@gt BIT,
@khoa VARCHAR(30),
@nhom VARCHAR(30),
@bs VARCHAR(30),
@sdt INT ,
@ns SMALLDATETIME

AS BEGIN
	ALTER TABLE dbo.BenhNhan NOCHECK CONSTRAINT ALL

UPDATE	dbo.BenhNhan SET
			HoBN=@hbn, TenBN=@tbn, DiaChi=@dc,GioiTinh=@gt,Khoa = @khoa, Nhom=@nhom, BacSi=@bs,SDT=@sdt,NgaySinh=@ns WHERE MaBenhNhan=@mabn;
				ALTER TABLE dbo.BenhNhan CHECK CONSTRAINT  ALL


END
GO
/****** Object:  StoredProcedure [dbo].[usp_update_DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_update_DT]
@mdt VARCHAR(30),
@sl INT,
@hd NVARCHAR(50),
@mt VARCHAR(30),
@bn VARCHAR(30)
AS
BEGIN
	UPDATE dbo.DonThuoc SET SoLuong=@sl,HuongDan=@hd,MaThuoc=@mt,BenhNhan=@bn WHERE MaDT=@mdt
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_Khoa]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Update_Khoa]
@mak VARCHAR(30),
@tk NVARCHAR(50)

AS
BEGIN
	UPDATE dbo.Khoa SET TenKhoa=@tk WHERE MaKhoa=@mak
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_NhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Update_NhanVien]
@manv VARCHAR(30),
@hnv NVARCHAR(20),
@tnv NVARCHAR(30),
@ns SMALLDATETIME,
@dc NVARCHAR(50),
@sdt VARCHAR(11),
@luong MONEY,
@gt BIT,
@nhom VARCHAR(30)
AS
BEGIN
	UPDATE dbo.NhanVien SET HoNV=@hnv,TenNV=@tnv,NgaySinh=@ns,DiaChi=@dc,SDT=@sdt,Luong=@luong,Nhom=@nhom,GioiTinh=@gt WHERE MaNV=@manv
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_Nhom]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Update_Nhom]
@manhom VARCHAR(30),
@tn NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.NhomDoiTuong SET TenNhom=@tn WHERE MaNhom=@manhom
END

GO
/****** Object:  Trigger [dbo].[tg_DelBacSi]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_DelBacSi]
ON [dbo].[BacSi] FOR DELETE

AS
BEGIN
    UPDATE dbo.BacSi SET Deleted=1 WHERE MaBS IN (SELECT Deleted.MaBS FROM deleted);
	ROLLBACK
ENd

GO
ALTER TABLE [dbo].[BacSi] ENABLE TRIGGER [tg_DelBacSi]
GO
/****** Object:  Trigger [dbo].[tg_DelBA]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_DelBA]
ON [dbo].[BenhAn] FOR DELETE

AS
BEGIN
    UPDATE dbo.BenhAn SET deleted=1 WHERE MaBA IN (SELECT Deleted.MaBA FROM Deleted);
	ROLLBACK
END

GO
ALTER TABLE [dbo].[BenhAn] ENABLE TRIGGER [tg_DelBA]
GO
/****** Object:  Trigger [dbo].[tg_DelBenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE TRIGGER [dbo].[tg_DelBenhNhan]
		ON [dbo].[BenhNhan] AFTER
		DELETE
		AS
		BEGIN
			DECLARE @makhoa VARCHAR(30);
			DECLARE @mabn VARCHAR(30);
		
			SELECT @mabn =Deleted.MaBenhNhan FROM Deleted
			SELECT @makhoa=	Deleted.Khoa FROM Deleted
			ROLLBACK TRANSACTION
			UPDATE dbo.Khoa SET SoBN = SoBN -1  WHERE MaKhoa=@makhoa
			UPDATE dbo.BenhNhan SET Deleted=1 WHERE MaBenhNhan=@mabn;
			IF EXISTS ( SELECT * FROM dbo.BenhAn WHERE BenhNhan=@mabn )
				UPDATE dbo.BenhAn SET deleted =1 WHERE BenhNhan=@mabn;
			
		END
GO
ALTER TABLE [dbo].[BenhNhan] ENABLE TRIGGER [tg_DelBenhNhan]
GO
/****** Object:  Trigger [dbo].[tg_Insert_BA]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE TRIGGER [dbo].[tg_Insert_BA]
  ON [dbo].[BenhNhan] FOR INSERT
  AS 
  BEGIN	
  		INSERT INTO dbo.BenhAn
  		        ( MaBA ,
  		          NgayLap ,
  		          KqDieuTri ,
  		          NoiDungKham ,
  		          TinhTrang ,
  		         
  		          HuongDieuTri ,
  		          BenhNhan ,
  		          deleted
  		        )
  		VALUES  (  (SELECT Inserted.MaBenhNhan FROM Inserted), -- MaBA - varchar(30)
  		          GETDATE() , -- NgayLap - smalldatetime
  		          N'' , -- KqDieuTri - nvarchar(50)
  		          N'' , -- NoiDungKham - nvarchar(50)
  		          N'' , -- TinhTrang - nvarchar(50)
  		          N'' , -- HuongDieuTri - nvarchar(50)
  		          (SELECT Inserted.MaBenhNhan FROM Inserted) , -- BenhNhan - varchar(30)
  		          0 -- deleted - bit 
  		        )
  END
GO
ALTER TABLE [dbo].[BenhNhan] ENABLE TRIGGER [tg_Insert_BA]
GO
/****** Object:  Trigger [dbo].[tg_Insert_BenhNhan]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_Insert_BenhNhan]
ON [dbo].[BenhNhan] FOR INSERT
AS
BEGIN
	UPDATE dbo.Khoa SET SoBN = SoBN +1 FROM Inserted  WHERE Inserted.Khoa=dbo.Khoa.MaKhoa
END

GO
ALTER TABLE [dbo].[BenhNhan] ENABLE TRIGGER [tg_Insert_BenhNhan]
GO
/****** Object:  Trigger [dbo].[tg_Insert_DT]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_Insert_DT]
ON [dbo].[DonThuoc] FOR INSERT
AS
BEGIN
	DECLARE @ma VARCHAR(30);
	DECLARE @sl INT;
	DECLARE @sl_old INT;


	SELECT @ma=	Inserted.MaThuoc FROM Inserted
	SELECT @sl_old = dbo.Thuoc.SL FROM dbo.Thuoc WHERE MaThuoc=@ma;
	SELECT @sl = Inserted.SoLuong FROM Inserted
	IF(@sl_old  >= @sl)
			UPDATE dbo.Thuoc SET  SL = SL - @sl  WHERE MaThuoc=@ma

	ELSE
		ROLLBACK
		
END


GO
ALTER TABLE [dbo].[DonThuoc] ENABLE TRIGGER [tg_Insert_DT]
GO
/****** Object:  Trigger [dbo].[tg_Delete_Giuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_Delete_Giuong]
ON [dbo].[Giuong] FOR DELETE
AS
BEGIN
	DECLARE @ma VARCHAR(30);
	SELECT @ma=	Deleted.Phong FROM Deleted
	UPDATE dbo.Phong SET  SoGiuong = SoGiuong - 1  WHERE MaPhong=@ma
END

GO
ALTER TABLE [dbo].[Giuong] ENABLE TRIGGER [tg_Delete_Giuong]
GO
/****** Object:  Trigger [dbo].[tg_Insert_Giuong]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[tg_Insert_Giuong]
ON [dbo].[Giuong] FOR INSERT
AS
BEGIN
	DECLARE @ma VARCHAR(30);
	SELECT @ma=	Inserted.Phong FROM Inserted
	UPDATE dbo.Phong SET  SoGiuong = SoGiuong + 1  WHERE MaPhong=@ma
END


GO
ALTER TABLE [dbo].[Giuong] ENABLE TRIGGER [tg_Insert_Giuong]
GO
/****** Object:  Trigger [dbo].[tg_DelNhanVien]    Script Date: 11-Dec-18 07:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_DelNhanVien]
ON [dbo].[NhanVien] FOR DELETE

AS
BEGIN
    UPDATE dbo.NhanVien SET Deleted=1 WHERE MaNV IN (SELECT MaNV FROM deleted);
	ROLLBACK
ENd

GO
ALTER TABLE [dbo].[NhanVien] ENABLE TRIGGER [tg_DelNhanVien]
GO
/****** Object:  Trigger [dbo].[tg_BookPhong]    Script Date: 11-Dec-18 07:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE TRIGGER [dbo].[tg_BookPhong]
	ON
    [dbo].[PhieuNhapVien] AFTER INSERT
	AS
     BEGIN
			DECLARE @ma VARCHAR(30);
			SELECT @ma=Inserted.Giuong FROM Inserted 
			UPDATE dbo.Giuong SET Book =1 WHERE MaGiuong=@ma

	 end
GO
ALTER TABLE [dbo].[PhieuNhapVien] ENABLE TRIGGER [tg_BookPhong]
GO
/****** Object:  Trigger [dbo].[tr_DeleteBooked]    Script Date: 11-Dec-18 07:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE TRIGGER [dbo].[tr_DeleteBooked] ON [dbo].[PhieuNhapVien]  AFTER DELETE 
  AS
   BEGIN
		DECLARE @mg VARCHAR(30);
		SET @mg =(SELECT Deleted.Giuong FROM Deleted)
		DECLARE @ma VARCHAR(30);
		SET @ma =(SELECT Deleted.MaPNV FROM Deleted)
		ROLLBACK TRANSACTION;
        UPDATE dbo.Giuong SET dbo.Giuong.Book=0 FROM Deleted WHERE Deleted.Giuong=@mg
		UPDATE dbo.PhieuNhapVien SET Deleted=1 WHERE MaPNV=@ma;
   END
GO
ALTER TABLE [dbo].[PhieuNhapVien] ENABLE TRIGGER [tr_DeleteBooked]
GO
/****** Object:  Trigger [dbo].[tg_Delete_Phong]    Script Date: 11-Dec-18 07:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_Delete_Phong]
ON [dbo].[Phong] FOR DELETE
AS
BEGIN
	DECLARE @ma VARCHAR(30);
	SELECT @ma=	Deleted.Khoa FROM Deleted
	UPDATE dbo.Khoa SET  SoPhong = SoPhong - 1  WHERE MaKhoa=@ma
END

GO
ALTER TABLE [dbo].[Phong] ENABLE TRIGGER [tg_Delete_Phong]
GO
/****** Object:  Trigger [dbo].[tg_Insert_Phong]    Script Date: 11-Dec-18 07:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[tg_Insert_Phong]
ON [dbo].[Phong] FOR INSERT
AS
BEGIN
	DECLARE @ma VARCHAR(30);
	SELECT @ma=	Inserted.Khoa FROM Inserted
	UPDATE dbo.Khoa SET  SoPhong = SoPhong + 1  WHERE MaKhoa=@ma
END

GO
ALTER TABLE [dbo].[Phong] ENABLE TRIGGER [tg_Insert_Phong]
GO
USE [master]
GO
ALTER DATABASE [qlpk1] SET  READ_WRITE 
GO
