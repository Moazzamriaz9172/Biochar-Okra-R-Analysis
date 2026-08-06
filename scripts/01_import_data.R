#install.packages("janitor")
#install.packages("here")

library(tidyverse)
library(readxl)
library(janitor)
library(here)
here()
 file_path <- here(
   "data",
   "raw",
   "okra_biochar_data.xlsx"
 ) 
sheet_names <- excel_sheets(file_path)
 
sheet_names

library(purrr)

raw_data <- map(
  sheet_names,
  ~read_excel(file_path, sheet = .x)
)

names(raw_data) <- sheet_names

map(raw_data, dim)

View(raw_data[[1]])

write.csv(raw_data, "data/processed/raw_data.csv")



