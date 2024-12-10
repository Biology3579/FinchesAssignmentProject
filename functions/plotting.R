## Key Info ----
##
## Script name: Plotting.r
##
## Purpose of script: 
##      # A file of functions for plotting the Sleuth3 case 0201 dataset
##
## Date Created: 01/2024
##
##
##
##
## Notes:
##   This file ...
##
##


# Explanatory box plot ---- 


# Function to create an exploratory boxplot
plot_exploratory_boxplot <- function(data, x_col, y_col, color_map, x_label = "Year", y_label = "Beak Depth (mm)") {
  library(ggplot2)
  
  ggplot(
    data = data,
    aes_string(x = x_col, y = y_col)) + # Use aes_string for dynamic column names
    geom_boxplot(aes_string(color = x_col), 
                 width = 0.5, 
                 show.legend = FALSE) + 
    geom_jitter(aes_string(color = x_col), 
                 alpha = 0.4, 
                 show.legend = FALSE, 
                 position = position_jitter(width = 0.2, seed = 0),
                 shape = 16, # solid points
                 size = 3,   # size of the points
                 stroke = 0) +  # Set stroke to 0 to remove point borders
    scale_color_manual(values = color_map) + 
    labs(
      x= "Year",
      y = "Beak Depth (mm)"
    ) +
    theme_classic()
}

# Function to create a boxplot with p-value from t-test and significance levels (without jitter)
plot_boxplot_t.test <- function(data, x_col, y_col, color_map, x_label = "Year", y_label = "Beak Depth (mm)") {
  library(ggplot2)
  library(ggpubr)  # For stat_compare_means
  # Relevel the 'year' factor to ensure 1976 appears before 1978
  data[[x_col]] <- factor(data[[x_col]], levels = c("1976", "1978"))
  
  # Perform the t-test
  t_test_result <- t.test(as.formula(paste(y_col, "~", x_col)), data = data)
  
  # Get the exact p-value
  p_value <- t_test_result$p.value
  
  # Print the exact p-value (check the value)
  print(p_value)
  
  # Create the plot
  ggplot(
    data = data,
    aes_string(x = x_col, y = y_col)
  ) + 
    geom_boxplot(aes_string(color = x_col), width = 0.5, show.legend = FALSE) +
    scale_color_manual(values = color_map) + 
    labs(x = x_label, y = y_label) +
    stat_compare_means(comparisons = list(c("1976", "1978")), 
                       label = "p.signif", label.y = max(data[[y_col]]) + 1) + 
    # Display the exact p-value without rounding
    annotate("text", x = 1.5, y = max(data[[y_col]]) + 2, 
             label = paste("p-value =", format(p_value, scientific = TRUE)), 
             size = 5, color = "black") +
    theme_classic()
}


# Function to create a boxplot with p-value from t-test and significance levels (without jitter)
plot_boxplot_CI <- function(data, x_col, y_col, color_map, x_label = "Year", y_label = "Beak Depth (mm)") {
  library(ggplot2)
  library(ggpubr)  # For stat_compare_means

  # Relevel the 'year' factor to ensure 1976 appears before 1978
  data[[x_col]] <- factor(data[[x_col]], levels = c("1976", "1978"))
  
  # Perform the t-test
  t_test_result <- t.test(as.formula(paste(y_col, "~", x_col)), data = data)
  
  # Get the means and the confidence interval for the difference
  mean_1976 <- mean(data[[y_col]][data[[x_col]] == "1976"])
  mean_1978 <- mean(data[[y_col]][data[[x_col]] == "1978"])
  
  # Confidence interval for the difference
  conf_int <- t_test_result$conf.int
  
  # Calculate the difference in means
  mean_diff <- mean_1978 - mean_1976
  
  # Create the boxplot
  boxplot <- ggplot(data = data, aes_string(x = x_col, y = y_col)) + 
    geom_boxplot(aes_string(color = x_col), width = 0.5, show.legend = FALSE) +
    scale_color_manual(values = color_map) + 
    labs(x = x_label, y = y_label) +
    stat_compare_means(comparisons = list(c("1976", "1978")), label = "p.signif", label.y = max(data[[y_col]]) + 1) +
    annotate("text", x = 1.5, y = max(data[[y_col]]) + 2, label = paste("p-value =", format(t_test_result$p.value, scientific = TRUE)), size = 5, color = "black") +
    theme_classic()
  
  # Plot the mean difference with 95% CI
  mean_diff_plot <- ggplot(data = data.frame(mean_diff = mean_diff, 
                                             conf_low = conf_int[1],
                                             conf_high = conf_int[2]),
                           aes(x = 1, y = mean_diff)) +
    geom_pointrange(aes(ymin = conf_low, ymax = conf_high), 
                    color = "red", 
                    size = 1, 
                    shape = 16) + 
    scale_x_continuous(breaks = NULL) +  # Hide x-axis
    labs(x = "", y = "Difference in Beak Depth (mm)") +
    theme_classic() +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank()) + 
    ggtitle("Difference in Mean Beak Depth (1978 - 1976)")  # Title for the plot
  
  # Print both the boxplot and the mean difference plot
  print(boxplot)
  print(mean_diff_plot)
}

