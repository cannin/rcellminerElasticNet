# Description 

A collection of R functions that make use of the glmnet Elastic Net implementation.

# Usage 

See tests directory for example

# Install 
```
    if (!"devtools" %in% installed.packages()) install.packages("devtools")
    
    setRepositories(ind=1:6)
    library(devtools)

    install_github("cannin/rcellminerElasticNet",
      dependencies=TRUE,
      args="--no-multiarch")
```
