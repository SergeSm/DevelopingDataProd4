#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)


shinyUI(fluidPage(
    
    titlePanel("Diamond Prices"),
    
    # Sidebar
    sidebarLayout(
        sidebarPanel(
            helpText("To estimate the price of a diamond provide its characteristics."),
          
            h3(helpText("Characteristics:")),
            sliderInput("car", label = h4("Carats:"), 0, 4, step = 0.1, value = 1),
            
            helpText("Rem: '*' in cahracteristic field means it will not be included in analysis."),
            selectInput("cut", label = h4("Cut:"), 
                        choices = list("*", "Fair","Good","Very Good","Premium","Ideal")),
            selectInput("col", label = h4("Color: J(worst) to D(best)"), 
                        choices = list("*","J","I","H","G","F","E","D")),
            selectInput("clar", label = h4("Clarity: I1(worst) to IF(best)"), 
                        choices = list("*","I1","SI2","SI1","VS2","VS1","VVS2","VVS1","IF" ))
        ),
        
        # Plot Panel
        mainPanel(
            
            h4("Estimated price of diamond is:"),
            h3(textOutput("price"),
               
            plotOutput("pricePlot"))
        )
    )
))