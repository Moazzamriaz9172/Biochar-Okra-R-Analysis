# Effects of Mixed-Wood Biochar on Fertilizer Use Efficiency and Growth Performance of Okra

![Research](https://img.shields.io/badge/Research-Soil%20Science-4CAF50)
![R](https://img.shields.io/badge/R-Statistical%20Analysis-276DC3)
![Agriculture](https://img.shields.io/badge/Agriculture-Okra-8BC34A)
![Design](https://img.shields.io/badge/Design-CRD-orange)

## Overview

This repository contains the complete data analysis workflow for a pot experiment investigating the effects of mixed-wood biochar application on the growth, yield, and nutrient uptake of okra (*Abelmoschus esculentus* L.).

The project was developed as an end-to-end research data analysis workflow, covering data preparation, validation, exploratory analysis, statistical testing, visualization, and generation of final analytical outputs.

The main objective was to evaluate whether different biochar application rates influence plant growth, yield-related traits, and plant nutrient status under a standardized NPK fertilizer regime.

---

## Research Question

How do different rates of mixed-wood biochar affect the growth, yield components, biomass production, and nutrient uptake of okra?

---

## Experimental Design

A pot experiment was conducted using a **Completely Randomized Design (CRD)** with five biochar treatments and three replications per treatment.

### Biochar Treatments

| Treatment | Biochar application rate |
|---|---:|
| T0 | 0 t/ha (Control) |
| T1 | 5 t/ha |
| T2 | 10 t/ha |
| T3 | 15 t/ha |
| T4 | 20 t/ha |

The corresponding biochar quantities applied per pot were:

| Treatment | Biochar per pot |
|---|---:|
| T0 | 0 g |
| T1 | 62.5 g |
| T2 | 121.5 g |
| T3 | 187 g |
| T4 | 250 g |

Each treatment had three replications.

### Fertilizer Application

All treatments received NPK fertilizer under the experimental fertilizer regime:

- DAP: 0.95 g/pot
- Urea: 0.33 g/pot
- SOP: 0.625 g/pot
- Additional NPK booster dose: 0.5 g/pot

---

## Variables Evaluated

The experiment included measurements covering plant growth, biomass, yield components, and nutrient status.

### Growth and Biomass

- Plant height (cm)
- Shoot fresh weight (g)
- Shoot dry weight (g)
- Root fresh weight (g)
- Root dry weight (g)

### Yield Components

- Pod fresh weight (g)
- Pod dry weight (g)
- Pod length (cm)
- Pods per plant
- Grains per pod

### Nutrient Status

Plant and grain nutrient concentrations were evaluated for:

- Nitrogen (N)
- Phosphorus (P)
- Potassium (K)

Nutrient uptake was additionally summarized for:

- N uptake (mg)
- P uptake (mg)
- K uptake (mg)

---

## Statistical Analysis

The analysis workflow was developed in **R**.

The repository includes:

1. Data import
2. Data validation
3. Master dataset preparation
4. Exploratory data analysis
5. Statistical assumption testing
6. One-way ANOVA
7. Tukey HSD post-hoc comparisons
8. Treatment mean and standard-error summaries
9. Nutrient uptake analysis
10. Final statistical outputs
11. Research-oriented visualization

### Statistical Methods

- Descriptive statistics
- Analysis of Variance (ANOVA)
- Tukey's HSD multiple-comparison test
- Estimated marginal means
- Compact letter displays
- Assumption diagnostics
- Standardized response visualization

Statistical significance was evaluated using the conventional significance threshold of **p < 0.05**.

---

## Analysis Workflow

The R scripts are organized sequentially so that the analysis can be reproduced from the source data.

```text
01_import_data.R
        ↓
02_validate_data.R
        ↓
03_create_master_dataset.R
        ↓
04_exploratory_analysis.R
        ↓
05_assumptions_tests.R
        ↓
06_anova_in_r.R
        ↓
07_Tukey_HSD.R
        ↓
08_Visualization.R
        ↓
09_final_analysis_outputs.R
        ↓
10_analysis_results.R
