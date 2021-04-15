if(!require("rgbif")) install.packages("rgbif"); library("rgbif")


speciesInfo <- function(query){
  name = name_lookup(query=query)

# z <- name_lookup(query='Cnaemidophorus', rank="genus")
# m <- name_lookup(query = 'Helianthus annuus', rank="species")

  occ_get(key=name$data$key[1])
}