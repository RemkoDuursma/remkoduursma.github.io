library(rvest)
library(dplyr)

page <- read_html("https://www.r-bloggers.com/blogs-list/") 

link_set <- page %>% html_nodes("ul") %>% .[6]



link_set <- page %>% html_nodes("li") %>% html_attrs
w