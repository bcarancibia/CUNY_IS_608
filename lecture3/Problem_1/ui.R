#Problem 1
#ui
#ben arancibia

require(shiny)

data <- read.csv("cleaned-cdc-mortality-1999-2000.csv") #load data

#used this as guide: http://rstudio.github.io/shiny/tutorial/#ui-and-server
# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Crude Mortality Rate Across States by Cause of Death"),
  
  sidebarPanel(
    selectInput("cause", "Mortality Cause:",
                choices = names(table(cdc$ICD.Chapter))),
    submitButton("Update")
    ),
  
  mainPanel(plotOutput("barPlot", height="800px"))
))
  


