USE prairiespark;
GO

CREATE OR ALTER VIEW dbo.v_field_stability AS
SELECT
    field_id_anon,
    COUNT(*) AS years_of_data,
    AVG(CAST(yield_aw_year AS float)) AS avg_yield_aw,
    STDEV(CAST(yield_aw_year AS float)) AS stdev_yield_aw,
    CASE
        WHEN AVG(CAST(yield_aw_year AS float)) = 0 THEN NULL
        ELSE STDEV(CAST(yield_aw_year AS float)) / AVG(CAST(yield_aw_year AS float))
    END AS cv_yield_aw,
    SUM(CAST(acres_year AS float)) AS total_acres
FROM dbo.v_field_year_base
GROUP BY field_id_anon;
GO

