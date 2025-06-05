
/*
    Stats about the difference in permormance in realtion with ball possession.
*/

WITH possession_data AS (
    SELECT
        'home' AS side,
        home_possession AS possession,
        result
    FROM football_matches
    UNION ALL
    SELECT
        'away' AS side,
        away_possession,
        result
    FROM football_matches
),
binned_data AS (
    SELECT
        side,
        result,
        CASE
            WHEN possession BETWEEN 20 AND 29.9 THEN '20-29.9%'
            WHEN possession BETWEEN 30 AND 39.9 THEN '30-39.9%'
            WHEN possession BETWEEN 40 AND 49.9 THEN '40-49.9%'
            WHEN possession BETWEEN 50 AND 59.9 THEN '50-59.9%'
            WHEN possession BETWEEN 60 AND 69.9 THEN '60-69.9%'
            WHEN possession BETWEEN 70 AND 79.9 THEN '70-79.9%'
        END AS possession_range
    FROM possession_data
    WHERE possession BETWEEN 20 AND 79.9
)
SELECT
    side,
    possession_range,
    ROUND(100.0 * COUNT(CASE WHEN (side = 'home' AND result = 0) OR (side = 'away' AND result = 1) THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN (side = 'home' AND result = 1) OR (side = 'away' AND result = 0) THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM binned_data
WHERE possession_range is NOT NULL
GROUP BY side, possession_range
ORDER BY side DESC, possession_range

