#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Outer UI
ui <- fluidPage(

    # Application title
    titlePanel("Calculating Energy Usage of Storing Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          numericInput("num", "Number of Gigabytes Stored", value = 0, min = 0, max = 100000),
            radioButtons("disk", "Disk Type",
                         c("HDD" = 0.65, "SSD" = 1.2)),
            radioButtons("replication", "Replication Level",
                         c("0.5" = 0.5, "1" = 1.0, "2" = 2.0, "3" = 3.0), selected = "1"),
            # radioButtons("locality", "Locality",
            #              c("NAS" = 1, "Data Center" = 1 / 1.3, "Hyperscale Cloud" = 1 / 1.1)),
          radioButtons("timeframe", "Calculate energy usage per:",
                       c("1 Month" = 1.0 / 12.0, "1 year" = 1, "1 decade"  = 10, "1 lifetime (70 years)" = 70),
                       selected = 1),
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
  

    num = reactive(input$num)
    time = reactive(input$timeframe)
    hours_per_year = 24 * 365
    factor_W_to_kW = 1.0 / 1000.00
    factor_gb_to_tb = 1.0 / 1000

    
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
