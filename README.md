# Two Factor Oauth for api.immobilienscout24.de (German Real Estate Portal)

This is an experimental R library for authenticating with the immobelienscout24.de Sandbox api.

Please sign up for api.immobelienscout24.de sandbox access at https://rest.immobilienscout24.de/restapi/security/registration.

Save your customer key and customer secret, along with your sandbox email and password. 

You can install this package by running devtools::install_github("mhudecheck/immoauth").

``` 
devtools::install_github("mhudecheck/immoauth")
```

Then, load the library and run the following to authenticate:
``` 
library(immoauth)

auth_token <- immoAuth(your_key, your_secret)
```
You will be required to manually authenticate on immobelienscout24.de.  Complete authentication with your sandbox credentials in the web page.  Once authentification is finished, a message will appear in your browser.  You can close the webpage and run your search in R. E.g.: 

```
raw_data <- httr::GET(https://rest.sandbox-immobilienscout24.de/restapi/api/search/v1.0/search/region?realestatetype=housebuy&price=10000-&geocodes=1276, config=config(token=auth_token)
```

More features will be added over time.  
