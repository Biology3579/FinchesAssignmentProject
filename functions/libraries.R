## Script name: libraries.R
##
## Purpose of script: 
##    A function to load all necessary libraries for finches beak size 
##    analysis, to declutter main analysis file.
##    An outline of the use of each library is also provided. 
##
## Author: Biology3579
##
## Date Created: 2024-10-01 
##
## ---------------------------

# Function to load all necessary libraries for the Pygoscelis penguins bill morphology analysis
load_libraries <- function() {
    library(Sleuth3)          # for ecological and evolutionary analysis
    library(janitor)          # for cleaning and organizing data (e.g., renaming columns)
    library(here)             # for specifying file paths relative to the project root
    library(car)              # for advanced statistical analysis, including regression diagnostics
    library(tidyverse)        # for comprehensive data manipulation, visualization, and tidying
    library(dplyr)            # for data manipulation 
    library(ggplot2)          # for creating high-quality data visualizations
    library(gridExtra)        # for arranging multiple grid-based plots or tables in one figure
    library(svglite)          # for saving plots as scalable vector graphics (SVG format)
    library(broom)            # for tidying model outputs into easy-to-use data frames
}