USE prairiespark;
GO
SET NOCOUNT ON;

WITH field_crop_year AS (
    SELECT
        field_id_anon,
        [year],
        crop,
        SUM(CAST(area_acres AS decimal(18,10))) AS acres,
        SUM(CAST(total_bu   AS decimal(18,10))) AS bu,
        CAST(SUM(CAST(total_bu AS decimal(18,10))) / NULLIF(SUM(CAST(area_acres AS decimal(18,10))),0) AS decimal(18,10)) AS yield_aw
    FROM dbo.public_field_year
    GROUP BY field_id_anon, [year], crop
)
SELECT
    field_id_anon,
    crop,
    COUNT(DISTINCT [year]) AS years_count,
    SUM(acres) AS acres_sum,
    SUM(bu)    AS bu_sum,
    CAST(SUM(bu) / NULLIF(SUM(acres),0) AS decimal(18,10)) AS avg_yield_aw
FROM field_crop_year
GROUP BY field_id_anon, crop
ORDER BY field_id_anon, avg_yield_aw DESC;

USE prairiespark;
GO
SET NOCOUNT ON;

;WITH crop_year AS (
    SELECT
        field_id_anon,
        [year],
        crop,
        SUM(CAST(area_acres AS float)) AS acres,
        SUM(CAST(total_bu   AS float)) AS bu,
        SUM(CAST(total_bu   AS float)) / NULLIF(SUM(CAST(area_acres AS float)),0) AS yield_aw
    FROM dbo.public_field_year
    GROUP BY field_id_anon, [year], crop
),
dominant AS (
    SELECT
        field_id_anon,
        [year],
        crop AS dominant_crop
    FROM (
        SELECT
            field_id_anon,
            [year],
            crop,
            acres,
            ROW_NUMBER() OVER (
                PARTITION BY field_id_anon, [year]
                ORDER BY acres DESC, crop
            ) AS rn
        FROM crop_year
    ) d
    WHERE rn = 1
),
dom_yield AS (
    -- keep only dominant crop-years, and keep that crop-year yield
    SELECT
        cy.field_id_anon,
        cy.[year],
        d.dominant_crop AS crop,
        cy.acres,
        cy.yield_aw
    FROM crop_year cy
    JOIN dominant d
      ON d.field_id_anon = cy.field_id_anon
     AND d.[year]       = cy.[year]
     AND d.dominant_crop= cy.crop
),
with_prev AS (
    SELECT
        field_id_anon,
        [year],
        crop,
        acres,
        yield_aw,
        LAG(crop) OVER (PARTITION BY field_id_anon ORDER BY [year]) AS prev_crop
    FROM dom_yield
)
SELECT
    prev_crop,
    crop,
    COUNT(*) AS pair_count,
    SUM(acres) AS acres_following_sum,
    CAST( SUM(yield_aw * acres) / NULLIF(SUM(acres),0) AS decimal(18,10)) AS aw_avg_yield_when_following
FROM with_prev
WHERE prev_crop IS NOT NULL
GROUP BY prev_crop, crop
HAVING COUNT(*) >= 2          -- reliability gate
ORDER BY pair_count DESC, aw_avg_yield_when_following DESC;
GO

