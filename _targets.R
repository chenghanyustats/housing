## The first part of the pipeline is where packages and helper functions get loaded.

library(targets)
library(tarchetypes)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(data_summary) to view the results.
# library(future)
# library(future.callr)
# plan(callr)



## The second is where pipeline-specific options are defined;
# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
# summarize_data <- function(dataset) {
#   colMeans(dataset)
# }

save_plot <- function(filename, ...){
    png(filename = filename)
    plot(...)
    dev.off()
    filename
}

# path_data <- function(path){
#     path
# }

# slow_summary <- function(...){
#     Sys.sleep(30)
#     summary(...)
# }


# you have two other options: you either define them directly 
# inside the _targets.R script, like in the template, or 
# you create a functions/ folder next to the _targets.R script, and 
# put your functions there.
# Set target-specific options such as packages:
# tar_option_set(packages = "utils") # nolint
# tar_option_set(packages = c("dplyr", "ggplot2"))
tar_option_set(packages = c(
    "housing"
    # "dplyr",
    # "flextable",
    # "ggplot2",
    # "skimr"
)
)
source("functions/read_data.R")


## The third is the pipeline itself, defined as a series of targets.
# End this file with a list of target objects.
list(
    tar_target(
        commune_level_data,
        read_data("commune_level_data",
                  "housing")
    ),
    
    tar_target(
        country_level_data,
        read_data("country_level_data",
                  "housing")
    ),
    
    tar_target(
        commune_data,
        get_laspeyeres(commune_level_data)
    ),
    
    tar_target(
        country_data,
        get_laspeyeres(country_level_data)
    ),
    
    tar_target(
        communes,
        c("Luxembourg",
          "Esch-sur-Alzette",
          "Mamer",
          "Schengen",
          "Wincrange")
    ),
    
    tar_quarto(
        analyse_data,
        # "analyse_data.Rmd"
        "analysis.qmd"
    )
    
)