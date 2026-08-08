# Effects of Mixed-Wood Biochar on Fertilizer Use Efficiency and Growth Performance of Okra

## Project Overview

This repository contains the data-analysis workflow, statistical outputs, visualizations, and supporting materials for a pot experiment investigating the effects of mixed-wood biochar application on the growth, yield-related characteristics, and nutrient status of okra (*Abelmoschus esculentus* L.).

The project was developed to evaluate whether increasing biochar application rates influence plant growth, biomass production, yield components, and plant/grain nutrient concentrations under a common fertilizer regime.

> **Research status:** This work is currently unpublished. The repository is intended to document the experimental analysis workflow and research outputs.

---

## Research Objective

The study aimed to evaluate the effects of different mixed-wood biochar application rates on:

- Plant growth and biomass
- Pod production and yield-related traits
- Root and shoot development
- Nutrient concentrations
- Estimated nutrient uptake
- Overall fertilizer-use efficiency and crop performance

---

## Experimental Design

The experiment followed a **Completely Randomized Design (CRD)**.

- **Treatments:** 5
- **Replications:** 3 per treatment
- **Total experimental units:** 15
- **Design:** Completely Randomized Design (CRD)

Each treatment was represented by three independent experimental units.

### Treatment Plan

| Treatment | Biochar application |
|-----------|---------------------|
| T0 | Control – no biochar |
| T1 | 5 t/ha biochar |
| T2 | 10 t/ha biochar |
| T3 | 15 t/ha biochar |
| T4 | 20 t/ha biochar |

The experimental treatments were evaluated under the same fertilizer regime.

---

## Variables Analyzed

### Growth and Biomass

- Plant height (cm)
- Shoot fresh weight (g)
- Shoot dry weight (g)
- Root fresh weight (g)
- Root dry weight (g)

### Yield and Yield Components

- Pod fresh weight (g)
- Pod dry weight (g)
- Pods per plant
- Grains per pod
- Pod length (cm)

### Nutrient Variables

- Plant N (%)
- Plant P (%)
- Plant K (%)
- Grain N (%)
- Grain P (%)
- Grain K (%)

### Nutrient Uptake

Estimated N, P, and K uptake were also summarized and statistically evaluated using biomass and nutrient concentration data.

---

## Statistical Analysis

Statistical analyses were conducted in **R**.

For each response variable, treatment effects were evaluated using one-way ANOVA appropriate for the completely randomized design:

```text
Response ~ Treatment
