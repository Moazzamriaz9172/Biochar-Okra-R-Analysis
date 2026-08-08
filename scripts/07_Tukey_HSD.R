
# ============================================================
# 07_Tukey_HSD.R
# CRD Tukey HSD / emmeans Analysis
# ============================================================

library(tidyverse)
library(emmeans)
library(multcomp)
library(multcompView)

# ------------------------------------------------------------
# Load master dataset
# ------------------------------------------------------------

if (!exists("master_data")) {
  master_data <- read_csv(
    "data/processed/master_data.csv",
    show_col_types = FALSE
  )
}

master_data <- master_data %>%
  mutate(
    treatment = factor(
      treatment,
      levels = c("T0", "T1", "T2", "T3", "T4")
    )
  )

# ------------------------------------------------------------
# Response variables
# ------------------------------------------------------------

response_variables <- c(
  "plant_height_cm",
  "shoot_dry_weight_g",
  "shoot_fresh_weight_g",
  "root_fresh_weight_g",
  "root_dry_weight_g",
  "pod_fresh_weight_g",
  "pod_dry_weight_g",
  "pods_per_plant",
  "grains_per_pod",
  "pod_length_cm",
  "grain_k_pct",
  "plant_k_pct",
  "plant_n_pct",
  "grain_n_pct",
  "plant_p_pct",
  "grain_p_pct"
)

# ------------------------------------------------------------
# Function for estimated marginal means
# ------------------------------------------------------------

run_emmeans <- function(variable) {

  formula_model <- as.formula(
    paste(variable, "~ treatment")
  )

  model <- aov(
    formula_model,
    data = master_data
  )

  emm <- emmeans(
    model,
    ~ treatment
  )

  as.data.frame(emm) %>%
    mutate(
      Response = variable
    ) %>%
    select(
      Response,
      treatment,
      emmean,
      SE,
      df,
      lower.CL,
      upper.CL
    )
}

# ------------------------------------------------------------
# Function for Tukey pairwise comparisons
# ------------------------------------------------------------

run_tukey <- function(variable) {

  formula_model <- as.formula(
    paste(variable, "~ treatment")
  )

  model <- aov(
    formula_model,
    data = master_data
  )

  emm <- emmeans(
    model,
    ~ treatment
  )

  pairs(emm, adjust = "tukey") %>%
    as.data.frame() %>%
    mutate(
      Response = variable
    ) %>%
    select(
      Response,
      contrast,
      estimate,
      SE,
      df,
      t.ratio,
      p.value
    )
}

# ------------------------------------------------------------
# Function for compact letter display
# ------------------------------------------------------------

run_cld <- function(variable) {

  formula_model <- as.formula(
    paste(variable, "~ treatment")
  )

  model <- aov(
    formula_model,
    data = master_data
  )

  emm <- emmeans(
    model,
    ~ treatment
  )

  cld(emm, adjust = "tukey", Letters = letters) %>%
    as.data.frame() %>%
    mutate(
      Response = variable
    ) %>%
    select(
      Response,
      treatment,
      emmean,
      SE,
      df,
      lower.CL,
      upper.CL,
      .group
    )
}

# ------------------------------------------------------------
# Run all analyses
# ------------------------------------------------------------

emmeans_results <- map_dfr(
  response_variables,
  run_emmeans
)

tukey_results <- map_dfr(
  response_variables,
  run_tukey
)

cld_results <- map_dfr(
  response_variables,
  run_cld
)

# ------------------------------------------------------------
# Create output directories
# ------------------------------------------------------------

dir.create(
  "outputs/CSV files",
  recursive = TRUE,
  showWarnings = FALSE
)

dir.create(
  "outputs/tables",
  recursive = TRUE,
  showWarnings = FALSE
)

# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

write_csv(
  emmeans_results,
  "outputs/CSV files/estimated_marginal_means.csv"
)

write_csv(
  tukey_results,
  "outputs/CSV files/tukey_pairwise_results.csv"
)

write_csv(
  cld_results,
  "outputs/CSV files/cld_results.csv"
)

write_csv(
  emmeans_results,
  "outputs/tables/estimated_marginal_means.csv"
)

write_csv(
  tukey_results,
  "outputs/tables/tukey_comparisons_final.csv"
)

write_csv(
  cld_results,
  "outputs/tables/cld_results.csv"
)

cat("\n========================================\n")
cat("CRD TUKEY / EMMEANS ANALYSIS COMPLETED\n")
cat("========================================\n")
cat("Model: Response ~ treatment\n")
cat("Adjustment: Tukey\n")
cat("Treatments: T0, T1, T2, T3, T4\n")
cat("========================================\n")

