-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2026 at 02:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nch_appointment`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `serial_no` int(11) NOT NULL DEFAULT 0,
  `patient_name` varchar(150) NOT NULL,
  `patient_mobile` varchar(20) NOT NULL,
  `patient_gender` enum('Male','Female','Other') DEFAULT NULL,
  `patient_age` int(11) DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `time_slot` time NOT NULL,
  `status` enum('confirmed','cancelled') DEFAULT 'confirmed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_by` int(11) DEFAULT NULL,
  `slot_lock` time GENERATED ALWAYS AS (if(`status` = 'confirmed',`time_slot`,NULL)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `bmdc` varchar(30) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `bmdc`, `details`, `status`) VALUES
(1, 'Dr. Mohammad Joynal Abedin', NULL, 'Chest Disease & Medicine', 1),
(2, 'Dr. Sharmin Sultana', NULL, 'MBBS, BCS(Health), MPhil(Biochemistry), MSC(Food & Nutrition Science)', 1),
(3, 'Nutritionist Md. Iqbal Hossain', NULL, 'Nutritionist & Diet Management at Chittagong Diabetic General Hospital', 1),
(4, 'Dr. Mahfuzul Kabir', NULL, 'Associate Professor & Head of Department (Child surgery department)', 1),
(5, 'Dr. M.A Mushfiqur Rahman (Piku)', NULL, 'Associate Professor, Pediatric Surgery & Pediatric Urology Department, Chittagong Medical College & Hospital', 1),
(6, 'Dr. Fazle Kibria Chowdhury', NULL, 'Assistant Professor (Chattogram Maa O Shisu Hospital Medical college)', 1),
(7, 'Dr. Mohammad Zakir Hossen Bhuiyan', NULL, 'Assistant Professor, Chest Pain Surgery Department (CMCH)', 1),
(8, 'Dr. Mohammadul Haque Mezbah', NULL, 'Senior Consultant (Eye), Chattogram General Hospital', 1),
(9, 'Dr. Md. Gias Uddin (Eye)', NULL, 'Associate Professor (Eye)-CIMC, Former Associate professor (Eye), Cox\'s Bazar Medical College', 1),
(10, 'Dr. Muhammed Abu Bakar', NULL, 'Assistant Professor & Head of Department, Chattogram Maa-O-Shisu Medical College & Hospital', 1),
(11, 'Dr. Md. Abdur Razzak', NULL, 'Head of the Department & Associate Professor (Ex), Sher-e-Bangla Medical College Hospital, Barisal', 1),
(12, 'Dr. Md. Ismail Hossen Chowdhury (Ripon)', NULL, 'Dermatology specialist', 1),
(13, 'Dr. Mst. Nasrin Sultana', NULL, 'Consultant, Chattogram Diabetes General Hospital', 1),
(14, 'Dr. Shamsun Nahar', NULL, 'Associate Professor & Head of the Department, Department of Dermatology and Venereology (Chattogram Maa O Shisu Medical College & Hospital)', 1),
(15, 'Dr. Didaruzzaman', NULL, 'Former Senior Consultant (American Hospital, Agrabad, Chattogram)', 1),
(16, 'Dr. Md. Amir Khasru', NULL, 'Dermatology specialist', 1),
(17, 'Dr. Md. Fazle Robbi Riyad', NULL, 'Cancer Specialist', 1),
(18, 'Dr. Nasir Uddin Mahamud (Shuvo)', NULL, 'Consultant (Oncology), CMCH', 1),
(19, 'Dr. Mohammad Nasir Uddin', NULL, 'Cancer Specialist', 1),
(20, 'Dr. Mohammad Abul Bashar', NULL, 'Senior Consultant (ENT), Chattogram General Hospital', 1),
(21, 'Dr. Mohammad Rezaul Karim (ENT)', NULL, 'ENT Surgery Dept. DMC', 1),
(22, 'Dr. Nurul Korim Chowdhury', NULL, 'Assistant Professor (ENT), CMCH, Fellowship in endoscopy & sinus surgery, Mumbai, India', 1),
(23, 'Dr. Mohammad Jamal Hussain', '11137', 'Associate Professor & Head Dept. of ENT at Chittagong Medical College Hospital', 1),
(24, 'Prof. Col. Dr. Mohammed Sirazul Islam', NULL, 'Professor and Head of the Dept. (ENT & Head-Neck Surgery) at Army Medical College & CMH, Chattogram', 1),
(25, 'Prof. Dr. Md. Abdus Sattar', NULL, 'Professor (ENT), Bangabandhu Sheikh Mujib Medical College (PG Hospital), Dhaka', 1),
(26, 'Professor. Dr. Ziaul Ansar Chowdhury', '11134', 'Professor, ENT (Ear, Nose, Throat) Specialist & Head Neck Surgeon', 1),
(27, 'Professor Dr. Mahbub Ul Alam Chowdhury', NULL, 'Professor', 1),
(28, 'Dr. Naima Akter', NULL, 'Assistant Professor (Gynecology, Obstetrics Specialist & Surgeon), Chattogram Medical College & Hospital', 1),
(29, 'Dr. Nurjahan Begum', NULL, 'Gynae & Obs. Specialist & Surgeon', 1),
(30, 'Dr. Musarat Naz', NULL, 'Consultant (Gyne & Obs)', 1),
(31, 'Dr. Nazneen Sultana (Lulu)', NULL, 'Gynae & Obs. Specialist, Laparoscopic Surgeon', 1),
(32, 'Dr. Sarwat Ara (Riku)', NULL, 'Consultant (CMCH)', 1),
(33, 'Prof. Dr. Kamrun Nessa Runa', NULL, 'Vice Principal & Professor (Gynae & Obs), Marine City Medical College; Ex. Professor (Gynae & Obs), CMCH; President, Obs & Gynae Society of Bangladesh, CTG Branch', 1),
(34, 'Dr. Mohammad Mamun', NULL, 'MBBS, D(ortho)', 1),
(35, 'Dr. Md. Abdur Rob Faisal', NULL, 'Junior Consultant (Orthopedics & Traumatology), CMCH', 1),
(36, 'Dr. Md. Fahad Goni', NULL, 'Associate Professor & Head of Dept. (IAHS, USTC, Chittagong)', 1),
(37, 'Dr. Mohammed Selim', NULL, 'Consultant (Surgery)', 1),
(38, 'Dr. Md. Jamal Uddin', NULL, 'Assistant Professor, Orthopedic Surgery at Chittagong Medical College Hospital', 1),
(39, 'Lt. Col. Dr. Md. Zamil Zaidur Rahim', NULL, 'Associate Professor (Orthopedic), Army Medical College; Senior Orthopedic Surgeon, CMH, Chattogram', 1),
(40, 'Dr. Shahed Mohammed Anwar', NULL, 'General, Laparoscopic and Colorectal Surgeon; Assistant Professor, Dept. of Surgery at Chattogram Maa-O-Shishu Hospital', 1),
(41, 'Dr. A.Z.M Farman Ullah (Sohel)', NULL, 'Associate Professor (General Surgery), Chattogram Maa-O-Shishu Medical College & Hospital', 1),
(42, 'Dr. Saira Banu Shiuli', NULL, 'Assistant Professor (General Surgery), CMC', 1),
(43, 'Dr. Md. Abu Naser', NULL, 'National Hospital Chattogram & Sigma Lab Ltd.', 1),
(44, 'Dr. Mofizur Rahman', NULL, 'Assistant Professor, Department of Urology, Chittagong Medical College & Hospital', 1),
(45, 'Dr. Abdus Salam', NULL, 'Associate Professor (Urology)', 1),
(46, 'Prof. Dr. Md. Mazharul Haque Nasim', NULL, 'Professor (Surgery), General, Laparoscopic & Urological Surgeon', 1),
(47, 'Dr. Ahsan Uddin Mahmud (Munna)', NULL, 'Assistant Professor, Vascular Surgery, Chattogram Medical College Hospital', 1),
(48, 'Dr. Khondokar Md. Ismail', NULL, 'Junior Consultant (Cardiology), Chattogram Medical College & Hospital', 1),
(49, 'Dr. Habibul Islam Chowdhury', NULL, 'Assistant Professor, Dept. of Cardiology, Chittagong Medical College Hospital', 1),
(50, 'Dr. Md. Mostafizur Rahman', NULL, 'Assistant Professor, Cardiology at Chittagong Medical College Hospital', 1),
(51, 'Dr. Mohammed Abdul Jalil', NULL, 'Associate Professor of Cardiology (Ex) at Chittagong Medical College Hospital', 1),
(52, 'Lt. Col. Dr. Md. Mostafa Kamal', NULL, 'Ex MD (Cardiology), BSMMU', 1),
(53, 'Dr. Abdullah-Al-Mamun', NULL, 'Clinical and Interventional Cardiology at National Institute of Cardiovascular Diseases (NICVD)', 1),
(54, 'Dr. Mohammad Abdul Momen', NULL, 'Pediatrician', 1),
(55, 'Dr. Mumtahina Mahmuda', NULL, 'Child Specialist, Chittagong Medical College & Hospital', 1),
(56, 'Dr. Roksana Afrose', NULL, 'Research Physician (X), Chattogram Maa-O-Shishu Hospital', 1),
(57, 'Dr. Mohammed Hossain', NULL, 'Consultant (Pediatrics)', 1),
(58, 'Dr. Nazmul Huda Ripon', NULL, 'Associate Professor (CIMCH)', 1),
(59, 'Dr. Md. Abdullah Al Mamun', NULL, 'Assistant Professor Dept. of Child Health at Rangamati Medical College', 1),
(60, 'Dr. Nazrul Quader Shikder', NULL, 'Associate Professor (Department of Paediatrics) at Chattogram Maa-O-Shishu Hospital & Consultant-NICU, National Hospital Chattogram', 1),
(61, 'Prof. Dr. A J M Sadeque', NULL, 'Professor & Head, Department of Pediatrics at Bangabandhu Memorial Hospital USTC, Chattogram', 1),
(62, 'Dr. Mobinul Hoque Chowdhury', NULL, 'Consultant (Neurology)', 1),
(63, 'Dr. Md. Shamchul Alam', NULL, 'Consultant Neurologist at Chittagong Medical College Hospital', 1),
(64, 'Dr. Touhidur Rahman', NULL, 'Associate Professor, Dept. of Neurology at Chattogram Medical College & Hospital', 1),
(65, 'Professor Dr. Muhammad Tayeb', NULL, 'Professor, Dept. of Neuro Medicine at Chittagong Medical College Hospital', 1),
(66, 'Dr. Mohammad Mohitul Islam', NULL, 'Associate Professor (Neurology Department), Chattogram Medical College & Hospital', 1),
(67, 'Dr. Md. Saiful Alam', NULL, 'Associate Professor, Department of Neurosurgery at Chittagong Medical College Hospital', 1),
(68, 'Dr. Md. Monzurul Islam', NULL, 'Associate Professor (Ex) (CMCH)', 1),
(69, 'Dr. Md. Jamal Uddin Tanin', NULL, 'Faculty of Medicine (BSMMU)', 1),
(70, 'Prof. Dr. Md. Gias Uddin Sagor', NULL, 'Professor & Head of Dept. (Psychology Dept.), Chattogram Maa O Sishu Medical College Hospital', 1),
(71, 'Dr. Shafiul Karim Md Elias', NULL, 'Associate Professor & Head of Dept. at CIMC Hospital', 1),
(72, 'Prof. Dr. Zahangir Alam Chowdhury', NULL, 'Professor & Head of the Department of Physical Medicine and Rehabilitation at Chattogram Maa-O-Shishu Hospital', 1),
(73, 'Dr. M. A. Mazed', NULL, 'Consultant in Physical Medicine', 1),
(74, 'Prof. Dr. Mohammad Jalal Uddin', NULL, 'Professor, Chattogram Maa-O-Shishu Hospital Medical College', 1),
(75, 'Dr. Murad Mohammed Faisal Hero', NULL, 'Consultant (Medicine)', 1),
(76, 'Dr. A.M Shahed', NULL, 'Assistant Professor (Medicine)', 1),
(77, 'Dr. Farzin Akter', NULL, 'Medicine Specialist at Chittagong Medical College Hospital', 1),
(78, 'Dr. S.M Kamrul Haque', NULL, 'Assistant Professor (Medicine)', 1),
(79, 'Dr. Md. Abu Naser Siddique', NULL, 'Associate Professor (Medicine Dept.), Chattogram Medical College Hospital', 1),
(80, 'Dr. Mosharraf Hossen', NULL, 'Assistant Professor (Ex), Medicine Department at Chittagong Medical College Hospital', 1),
(81, 'Dr. Md. Ferdous', NULL, 'Assistant Professor, Dept. of Medicine at USTC, Chattogram', 1),
(82, 'Dr. Mohammad Rezaul Karim (Medicine)', NULL, 'Consultant (Medicine)', 1),
(83, 'Professor Dr. A.S.M Zahed', NULL, 'Professor at Chattogram Medical College & Hospital', 1),
(84, 'Dr. Mohammad Forhad', NULL, 'Specialist in Medicine', 1),
(85, 'Dr. Saddat Hossain', NULL, 'Consultant (Nephrology)', 1),
(86, 'Dr. Mohammad Abdul Kader', NULL, 'Consultant, Dept. of Nephrology at Chittagong Medical College & Hospital', 1),
(87, 'Prof. Dr. AMM Ehteshamul Haque', NULL, 'Professor & Head of Dept. (Nephrology Department), Dean Faculty of Medicine, USTC; Principal, Institute of Applied Health Science', 1),
(88, 'Dr. Md. Gias Uddin (Rheumatology)', NULL, 'Rheumatology (Arthritis, Vasculitis, SLE, Osteoporosis) Specialist', 1),
(89, 'Dr. Mushfiqul Abrar', NULL, 'Consultant: Hepatologist & Therapeutic Endoscopist', 1),
(90, 'Professor Dr. Tazin Sultana', NULL, 'Professor, Department of Gyne', 1),
(91, 'Dr. Tasbirul Hasan Zihan', NULL, 'Gastroliver & Medicine Specialist, Chittagong Medical College', 1),
(92, 'Dr. Shamim Boksha', NULL, 'Medicine, Gastroenterology & Liver disease', 1),
(93, 'Dr. Mohammad Jashim Uddin', NULL, 'Medicine, Gastroenterology & Liver disease', 1);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_schedules`
--

CREATE TABLE `doctor_schedules` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `day_of_week` tinyint(4) NOT NULL,
  `session_name` varchar(20) NOT NULL DEFAULT 'Evening',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `slot_minutes` int(11) NOT NULL DEFAULT 20,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctor_schedules`
--

INSERT INTO `doctor_schedules` (`id`, `doctor_id`, `day_of_week`, `session_name`, `start_time`, `end_time`, `slot_minutes`, `is_active`) VALUES
(1024, 1, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1025, 1, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1026, 1, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1027, 2, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1028, 2, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1029, 2, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1033, 4, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1034, 4, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1035, 4, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1036, 4, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1037, 5, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1038, 5, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1039, 5, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1040, 6, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1041, 6, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1042, 6, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1043, 7, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1044, 7, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1045, 7, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1046, 8, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1047, 8, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1048, 8, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1049, 9, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1050, 9, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1051, 9, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1052, 9, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1053, 10, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1054, 10, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1055, 10, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1056, 11, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1057, 11, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1058, 11, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1059, 12, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1060, 12, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1061, 12, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1062, 13, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1063, 13, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1064, 13, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1065, 14, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1066, 14, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1067, 14, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1068, 14, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1069, 15, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1070, 15, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1071, 15, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1072, 16, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1073, 16, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1074, 16, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1075, 17, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1076, 17, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1077, 17, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1078, 18, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1079, 18, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1080, 18, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1081, 19, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1082, 19, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1083, 19, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1084, 19, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1085, 20, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1086, 20, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1087, 20, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1088, 21, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1089, 21, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1090, 21, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1091, 22, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1092, 22, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1093, 22, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1094, 24, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1095, 24, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1096, 24, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1097, 24, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1098, 25, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1099, 25, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1100, 25, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1101, 27, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1102, 27, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1103, 27, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1104, 28, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1105, 28, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1106, 28, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1107, 29, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1108, 29, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1109, 29, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1110, 29, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1111, 30, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1112, 30, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1113, 30, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1114, 31, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1115, 31, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1116, 31, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1117, 32, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1118, 32, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1119, 32, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1120, 33, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1121, 33, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1122, 33, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1123, 34, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1124, 34, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1125, 34, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1126, 34, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1127, 35, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1128, 35, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1129, 35, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1130, 36, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1131, 36, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1132, 36, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1133, 37, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1134, 37, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1135, 37, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1136, 38, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1137, 38, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1138, 38, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1139, 39, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1140, 39, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1141, 39, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1142, 39, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1143, 40, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1144, 40, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1145, 40, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1146, 41, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1147, 41, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1148, 41, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1149, 42, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1150, 42, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1151, 42, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1152, 43, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1153, 43, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1154, 43, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1155, 44, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1156, 44, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1157, 44, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1158, 44, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1159, 45, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1160, 45, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1161, 45, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1162, 46, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1163, 46, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1164, 46, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1165, 47, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1166, 47, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1167, 47, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1168, 48, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1169, 48, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1170, 48, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1171, 49, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1172, 49, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1173, 49, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1174, 49, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1175, 50, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1176, 50, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1177, 50, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1178, 51, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1179, 51, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1180, 51, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1181, 52, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1182, 52, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1183, 52, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1184, 53, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1185, 53, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1186, 53, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1187, 54, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1188, 54, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1189, 54, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1190, 54, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1191, 55, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1192, 55, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1193, 55, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1194, 56, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1195, 56, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1196, 56, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1197, 57, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1198, 57, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1199, 57, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1200, 58, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1201, 58, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1202, 58, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1203, 59, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1204, 59, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1205, 59, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1206, 59, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1207, 60, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1208, 60, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1209, 60, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1210, 61, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1211, 61, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1212, 61, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1213, 62, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1214, 62, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1215, 62, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1216, 63, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1217, 63, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1218, 63, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1219, 64, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1220, 64, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1221, 64, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1222, 64, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1223, 65, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1224, 65, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1225, 65, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1226, 66, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1227, 66, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1228, 66, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1229, 67, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1230, 67, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1231, 67, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1232, 68, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1233, 68, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1234, 68, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1235, 69, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1236, 69, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1237, 69, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1238, 69, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1239, 70, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1240, 70, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1241, 70, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1242, 71, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1243, 71, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1244, 71, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1245, 72, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1246, 72, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1247, 72, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1248, 73, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1249, 73, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1250, 73, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1251, 74, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1252, 74, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1253, 74, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1254, 74, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1255, 75, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1256, 75, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1257, 75, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1258, 76, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1259, 76, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1260, 76, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1261, 77, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1262, 77, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1263, 77, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1264, 78, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1265, 78, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1266, 78, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1267, 79, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1268, 79, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1269, 79, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1270, 79, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1271, 80, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1272, 80, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1273, 80, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1274, 81, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1275, 81, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1276, 81, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1277, 82, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1278, 82, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1279, 82, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1280, 83, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1281, 83, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1282, 83, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1283, 84, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1284, 84, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1285, 84, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1286, 84, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1287, 85, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1288, 85, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1289, 85, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1290, 86, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1291, 86, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1292, 86, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1293, 87, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1294, 87, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1295, 87, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1296, 88, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1297, 88, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1298, 88, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1299, 89, 6, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1300, 89, 2, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1301, 89, 4, 'Evening', '18:00:00', '21:00:00', 20, 1),
(1302, 89, 5, 'Morning', '09:00:00', '12:00:00', 20, 1),
(1303, 90, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1304, 90, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1305, 90, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1306, 91, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1307, 91, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1308, 91, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1309, 92, 5, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1310, 92, 6, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1311, 92, 0, 'Morning', '10:00:00', '13:00:00', 15, 1),
(1312, 93, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1313, 93, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1314, 93, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1315, 26, 0, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1316, 26, 2, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1317, 26, 4, 'Evening', '17:00:00', '20:00:00', 20, 1),
(1318, 23, 1, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1319, 23, 3, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1320, 23, 5, 'Afternoon', '16:00:00', '19:00:00', 30, 1),
(1535, 3, 0, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1536, 3, 1, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1537, 3, 2, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1538, 3, 3, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1539, 3, 4, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1540, 3, 5, 'Afternoon', '15:00:00', '17:00:00', 20, 1),
(1541, 3, 6, 'Afternoon', '15:00:00', '17:00:00', 20, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'Admin', 'receptionist@gmail.com', '$2y$10$kmyufPSrWF.BIw0DhzEM0.vcbWspz72Aiu4UYTCe8Y9ajnpPQXYSK');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_slot` (`doctor_id`,`appointment_date`,`slot_lock`),
  ADD KEY `idx_date_status` (`appointment_date`,`status`),
  ADD KEY `idx_doc_date` (`doctor_id`,`appointment_date`),
  ADD KEY `fk_appt_created_by` (`created_by`),
  ADD KEY `fk_appt_cancelled_by` (`cancelled_by`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_doctor_bmdc` (`bmdc`),
  ADD KEY `idx_doctor_name` (`name`);

--
-- Indexes for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_doc_day_start` (`doctor_id`,`day_of_week`,`start_time`),
  ADD KEY `idx_doc_day` (`doctor_id`,`day_of_week`,`is_active`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1542;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `fk_appt_cancelled_by` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_appt_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  ADD CONSTRAINT `doctor_schedules_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
