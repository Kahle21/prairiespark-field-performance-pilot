USE prairiespark;
GO

CREATE OR ALTER VIEW dbo.v_rotation_transition_detail AS
WITH fy AS (
    -- One row per field per year (dominant crop + totals)
    SELECT
        field_id_anon,
        [year],
        dominant_crop = crop,   -- from v_field_year_base (crop = dominant crop)
        acres_year,
        bu_year,
        yield_aw_year
    FROM dbo.v_field_year_base
),
lagged AS (
    SELECT
        field_id_anon,
        [year],
        curr_crop = dominant_crop,
        prev_crop = LAG(dominant_crop) OVER (
            PARTITION BY field_id_anon
            ORDER BY [year]
        ),
        acres_year,
        bu_year,
        yield_aw_year
    FROM fy
)
SELECT
    field_id_anon,
    curr_year = [year],
    prev_year = [year] - 1,
    prev_crop,
    curr_crop,
    rotation_label = CONCAT(prev_crop, ' -> ', curr_crop), -- use -> to avoid unicode issues
    acres_year,
    bu_year,
    yield_aw_year
FROM lagged
WHERE prev_crop IS NOT NULL;
GO
