#Problem 2
#server
#ben arancibia

library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("cleaned-cdc-mortality-1999-2010.csv") #data

#http://rstudio.github.io/shiny/tutorial/#inputs-and-outputs for the server side of stuff
#reused a lot of the same components from problem 1
#i prefer dplyr over googlevis right now, don't feel comfortable with googlevis

shinyServer(function(input, output) {
  datasetChoice <- reactive({
    filter(data, ICD.Chapter == input$cause, State==input$state)
  })
  national <- reactive({ #national average
    national_choice <- filter(data, ICD.Chapter == input$cause)
    aggregate(national_choice[c("Population", "Deaths")], by=national_choice["Year"], FUN=sum)
  })
  
#summary
  output$barPlot <- renderPlot({
    data_filtered <- datasetChoice()
    if (nrow(data_filtered) == 12){
      natlAvg <- national()
      data_filtered["compareNatl"] <- data_filtered$Crude.Rate - ((natlAvg$Deaths/natlAvg$Population)) #compare
      
#make a viz
      
      ggplot(data=data_filtered, aes(x=factor(Year), y=compareNatl, fill=Crude.Rate)) + 
        geom_bar(stat="identity", position = position_dodge(width=10)) + 
        ylab("Crude Mortality Rate") + 
        xlab("Year") +
        ggtitle(paste(input$cause, "compared to the national average")) +
        theme_bw()
    }
  })
})