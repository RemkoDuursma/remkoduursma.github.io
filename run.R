
# if(!require(pacman))install.packages("pacman")
# pacman::p_load(blogdown,)
# PUT all packages there ^^^

library(blogdown)
options(servr.daemon = TRUE)
serve_site()
