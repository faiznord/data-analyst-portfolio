
-- 1. Build a Data Model using the Sheets in the Excel File
CREATE DATABASE zomato;
USE zomato;
CREATE TABLE restaurants (
    RestaurantID INT,
    RestaurantName VARCHAR(255),
    CountryCode VARCHAR(10),
    City VARCHAR(100),
    Address TEXT,
    Locality VARCHAR(255),
    LocalityVerbose VARCHAR(255),
    Longitude DECIMAL(10,6),
    Latitude DECIMAL(10,6),
    Cuisines VARCHAR(255),
    Currency VARCHAR(50),
    Has_Table_booking VARCHAR(3),
    Has_Online_delivery VARCHAR(3),
    Is_delivering_now VARCHAR(3),
    Switch_to_order_menu VARCHAR(3),
    Price_range INT,
    Votes INT,
    Average_Cost_for_two DECIMAL(10,2),
    Rating DECIMAL(3,1),
    Year_Opening INT,
    Month_Opening INT,
    Day_Opening INT
);
SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ZomatoDataset_csv.csv'
INTO TABLE restaurants
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM restaurants;
SELECT COUNT(*) FROM restaurants;

SELECT DISTINCT Month_Opening FROM restaurants ORDER BY Month_Opening;





