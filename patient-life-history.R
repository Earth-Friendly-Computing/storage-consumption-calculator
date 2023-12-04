#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

## Plot using a time-series, with cumulative energy use
## over lifetime and amount due to data


# Outer UI
ui <- fluidPage(

    # Application title
    titlePanel("A Lifetime of Digital Medicine"),
    ## MRI
    ## WGS
    ## WES
    ## Medical Records
    ## Viral WGS

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          numericInput("age", "Airyn's Lifetime", value = 0, min = 0, max = 120),
            radioButtons("baselineWGS", "Does Airyn undergo genetic fingerprinting at birth?",
                         c("Yes" = 1.0, "No" = 0.0)),
          radioButtons("cancerStatus", "Is Airyn diagnosed with cancer during their lifetime?",
                       c("Yes" = 1.0, "No" = 0.0)),
            radioButtons("liquidBiopsy", "Frequency of liquid biopsies after 40",
                         c("Yearly" = 1, "Biannually" = 2, "Every 5 years" = 5, "Every Decade" = 10), selected = "2"),
          numericInput("mriCount", "Airyn receives how many MRIs in their lifetime?", value=2, min=0, max=10),
          radioButtons("units", "Units", c("kWh"=1.0, "BTU"=3412.14, "Barrel of Oil"=1.0/1628.0))
        ),

        # Show a plot of the generated distribution
        mainPanel(
          textOutput("text")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  

    age = reactive(input$age)
    wgsMult = reactive(input$baselineWGS)
    hours_per_year = 24 * 365
    factor_W_to_kW = 1.0 / 1000.00
    factor_gb_to_tb = 1.0 / 1000
    wgsBaseKWH = 1

    
    val = reactive(
      as.numeric(input$num) * 
        as.numeric(input$disk) * 
        as.numeric(input$timeframe) * 
        as.numeric(input$replication) *
        hours_per_year *factor_gb_to_tb * 
        factor_W_to_kW *
        as.numeric(input$units)
      )
    output$text <- renderText({paste("Expected usage: ", val())})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
