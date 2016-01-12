#' Get Current Regional Network Load
#' 
#' May need to add \code{config = httr::config(ssl.verifypeer = FALSE)} if SSL cert cant be found.
#' 
#' @param user user account
#' @param password password
#' @param out.tz output timezone.
#' @param ... passed to httr functions.
#' @importFrom lubridate mdy_hms
#' @importFrom httr GET authenticate accept_json config
#' @importFrom RJSONIO fromJSON
#' @export
getCurrentRegionalNetworkLoad <- function(user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                                          out.tz = "America/New_York", ...){
  
  json <- get_path(path = "/networkload/current", user = user, password = password, ...)
  
  dat <- do.call(what = "rbind", 
                 lapply(json$MonthlyNetworkLoads$MonthlyNetworkLoad, 
                        FUN = function(x) as.data.frame(x = x, stringsAsFactors = FALSE)))
  
  dat$BeginDate <- lubridate::ymd_hms(dat$BeginDate, tz = out.tz)
  
  return(dat)
  
}