# How to run

- Clone the repository: `git clone git@github.com:chenghanyustats/housing.git`
- Switch to the `pipeline` branch: `git checkout pipeline`
- Start an R session in the folder and run `renv::restore()` 
   to install the project’s dependencies.
- Run the pipeline with `targets::tar_make()`.
- Checkout `analysis.html` for the output.