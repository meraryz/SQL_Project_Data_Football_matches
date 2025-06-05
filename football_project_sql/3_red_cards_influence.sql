
/*
    Stats about the difference in permormance When 1 red card or more are given.
*/
SELECT
    'home with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE home_red_cards > 0

UNION ALL

SELECT
    'away with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE away_red_cards > 0
   

   