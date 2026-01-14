USE prairiespark;
GO
SET NOCOUNT ON;

SELECT
    field_id_anon,
    MIN([year]) AS min_year,
    MAX([year]) AS max_year,
    COUNT(*)    AS years_count,

    SUM(acres_year) AS total_acres,
    SUM(bu_year)    AS total_bu,

    -- Area-weighted avg yield across years (best “true” average)
    CAST(SUM(bu_year) / NULLIF(SUM(acres_year),0) AS decimal(18,10)) AS avg_yield_aw,

    -- Simple avg of yearly yields (less ideal, but useful)
    CAST(AVG(yield_aw_year) AS decimal(18,10)) AS avg_yield_simple,

    MIN(yield_aw_year) AS min_year_yield,
    MAX(yield_aw_year) AS max_year_yield,

    -- How often a field was split in a year
    SUM(CASE WHEN crops_in_year > 1 THEN 1 ELSE 0 END) AS split_years_count
FROM dbo.v_field_year_base
GROUP BY field_id_anon
ORDER BY avg_yield_aw DESC;





