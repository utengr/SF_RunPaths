# Load data
routes <- read.csv("runkeeper-routes-sf.csv", stringsAsFactors=FALSE)

detailMap <- function(bbox, thedata) {
  basemap <- get_map(location=bbox, source='google', maptype="terrain", color="bw")
  ggmap(basemap) + geom_path(aes(x=longitude, y=latitude, group=tempid), size=1, color="#570864", alpha=1, data=thedata)
}
sanfran <- c(-122.50476977783954, 37.70528090348771, -122.3619475122155, 37.83825794027055)
area <- c(min(route$longitude)-.015, min(route$latitude)-.015, max(route$longitude)+0.035, max(route$latitude)+0.035)