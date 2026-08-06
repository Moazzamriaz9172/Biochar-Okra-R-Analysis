# ==========================================================
# Project : Effects of Mixed Wood Biochar on Fertilizer Use Efficiency
# Script  : 02_validate_data.R
# Author  : Moazzam Riaz
# Purpose : Validate imported data before analysis
# ==========================================================

library(readxl)
library(purrr)
library(dplyr)
library(here)

file_path <- here(
  "data",
  "raw",
  "okra_biochar_data.xlsx"
)

sheet_names <- excel_sheets(file_path)

raw_data <- map(
  sheet_names,
  ~ read_excel(file_path, sheet = .x)
)

names(raw_data) <- sheet_names

sapply(raw_data, nrow)

map(raw_data, ~ colSums(is.na(.)))
map(raw_data, str)
map(raw_data, ~ sum(duplicated(.)))
