# This code enables reverse geocoding with Google Maps API, Bing API, and Photon API  
# revgeo() requires RCurl and RJSONIO to function properly
# You must provide a valid Google Maps API to reverse geocode with Google Maps.  Same with Bing. 
# You can specify whether you want the output to be a string, a hashed string, or a dataframe with option="string" | "hash" | "frame"
# If you specify an option that isn't included in the list, the function will return the results as a dataframe
# Specifying a hashed string or dataframe allows you to specify whether you want to return the entire results, or a single item with item=""
# Valid options for 'items=' include 'housenumber', 'street', 'city', 'county', 'state', and 'country'

# This package is licensed under GPL 3.0
# Please contact Mike Hudecheck at michael.hudecheck@gess.ethz.ch if you have any questions

#' Reverse Geocoding with the Photon Geocoder for OpenStreetMap, Google Maps, and Bing.
#' @description Enables the use of the Photon geocoder for OpenStreetMap, Google Maps, and Bing to reverse geocode coordinate pairs. Photon allows for unlimited geocode queries, while Google Maps and Bing provide a little more information for 'out of the way' locations. Google Maps and Bing require an API key, and Google Maps limits users to 2,500 free queries a day.  
#' @author Michael Hudecheck, \email{michael.hudecheck@gess.ethz.ch}
#' @param longitude Required. You must enter a valid longitude coordinate;  e.g., -77.0229529
#' @examples 
#' revgeo(longitude=-77.0229529, latitude=38.89283435)
#' @source https://github.com/mhudecheck/immo/
#' @keywords immo 
#' @keywords realestate
#' @keywords api
#' @import httr 
#' @export

immoAuth <- function(key, secret) {
  library(httr)
  api_endpoint <- oauth_endpoint("request_token",
                                 base_url = "https://rest.sandbox-immobilienscout24.de/restapi/security/oauth",
                                 access = "https://rest.sandbox-immobilienscout24.de/restapi/security/oauth/access_token", # for demo
                                 authorize = "https://rest.sandbox-immobilienscout24.de/restapi/security/oauth/confirm_access"
  )
  
  api_app <- oauth_app(
    appname = "App1",
    #key = "PropertyScannerCH2Key",
    #secret = "QCm4P0fsZ7hRqB7C"
    key = key,
    secret = secret,
  )
  json_res <- oauth1.0_token(api_endpoint, api_app, permission = NULL, as_header = TRUE, private_key = NULL, cache = TRUE)
}

immoSearch <- function(url, token) {
  z <- GET(retUrl, config=config(token=token))
  http_type(z)
  jsonRespParsed<-content(z,as="parsed") 
  dataset <- jsonRespParsed[[1]]
  pages <- dataset$paging$numberOfPages
  fin <- data.table()
  for(i in 1:pages) {
    retUrl <- paste0("https://rest.sandbox-immobilienscout24.de/restapi/api/search/v1.0/search/region?realestatetype=housebuy&price=10000-200000&geocodes=1276&buildingtypes=multifamilyhouse&", "pagenumber=", i)
    z <- GET(retUrl, config=config(token=token))
    http_type(z)
    jsonRespParsed <- content(z,as="parsed") 
    dataset.tmp <- jsonRespParsed[[1]]$resultlistEntries[[1]][3]$resultlistEntry
    for(j in 1:length(dataset.tmp)) {
      res.tmp <- as.data.table(dataset.tmp[j][[1]]$resultlist.realEstate)[1]
      fin <- rbind(fin, res.tmp, fill=TRUE)
    }
  }
}

#token <- immoAuth("PropertyScannerCH2Key", "QCm4P0fsZ7hRqB7C")
#retUrl <- "https://rest.sandbox-immobilienscout24.de/restapi/api/search/v1.0/search/region?realestatetype=housebuy&price=10000-200000&geocodes=1276&buildingtypes=multifamilyhouse"
  
#dataset <- immoSearch(retUrl, token)
