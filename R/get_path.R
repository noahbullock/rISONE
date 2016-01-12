#' Get value from any API path
#' 
#' May need to add \code{config = httr::config(ssl.verifypeer = FALSE)} if SSL cert can't be found.
#' 
#' @param user user account
#' @param password password
#' @param out.tz output timezone.
#' @param ... passed to httr functions.
#' @importFrom httr GET authenticate accept_json config
#' @importFrom RJSONIO fromJSON
#' @export
get_path <- function(path, user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                     ...){
  q <- httr::GET(url = paste0(ISO_NE_PATH(), path), 
                 httr::authenticate(user = user, password = password, type = "basic"), 
                 httr::accept_json(), ...)
  
  json <- RJSONIO::fromJSON(rawToChar(q$content))
  
  return(json)
}