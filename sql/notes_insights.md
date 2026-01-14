# Insights (Field Performance, Stability, Rotation)

## Field performance (`01_field_summary.sql`)

### Which fields carry the farm (highest bushel leverage)?
- **F001 is the production anchor:** **70,947 bu** over **1,402 ac** across **6 years**. What happens on F001 noticeably swings whole-farm results.
- Next tier “heavy lifters” by total bushels (big acres, multi-year):
  - **F013:** ~**36,045 bu** (920 ac, 6 yrs)
  - **F034:** ~**35,460 bu** (974 ac, 6 yrs)
  - **F033:** ~**32,700 bu** (750 ac, 5 yrs)
  - **F024:** ~**31,950 bu** (900 ac, 6 yrs)

**Takeaway:** Don’t chase only the highest average yield—prioritize fields where a small lift moves the most **total bushels** (big acres × repeated years).

---

## Stability (`02_yield_stability.sql`)

### 1) Most consistent fields (lowest CV = easiest to trust)
- **F032:** CV **0.10** (very steady) but trend **−2.7 bu/ac/yr** (slipping)
- **F017:** CV **0.16** but trend **−2.9** (slipping)
- **F011:** CV **0.19** and **flat trend (~0)** → steady baseline
- **F024:** CV **0.23** with **slight + trend (+0.37)**

**Use these for:** side-by-side trials (variety / N / rate changes) because noise is lower.

### 2) Most volatile fields (highest CV = biggest risk / biggest upside)
- **F023:** CV **0.59** (wild swings) despite **+4.2** trend
- **F036:** CV **0.52**
- **F019:** CV **0.49**
- **F007:** CV **0.46**

**Use these for:** risk-tiered inputs (don’t over-invest every year), zone management, and moisture-driven decisions.

### 3) Fields improving fast (positive slope)
- **F016:** **+7.5 bu/ac/yr** (CV **0.39** = still volatile)
- **F040 / F014:** **+6.5** (CV **0.30**)
- **F019:** **+4.64** (CV **0.49**)
- **F007 / F025 / F023:** ~**+4.1 to +4.2** (high volatility)

**Meaning:** gains are real, but many are **not reliable year-to-year** yet.

### 4) Fields trending down (priority to diagnose)
- **F006:** **−7.5 bu/ac/yr** (big red flag)
- **F017:** **−2.86**
- **F032:** **−2.69**
- **F033:** **−0.77**
- **F005:** **−0.33** (mild)

**Meaning:** these are “stop the bleed” fields—check drainage, compaction, salinity patches, rotation effects, fertility strategy, or field splits.

---

## Rotation (`03_crop_rotation_perf.sql`)

### 1) Best-performing “what you seeded after what” (area-weighted yield)
Ranked by `aw_avg_yield_when_following`:
- **Canola → Barley:** ~**51.38** (2,629 ac, 15 pairs)
- **Barley → Barley:** ~**51.04** (1,092 ac, 9 pairs)
- **Oats → Oats:** ~**50.85** (978 ac, 8 pairs)
- **Wheat → Barley:** ~**45.85** (347 ac, 4 pairs)
- **Barley → Oats:** ~**43.57** (414 ac, 3 pairs)
- **Canola → Canola:** ~**42.32** (276 ac, 3 pairs)
- **Canola → Wheat:** ~**41.97** (1,987 ac, 15 pairs)
- **Canola → Oats:** ~**41.19** (284 ac, 2 pairs)

**Takeaway:** In this dataset, **Barley after Canola** and **Barley after Barley** are the strongest average outcomes.

### 2) Red-flag sequences (lowest yield when following)
- **Barley → Canola:** ~**27.47** (1,655 ac, 13 pairs) ✅ strongest “avoid or manage harder”
- **Wheat → Canola:** ~**32.29** (2,213 ac, 16 pairs)
- **Oats → Canola:** ~**32.93** (417 ac, 3 pairs)

**Agronomy takeaway:** Canola following cereals (especially barley) is where yield is getting hit—possible drivers include residue/moisture use, disease carryover, timing, or N strategy mismatch.

---

## Next actions

### Which 3 fields deserve investigation?
1) **F001** — biggest bushel driver + big swings. If improving one field first, start here.  
2) **F006** — worst trend (**−7.5 bu/ac/yr**) = “stop the bleed.”  
3) **F023** — most volatile (**CV ~0.59**) = strong candidate for risk-tiering + zones.

### Which rotation patterns look promising?
Promising = **high yield + decent sample size**:
- **Canola → Barley:** ~**51.4** (15 pairs, 2,629 ac) ✅ best + most reliable
- **Barley → Barley:** ~**51.0** (9 pairs, 1,092 ac) ✅ strong
- **Oats → Oats:** ~**50.8** (8 pairs, 978 ac) ✅ strong
- **Wheat → Barley:** ~**45.8** (4 pairs, 347 ac) (interesting, smaller sample)

**Manage cautiously:**
- **Barley → Canola:** ~**27.5** (13 pairs, 1,655 ac) = consistent underperformer in this dataset.
