# Install 
```
    if (!"devtools" %in% installed.packages()) install.packages("devtools")
    
    setRepositories(ind=1:6)
    library(devtools)

    install_github("cannin/rcellminerElasticNet",
      dependencies=TRUE,
      args="--no-multiarch")
```
