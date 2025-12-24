USE zomato;
-- 3. Convert the Average cost for 2 column into USD dollars (currently the Average cost for 2 in local currencies
SELECT 
    RestaurantID,
    RestaurantName,
    CountryCode,
    City,
    Address,
    Locality,
    LocalityVerbose,
    Longitude,
    Latitude,
    Cuisines,
    Currency,
    Has_Table_booking,
    Has_Online_delivery,
    Is_delivering_now,
    Switch_to_order_menu,
    Price_range,
    Votes,
    Average_Cost_for_two,
    Rating,
    Year_Opening,
    Month_Opening,
    Day_Opening,

    -- 4. Converted cost in USD
    ROUND(
        Average_Cost_for_two / CASE
            WHEN Currency LIKE '%Pula%' THEN 13.5         -- Botswana Pula (BWP)
            WHEN Currency LIKE '%R$%' THEN 5.0            -- Brazilian Real (BRL)
            WHEN Currency = '$' THEN 1                    -- US Dollar (assumed already USD)
            WHEN Currency LIKE '%Diram%' OR Currency LIKE '%AED%' THEN 3.67 -- Emirati Dirham
            WHEN Currency LIKE '%Rs.%' THEN 83.0          -- Indian Rupees
            WHEN Currency LIKE '%IDR%' THEN 16000.0       -- Indonesian Rupiah
            WHEN Currency LIKE '%NewZealand%' OR Currency = '$' THEN 1.66 -- NZD (New Zealand Dollar)
            WHEN Currency LIKE '%Pounds%' OR Currency LIKE '%Œ£%' THEN 0.78 -- British Pounds
            WHEN Currency LIKE '%Qatari%' OR Currency LIKE '%QR%' THEN 3.64 -- Qatari Rial
            WHEN Currency LIKE '%Rand%' OR Currency = 'R' THEN 18.0         -- South African Rand
            WHEN Currency LIKE '%LKR%' THEN 300.0        -- Sri Lankan Rupee
            WHEN Currency LIKE '%Lira%' OR Currency LIKE '%TL%' THEN 33.0 -- Turkish Lira
            ELSE 1 -- fallback
        END,
    2) AS Average_Cost_USD

FROM restaurants;

-- 4 Find the Numbers of Resturants based on City and Country
SELECT 
    CountryCode,
    City,
    COUNT(*) AS Number_of_Restaurants
FROM restaurants
GROUP BY CountryCode, City
ORDER BY CountryCode, Number_of_Restaurants DESC;


SELECT DISTINCT Currency
FROM restaurants
WHERE Currency IS NOT NULL
ORDER BY Currency;


-- 5. Numbers of Resturants opening based on Year , Quarter , Month
SELECT
  Year_Opening AS Year,
  
  CONCAT('Q', 
    CASE 
      WHEN Month_Opening BETWEEN 1 AND 3 THEN 1
      WHEN Month_Opening BETWEEN 4 AND 6 THEN 2
      WHEN Month_Opening BETWEEN 7 AND 9 THEN 3
      WHEN Month_Opening BETWEEN 10 AND 12 THEN 4
      ELSE NULL
    END
  ) AS Quarter,
  
  Month_Opening AS Month_Number,

  MONTHNAME( MAKEDATE(2000, 1) + INTERVAL (Month_Opening - 1) MONTH ) AS Month_Name,

  COUNT(*) AS Number_of_Restaurants

FROM restaurants
WHERE Year_Opening IS NOT NULL AND Month_Opening IS NOT NULL
GROUP BY Year_Opening, Quarter, Month_Opening
ORDER BY Year_Opening, Month_Opening;

-- 6. Count of Resturants based on Average Ratings

SELECT
  Rating AS Average_Rating,
  COUNT(*) AS Number_of_Restaurants
FROM restaurants
WHERE Rating IS NOT NULL
GROUP BY Rating
ORDER BY Rating DESC;

-- 7. Create a bucket based on Average price of reasonable size and find out how many restaurants falls in each buckets--

SELECT 
    CASE 
        WHEN Average_Cost_for_two <= 500 THEN '0-500'
        WHEN Average_Cost_for_two <= 1000 THEN '501-1000'
        WHEN Average_Cost_for_two <= 2000 THEN '1001-2000'
        WHEN Average_Cost_for_two <= 4000 THEN '2001-4000'
        ELSE '4000+'
    END AS Price_Bucket,
    COUNT(*) AS Restaurant_Count
FROM Main
GROUP BY 
    CASE 
        WHEN Average_Cost_for_two <= 500 THEN '0-500'
        WHEN Average_Cost_for_two <= 1000 THEN '501-1000'
        WHEN Average_Cost_for_two <= 2000 THEN '1001-2000'
        WHEN Average_Cost_for_two <= 4000 THEN '2001-4000'
        ELSE '4000+'
    END
ORDER BY Restaurant_Count DESC;

-- 8. percentage of restaurants based on "Has_table_bookings"

SELECT 
    Has_Table_Bookings,
    COUNT(*) AS Number_of_Restaurants,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurants)), 2) AS Percentage_of_Restaurants
FROM restaurants
GROUP BY Has_Table_Bookings;


-- 9. percentage of restaurant based on "Has_Online_Delivery--

SELECT 
    Has_Online_Delivery,
    COUNT(*) AS Number_of_Restaurants,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurants)), 2) AS Percentage_of_Restaurants
FROM restaurants
GROUP BY Has_Online_Delivery;









