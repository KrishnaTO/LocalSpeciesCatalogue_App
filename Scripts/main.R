# Get image
imageURL <- readline(prompt = 'Enter Image URL:')
## browse button for local image


# Create JSON (requestID = sys_date + filename)
filename <- NULL; filename <- sub('.*\\/', '', imageURL)
sys_time = Sys.time()
requestID = paste(sys_time, filename, sep = "-")

image = jsonlite::toJSON(data.frame(requestID, filename, sys_time), pretty = T)

# Online path
source(file = "Scripts/downloadImage.R")
downloadImage(imageURL)
source(file = "Scripts/ImageExif.R")
imagedata <- read_exif(imageURL)
                       
imageJSON <- 