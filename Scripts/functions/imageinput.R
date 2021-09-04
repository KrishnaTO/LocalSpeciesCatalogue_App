# Get image
imageinput <- function(url = NULL){
  if(is.null(url))
    # pick if url or file.choose()
    url = readline(prompt = 'Enter Image URL or enter "0" to choose local file:')
    if(url == "0")
      url = file.choose()
  return(url)
}