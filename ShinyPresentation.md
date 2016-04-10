Miles Per Gallon
========================================================
author: David Loughborough
date: April 10, 2016

MTCARS Data
========================================================

- This data is preloaded into R.
- The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).
- A data frame with 32 observations on 11 variables.
- This application helps analyze miles per gallon information distributions across cars.


Server Code
========================================================


```r
library(shiny)
shinyServer(function(input, output) {
  output$main_plot <- renderPlot({
    hist(mtcars$mpg,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Miles Per Gallon",
         main = "Miles Per Gallon Breakdown")
    if (input$individual_obs) {
      rug(mtcars$mpg)
    }
    if (input$density) {
      dens <- density(mtcars$mpg,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
  })
})
```

Code for UI
========================================================


```r
shinyUI(bootstrapPage(
  selectInput(inputId = "n_breaks",
              label = "Number of bins in histogram (approximate):",
              choices = c(10, 15, 20, 30),
              selected = 20),
  checkboxInput(inputId = "individual_obs",
                label = strong("Show individual observations"),
                value = FALSE),
  plotOutput(outputId = "main_plot", height = "300px"),
  conditionalPanel(condition = "input.density == true",
                   sliderInput(inputId = "bw_adjust",
                               label = "Bandwidth adjustment:",
                               min = 0.2, max = 2, value = 1, step = 0.2)
  )
))
```

<!--html_preserve--><div class="form-group shiny-input-container">
<label class="control-label" for="n_breaks">Number of bins in histogram (approximate):</label>
<div>
<select id="n_breaks"><option value="10">10</option>
<option value="15">15</option>
<option value="20" selected>20</option>
<option value="30">30</option></select>
<script type="application/json" data-for="n_breaks" data-nonempty="">{}</script>
</div>
</div>
<div class="form-group shiny-input-container">
<div class="checkbox">
<label>
<input id="individual_obs" type="checkbox"/>
<span>
<strong>Show individual observations</strong>
</span>
</label>
</div>
</div>
<div id="main_plot" class="shiny-plot-output" style="width: 100% ; height: 300px"></div>
<div data-display-if="input.density == true">
<div class="form-group shiny-input-container">
<label class="control-label" for="bw_adjust">Bandwidth adjustment:</label>
<input class="js-range-slider" id="bw_adjust" data-min="0.2" data-max="2" data-from="1" data-step="0.2" data-grid="true" data-grid-num="9" data-grid-snap="false" data-prettify-separator="," data-keyboard="true" data-keyboard-step="11.1111111111111" data-drag-interval="true" data-data-type="number"/>
</div>
</div><!--/html_preserve-->
