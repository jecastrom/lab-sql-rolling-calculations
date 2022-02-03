SELECT
    count(customer_id) number_users_retained,
    `month`,
    `year`
FROM
    (
        SELECT
            *
        FROM
            (
                SELECT
                    c.customer_id,
                    MONTH(r.rental_date) `month`,
                    year(r.rental_date) `year`,
                    c.`active` `active`,
                    lag(c.active, 1) over (
                        PARTITION by c.customer_id
                        ORDER BY
                            year(r.rental_date),
                            MONTH(r.rental_date)
                    ) AS active_last_month,
                    CASE
                        WHEN c.active = 1
                        AND lag(c.active, 1) over (
                            PARTITION by c.customer_id
                            ORDER BY
                                year(r.rental_date) = 1,
                                MONTH(r.rental_date)
                        ) THEN 1
                        ELSE 0
                    END AS customer_retention
                FROM
                    customer c
                    INNER JOIN rental r ON c.customer_id = r.customer_id
            ) AS t
        WHERE
            customer_retention = 1
    ) AS t
GROUP BY
    3,
    2;