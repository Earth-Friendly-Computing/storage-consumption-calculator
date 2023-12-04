#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tibble)
library(ggplot2)
## Plot using a time-series, with cumulative energy use
## over lifetime and amount due to data
GB_PER_FOLD_COV = 5

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
          numericInput("patients", "How many patients?", value = 0, min = 0, max = 1000000),
          radioButtons("wesOrWGS", "WES, Panel, or WGS?", c("WES"=1, "Panel"=2, "WGS"=3)),
            radioButtons("gpuGen", "Which generation of GPUs were used for the analysis?",
                         c("Pascal (P100)" = 250,
                           "Volta (V100)" = 300,
                           "Ampere (A100)" = 450,
                           "Hopper (H100)" = 500,
                           "Lovelace (L40)" = 250)),
          numericInput("nGPUs", "How many total GPUs were used?",
                       value=16,min=1,max=128),
          numericInput("nCPUs", "How many total CPUs were used", value=4,min=1,max=32),
          # radioButtons("cpuTDP", "What is the approximate TDP of the CPU(s) utilized?"),
          # numericInput("dataGenerated", "How much coverage is used as an approximate cutoff?"),
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
    ## Plot chance of survival by hour
    output$text <- renderText({paste("Expected usage: ", val())})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
