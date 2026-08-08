
# ============================================================
# 06_anova_in_r.R
# CRD ANOVA — Mixed Wood Biochar Effects on Okra
# ============================================================
#
# Experimental design:
# Completely Randomized Design (CRD)
# 5 treatments × 3 replications = 15 experimental units
#
# Statistical model:
# Response ~ treatment
#
# IMPORTANT:
# Replication is an identifier for the three experimental
# units within each treatment. It is NOT included as a
# blocking factor because the experiment was conducted as CRD.
# ============================================================

library(tidyverse)
library(car)
library(broom)

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
# CRD ANOVA function
# ------------------------------------------------------------

run_anova <- function(variable) {

  formula_model <- as.formula(
    paste(variable, "~ treatment")
  )

  model <- aov(
    formula_model,
    data = master_data
  )

  result <- broom::tidy(model) %>%
    filter(term == "treatment") %>%
    mutate(
      Response = variable
    ) %>%
    select(
      Response,
      df,
      sumsq,
      meansq,
      statistic,
      p.value
    )

  result
}

# ------------------------------------------------------------
# Run ANOVA for all responses
# ------------------------------------------------------------

anova_results <- map_dfr(
  response_variables,
  run_anova
)

# ------------------------------------------------------------
# Add significance labels
# ------------------------------------------------------------

anova_results <- anova_results %>%
  mutate(
    Significance = case_when(
      p.value < 0.001 ~ "***",
      p.value < 0.01  ~ "**",
      p.value < 0.05  ~ "*",
      p.value < 0.10  ~ ".",
      TRUE ~ "ns"
    )
  )

# ------------------------------------------------------------
# Save ANOVA results
# ------------------------------------------------------------

dir.create(
  "outputs/CSV files",
  recursive = TRUE,
  showWarnings = FALSE
)

write_csv(
  anova_results,
  "outputs/CSV files/anova_results.csv"
)

# Also save the main output location used by the repository
write_csv(
  anova_results,
  "outputs/anova_results.csv"
)

# ------------------------------------------------------------
# Display results
# ------------------------------------------------------------

cat("\n========================================\n")
cat("CRD ANOVA ANALYSIS COMPLETED\n")
cat("========================================\n")
cat("Design: Completely Randomized Design\n")
cat("Treatments:", nlevels(master_data$treatment), "\n")
cat("Replications per treatment: 3\n")
cat("Experimental units:", nrow(master_data), "\n")
cat("Model: Response ~ treatment\n")
cat("========================================\n\n")

print(anova_results)

