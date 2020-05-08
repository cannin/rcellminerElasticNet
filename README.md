# Install Dependencies 
    if (!"devtools" %in% installed.packages()) install.packages("devtools")
    
    setRepositories(ind=1:6)
    library(devtools)

    install_bitbucket("cbio_mskcc/rcellminerelasticnet",
      auth_user="discoverUser",
      password="discoverUserPassword",
      build_vignettes=FALSE,
      dependencies=TRUE,
      args="--no-multiarch")
    
    # Custom pheatmap version  
    install_github("cannin/pheatmap", dependencies=TRUE)

# Run Vignette

Open vignette (Rmd files) from vignettes/ folder and use "Knit HTML" button to generate the HTML file.

