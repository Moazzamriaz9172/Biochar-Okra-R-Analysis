# ============================================================
# 11_portfolio_figures.R
# Portfolio-quality visualizations
# Mixed-Wood Biochar × Okra Experiment
# ============================================================

# ============================================================
# 1. PACKAGES
# ============================================================

library(tidyverse)
library(ggplot2)

# ============================================================
# 2. PATHS
# ============================================================

dir.create(
  "figures/portfolio",
  recursive = TRUE,
  showWarnings = FALSE
)

# ============================================================
# 3. LOAD DATA
# ============================================================

master_data <- read_csv(
  "data/processed/master_data.csv",
  show_col_types = FALSE
)

cld_results <- read_csv(
  "outputs/CSV files/cld_results.csv",
  show_col_types = FALSE
)

anova_results <- read_csv(
  "outputs/CSV files/anova_results.csv",
  show_col_types = FALSE
)

nutrient_uptake <- read_csv(
  "outputs/tables/nutrient_uptake_summary.csv",
  show_col_types = FALSE
)

# ============================================================
# 4. TREATMENT LABELS AND COLORS
# ============================================================

treatment_labels <- c(
  T0 = "0 t/ha",
  T1 = "5 t/ha",
  T2 = "10 t/ha",
  T3 = "15 t/ha",
  T4 = "20 t/ha"
)

treatment_colors <- c(
  T0 = "#4C78A8",
  T1 = "#59A14F",
  T2 = "#F28E2B",
  T3 = "#E15759",
  T4 = "#7B61A8"
)

# ============================================================
# 5. GENERAL PORTFOLIO THEME
# ============================================================

portfolio_theme <- function() {
  
  theme_minimal(base_size = 13) +
    
    theme(
      plot.title = element_text(
        face = "bold",
        size = 16,
        hjust = 0.5
      ),
      
      plot.subtitle = element_text(
        size = 11,
        hjust = 0.5
      ),
      
      axis.title = element_text(
        face = "bold"
      ),
      
      axis.text = element_text(
        color = "black"
      ),
      
      panel.grid.major.x = element_blank(),
      
      panel.grid.minor = element_blank(),
      
      legend.position = "bottom",
      
      legend.title = element_text(
        face = "bold"
      ),
      
      plot.margin = margin(
        12, 15, 12, 15
      )
    )
}

# ============================================================
# FIGURE 1
# PLANT HEIGHT RESPONSE
# ============================================================

plant_height <- master_data %>%
  
  mutate(
    treatment = factor(
      treatment,
      levels = names(treatment_labels)
    )
  )

ph_summary <- plant_height %>%
  
  group_by(treatment) %>%
  
  summarise(
    mean = mean(
      plant_height_cm,
      na.rm = TRUE
    ),
    
    SE = sd(
      plant_height_cm,
      na.rm = TRUE
    ) / sqrt(n()),
    
    .groups = "drop"
  )

ph_cld <- cld_results %>%
  
  filter(
    Response == "plant_height_cm"
  ) %>%
  
  mutate(
    treatment = factor(
      treatment,
      levels = names(treatment_labels)
    ),
    
    group = str_trim(.group)
  )

p1 <- ggplot(
  ph_summary,
  aes(
    x = treatment,
    y = mean,
    fill = treatment
  )
) +
  
  geom_col(
    width = 0.68,
    color = "white"
  ) +
  
  geom_errorbar(
    aes(
      ymin = mean - SE,
      ymax = mean + SE
    ),
    
    width = 0.12,
    linewidth = 0.7
  ) +
  
  geom_jitter(
    data = plant_height,
    
    aes(
      x = treatment,
      y = plant_height_cm
    ),
    
    inherit.aes = FALSE,
    
    width = 0.08,
    size = 2.5,
    alpha = 0.75,
    color = "black"
  ) +
  
  geom_text(
    data = ph_cld,
    
    aes(
      x = treatment,
      y = upper.CL + 0.8,
      label = group
    ),
    
    inherit.aes = FALSE,
    
    fontface = "bold",
    size = 5
  ) +
  
  scale_fill_manual(
    values = treatment_colors
  ) +
  
  scale_x_discrete(
    labels = treatment_labels
  ) +
  
  labs(
    title = "Effect of Biochar Rate on Okra Plant Height",
    
    subtitle =
      "Mean ± SE with individual observations and Tukey grouping",
    
    x = "Biochar application rate",
    
    y = "Plant height (cm)",
    
    fill = "Treatment"
  ) +
  
  portfolio_theme()

ggsave(
  "figures/portfolio/01_plant_height_response.png",
  
  p1,
  
  width = 8.5,
  height = 6.5,
  dpi = 300
)

# ============================================================
# FIGURE 2
# POD FRESH WEIGHT RESPONSE
# ============================================================

pod_data <- master_data %>%
  
  mutate(
    treatment = factor(
      treatment,
      levels = names(treatment_labels)
    )
  )

pod_summary <- pod_data %>%
  
  group_by(treatment) %>%
  
  summarise(
    
    mean = mean(
      pod_fresh_weight_g,
      na.rm = TRUE
    ),
    
    SE = sd(
      pod_fresh_weight_g,
      na.rm = TRUE
    ) / sqrt(n()),
    
    .groups = "drop"
  )

pod_cld <- cld_results %>%
  
  filter(
    Response == "pod_fresh_weight_g"
  ) %>%
  
  mutate(
    
    treatment = factor(
      treatment,
      levels = names(treatment_labels)
    ),
    
    group = str_trim(.group)
  )

p2 <- ggplot(
  pod_summary,
  
  aes(
    x = treatment,
    y = mean,
    fill = treatment
  )
) +
  
  geom_col(
    width = 0.68,
    color = "white"
  ) +
  
  geom_errorbar(
    
    aes(
      ymin = mean - SE,
      ymax = mean + SE
    ),
    
    width = 0.12,
    linewidth = 0.7
  ) +
  
  geom_jitter(
    
    data = pod_data,
    
    aes(
      x = treatment,
      y = pod_fresh_weight_g
    ),
    
    inherit.aes = FALSE,
    
    width = 0.08,
    size = 2.5,
    alpha = 0.75,
    color = "black"
  ) +
  
  geom_text(
    
    data = pod_cld,
    
    aes(
      x = treatment,
      y = upper.CL + 1.2,
      label = group
    ),
    
    inherit.aes = FALSE,
    
    fontface = "bold",
    size = 5
  ) +
  
  scale_fill_manual(
    values = treatment_colors
  ) +
  
  scale_x_discrete(
    labels = treatment_labels
  ) +
  
  labs(
    
    title =
      "Effect of Biochar Rate on Pod Fresh Weight",
    
    subtitle =
      "Mean ± SE with individual observations and Tukey grouping",
    
    x = "Biochar application rate",
    
    y = "Pod fresh weight (g)",
    
    fill = "Treatment"
  ) +
  
  portfolio_theme()

ggsave(
  
  "figures/portfolio/02_pod_fresh_weight_response.png",
  
  p2,
  
  width = 8.5,
  height = 6.5,
  dpi = 300
)

# ============================================================
# FIGURE 3
# YIELD COMPONENTS OVERVIEW
# ============================================================

yield_long <- master_data %>%
  
  select(
    treatment,
    pods_per_plant,
    grains_per_pod,
    pod_length_cm
  ) %>%
  
  pivot_longer(
    
    cols = -treatment,
    
    names_to = "trait",
    
    values_to = "value"
  ) %>%
  
  mutate(
    
    treatment = factor(
      treatment,
      levels = names(treatment_labels)
    ),
    
    trait = recode(
      
      trait,
      
      pods_per_plant =
        "Pods per plant",
      
      grains_per_pod =
        "Grains per pod",
      
      pod_length_cm =
        "Pod length (cm)"
    )
  )

yield_summary <- yield_long %>%
  
  group_by(
    trait,
    treatment
  ) %>%
  
  summarise(
    
    mean = mean(
      value,
      na.rm = TRUE
    ),
    
    SE = sd(
      value,
      na.rm = TRUE
    ) / sqrt(n()),
    
    .groups = "drop"
  )

p3 <- ggplot(
  
  yield_summary,
  
  aes(
    x = treatment,
    y = mean,
    fill = treatment
  )
) +
  
  geom_col(
    
    width = 0.68,
    
    color = "white"
  ) +
  
  geom_errorbar(
    
    aes(
      ymin = mean - SE,
      ymax = mean + SE
    ),
    
    width = 0.12
  ) +
  
  facet_wrap(
    
    ~ trait,
    
    scales = "free_y",
    
    nrow = 1
  ) +
  
  scale_fill_manual(
    
    values = treatment_colors
  ) +
  
  scale_x_discrete(
    
    labels = treatment_labels
  ) +
  
  labs(
    
    title =
      "Yield Components of Okra under Different Biochar Rates",
    
    x =
      "Biochar application rate",
    
    y =
      "Mean ± SE",
    
    fill =
      "Treatment"
  ) +
  
  portfolio_theme() +
  
  theme(
    
    legend.position = "none",
    
    strip.text =
      element_text(
        face = "bold"
      )
  )

ggsave(
  
  "figures/portfolio/03_yield_components_overview.png",
  
  p3,
  
  width = 12,
  
  height = 5.8,
  
  dpi = 300
)

# ============================================================
# FIGURE 4
# NUTRIENT UPTAKE
# ============================================================

uptake_long <- nutrient_uptake %>%
  
  select(
    
    treatment,
    
    mean_N_uptake_mg,
    
    mean_P_uptake_mg,
    
    mean_K_uptake_mg
  ) %>%
  
  pivot_longer(
    
    cols = starts_with("mean_"),
    
    names_to = "nutrient",
    
    values_to = "uptake"
  ) %>%
  
  mutate(
    
    nutrient = recode(
      
      nutrient,
      
      mean_N_uptake_mg =
        "N uptake",
      
      mean_P_uptake_mg =
        "P uptake",
      
      mean_K_uptake_mg =
        "K uptake"
    ),
    
    treatment = factor(
      
      treatment,
      
      levels = names(treatment_labels)
    )
  )

p4 <- ggplot(
  
  uptake_long,
  
  aes(
    
    x = treatment,
    
    y = uptake,
    
    fill = treatment
  )
) +
  
  geom_col(
    
    width = 0.68,
    
    color = "white"
  ) +
  
  geom_text(
    
    aes(
      
      label = round(
        uptake,
        1
      )
    ),
    
    vjust = -0.4,
    
    fontface = "bold",
    
    size = 3.7
  ) +
  
  facet_wrap(
    
    ~ nutrient,
    
    scales = "free_y",
    
    nrow = 1
  ) +
  
  scale_fill_manual(
    
    values =
      treatment_colors
  ) +
  
  scale_x_discrete(
    
    labels =
      treatment_labels
  ) +
  
  labs(
    
    title =
      "Nutrient Uptake under Different Biochar Rates",
    
    subtitle =
      "Mean nutrient uptake per plant",
    
    x =
      "Biochar application rate",
    
    y =
      "Nutrient uptake (mg)",
    
    fill =
      "Treatment"
  ) +
  
  portfolio_theme() +
  
  theme(
    
    legend.position = "none",
    
    strip.text =
      element_text(
        face = "bold"
      )
  )

ggsave(
  
  "figures/portfolio/04_nutrient_uptake_overview.png",
  
  p4,
  
  width = 11,
  
  height = 5.8,
  
  dpi = 300
)

# ============================================================
# FIGURE 5
# ANOVA SIGNIFICANCE OVERVIEW
# ============================================================

# NOTE:
# The saved anova_results.csv already contains one row per
# response variable and does NOT contain a "term" column.

anova_plot <- anova_results %>%
  
  mutate(
    
    Response = factor(
      
      Response,
      
      levels =
        rev(unique(Response))
    ),
    
    significance = case_when(
      
      p.value < 0.001 ~ "***",
      
      p.value < 0.01 ~ "**",
      
      p.value < 0.05 ~ "*",
      
      TRUE ~ "ns"
    )
  )

p5 <- ggplot(
  
  anova_plot,
  
  aes(
    
    x = significance,
    
    y = Response,
    
    fill = significance
  )
) +
  
  geom_tile(
    
    color = "white",
    
    linewidth = 1
  ) +
  
  geom_text(
    
    aes(
      label = significance
    ),
    
    fontface = "bold",
    
    size = 5
  ) +
  
  scale_fill_manual(
    
    values = c(
      
      "ns" = "#D9D9D9",
      
      "*" = "#F6BD60",
      
      "**" = "#F28482",
      
      "***" = "#6A4C93"
    )
  ) +
  
  labs(
    
    title =
      "Treatment Effects across Measured Traits",
    
    subtitle =
      "ANOVA significance for the biochar treatment effect",
    
    x = NULL,
    
    y = NULL,
    
    fill =
      "Significance"
  ) +
  
  portfolio_theme() +
  
  theme(
    
    axis.text.x =
      element_text(
        
        face = "bold",
        
        size = 12
      ),
    
    axis.text.y =
      element_text(
        size = 10
      )
  )

ggsave(
  
  "figures/portfolio/05_anova_significance_overview.png",
  
  p5,
  
  width = 8.5,
  
  height = 8,
  
  dpi = 300
)

# ============================================================
# FIGURE 6
# STANDARDIZED GROWTH AND YIELD HEATMAP
# ============================================================

major_traits <- c(
  
  "plant_height_cm",
  
  "shoot_dry_weight_g",
  
  "root_dry_weight_g",
  
  "pod_fresh_weight_g",
  
  "pod_dry_weight_g",
  
  "pods_per_plant",
  
  "grains_per_pod",
  
  "pod_length_cm"
)

heatmap_data <- master_data %>%
  
  select(
    
    treatment,
    
    all_of(major_traits)
  ) %>%
  
  group_by(treatment) %>%
  
  summarise(
    
    across(
      
      everything(),
      
      ~ mean(
        .x,
        na.rm = TRUE
      )
    ),
    
    .groups = "drop"
  ) %>%
  
  pivot_longer(
    
    cols = -treatment,
    
    names_to = "trait",
    
    values_to = "mean_value"
  ) %>%
  
  group_by(trait) %>%
  
  mutate(
    
    standardized =
      as.numeric(
        scale(mean_value)
      )
  ) %>%
  
  ungroup() %>%
  
  mutate(
    
    treatment = factor(
      
      treatment,
      
      levels =
        names(treatment_labels)
    ),
    
    trait = recode(
      
      trait,
      
      plant_height_cm =
        "Plant height",
      
      shoot_dry_weight_g =
        "Shoot dry weight",
      
      root_dry_weight_g =
        "Root dry weight",
      
      pod_fresh_weight_g =
        "Pod fresh weight",
      
      pod_dry_weight_g =
        "Pod dry weight",
      
      pods_per_plant =
        "Pods per plant",
      
      grains_per_pod =
        "Grains per pod",
      
      pod_length_cm =
        "Pod length"
    )
  )

p6 <- ggplot(
  
  heatmap_data,
  
  aes(
    
    x = treatment,
    
    y = trait,
    
    fill = standardized
  )
) +
  
  geom_tile(
    
    color = "white",
    
    linewidth = 0.8
  ) +
  
  geom_text(
    
    aes(
      
      label =
        round(
          standardized,
          1
        )
    ),
    
    size = 3.5,
    
    fontface = "bold"
  ) +
  
  scale_fill_gradient2(
    
    low = "#4575B4",
    
    mid = "white",
    
    high = "#D73027",
    
    midpoint = 0
  ) +
  
  scale_x_discrete(
    
    labels =
      treatment_labels
  ) +
  
  labs(
    
    title =
      "Standardized Response of Major Growth and Yield Traits",
    
    subtitle =
      "Treatment means expressed as within-trait standardized values",
    
    x =
      "Biochar application rate",
    
    y = NULL,
    
    fill =
      "Standardized\nresponse"
  ) +
  
  portfolio_theme() +
  
  theme(
    
    axis.text.y =
      element_text(
        face = "bold"
      )
  )

ggsave(
  
  "figures/portfolio/06_growth_yield_heatmap.png",
  
  p6,
  
  width = 9,
  
  height = 7,
  
  dpi = 300
)

# ============================================================
# FINAL CHECK
# ============================================================

cat(
  "\n========================================\n"
)

cat(
  "PORTFOLIO FIGURES GENERATED\n"
)

cat(
  "========================================\n\n"
)

portfolio_files <- list.files(
  
  "figures/portfolio",
  
  pattern = "\\.png$",
  
  full.names = FALSE
)

print(
  portfolio_files
)

cat(
  "\nTotal portfolio figures:",
  length(portfolio_files),
  "\n"
)

cat(
  "\nPortfolio folder:",
  normalizePath(
    "figures/portfolio",
    winslash = "/",
    mustWork = FALSE
  ),
  "\n"
)

# ============================================================
# END OF SCRIPT
# ============================================================

source("scripts/11_portfolio_figures.R")


list.files(
  "figures/portfolio",
  pattern = "\\.png$"
)
length(
  list.files(
    "figures/portfolio",
    pattern = "\\.png$"
  )
)
