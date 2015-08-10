library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Extreme match"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bmi",
                  "Maximal BMI difference:",
                  min = 0,
                  max = 2,
                  value = 1,
				  step = 0.01),

      sliderInput("samples",
                  "Samples per group:",
                  min = 1,
                  max = 20,
                  value = 5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
	  fluidRow(

      plotOutput("distPlot"),
	  dataTableOutput(outputId="matched")
    ))
  )
))
