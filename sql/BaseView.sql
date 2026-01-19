USE prairiespark;
GO

CREATE OR ALTER VIEW dbo.v_field_year_base AS
WITH by_crop AS (
    SELECT
        field_id_anon,
        [year],
        crop,
        SUM(CAST(area_acres AS decimal(18,10))) AS acres_crop,
        SUM(CAST(total_bu   AS decimal(18,10))) AS bu_crop
    FROM dbo.public_field_year
    GROUP BY field_id_anon, [year], crop
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY field_id_anon, [year]
            ORDER BY acres_crop DESC, bu_crop DESC
        ) AS rn
    FROM by_crop
),
field_year AS (
    SELECT
        field_id_anon,
        [year],
        SUM(acres_crop) AS acres_year,
        SUM(bu_crop)    AS bu_year,
        CAST(SUM(bu_crop) / NULLIF(SUM(acres_crop),0) AS decimal(18,10)) AS yield_aw_year
    FROM by_crop
    GROUP BY field_id_anon, [year]
),
dominant AS (
    SELECT
        field_id_anon,
        [year],
        crop AS dominant_crop,
        acres_crop AS dominant_acres
    FROM ranked
    WHERE rn = 1
)
SELECT
    fy.field_id_anon,
    fy.[year],
    d.dominant_crop AS crop,
    fy.acres_year,
    fy.bu_year,
    fy.yield_aw_year,
    d.dominant_acres
FROM field_year fy
JOIN dominant d
  ON fy.field_id_anon = d.field_id_anon
 AND fy.[year]       = d.[year];
GO
