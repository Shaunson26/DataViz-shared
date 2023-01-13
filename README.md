
# Data visualisation project

<!-- badges: start -->
<!-- badges: end -->

A small project to play around with Javascript visualisation libraries and a shared
github repository.  

## How it works

A single `index.html` document is created that incorporates plot HTMLs within the `plots/`
directory. Data is sourced from `data/data.js` which holds small datasets in javascript
variables/objects - these are to be expanded when needed.

### Index build

Currently R is used to wrangle the individual plot htmls and embed into the `index.html`
using the wrapper script `run-build-index.R`. Future plans will involve using some other
method or web framework.

### Plot template

`plots/new-plot-template.html` contains a boilerplate to create a new visualisation. 
Generally we need a plot library, a div for the plot, some data and a script that 
builds the plot. The boilerplate currently references `data/data.js` and then requires:  

  - a plot library reference - from a CDN
  - a title - for where the plot is finally displayed in `index.html`
  - code to generate the plot within the given div
  
A short piece of code exists in the script tags that generates a unique plot ID so there
are no name clashes.

### Adding a new plot

 1. Create a new branch
 2. Copy this `plots/new-plot-template.html` witin the `plots/` directory, rename,
 and create a new visualisation.
     - you should be able to do all this within the new visualisation html
     - once complete, move to step 3
 3. Run `run-build-index.R`
 4. Examine `index.html`
 5. Create a pull request to add to the main branch
 
