#Problem 1
#server
#ben arancibia

require(shiny)
require(dplyr)
require(ggplot2)

data <- read.csv("cleaned-cdc-mortality-1999-2010.csv") #data

data <- filter(data, Year==2007) #picked 2007 because that's when I graduated high school

#http://rstudio.github.io/shiny/tutorial/#inputs-and-outputs for the server side of stuff

shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  datasetInput <- reactive({
    filter(data, ICD.Chapter == input$cause)
  })
  
 
