
if(!require("plantnet")) install.packages("plantnet"); library(plantnet)
library(dplyr)
if(!require("httr")) install.packages("httr"); library(httr)
if(!require("RCurl")) install.packages("RCurl"); library(RCurl)

getSpecies <- function(key, location, organ) {
  
  # check for local image file
  url <- paste("https://my-api.plantnet.org/v2/identify/all?api-key=", key, sep = "")
  if(RCurl::url.exists(location)){
    # Hosted image file via URL
    # query GET equivalent to cURL params
    plantnetPOST <- httr::GET(url = url, 
                              query = list(
                                images =  location,
                                organs = organ)
    )
  }
  else({
    # local file path, in accordance with script location
    message("Sending local file to server...")
    try(
      location <- upload_file(normalizePath(location)), silent = TRUE)
    plantnetPOST <- httr::POST(url = url,
                               add_headers(`Content-Type`="multipart/form-data"),
                               body = list(
                                 images = location,
                                 organs = organ
                               ),
                               encode = "multipart"
    )
  }
  )
  
  # Parse response contents (Note of similar response format between local vs hosted)
  classifications_check <- httr::content(plantnetPOST)
  
  # TODO convert to tryError Warning message
  # Classification score function
  if(classifications_check$results[[1]]$score > 5) {
    species_name <- classifications_check$results[[1]]$species$scientificNameWithoutAuthor[1]
    print(paste(species_name, classifications_check$results[[1]]$score))
  }
  else {
    print("Insufficent accuracy. Not recommended to continue with current image. Please use other images")
    species_name <- classifications_check$results[[1]]$species$scientificNameWithoutAuthor[1]
    print(paste(species_name, classifications_check$results[[1]]$score))
  }
  
  # Return value for variable storage
  return(species_name)
}

