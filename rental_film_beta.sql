-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2023 at 03:47 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rental film beta`
--

-- --------------------------------------------------------

--
-- Table structure for table `akses`
--

CREATE TABLE `akses` (
  `ak_id` char(6) NOT NULL,
  `ak_jenis_akses` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cs_nik` char(16) NOT NULL,
  `cs_nama` varchar(100) DEFAULT NULL,
  `cs_email` varchar(100) DEFAULT NULL,
  `cs_alamat` varchar(100) DEFAULT NULL,
  `cs_usia` int(11) DEFAULT NULL,
  `cs_jenis_kelamin` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `st_id` char(7) NOT NULL,
  `st_nama` varchar(40) DEFAULT NULL,
  `st_reputasi` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `f_id` char(6) NOT NULL,
  `f_judul` varchar(50) DEFAULT NULL,
  `f_rumah_produksi` varchar(50) DEFAULT NULL,
  `f_stok` int(11) DEFAULT NULL,
  `f_tahun_rilis` int(11) DEFAULT NULL,
  `f_durasi` int(11) DEFAULT NULL,
  `k_id` char(6) DEFAULT NULL,
  `sutradara_st_id` char(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `pk_id` int(11) NOT NULL,
  `pk_pekerjaan` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `k_id` char(6) NOT NULL,
  `k_jenis_kategori` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `no_telp`
--

CREATE TABLE `no_telp` (
  `no_nomor_telepon` varchar(15) NOT NULL,
  `customer_cs_nik` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `pe_nip` char(10) NOT NULL,
  `pe_nama` varchar(100) DEFAULT NULL,
  `pe_no_telp` varchar(15) DEFAULT NULL,
  `pe_email` varchar(100) DEFAULT NULL,
  `pe_alamat` varchar(100) DEFAULT NULL,
  `pe_jenis_kelamin` char(1) DEFAULT NULL,
  `pe_usia` int(11) DEFAULT NULL,
  `akses_ak_id` char(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_film`
--

CREATE TABLE `rental_film` (
  `film_f_id` char(6) DEFAULT NULL,
  `transaksi_rental_film_trf_id` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_rental_film`
--

CREATE TABLE `transaksi_rental_film` (
  `trf_id` char(10) NOT NULL,
  `trf_tgl_rental` date DEFAULT NULL,
  `trf_tgl_kembali` date DEFAULT NULL,
  `trf_denda` decimal(10,2) DEFAULT NULL,
  `pegawai_pe_nip` char(10) DEFAULT NULL,
  `customer_cs_nik` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akses`
--
ALTER TABLE `akses`
  ADD PRIMARY KEY (`ak_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cs_nik`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`st_id`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `k_id` (`k_id`),
  ADD KEY `sutradara_st_id` (`sutradara_st_id`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`pk_id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`k_id`);

--
-- Indexes for table `no_telp`
--
ALTER TABLE `no_telp`
  ADD PRIMARY KEY (`no_nomor_telepon`),
  ADD KEY `customer_cs_nik` (`customer_cs_nik`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`pe_nip`),
  ADD KEY `akses_ak_id` (`akses_ak_id`);

--
-- Indexes for table `rental_film`
--
ALTER TABLE `rental_film`
  ADD KEY `film_f_id` (`film_f_id`),
  ADD KEY `transaksi_rental_film_trf_id` (`transaksi_rental_film_trf_id`);

--
-- Indexes for table `transaksi_rental_film`
--
ALTER TABLE `transaksi_rental_film`
  ADD PRIMARY KEY (`trf_id`),
  ADD KEY `customer_cs_nik` (`customer_cs_nik`),
  ADD KEY `pegawai_pe_nip` (`pegawai_pe_nip`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `film_ibfk_1` FOREIGN KEY (`k_id`) REFERENCES `kategori` (`k_id`),
  ADD CONSTRAINT `sutradara_st_id` FOREIGN KEY (`sutradara_st_id`) REFERENCES `director` (`st_id`);

--
-- Constraints for table `no_telp`
--
ALTER TABLE `no_telp`
  ADD CONSTRAINT `no_telp_ibfk_1` FOREIGN KEY (`customer_cs_nik`) REFERENCES `customer` (`cs_nik`);

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`akses_ak_id`) REFERENCES `akses` (`ak_id`);

--
-- Constraints for table `rental_film`
--
ALTER TABLE `rental_film`
  ADD CONSTRAINT `rental_film_ibfk_1` FOREIGN KEY (`film_f_id`) REFERENCES `film` (`f_id`),
  ADD CONSTRAINT `rental_film_ibfk_2` FOREIGN KEY (`transaksi_rental_film_trf_id`) REFERENCES `transaksi_rental_film` (`trf_id`);

--
-- Constraints for table `transaksi_rental_film`
--
ALTER TABLE `transaksi_rental_film`
  ADD CONSTRAINT `transaksi_rental_film_ibfk_1` FOREIGN KEY (`customer_cs_nik`) REFERENCES `customer` (`cs_nik`),
  ADD CONSTRAINT `transaksi_rental_film_ibfk_2` FOREIGN KEY (`pegawai_pe_nip`) REFERENCES `pegawai` (`pe_nip`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
