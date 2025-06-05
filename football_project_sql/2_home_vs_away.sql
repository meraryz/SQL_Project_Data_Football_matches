/*
    Stats about the difference in permormance between home and away games.
*/

SELECT
    'home' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 0 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(home_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(home_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(home_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS ga_avg
FROM football_matches

UNION ALL

SELECT
    'away' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 1 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(away_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(away_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(away_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS ga_avg
FROM football_matches
