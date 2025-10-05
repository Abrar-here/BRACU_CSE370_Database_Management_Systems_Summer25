-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2025 at 07:44 PM
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
-- Database: `pet_adoption`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `User_id` int(11) NOT NULL,
  `Admin_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adopter`
--

CREATE TABLE `adopter` (
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `Event-id` int(11) NOT NULL,
  `Event_Name` varchar(100) NOT NULL,
  `Date` date NOT NULL,
  `Location` varchar(200) NOT NULL,
  `Description` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`Event-id`, `Event_Name`, `Date`, `Location`, `Description`) VALUES
(1, 'Summer Paws Adoption Fair', '2025-09-03', 'City Park, Main Street', '“Join us for a fun-filled summer day! Meet adorable cats and dogs looking for loving homes. Free treats and play areas for pets included.”\r\n'),
(2, 'Furry Friends Weekend', '2025-09-03', 'Riverside Community Center', '“Spend your weekend with furry friends! Pet adoption, grooming demos, and a photo booth for new pet families.”\r\n'),
(3, 'Paws & Play Adoption Day', '2025-09-03', 'Sunshine Animal Shelter', ' “A day dedicated to finding forever homes! Interactive play zones, adoption counseling, and a chance to meet our cutest pets.”'),
(4, 'Tail Waggers Adoption Festival', '2025-09-03', 'Greenfield Park', '“Celebrate pets with music, food stalls, and adoption booths. Bring your family and meet dogs, cats, and other small animals ready to go home with you!”\r\n\r\n\r\n'),
(5, 'Tail Waggers Adoption Festival', '2025-09-03', 'Greenfield Park', '“Celebrate pets with music, food stalls, and adoption booths. Bring your family and meet dogs, cats, and other small animals ready to go home with you!”\r\n\r\n\r\n'),
(6, 'Happy Tails Adoption Event', '2025-09-01', 'Downtown Pet Plaza', '“Discover your new best friend! Adoption experts will guide you through the process and help you find the perfect match.”\r\n'),
(7, 'Cats & Dogs Meet & Greet', '2025-09-02', 'Lakeside Community Hall', '“Meet our cats and dogs in a relaxed environment. Learn about each pet’s personality and find a furry companion for your home.”\r\n\r\n\r\n'),
(8, 'Puppy Love Adoption Day', '2025-08-31', 'Oakwood Park', '“Puppies, cuddles, and forever homes! Join us to find your new furry best friend and enjoy games and treats.”\r\n'),
(9, 'Meow & Woof Festival', '2025-09-04', 'Harmony Town Square', '“A lively event for pet lovers! Cat and dog adoptions, fun workshops, and pet-friendly activities for families.”\r\n\r\n\r\n'),
(10, 'Forever Friends Fair', '2025-09-05', 'Maple Street Community Hall', '“Meet animals waiting for a loving home. Expert volunteers will help you choose the perfect companion.”\r\n'),
(11, 'Whiskers & Wags Day', '2025-09-02', 'Sunnyside Plaza', '“Meet cats and dogs ready for adoption. Volunteers will guide you through the adoption process and share care tips.”\r\n\r\n\r\n'),
(12, 'Adopt-a-Pet Weekend', '2025-09-02', 'Central City Park', '“A weekend full of paws, cuddles, and love. Find your new pet and make memories that last forever.”\r\n\r\n\r\n'),
(13, 'Furry Fiesta', '2025-09-10', 'Willow Creek Community Center', '“A festive adoption day with games, treats, and fun activities. Bring your family to meet your future furry friend!”\r\n\r\n\r\n'),
(14, 'Pets & Families Meetup', '2025-09-08', ' Grandview Park', '“A family-friendly pet adoption day. Play with pets, learn about adoption, and find your perfect companion.”\r\n'),
(15, 'Pawsome Adoption Day', '2025-09-12', 'Central Community Center', '“A fun and interactive event to meet pets waiting for a forever home. Activities for both pets and families included.”\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `Event_id` int(11) NOT NULL,
  `Pet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`Event_id`, `Pet_id`) VALUES
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 11),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 18),
(2, 2),
(2, 4),
(2, 5),
(2, 8),
(2, 9),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(3, 3),
(3, 4),
(3, 5),
(3, 12),
(3, 13),
(3, 14),
(3, 17),
(3, 18),
(3, 19),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 8),
(4, 9),
(4, 12),
(4, 13),
(4, 15),
(4, 19),
(5, 2),
(5, 3),
(5, 6),
(5, 7),
(5, 9),
(5, 12),
(5, 14),
(5, 16),
(5, 18),
(6, 3),
(6, 4),
(6, 7),
(6, 9),
(6, 12),
(6, 13),
(6, 14),
(6, 16),
(6, 17),
(6, 18),
(7, 3),
(7, 5),
(7, 7),
(7, 9),
(7, 12),
(7, 13),
(7, 15),
(7, 17),
(7, 18),
(8, 2),
(8, 4),
(8, 6),
(8, 8),
(8, 11),
(8, 13),
(8, 15),
(8, 17),
(8, 19),
(9, 3),
(9, 4),
(9, 6),
(9, 8),
(9, 9),
(9, 12),
(9, 13),
(9, 16),
(9, 17),
(9, 18),
(10, 2),
(10, 3),
(10, 5),
(10, 7),
(10, 8),
(10, 12),
(10, 13),
(10, 15),
(10, 18),
(10, 19),
(11, 4),
(11, 5),
(11, 7),
(11, 8),
(11, 14),
(11, 16),
(11, 17),
(11, 19),
(12, 2),
(12, 5),
(12, 6),
(12, 9),
(12, 11),
(12, 14),
(12, 15),
(12, 18),
(13, 2),
(13, 3),
(13, 5),
(13, 6),
(13, 8),
(13, 9),
(13, 12),
(13, 13),
(13, 15),
(13, 16),
(13, 19),
(14, 4),
(14, 5),
(14, 7),
(14, 8),
(14, 12),
(14, 13),
(14, 16),
(14, 17),
(15, 2),
(15, 5),
(15, 6),
(15, 9),
(15, 11),
(15, 14),
(15, 15),
(15, 18),
(15, 19);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `Content` varchar(300) NOT NULL,
  `Date` date NOT NULL,
  `Rating` int(11) NOT NULL,
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `Content`, `Date`, `Rating`, `User_id`) VALUES
(1, 'I recently adopted my pet from the shelter, and I’m very happy with the overall experience. The staff were welcoming, supportive, and patient in guiding me through the process. They provided all the necessary information about my pet’s background, health, and care requirements, which made the transi', '0000-00-00', 5, 2),
(3, 'The adoption shelter is super cool.', '0000-00-00', 5, 4),
(5, 'Looking to meet with the little paws on adoption fair.', '0000-00-00', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `feeding_schedule`
--

CREATE TABLE `feeding_schedule` (
  `Schedule_id` int(11) NOT NULL,
  `Feeding_time` time NOT NULL,
  `Food_type` varchar(500) NOT NULL,
  `Notes` varchar(500) NOT NULL,
  `Pet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feeding_schedule`
--

INSERT INTO `feeding_schedule` (`Schedule_id`, `Feeding_time`, `Food_type`, `Notes`, `Pet_id`) VALUES
(13, '07:30:00', 'Wet Dog Food', 'Add vitamins if needed', 5),
(14, '09:00:00', 'Wet Cat Food', 'Keep fresh water available', 7),
(15, '18:00:00', 'Wet Dog Food', 'Add vitamins if needed\r\n\r\n', 8),
(16, '07:00:00', 'Dry Dog Food', 'Add a teaspoon of fish oil\r\n\r\n', 9),
(17, '18:30:00', 'Wet Dog Food', 'Monitor portion size\r\n\r\n', 11),
(18, '18:30:00', 'Wet Cat Food', 'Keep food area clean\r\n\r\n', 12),
(19, '07:30:00', 'Wet Dog Food', 'Add vitamins if needed', 13),
(20, '10:30:00', 'Wet Dog Food', 'Add a teaspoon of fish oil\r\n\r\n', 14),
(21, '14:00:00', 'Dry Dog Food', 'Mix with a bit of wet food once a week', 15),
(22, '08:30:00', 'Cat Kibble', 'Keep fresh water available', 16),
(23, '17:00:00', 'Wet Cat Food', 'Avoid overfeeding\r\n\r\n', 17),
(24, '08:00:00', 'Dry Dog Food', 'Mix with a bit of wet food once a week\r\n\r\n', 18),
(25, '09:00:00', 'Cat Kibble', 'Provide a scratching post nearby', 19);

-- --------------------------------------------------------

--
-- Table structure for table `medical_record`
--

CREATE TABLE `medical_record` (
  `Record_id` int(11) NOT NULL,
  `Treatment` varchar(300) NOT NULL,
  `Comment` varchar(300) NOT NULL,
  `Vet_name` varchar(200) NOT NULL,
  `Date` date NOT NULL,
  `Pet_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medical_record`
--

INSERT INTO `medical_record` (`Record_id`, `Treatment`, `Comment`, `Vet_name`, `Date`, `Pet_id`, `description`) VALUES
(1, '', '', '', '2025-09-02', 3, 'Routine wellness check – all vitals normal '),
(2, '', '', '', '2025-09-02', 5, 'Rabies vaccine administered.'),
(3, '', '', '', '2025-09-02', 5, 'Routine wellness check – all vitals normal '),
(4, '', '', '', '2025-09-01', 3, 'treated for mild ear infection; prescribed ear drops.'),
(5, '', '', '', '2025-08-31', 7, 'Dental cleaning performed; no issues detected'),
(6, '', '', '', '2025-08-07', 3, 'Spay surgery completed; stitches removed successfully.'),
(7, '', '', '', '2025-09-01', 9, 'Spay surgery completed; stitches removed successfully.'),
(8, '', '', '', '2025-08-30', 8, 'Behavioral assessment – mild anxiety noted; enrichment recommended.'),
(9, '', '', '', '2025-09-02', 11, 'Flea and tick prevention applied.'),
(10, '', '', '', '2025-09-01', 12, 'Spay surgery completed; stitches removed successfully.'),
(11, '', '', '', '2025-08-31', 13, 'Weight and diet assessed; recommended controlled diet.'),
(12, '', '', '', '2025-08-31', 14, 'Dental cleaning performed; no issues detected.'),
(13, '', '', '', '2025-08-25', 15, 'Gastrointestinal upset treated with medication.'),
(14, '', '', '', '2025-09-03', 16, 'Heartworm prevention administered.'),
(15, '', '', '', '2025-09-02', 17, 'Behavioral assessment – mild anxiety noted; enrichment recommended.'),
(16, '', '', '', '2025-08-31', 18, 'Rabies vaccine administered.'),
(17, '', '', '', '2025-09-01', 19, 'Treated for mild ear infection; prescribed ear drops.');

-- --------------------------------------------------------

--
-- Table structure for table `pet`
--

CREATE TABLE `pet` (
  `Pet_id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Breed` varchar(50) NOT NULL,
  `Age` int(11) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Adoption_status` varchar(20) NOT NULL,
  `User_id` int(11) DEFAULT NULL,
  `Image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pet`
--

INSERT INTO `pet` (`Pet_id`, `Name`, `Breed`, `Age`, `Gender`, `Adoption_status`, `User_id`, `Image_url`) VALUES
(2, 'Hunk', 'Labrador Retriever', 1, '', 'Adopted', 2, 'images/Hunk.jpg'),
(3, 'Bella ', 'Ragdoll Cat', 2, '', 'Adopted', 2, 'images/Bella.jpeg'),
(4, 'Leo', 'Beagle', 1, '', 'Adopted', 4, 'images/leo.jpg'),
(5, 'Tommy', 'German Shepherd', 2, '', 'Adopted', 2, 'images/bella.jpg'),
(6, 'Lucy', 'Labrador Retriever', 1, '', 'Adopted', 2, 'images/lucy.jpg'),
(7, 'Luna', 'Siamese Cat', 1, '', 'Available', NULL, 'images/Milo.jpg'),
(8, 'Milo', 'German Shepherd', 2, '', 'Available', NULL, 'images/Daisy.jpg'),
(9, 'Max', 'Labrador Retriever', 3, '', 'Available', NULL, 'images/max.jpg'),
(11, 'Buddy', 'Golden Retriever', 3, '', 'Available', NULL, 'images/buddy.jpg'),
(12, 'Mittens', 'Persian Cat', 2, '', 'Available', NULL, 'images/mittens.jpg'),
(13, 'Ricky', 'German Shepherd', 4, '', 'Available', NULL, 'images/ricky.jpg'),
(14, 'Milo', 'Pug', 1, '', 'Available', NULL, 'images/Milo.jpeg'),
(15, 'Nala', 'Shiba Inu', 3, '', 'Available', NULL, 'images/Nala.jpg'),
(16, 'Biscuit', 'Pomeranian', 2, '', 'Available', NULL, 'images/Biscuit.jpeg'),
(17, 'Oreo', 'British Shorthair Cat', 2, '', 'Available', NULL, 'images/Oreo.jpg'),
(18, 'Baxter', 'Pembroke Welsh Corgi', 3, '', 'Available', NULL, 'images/Baxter.jpg'),
(19, 'Simba', 'Maine Coon', 3, '', 'Available', NULL, 'images/Simba.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `User_id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Street` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Post_code` varchar(20) NOT NULL,
  `Password_hash` varchar(255) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`User_id`, `Name`, `Email`, `Phone`, `Street`, `City`, `Post_code`, `Password_hash`, `admin`) VALUES
(1, 'Abrar Ahmed', 'abrar@gmail.com', '', '', '', '', 'scrypt:32768:8:1$bKsDkeMYCyh8Ngpa$806fffbeab3a5dc69c2754417f6d2cb1aeffb3db4c1164d00ed6b832c6b8f1c38b6dec9b4db76d1139ed9fe44531f074c5e339240ad07cd5b48a31a7c69f03f2', 1),
(2, 'Fahad khan', 'fahad@gmail.com', '', '', '', '', 'scrypt:32768:8:1$AcYEZb9JhLlOYpnu$11fdcb9574a478aaaec2c7847dd59697d59a8d57acd95a061cf13438f3b193275bc9321f581a289bf7119935ef9243f04a7901eb784b61369cdd656e8fb882c0', 0),
(3, 'User1', 'fahad1@gmail.com', '', '', '', '', 'scrypt:32768:8:1$UnF9BGvOW4Ez6yVk$a84c2f74174d4f286cfb2296d441b03da733537224307211965fb70b1893229ce7c6237b183ff8b1712af48589a1402e5ab7a9e385adf43a48e690eef77e3377', 0),
(4, 'Ayman Ahmed', 'ayman@gmail.com', '', '', '', '', 'scrypt:32768:8:1$Cv4zXXL13aDz84lf$033282634a747682fa16e3029850e84f79d259213c4f2197c49b2ccd59716083c8fd8fe1850d7c2b50cdabbd853a247f30328b71282c5eed269da4c25c81569c', 0),
(5, 'Hridoy', 'hridoy@gmail.com', '', '', '', '', 'scrypt:32768:8:1$yR6miDQCWcLGvHEJ$64d485686b650471a3181a5351e0a351daa46af2bb266934da2b6e9e96179fad64aa8b29b429809fb42afe8ade09260cf30fcf483e548d95591bf0a93fbc97f0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `us_registers_for_event`
--

CREATE TABLE `us_registers_for_event` (
  `User_id` int(11) NOT NULL,
  `Event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `us_registers_for_event`
--

INSERT INTO `us_registers_for_event` (`User_id`, `Event_id`) VALUES
(1, 2),
(1, 4),
(2, 1),
(2, 4),
(2, 15),
(4, 1),
(4, 15),
(5, 1),
(5, 14),
(5, 15);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`User_id`);

--
-- Indexes for table `adopter`
--
ALTER TABLE `adopter`
  ADD PRIMARY KEY (`User_id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`Event-id`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`Event_id`,`Pet_id`),
  ADD KEY `fk_feature_pet` (`Pet_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `fk_feedback_user` (`User_id`);

--
-- Indexes for table `feeding_schedule`
--
ALTER TABLE `feeding_schedule`
  ADD PRIMARY KEY (`Schedule_id`),
  ADD KEY `fk_feeding_pet` (`Pet_id`);

--
-- Indexes for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD PRIMARY KEY (`Record_id`),
  ADD KEY `fk_medical_pet` (`Pet_id`);

--
-- Indexes for table `pet`
--
ALTER TABLE `pet`
  ADD PRIMARY KEY (`Pet_id`),
  ADD KEY `fk_pet_adopt` (`User_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`User_id`);

--
-- Indexes for table `us_registers_for_event`
--
ALTER TABLE `us_registers_for_event`
  ADD PRIMARY KEY (`User_id`,`Event_id`),
  ADD KEY `fk_register_event` (`Event_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `Event-id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `feeding_schedule`
--
ALTER TABLE `feeding_schedule`
  MODIFY `Schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `medical_record`
--
ALTER TABLE `medical_record`
  MODIFY `Record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pet`
--
ALTER TABLE `pet`
  MODIFY `Pet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `User_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`);

--
-- Constraints for table `adopter`
--
ALTER TABLE `adopter`
  ADD CONSTRAINT `adopter_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`);

--
-- Constraints for table `features`
--
ALTER TABLE `features`
  ADD CONSTRAINT `fk_feature_event` FOREIGN KEY (`Event_id`) REFERENCES `event` (`Event-id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_feature_pet` FOREIGN KEY (`Pet_id`) REFERENCES `pet` (`Pet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `fk_feedback_user` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feeding_schedule`
--
ALTER TABLE `feeding_schedule`
  ADD CONSTRAINT `fk_feeding_pet` FOREIGN KEY (`Pet_id`) REFERENCES `pet` (`Pet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD CONSTRAINT `fk_medical_pet` FOREIGN KEY (`Pet_id`) REFERENCES `pet` (`Pet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pet`
--
ALTER TABLE `pet`
  ADD CONSTRAINT `fk_pet_adopt` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `us_registers_for_event`
--
ALTER TABLE `us_registers_for_event`
  ADD CONSTRAINT `fk_register_event` FOREIGN KEY (`Event_id`) REFERENCES `event` (`Event-id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_register_user` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
