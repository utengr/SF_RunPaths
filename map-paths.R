# Load data
routes <- read.csv("runkeeper-routes-sf.csv", stringsAsFactors=FALSE)

#
# Introduce base map
#
library(ggmap)
detailMap <- function(bbox, thedata) {
	basemap <- get_map(location=bbox, source='google', maptype="terrain", color="bw")
	ggmap(basemap) + geom_path(aes(x=longitude, y=latitude, group=tempid), size=0.3, color="#570864", alpha=0.3, data=thedata)
}
sanfran <- c(-122.50476977783954, 37.70528090348771, -122.3619475122155, 37.83825794027055)
area <- c(min(route$longitude)-.05, min(route$latitude)-.05, max(route$longitude)+0.5, max(route$latitude)+0.5)
detailMap(sanfran, routes)

