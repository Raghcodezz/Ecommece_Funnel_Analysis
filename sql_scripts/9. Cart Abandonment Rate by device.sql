-- =========================================================
-- Objective: Analyze cart abandonment distribution across
-- different device types
-- =========================================================

WITH cte AS (

    -- Step 1: Convert event-level data into session-level data
    SELECT 
        sessionid,
        devicetype,

        -- Get maximum number of items added to cart in a session
        MAX(itemsincart) AS itemsincart,

        -- Mark session as purchased if any event has purchased = 1
        MAX(purchased) AS purchased

    FROM ecommerce_journey
    GROUP BY sessionid, devicetype
),

abandoned AS (

    -- Step 2: Filter sessions where users added items to cart
    -- but did not complete the purchase (cart abandonment)
    SELECT *
    FROM cte 
    WHERE itemsincart > 0 
      AND purchased = 0
)

-- Step 3: Calculate percentage distribution of abandoned sessions by device
SELECT
    devicetype,

    -- Percentage = (abandoned sessions per device / total abandoned sessions) * 100
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage

FROM abandoned

-- Group results by device type
GROUP BY devicetype

-- Sort devices by highest share of abandonment
ORDER BY COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() DESC;
