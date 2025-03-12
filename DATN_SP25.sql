CREATE DATABASE DATN_SP25;
go
USE DATN_SP25;
go

CREATE TABLE thuong_hieu (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_thuong_hieu NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);


CREATE TABLE xuat_xu (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_xuat_xu NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE chat_lieu (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_chat_lieu NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE co_ao (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_co_ao NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE tay_ao (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_tay_ao NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE mau_sac (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ma_hex NVARCHAR(7) UNIQUE NOT NULL,
    ten_mau_sac NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE kich_thuoc (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_kich_thuoc NVARCHAR(255) NOT NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE san_pham (
    id INT PRIMARY KEY IDENTITY(1, 1),
    ten_san_pham NVARCHAR(255) NOT NULL,
    ma_san_pham NVARCHAR(50) UNIQUE NOT NULL,
    mo_ta NVARCHAR(MAX) NULL,
    trang_thai BIT NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE san_pham_chi_tiet (
    id INT PRIMARY KEY IDENTITY(1, 1),
    san_pham_id INT NOT NULL,
    thuong_hieu_id INT NOT NULL,
    xuat_xu_id INT NOT NULL,
    chat_lieu_id INT NOT NULL,
    co_ao_id INT NOT NULL,
    tay_ao_id INT NOT NULL,
    mau_sac_id INT NOT NULL,
    kich_thuoc_id INT NOT NULL,
    so_luong INT NOT NULL DEFAULT 0,
    don_gia DECIMAL(18, 2) NOT NULL,
    hinh_anh NVARCHAR(255) NOT NULL, 
    ngay_tao DATETIME DEFAULT GETDATE(),
    trang_thai BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (san_pham_id) REFERENCES san_pham(id),
    FOREIGN KEY (thuong_hieu_id) REFERENCES thuong_hieu(id),
    FOREIGN KEY (xuat_xu_id) REFERENCES xuat_xu(id),
    FOREIGN KEY (chat_lieu_id) REFERENCES chat_lieu(id),
    FOREIGN KEY (co_ao_id) REFERENCES co_ao(id),
    FOREIGN KEY (tay_ao_id) REFERENCES tay_ao(id),
    FOREIGN KEY (mau_sac_id) REFERENCES mau_sac(id),
    FOREIGN KEY (kich_thuoc_id) REFERENCES kich_thuoc(id)
);

CREATE TABLE vai_tro (
    id INT PRIMARY KEY IDENTITY (1, 1),
    ma_vai_tro NVARCHAR(50),
    ten_vai_tro NVARCHAR(255),
    trang_thai TINYINT
);

-- Bảng khách hàng (khach_hang)
CREATE TABLE khach_hang (
    id INT PRIMARY KEY IDENTITY (1, 1),
    ma_khach_hang NVARCHAR(50) NOT NULL,
    ten_khach_hang NVARCHAR(255) NOT NULL,
    ten_dang_nhap NVARCHAR(50) UNIQUE NOT NULL, -- Thêm cột này
    mat_khau NVARCHAR(255) NOT NULL, -- Thêm cột này
    email NVARCHAR(255) UNIQUE NOT NULL,
    so_dien_thoai NVARCHAR(15) UNIQUE,
    gioi_tinh INT,
    ngay_sinh DATE,
    avatar_url NVARCHAR(255),
    trang_thai INT NOT NULL
);

CREATE TABLE nhan_vien (
    id INT PRIMARY KEY IDENTITY (1, 1),
    vai_tro_id INT NOT NULL,
    ma_nhan_vien NVARCHAR(50) NOT NULL,
    ten_nhan_vien NVARCHAR(255) NOT NULL,
    ten_dang_nhap NVARCHAR(50) UNIQUE NOT NULL, -- Thêm cột này
    mat_khau NVARCHAR(255) NOT NULL, -- Thêm cột này
    email NVARCHAR(255) UNIQUE NOT NULL,
    so_dien_thoai NVARCHAR(15) UNIQUE NOT NULL,
    dia_chi NVARCHAR(255),
    trang_thai INT NOT NULL,
    gioi_tinh INT,
    avatar_url NVARCHAR(255),
    FOREIGN KEY (vai_tro_id) REFERENCES vai_tro(id)
);


-- Bảng địa chỉ khách hàng (dia_chi_khach_hang)
CREATE TABLE dia_chi_khach_hang (
    id INT PRIMARY KEY IDENTITY(1, 1),
    khach_hang_id INT NOT NULL,
    tinh_thanh_id INT NOT NULL,
    quan_huyen_id INT NOT NULL,
    phuong_xa_id INT NOT NULL,
	tinh_thanh NVARCHAR(255) NOT NULL,
    quan_huyen NVARCHAR(255) NOT NULL,
    phuong_xa NVARCHAR(255) NOT NULL,
    dia_chi_chi_tiet NVARCHAR(255) NOT NULL,
    ngay_tao DATETIME DEFAULT GETDATE(),
    trang_thai BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(id) ON DELETE CASCADE
);

-- Bảng phieu_giam_gia
CREATE TABLE phieu_giam_gia (
    id INT PRIMARY KEY IDENTITY (1, 1),
    ma_phieu_giam_gia NVARCHAR(50),
    ten_phieu_giam_gia NVARCHAR(255),
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_sua DATETIME NULL,
    thoi_gian_ap_dung DATETIME,
    thoi_gian_het_han DATETIME,
    gia_tri_giam FLOAT,
    so_tien_toi_thieu_hd FLOAT,
    so_tien_giam_toi_da FLOAT,
    loai_giam INT, -- 0: tất cả ; 1: gửi riêng
    trang_thai INT,
    so_luong INT,
    hinh_thuc_giam_gia INT DEFAULT 0 -- 0: phần trăm, 1: số tiền cụ thể
);


-- Bảng phieu_giam_gia_khach_hang
CREATE TABLE phieu_giam_gia_khach_hang (
    id INT PRIMARY KEY IDENTITY (1, 1),
    id_khach_hang INT,
    id_voucher INT,
    trang_thai TINYINT,
    ngay_tao DATE DEFAULT CAST(GETDATE() AS DATE),
    ngay_sua DATE NULL,
    FOREIGN KEY (id_khach_hang) REFERENCES khach_hang(id),
    FOREIGN KEY (id_voucher) REFERENCES phieu_giam_gia(id)
);


-- Bảng hoa_don
CREATE TABLE hoa_don (
    id INT PRIMARY KEY IDENTITY (1, 1),
    id_khach_hang INT,
    id_nhan_vien INT,
	id_phieu_giam_gia INT,
    ma_hoa_don NVARCHAR(50),
    loai_don TINYINT,
    ghi_chu NVARCHAR(255),
    ho_ten_nguoi_nhan NVARCHAR(255),
    so_dien_thoai VARCHAR(15),
    email NVARCHAR(255),
    dia_chi_nhan_hang NVARCHAR(255),
    ngay_nhan_mong_muon DATE,
    ngay_du_kien_nhan DATE,
    trang_thai_giao_hang TINYINT,
    phi_ship DECIMAL(10, 2),
    tong_tien DECIMAL(10, 2),
    ngay_tao DATETIME DEFAULT GETDATE(),
    trang_thai TINYINT,
    FOREIGN KEY (id_khach_hang) REFERENCES khach_hang(id),
    FOREIGN KEY (id_nhan_vien) REFERENCES nhan_vien(id),
    FOREIGN KEY (id_phieu_giam_gia) REFERENCES phieu_giam_gia(id)

);



-- Bảng lich_su_hoa_don
CREATE TABLE lich_su_hoa_don (
    id INT PRIMARY KEY IDENTITY (1, 1),
    id_hoa_don INT,
    hanh_dong NVARCHAR(255),
    nguoi_thay_doi NVARCHAR(255),
    thoi_gian_thay_doi DATE DEFAULT CAST(GETDATE() AS DATE),
    ghi_chu NVARCHAR(255),
    FOREIGN KEY (id_hoa_don) REFERENCES hoa_don(id)
);

-- Bảng hoa_don_chi_tiet
CREATE TABLE hoa_don_chi_tiet (
    id INT PRIMARY KEY IDENTITY (1, 1),
    hoa_don_id INT,
    san_pham_chi_tiet_id INT,
    so_luong INT,
    thanh_tien DECIMAL(10, 2),
    trang_thai TINYINT,
    FOREIGN KEY (hoa_don_id) REFERENCES hoa_don(id),
    FOREIGN KEY (san_pham_chi_tiet_id) REFERENCES san_pham_chi_tiet(id)
);

-- Bảng phuong_thuc_thanh_toan
CREATE TABLE phuong_thuc_thanh_toan (
    id INT PRIMARY KEY IDENTITY (1, 1),
    ma_phuong_thuc NVARCHAR(50),
    ten_phuong_thuc NVARCHAR(255),
    ghi_chu NVARCHAR(255),
    trang_thai TINYINT
);
-- Bảng hoa_don_phuong_thuc_thanh_toan
CREATE TABLE hoa_don_phuong_thuc_thanh_toan (
    id INT PRIMARY KEY IDENTITY (1, 1),
    hoa_don_id INT,
    phuong_thuc_thanh_toan_id INT,
    so_tien_thanh_thoan DECIMAL(10, 2),
    ngay_thuc_hien_thanh_toan DATE DEFAULT CAST(GETDATE() AS DATE),
    ghi_chu NVARCHAR(255),
    FOREIGN KEY (hoa_don_id) REFERENCES hoa_don(id),
    FOREIGN KEY (phuong_thuc_thanh_toan_id) REFERENCES phuong_thuc_thanh_toan(id)
);



INSERT INTO vai_tro (ma_vai_tro, ten_vai_tro, trang_thai) VALUES
('ADMIN', 'Quản trị viên', 1),
('EMPLOYEE', 'Nhân viên', 1)

INSERT INTO thuong_hieu (ten_thuong_hieu, trang_thai) VALUES
('Nike', 1),
('Adidas', 1),
('Puma', 1),
('Uniqlo', 1),
('Zara', 1);

INSERT INTO xuat_xu (ten_xuat_xu, trang_thai) VALUES
('Việt Nam', 1),
('Trung Quốc', 1),
('Ấn Độ', 1),
('Nhật Bản', 1),
('Hàn Quốc', 1);

INSERT INTO chat_lieu (ten_chat_lieu, trang_thai) VALUES
('Cotton', 1),
('Polyester', 1),
('Vải thun', 1),
('Lụa', 1),
('Len', 1);

INSERT INTO co_ao (ten_co_ao, trang_thai) VALUES
('Cổ Tròn', 1),
('Cổ Bẻ', 1),
('Cổ V', 1),
('Cổ Phân', 1),
('Cổ Nhọn', 1);

INSERT INTO tay_ao (ten_tay_ao, trang_thai) VALUES
('Tay Ngắn', 1),
('Tay Dài', 1),
('Tay Lỡ', 1),
('Tay Ba Lỗ', 1);

INSERT INTO mau_sac (ma_hex, ten_mau_sac, trang_thai) VALUES
('#000000', 'Đen', 1),
('#FFFFFF', 'Trắng', 1),
('#0000FF', 'Xanh', 1),
('#FF0000', 'Đỏ', 1),
('#FFFF00', 'Vàng', 1);

INSERT INTO kich_thuoc (ten_kich_thuoc, trang_thai) VALUES
('S', 1),
('M', 1),
('L', 1),
('XL', 1),
('XXL', 1);

INSERT INTO san_pham (ten_san_pham, ma_san_pham, mo_ta, trang_thai) VALUES
('Áo Polo Nam', 'AP001', 'Áo Polo nam với thiết kế trẻ trung, thoải mái.', 1),
('Áo Thun Nam', 'AT001', 'Áo thun nam chất liệu cotton, thoáng mát.', 1),
('Áo Khoác Nam', 'AK001', 'Áo khoác nam phong cách thể thao, giữ ấm tốt.', 1),
('Áo Sơ Mi Nam', 'ASM001', 'Áo sơ mi nam cho dịp công sở, sang trọng.', 1);

INSERT INTO san_pham_chi_tiet (san_pham_id, thuong_hieu_id, xuat_xu_id, chat_lieu_id, co_ao_id, tay_ao_id, mau_sac_id, kich_thuoc_id, so_luong, don_gia, hinh_anh, trang_thai) VALUES
(1, 1, 1, 1, 1, 1, 1, 2, 50, 350000, 'polo_black.jpg', 1),
(1, 2, 2, 2, 2, 2, 2, 3, 30, 400000, 'polo_white.jpg', 1),
(2, 3, 3, 3, 1, 1, 3, 1, 100, 250000, 'thun_blue.jpg', 1),
(3, 4, 4, 4, 4, 3, 4, 4, 80, 450000, 'khoac_red.jpg', 1);

-- Dữ liệu mẫu cho khách hàng
INSERT INTO khach_hang (ma_khach_hang, ten_khach_hang, ten_dang_nhap, mat_khau, email, so_dien_thoai, gioi_tinh, ngay_sinh, trang_thai) VALUES
('KH001', 'Nguyễn Văn A', 'nguyenvana', 'password1', 'a@gmail.com', '0123456789', 1, '1990-01-01', 1),
('KH002', 'Trần Thị B', 'tranthib', 'password2', 'b@gmail.com', '0123456790', 0, '1992-02-01', 1),
('KH003', 'Lê Minh C', 'leminhc', 'password3', 'c@gmail.com', '0123456791', 1, '1994-03-01', 1),
('KH004', 'Phạm Thị D', 'phamthid', 'password4', 'd@gmail.com', '0123456792', 0, '1996-04-01', 1),
('KH005', 'Hoàng Văn E', 'hoangvane', 'password5', 'e@gmail.com', '0123456793', 1, '1998-05-01', 1);

-- Dữ liệu mẫu cho nhân viên
INSERT INTO nhan_vien (vai_tro_id, ma_nhan_vien, ten_nhan_vien, ten_dang_nhap, mat_khau, email, so_dien_thoai, dia_chi, trang_thai, gioi_tinh) VALUES
(1, 'NV001', 'Nguyễn Văn X', 'nguyenvanx', 'nvpassword1', 'nvx@gmail.com', '0123456784', 'Hà Nội', 1, 1),
(2, 'NV002', 'Trần Thị Y', 'tranthiy', 'nvpassword2', 'nvy@gmail.com', '0123456785', 'TP.HCM', 1, 0),
(2, 'NV003', 'Lê Minh Z', 'leminhz', 'nvpassword3', 'nmz@gmail.com', '0123456786', 'Đà Nẵng', 1, 1),
(2, 'NV004', 'Phạm Hồng A', 'phamhonga', 'nvpassword4', 'nva@gmail.com', '0123456787', 'Cần Thơ', 1, 0),
(2, 'NV005', 'Hoàng Văn B', 'hoangvanb', 'nvpassword5', 'nvb@gmail.com', '0123456788', 'Nha Trang', 1, 1);


INSERT INTO phieu_giam_gia (ma_phieu_giam_gia, ten_phieu_giam_gia, thoi_gian_ap_dung, thoi_gian_het_han, gia_tri_giam, so_tien_toi_thieu_hd, so_tien_giam_toi_da, loai_giam, trang_thai, so_luong, hinh_thuc_giam_gia)
VALUES 
('GG001', N'Xuân', '2025-01-01', '2025-12-31', 100000, 100.00, 50.00, 1, 1, 10, 1),
('GG002', N'Hạ','2025-02-01', '2025-11-30', 20.00, 200.00, 100.00, 0, 1, 20, 0),
('GG003', N'Thu', '2025-01-15', '2025-10-31', 15000, 500.00, 150.00, 1, 1, 30, 1),
('GG004', N'Đông', '2025-03-01', '2025-09-30', 50000, 50.00, 25.00, 1, 1, 40, 1),
('GG005', N'Hè', '2025-01-10', '2025-12-31', 30.00, 300.00, 150.00, 0, 1, 50, 0);

INSERT INTO hoa_don (id_khach_hang, id_nhan_vien, id_phieu_giam_gia,  ma_hoa_don, loai_don, ghi_chu, ho_ten_nguoi_nhan, so_dien_thoai, email, dia_chi_nhan_hang, ngay_nhan_mong_muon, ngay_du_kien_nhan, trang_thai_giao_hang, phi_ship, tong_tien, ngay_tao, trang_thai) 
VALUES
(1, 1,2, 'HD00hhhf', 1, 'Giao nhanh', 'Nguyễn Văn A', '0123456789', 'a@gmail.com', 'Hà Nội', '2024-12-01', '', 0, 10.00, 150.00, '2024-12-01', 1),
(2, 2,3, 'HD002',1, 'Giao nhanh', 'Trần Thị B', '0123456790', 'b@gmail.com', 'TP.HCM', '2024-12-02', '2024-12-04', 1, 15.00, 200.00, '2024-12-02', 1),
(3, 3,4, 'HD003', 0, 'Tại cửa hàng', 'Lê Minh C', '0123456791', 'c@gmail.com', 'Đà Nẵng', '2024-12-03', '2024-12-05', 1, 0.00, 180.00, '2024-12-03', 1),
(4, 4,5, 'HD004',1, 'Giao nhanh', 'Phạm Thị D', '0123456792', 'd@gmail.com', 'Cần Thơ', '2024-12-04', '2024-12-06', 0, 12.00, 220.00, '2024-12-04', 1),
(5, 5,1, 'HD005', 1, 'Giao chậm', 'Hoàng Văn E', '0123456793', 'e@gmail.com', 'Nha Trang', '2024-12-05', '2024-12-07', 1, 20.00, 250.00, '2024-12-05', 1),
(1, 1,1, 'HD006', 1, 'Giao nhanh', 'Nguyễn Văn F', '0123456786', 'f@gmail.com', 'Hà Nội', '2025-02-15', '2025-02-17', 1, 10.00, 150.00, '2025-02-14 08:15:23', 1),
(2, 2,2, 'HD007', 1, 'Giao nhanh', 'Trần Thị G', '0123456787', 'g@gmail.com', 'TP.HCM', '2025-02-16', '2025-02-18', 2, 15.00, 200.00, '2025-02-14 09:35:12', 1),
(3, 3,3, 'HD008', 0, 'Tại cửa hàng', 'Lê Minh H', '0123456788', 'h@gmail.com', 'Đà Nẵng', '2025-02-17', '2025-02-19', 3, 0.00, 180.00, '2025-02-14 10:05:47', 1),
(4, 4,4, 'HD009', 1, 'Giao nhanh', 'Phạm Thị I', '0123456789', 'i@gmail.com', 'Cần Thơ', '2025-02-18', '2025-02-20', 4, 12.00, 220.00, '2025-02-14 11:25:36', 1),
(5, 5,5, 'HD010', 1, 'Giao chậm', 'Hoàng Văn J', '0123456790', 'j@gmail.com', 'Nha Trang', '2025-02-19', '2025-02-21', 5, 20.00, 250.00, '2025-02-14 12:45:29', 1),
(1, 5,1, 'HD011', 1, 'Giao nhanh', 'Nguyễn Văn K', '0123456791', 'k@gmail.com', 'Hà Nội', '2025-02-20', '2025-02-22', 6, 10.00, 180.00, '2025-02-14 13:15:10', 1),
(2, 4,null, 'HD012', 1, 'Giao nhanh', 'Trần Thị L', '0123456792', 'l@gmail.com', 'TP.HCM', '2025-02-21', '2025-02-23', 7, 15.00, 300.00, '2025-02-14 14:25:45', 1),
(3, 3,null, 'HD013', 0, 'Tại cửa hàng', 'Lê Minh M', '0123456793', 'm@gmail.com', 'Đà Nẵng', '2025-02-22', '2025-02-24', 8, 0.00, 100.00, '2025-02-14 15:30:20', 1),
(4, 2,1, 'HD014', 1, 'Giao nhanh', 'Phạm Thị N', '0123456794', 'n@gmail.com', 'Cần Thơ', '2025-02-23', '2025-02-25', 1, 12.00, 230.00, '2025-02-14 16:50:11', 1),
(5, 1,1, 'HD015', 1, 'Giao chậm', 'Hoàng Văn O', '0123456795', 'o@gmail.com', 'Nha Trang', '2025-02-24', '2025-02-26', 2, 20.00, 250.00, '2025-02-14 17:45:34', 1)


INSERT INTO phieu_giam_gia_khach_hang (id_khach_hang, id_voucher, trang_thai)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);


-- Thêm 5 dòng hóa đơn chi tiết
INSERT INTO hoa_don_chi_tiet (hoa_don_id, san_pham_chi_tiet_id, so_luong, thanh_tien, trang_thai) VALUES
(1, 1, 2,  300000, 1),
(2, 2, 1,  200000, 1),
(3, 3, 3,  750000, 1),
(4, 4, 1,  230000, 1);



select * from san_pham
select * from san_pham_chi_tiet
select * from hoa_don_chi_tiet
select * from hoa_don
select * from phieu_giam_gia
select * from phieu_giam_gia_khach_hang
select * from phuong_thuc_thanh_toan
select * from hoa_don_phuong_thuc_thanh_toan
select * from dia_chi_khach_hang

select id, don_gia from san_pham_chi_tiet
delete from hoa_don_chi_tiet where id =93


