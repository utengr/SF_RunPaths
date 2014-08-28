library(shiny)
library(ggplot2)
library(ggmap)


shinyUI(pageWithSidebar(
  headerPanel("Plotting Location Data"),
  sidebarPanel(
    helpText("San Fransisco Run Paths (Lat/Long Data)"),
    helpText(" "),
    helpText("Pick a subset of the Running Routes and adjust the routes transparency and thickness"),
    uiOutput("choose_min"),
    uiOutput("choose_max"),
    uiOutput("choose_alpha"),
    uiOutput("choose_line"),
    helpText("")
  ),

  mainPanel(
    h3(textOutput('caption')),
    tabsetPanel(
      tabPanel("Data", dataTableOutput("filetable")),
      tabPanel("Map", plotOutput("maproute", height = 600))
    )
   )
  )
)