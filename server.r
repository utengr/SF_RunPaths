library(shiny)
library(ggplot2)
library(ggmap)

rawdata <- read.csv("runroutessf.csv", header=T, stringsAsFactors = F)
pathNumber <- unique(rawdata$tempid)
area <- c(-122.50476977783954, 37.70528090348771, -122.3619475122155, 37.83825794027055)
basemap <- get_map(location=area, source='google', maptype="terrain", color="bw")

detailMap <- function(area, thedata) {
         basemap <- get_map(location=area, source='google', maptype="terrain", color="bw")
         ggmap(basemap) + geom_path(aes(x=longitude, y=latitude, group=tempid), size=0.3, color="#570864", alpha=0.3, data=thedata)
        }

shinyServer(function(input, output) {
   #Subset Data
     Data <- reactive({
         route <- subset(rawdata, tempid >= input$minimum)
         route <- subset(route, tempid <= input$maximum)
         area <- c(min(route$longitude)-.015, min(route$latitude)-.015, max(route$longitude)+0.035, max(route$latitude)+0.035)
         info <- list(route=route, area=area)
         return(info)
     })

   #Create summary of data showing Head and Tail
     output$filetable <- renderDataTable({
         Data()$route
     })

  # Pick min tempId with Slider
      output$choose_min <- renderUI(function() {
        # Pick the minimum value to filter the data on
        sliderInput("minimum", "Choose Lower Run Id",
            min = 1, max = length(pathNumber), value = 1, step = 1)
      })

  # Pick max tempId with Slider
      output$choose_max <- renderUI(function() {
        # Pick the maximum value to filter the data on
        sliderInput("maximum", "Choose Upper Run Id",
            min = 1, max = length(pathNumber), value = length(pathNumber), step = 1)
      })

  # Pick alpha value with Slider
      output$choose_alpha <- renderUI(function() {
        # Pick the transparency of the lines on the map
        sliderInput("alpha", "Set the Transparency of the Paths",
            min = 0, max = 1, value = 0.3, step = 0.1)
      })

  # Pick line thickness value with Slider
      output$choose_line <- renderUI(function() {
        # Pick the thickness of the lines on the map
        sliderInput("thickness", "Set the Thickness of the Paths",
            min = 0, max = 1, value = 0.3, step = 0.1)
      })

  # Take all the inputs and generate the appropriate plot
      output$maproute <- renderPlot(function() {
        #area <- c(min(Data()$route$longitude)-.015, min(Data()$route$latitude)-.015, max(Data()$route$longitude)+0.035, max(Data()$route$latitude)+0.035)
        #area <- c(-122.50476977783954, 37.70528090348771, -122.3619475122155, 37.83825794027055)
		#basemap <- get_map(location=area, source='google', maptype="terrain", color="bw")
        p <- ggmap(basemap) + geom_path(aes(x=longitude, y=latitude, group=tempid), size=input$thickness, color="#570864", alpha=input$alpha, data=Data()$route)
		print(p)
	    })
})