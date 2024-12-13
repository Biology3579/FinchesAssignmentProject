# Script name: plotting.R
##
## Purpose of script: 
##    A collection of functions for generating figures for the finches beak size 
##    analysis and saving them appropriately.
##    This ensures that the main analysis file is de-cluttered and runs smoothly.
##
## Author: Biology3579
##
## Date Created: 2024-10-01 
##
## ---------------------------

# Required packages
library(ggplot2)
library(dplyr)
library(ggsignif)
library(broom)
library(svglite)

# Defining custom color palettes and custom shapes for each species of penguin ----
year_colours <- c(
    "1976" = "#E7B800", 
    "1978" = "#FC4E07")

# Function to create exploratory boxplot of beak depths across the two years ----
plot_exploratory_boxplot <- function(data) {
  
  # Define data and axes
  ggplot(data = finches_clean, 
         aes(x = year,             # Define x-axis
             y = beak_depth_mm)) + # Define y-axis
    
    # Boxplot for bill depth
    geom_boxplot(aes(
      color = year),          # Year-specific colour
      width = 0.5) +          # Width of the boxplot
    
    # Plot all individual data points
    geom_jitter(aes(
      color = year,        # Year-specific colour
      alpha = 0.3,         # Transparency of the points
      size = 4),           # Size of the jittered points
      position = position_jitter(width = 0.2, # Jitter width
                                 seed = 0)) + # Ensures reproducible in random variation in point placement 
    
    # Apply custom colours
    scale_color_manual(values = year_colours) +
    
    # Axes labels 
    labs(x = "Year",
         y = "Beak Depth (mm)") + 
    
    # Themes, sizes, and positioning
    theme_minimal() + 
    theme(
      axis.title.x = element_text(size = 13), # Size of x-axis label
      axis.title.y = element_text(size = 13), # Size of y-axis label
      axis.text.x = element_text(size = 12),  # Size of x-axis values
      axis.text.y = element_text(size = 12),  # Size of x-axis values
      legend.position = "none")
}


# Function to plot diagnostic plots ----
plot_diagnostics <- function(model) {
  par(mfrow = c(1, 2), mar = c(6, 4, 2, 1))   # Set up the plotting layout
  plot(model, 1)  # Plot residuals vs fitted values
  plot(model, 2)  # Plot Q-Q plot for residuals
}


# Function to create a model summary table with only relevant values (effect size, p-value, and confidence intervals) ----
generate_summary_table <- function(linear_model, term_label, p_value_label, conf_lower_label, conf_upper_label, effect_size_label) {
  
  # Extract the model summary and confidence intervals
  model_summary <- broom::tidy(linear_model, conf.int = TRUE)
  
  # Filter out the Intercept (comparing only between years) and extract relevant stats
  year_comparison_row <- model_summary %>%
    filter(term == "year1978") %>%
    select(term, estimate, p.value, conf.low, conf.high) # Select relevant stats
  
  # Clean the table to match your needs and label appropriately
  cleaned_table <- year_comparison_row %>%
    mutate(
      term = term_label,  # Set custom term label
      p.value = round(p.value, 3),      # Round p-value for clarity
      conf.low = round(conf.low, 3),    # Round lower CI for clarity
      conf.high = round(conf.high, 3),  # Round upper CI for clarity
      effect_size = round(estimate, 3)  # Round effect size for clarity
    ) %>%
    rename(
      "Year_Effect" = term,      # Rename the 'term' column to 'Year_Effect
      # !! enables dynamic references to column names stored in variables to ensure they are interpretted correctly
      !!p_value_label := p.value,        # Rename p-value
      !!conf_lower_label := conf.low,    # Rename conf.low
      !!conf_upper_label := conf.high,   # Rename conf.high
      !!effect_size_label := effect_size # Rename effect_size
    ) %>%
    # Select specific columns based on the renamed labels
    select(Year_Effect, !!effect_size_label, !!p_value_label, !!conf_lower_label, !!conf_upper_label)
  
  return(cleaned_table)
}


# Function to create exploratory boxplot of beak depths across the two years with significance annotations ----
plot_results_boxplot <- function(data) {
  
  # Define data and axes
  ggplot(data = finches_clean, 
         aes(x = year, 
             y = beak_depth_mm)) +
    
    # Boxplot for beak depth
    geom_boxplot(aes(
      color = year,           # Year-specific colour
      fill = year),           # Year-specific colour fill
      width = 0.5,            # Width of the boxplot
      alpha = 0.5) +          # Transparency of fill
    
    # Add significance levels 
    geom_signif(comparisons = list(c("1976", "1978")),  # Compare 1976 vs 1978
                annotations = c("***"),                 # Significance stars for the comparison
                y_position = 12,                        # Adjust the y-position based on your data range
                tip_length = 0.01) +                    # Short tip lines for neatness
    
    # Apply custom colours
    scale_color_manual(values = year_colours) + # Boxplot outline
    scale_fill_manual(values = year_colours) +  # Boxplot fill
    
    # Axes labels 
    labs(x = "Year",
         y = "Beak Depth (mm)") + 
    
    # Themes, sizes, and positioning
    theme_minimal() + 
    theme(
      axis.title.x = element_text(size = 13), # Size of x-axis label
      axis.title.y = element_text(size = 13), # Size of y-axis label
      axis.text.x = element_text(size = 12),  # Size of x-axis values
      axis.text.y = element_text(size = 12),  # Size of x-axis values
      legend.position = "none")
}

# Function to save figures as svg (vector) files ----
save_plot_svg <- function(data, filename, size, scaling, plot_function){ # Features to define in the function
  
  size_inches = size / 2.54  # Convert size from cm to inches
  svglite(filename, width = size_inches, height = size_inches, scaling = scaling)
  
  # Plot the respective figure based on the passed plot_function
  plot <- plot_function(data)  # Call the appropriate plot function (e.g., results_plot_1, results_plot_2, etc.)
  print(plot)  # Print the plot to save it
  
  dev.off()  # Close the device (save the plot)
}
