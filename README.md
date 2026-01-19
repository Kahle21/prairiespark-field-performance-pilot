# PrairieSpark – Field Performance Pilot (2019–2024)

This project analyzes anonymized, real field-level yield data from a 3,500-acre Saskatchewan grain farm (2019–2024) to identify:
- Top/bottom performing fields (area-weighted yield)
- Yield stability / risk (CV volatility)
- Rotation effects (Previous crop → Current crop)
- Data driven recommendations

## Data
**File:** `data/public_field_year.csv`  
**Note:** Data is anonymized (Land Location IDs replaced with `F###`), but reflects real operational yield history.

### Key columns
- `field_id_anon` – anonymized field identifier
- `year`
- `crop` – current crop
- `prev_crop` – previous crop (for rotation analysis)
- `area_acres`, `total_bu`, `yield_bu_ac`
- `farm_year_avg_yield`, `yield_index`
- `field_split` – split label (A/B) when a field-year has multiple crops
- `field_unit_id` – unique key for field-year-crop split (ex: F005-2019-WHE-A)

## SQL
SQL scripts are in `/sql`.
A reusable view `dbo.v_field_year_base` creates a field-year rollup (handles multi-crop years and computes area-weighted yield).

## Power BI Dashboard
PBIX is in `/pbix`.

Key interactions:
- **Drill-through: Field → Field Details**  
  From the Stability/Risk visuals (or any field table), right-click a **Field ID** to open **Field Details (Page 4)** and view full historical performance for that field.
- **Drill-through: Rotation → Rotation Details**  
  From the Rotations page (heatmap/table), right-click a **Rotation Label** to open **Rotation Details (Page 5)** and view full historical results for that specific rotation.

Pages:
1. **Overview** – totals, avg yield by crop, field performance table
2. **Stability & Risk** – CV scatter + stability ranking + drill-through to Field Details
3. **Rotations** – rotation heatmap + best/worst combos + drill-through to Rotation Details
4. **Field Details** – full field history (all years), crop mix, yield trend, and supporting metrics
5. **Rotation Details** – rotation-specific history, transition counts, and performance breakdown
6. **Crop Mix & Revenue Leverage** – total acres vs 6-year area-weighted yield by dominant crop + ROI notes
7. **Field ROI Quadrant** – acres vs 6-year area-weighted yield by field (quadrants highlight “big acres + low yield” targets)


## Outputs
- `docs/Executive_Summary_Field_Performance.pdf`
- `docs/BRD_Field_Performance.pdf`

