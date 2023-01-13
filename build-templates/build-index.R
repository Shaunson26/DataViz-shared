# Build index HTML
plot_htmls <-
  list.files('plots/', full.names = TRUE)

plot_htmls <- plot_htmls[!grepl('new-plot-template', plot_htmls)]

message('Building:\n  ', paste(plot_htmls, collapse = '\n  '))

scripts <- c()
index_template <- readLines('build-templates/index-template.html')
div_template <- readLines('build-templates/plot-div-template.html')

# plots is a vector
plots <-
  sapply(plot_htmls, function(filename){
    
    current_plot_build <- div_template
    current_plot <- readLines(filename, warn = F)
    scripts <<- c(scripts, grep('<script src', current_plot, value = TRUE))
    
    plot_title_ind <- grep('<!-- plot title -->', current_plot)
    plot_div_ind <- grep('<!-- plot div -->', current_plot)
    plot_script_ind <- grep('<!-- plot script -->', current_plot)
    html_length <- length(current_plot)
    
    plot_title <- 
      paste(current_plot[(plot_title_ind + 1):(plot_div_ind - 1)],
            collapse = "\n")
    
    plot_div <- 
      paste(current_plot[(plot_div_ind + 1):(plot_script_ind - 1)],
            collapse = "\n")
    
    plot_script <- 
      paste(current_plot[(plot_script_ind + 1):html_length], 
            collapse = '\n')
    
    current_plot_build <- sub('<!-- plot title -->', plot_title, div_template)
    current_plot_build <- sub('<!-- plot div -->', plot_div, current_plot_build)
    current_plot_build <- sub('<!-- plot script -->', plot_script, current_plot_build)
    
    paste(current_plot_build, collapse = '\n')
    
  })

# insert_in_row <- function(x){
#   sprintf('<div class="w3-row">\n  %s\n</div>', x)
# }
# 
# # Group plots into rows of 3 columns
# for(i in seq_along(plots)){
#   if (i == 1){
#     row_divs <- list()
#     row_tmp <- c()
#   }
#   
#   row_tmp <- paste(c(row_tmp, plots[i]), collapse = '\n')
#   
#   if (i %% 3 == 0 | i == length(plots)){
#     row_divs <- c(row_divs, insert_in_row(row_tmp))
#     row_tmp <- c()
#   }
#   
# }
row_divs <-
  sprintf('<div class="w3-row">\n  %s\n</div>', 
          paste(plots, collapse = '\n'))

index_template[grep('<!-- HTML elements', index_template) + 1] <- paste(row_divs, collapse = "\n")

scripts <- unique(scripts)
scripts <- scripts[!grepl('/data.js', scripts)]
scripts <- paste(scripts, collapse = '\n')

index_template[grep('<!-- Libraries go here -->', index_template) + 1] <- scripts

writeLines(index_template, 'index.html')

















