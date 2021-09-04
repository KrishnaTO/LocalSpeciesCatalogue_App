
# Checks if file is in system; if not, download to local
downloadImage <- function(imageURL){
  try(
    if(!file.exists(imageURL)){
      filename <- ""
      filename <- sub('.*\\/', '', imageURL)
      download.file(url = imageURL, filename, quiet = T)
      imageURL <- filename
    })
  return(imageURL)
}