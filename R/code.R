# This is a two factor oauth library for api.immobilienscout24.de

# This package is licensed under GPL 3.0
# Please contact Mike Hudecheck at michael.hudecheckhudecheck@unisg.ch if you have any questions

#' Two factor oauth library for api.immobilienscout24.de
#' @description This is a two factor oauth library for api.immobilienscout24.de 
#' @author Michael Hudecheck, \email{michael.hudecheck@unisg.ch}
#' @examples 
#' @source https://github.com/mhudecheck/immoauth/
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
    appname = "App",
    key = key,
    secret = secret,
  )
  json_res <- oauth1.0_token(api_endpoint, api_app, permission = NULL, as_header = TRUE, private_key = NULL, cache = TRUE)
}
