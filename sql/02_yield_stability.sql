USE prairiespark;
GO
SET NOCOUNT ON;

WITH fy AS (
    SELECT field_id_anon, [year], yield_aw_year
    FROM dbo.v_field_year_base
)
SELECT
    field_id_anon,
    COUNT(*) AS years_count,
    CAST(AVG(yield_aw_year) AS decimal(18,10)) AS avg_yield,
    CAST(STDEV(yield_aw_year) AS decimal(18,10)) AS stdev_yield,
    CAST(
        STDEV(yield_aw_year) / NULLIF(AVG(yield_aw_year),0)
        AS decimal(18,10)
    ) AS cv,

    -- Trend slope (bu/ac per year) using regression slope formula
    CAST(
        (
            COUNT(*) * SUM(CAST([year] AS decimal(18,10)) * yield_aw_year)
            - SUM(CAST([year] AS decimal(18,10))) * SUM(yield_aw_year)
        )
        / NULLIF(
            COUNT(*) * SUM(CAST([year] AS decimal(18,10)) * CAST([year] AS decimal(18,10)))
            - SUM(CAST([year] AS decimal(18,10))) * SUM(CAST([year] AS decimal(18,10))),
            0
        )
        AS decimal(18,10)
    ) AS yield_trend_slope_bu_per_year
FROM fy
GROUP BY field_id_anon
HAVING COUNT(*) >= 3
ORDER BY cv ASC;  -- most stable first
