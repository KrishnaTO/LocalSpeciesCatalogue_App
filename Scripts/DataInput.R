# Geomap image
# 
# Docs:
#   - To get locations with images, currently must manually enable via camera app > settings > location with photos or similar option
# - Must use image sharable weblink (hosted via accessible server like Google Photos or OneDrive)
# ---
#   
# > Check with system if exif is installed, if not, install exif
# > system("apt-get install exif")

if(!require("exifr")) install.packages("exifr") 
library(exifr)
library(dplyr)

getImagedata <- function(imageURL){
  # If image is online, downloaded locally:
  # TODO Allow manual naming file
  
  try(
    if(!file.exists(imageURL)){
      filename <- ""
      filename <- sub('.*\\/', '', imageURL)
      download.file(url = imageURL, filename, quiet = T)
      imageURL <- filename
    })
  
  # TODO Get tags if exist
  imagedata <- read_exif(imageURL, tags = c("FileName",
                                            "FileSize",
                                            "ImageSize",
                                            "DateTimeOriginal",
                                            "FileAccessDate",
                                            "GPSTimeStamp",
                                            "GPSDateStamp",
                                            "GPSDOP",
                                            "GPSLatitude",
                                            "GPSLongitude"))
  
  # TODO [Feature] Allow manual GPS coordinates entry via Google Maps copy and paste coordinates
  
  # Confirm if image has GPS properties
  image.meta <- names(imagedata)
  if(length(grep("GPS", image.meta)) == 0)
    stop("No GPS data found, please confirm image taken has GPS data through camera settings, then retake")
  
  # TODO Write TryCatch methods to distinguish image sources 
  # (ie. Google Photos/OneDrive/Dropbox, etc)
  # Images must have open access "downloadable" conditions 
  # or have api access to log in to access
  # TODO [Feature] - save to local storage (NoSQL)
  
  # Remove downloaded local file
  if(filename==imageURL){
    file.remove(imageURL)
  }
  return(imagedata)
}
