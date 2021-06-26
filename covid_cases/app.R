

library(shiny)
library(tidyverse)
library(ggthemes)


#COVID-19 data from the New York Times
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")


ui <- fluidPage(
    
    titlePanel("Covid Data"),
    selectInput(inputId = "state1",
                label = "Choose first state",
                choices = covid19$state),
    selectInput(inputId = "state2",
                label = "Choose second state",
                choices = covid19$state),
    submitButton(text = "Compare"),
    plotOutput(outputId = "plot")

   
)


server <- function(input, output) {
    output$plot <- renderPlot({
     
        covid19 %>%
            filter(state == input$state1 | state == input$state2) %>%
            filter(cases > 20) %>% 
            ggplot(aes(x = date,
                       y = cases,
                       color = state)) +
            geom_line() +
            scale_y_log10() +
            theme_calc()
        
        
    })
}


shinyApp(ui = ui, server = server)
