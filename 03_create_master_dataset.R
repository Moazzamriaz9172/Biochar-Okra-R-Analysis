library(readxl)
library(dplyr)
library(purrr)
library(here)
library(janitor)

# Define the path to the Excel file
file_path <- here(
  "data",
  "raw",
  "okra_biochar_data.xlsx"
)
here()
# Get all sheet names
sheet_names <- excel_sheets(file_path)
# Import all sheets into a list
raw_data <- map(
  sheet_names,
  ~ read_excel(file_path, sheet = .x)
)

# Assign sheet names to the list
names(raw_data) <- sheet_names
names(raw_data)

# Keep only the first three columns from every sheet
clean_data <- map(raw_data, ~ .x %>%
                    select(1:3))
clean_data[[1]]
clean_data[[2]]
unique(clean_data[[2]][[3]])

# Convert the measurement column (3rd column) to numeric in every sheet
clean_data <- map(clean_data, ~ .x %>%
                    mutate(across(3, as.numeric)))
str(clean_data[[2]])


#master_data <- clean_data[[1]]
#names(master_data)
# Add Dry Shoot Weight to the master dataset
#master_data <- master_data %>% left_join(clean_data[[2]],by = c("Treatments", "Replications"))
#names(master_data)
#head(master_data)


# Merge all sheets into one master dataset
master_data <- reduce(
  clean_data,
  left_join,
  by = c("Treatments", "Replications")
)
dim(master_data)
names(master_data)

clean_data[[12]]

# Rename columns with clean, consistent names
names(master_data) <- c(
  "treatment",
  "replication",
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
names(master_data)
master_data <- master_data %>%
  mutate(
    treatment = factor(
      treatment,
      levels = c(1, 2, 3, 4, 5),
      labels = c("T0", "T1", "T2", "T3", "T4")
    ),
    replication = factor(replication)
  )
str(master_data)
head(master_data)
names(master_data)


write_csv(master_data,
          "data/processed/master_data.csv")
list.files("data/processed")

save(master_data,
     file = "data/processed/master_data.RData")
list.files("data/processed")
rm(raw_data)
