SELECT
    *,
    round(
        (active_users - last_month_users) / last_month_users * 100,
        2
    ) AS percentage_change
FROM
    user_activity;