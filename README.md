# FinchesAssignmentProject
This repository contains the files and scripts for the Penguins Project, in which I analyse ...

All the necessary code for the analysis can be found in the [PenguinAnalysis.Rmd](https://github.com/Biology3579/ReproducibleScienceAssignment/blob/main/PenguinAnalysis.Rmd) file. The R Markdown document contains the data preprocessing, statistical analysis, and visualizations performed during the project.

## Repository Structure

/project_root 
|----  /README.md # ...
|----  /ReproducibleScienceAssignment.Rproj # RStudio project file
|----  /PenguinAnalysis.Rmd # Main ... 
|----  /data # Contains raw and processed data files
|----  /functions # R scripts for ...
|----  /figures # Generated figures

## Finished Reports

In the /finished_files folder, you will find the completed reports summarizing the analysis, results, and conclusions:

- PDF Report: A full PDF report containing the analysis, results, and interpretations.
- HTML Report: An interactive HTML version of the report for a more dynamic viewing experience.

## Running the Analysis
If you would like to run the analysis and reproduce the results yourself, follow these steps to set up your local environment and execute the necessary code.

### Prerequisites
1. Install Git on your system.
2. Install R and RStudio.

### Installation
**1. Clone the repository:**

First, clone the repository to your local machine: 
1. Open Git Bash or the terminal application
2. Navigate to where you want to clone the repo to _(e.g. Documents)_:
```bash
cd ~/Documents
```
3. Clone the repo to the specificed location:
```bash
git clone https://github.com/Biology3579/ReproducibleScienceAssignment.git 
```
This will create a local copy of the repository on your machine.

4. After cloning, navigate to the project directory:
```bash
cd ReproducibleScienceAssignment
```

**2. Open PenguinAnalysis.Rmd**

Find the `PenguinAnaysis.Rmd` file in the ...
This is the main file for the analysis.

**3. Restore the R environment**

Within the file, under the *Analysis* section, you will see the following command to command in R to restore the project's environment:
```r
renv::restore()
```
*This command will:*

 - Install the required R packages as specified in the renv.lock file.
 - Set up the project environment to match the one used when the project was initially created, ensuring that all dependencies are correctly installed.

*Note: this requires yoi to have renv previously installed.*
If you don't have renv already installed, install it by running the following command in your R console:
```r
install.packages("renv")
```

## Packages
_Packages Used:_ 

This project requires the following R packages:
- **`here`** - Specifies directory paths relative to the project root.
- **`tinytex`** - A lightweight LaTeX distribution, useful for generating PDFs or reports.
- **`renv`** - Manages R environment and ensures reproducible package installation.
- **`janitor`** - Provides functions to clean and tidy data.
- **`tidyverse`** - A collection of data science packages for data manipulation and visualization.
- **`palmerpenguins`** - Contains the dataset of penguin measurements used in the analysis.
- **`dplyr`** - Used for data manipulation.
- **`ggplot2`** - Used for creating visualizations.
- **`lme4`** - Used for fitting linear models.
- **`grid`** - Provides functionality for graphical layout.
- **`gridExtra`** - Extends the `grid` package to arrange multiple plots.
- **`ggsignif`** - Adds significance annotations to plots.

These packages are managed through `renv`, and the necessary versions are specified in the `renv.lock` file. 
