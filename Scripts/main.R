
############
# Choose image [url or local file]
############
source(file = "Scripts/functions/imageinput.R")
imageURL = imageinput()


############
# build JSON (requestID = sys_date + filename)
############
filename <- NULL
filename <- sub('.*\\/', '', imageURL)

sys_time = Sys.time()
requestID = paste(sys_time, filename, sep = "-")

imageID = jsonlite::toJSON(data.frame(requestID, filename, sys_time), pretty = T)
imageID

## Get image data
source(file = "Scripts/functions/downloadImage.R")
source(file = "Scripts/functions/ImageExif.R")

# Downloading a remote image requires overwriting to imageURL
imageURL <- downloadImage(imageURL)
imagedata <- ImageExif(imageURL)
#imageJSON <- 

imageID <- jsonlite::toJSON(c(jsonlite::fromJSON(imageID), imagedata), pretty = T)
imageID

## plantnet plant recognition
source("Scripts/functions/getSpecies.R")
# Get your key from https://my.plantnet.org/
key <- as.character(read.table("plantnetkey.txt", stringsAsFactors=F))   # Personal key, please do not use without permission [limited to 50 uses per day]
# Get the URL for your image

test.id <- species_name <- getSpecies(key, imageURL, organ = "flower")
