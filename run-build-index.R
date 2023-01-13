if (!dir.exists('build-templates')){
  stop('Cannot find required directories. Are you in the correct working directory?\n',
       'This script is currently working from: ', getwd())
}

source('build-templates/build-index.R')
