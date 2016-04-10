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
