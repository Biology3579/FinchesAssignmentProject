## Script name: cleaning.R
##
## Purpose of script: 
##    A collection of functions for cleaning the finch beak data (Sleuth3 package: case0201) 
##    to streamline for analysis.
##
## Author: Biology3579
##
## Date Created: 2024-10-01 
##
## ---------------------------

# Required packages
library(dplyr)

# Function to rename columns for clarity ----
rename_columns <- function(raw_data) {
  raw_data %>%
    rename(
      year = Year,           # Rename Year to year for consistency
      bird_id = X,           # Rename X to bird_id for clarity
      beak_depth_mm = Depth  # Rename Depth to beak_depth_mm for clarity
    )
}

# Function to filter out rows with missing values (NAs) ----
remove_NA <- function(raw_data) {
  raw_data %>%
    na.omit()  # Remove rows with missing values
}

# Function to convert variables to appropriate types (e.g., factor for year) ----
convert_variables <- function(raw_data) {
  raw_data %>%
    mutate(
      year = factor(year),  # Convert year to a factor
      bird_id = as.integer(bird_id),  # Ensure bird_id is an integer
      beak_depth_mm = as.numeric(beak_depth_mm)  # Ensure beak_depth_mm is numeric
    )
}

# Unified cleaning function for preparing data for analysis ----
cleaning_data <- function(raw_data) {
  raw_data %>%
    rename_columns() %>%      # Rename columns for clarity
    remove_NA() %>%           # Remove rows with NAs
    convert_variables()       # Ensure correct data types
}
