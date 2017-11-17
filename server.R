#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


# Carats, Cut, Color and Clarity columns
diam <- diamonds[,c(1:4,7)]



# Define server logic required to draw a plot
shinyServer(function(input, output) {

    output$price <- renderText({
        # Predict the diamond price
        diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        fit <- lm(price~carat, diam)
        pred <- predict(fit, newdata = data.frame(carat = input$car,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar))  
        res <- paste(round(pred, digits = 2), "$")
        res
    })    
    
    output$pricePlot <- renderPlot({
        # Build the plot
        diam <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color), grepl(input$clar, clarity))
        fit <- lm( price~carat, diam)
        pred <- predict(fit, newdata = data.frame(carat = input$car,
                                                  cut = input$cut,
                                                  color = input$col,
                                                  clarity = input$clar))

        plot <- ggplot(data=diam, aes(x=carat, y=price)) +
            geom_point(aes(color = cut), alpha = 0.3) +
            geom_smooth(method = "lm") +
            geom_vline(xintercept = input$car, color = "red") +
            geom_hline(yintercept = pred, color = "red")
        plot
    })
})

