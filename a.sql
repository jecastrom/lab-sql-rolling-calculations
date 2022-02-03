WITH last_month_act_users AS (
    SELECT
        date_format(rental_date, '%M') AS `month`,
        date_format(rental_date, '%Y') AS `year`,
        count(customer_id) AS active_users
    FROM
        rental
    GROUP BY
        `month`,
        `year`
)
SELECT
    *,
    lag (active_users) over () AS last_month_act_users
FROM
    last_month_act_users;