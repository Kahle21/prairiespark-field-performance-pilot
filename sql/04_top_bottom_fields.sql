USE prairiespark;
GO
SET NOCOUNT ON;

-- Top 10 yield
;WITH summary AS (
    SELECT
        field_id_anon,
        CAST(SUM(CAST(acres_year AS float)) AS decimal(18,10)) AS total_acres,
        CAST(SUM(CAST(bu_year    AS float)) / NULLIF(SUM(CAST(acres_year AS float)),0) AS decimal(18,10)) AS avg_yield_aw,
        CAST(STDEV(CAST(yield_aw_year AS float)) AS decimal(18,10)) AS stdev_yield,
        CAST(
            STDEV(CAST(yield_aw_year AS float)) / NULLIF(AVG(CAST(yield_aw_year AS float)),0)
            AS decimal(18,10)
        ) AS cv,
        COUNT(*) AS years_count
    FROM dbo.v_field_year_base
    GROUP BY field_id_anon
    HAVING COUNT(*) >= 3
)
SELECT TOP (10) *
FROM summary
ORDER BY avg_yield_aw DESC;

-- Bottom 10 yield
;WITH summary AS (
    SELECT
        field_id_anon,
        CAST(SUM(CAST(acres_year AS float)) AS decimal(18,10)) AS total_acres,
        CAST(SUM(CAST(bu_year    AS float)) / NULLIF(SUM(CAST(acres_year AS float)),0) AS decimal(18,10)) AS avg_yield_aw,
        CAST(STDEV(CAST(yield_aw_year AS float)) AS decimal(18,10)) AS stdev_yield,
        CAST(
            STDEV(CAST(yield_aw_year AS float)) / NULLIF(AVG(CAST(yield_aw_year AS float)),0)
            AS decimal(18,10)
        ) AS cv,
        COUNT(*) AS years_count
    FROM dbo.v_field_year_base
    GROUP BY field_id_anon
    HAVING COUNT(*) >= 3
)
SELECT TOP (10) *
FROM summary
ORDER BY avg_yield_aw ASC;

-- Top 10 stability (lowest CV)
;WITH summary AS (
    SELECT
        field_id_anon,
        CAST(SUM(CAST(acres_year AS float)) AS decimal(18,10)) AS total_acres,
        CAST(SUM(CAST(bu_year    AS float)) / NULLIF(SUM(CAST(acres_year AS float)),0) AS decimal(18,10)) AS avg_yield_aw,
        CAST(STDEV(CAST(yield_aw_year AS float)) AS decimal(18,10)) AS stdev_yield,
        CAST(
            STDEV(CAST(yield_aw_year AS float)) / NULLIF(AVG(CAST(yield_aw_year AS float)),0)
            AS decimal(18,10)
        ) AS cv,
        COUNT(*) AS years_count
    FROM dbo.v_field_year_base
    GROUP BY field_id_anon
    HAVING COUNT(*) >= 3
)
SELECT TOP (10) *
FROM summary
ORDER BY cv ASC;

-- Bottom 10 stability (highest CV)
;WITH summary AS (
    SELECT
        field_id_anon,
        CAST(SUM(CAST(acres_year AS float)) AS decimal(18,10)) AS total_acres,
        CAST(SUM(CAST(bu_year    AS float)) / NULLIF(SUM(CAST(acres_year AS float)),0) AS decimal(18,10)) AS avg_yield_aw,
        CAST(STDEV(CAST(yield_aw_year AS float)) AS decimal(18,10)) AS stdev_yield,
        CAST(
            STDEV(CAST(yield_aw_year AS float)) / NULLIF(AVG(CAST(yield_aw_year AS float)),0)
            AS decimal(18,10)
        ) AS cv,
        COUNT(*) AS years_count
    FROM dbo.v_field_year_base
    GROUP BY field_id_anon
    HAVING COUNT(*) >= 3
)
SELECT TOP (10) *
FROM summary
ORDER BY cv DESC;
