#' Get Gen Fuel Mixes For Day
#' 
#' Get all hourly load forecasts for a given day. May need to add \code{config = httr::config(ssl.verifypeer = FALSE)} if SSL cert cant be found.
#' 
#' @param day date in \code{'\%Y-\%m-\%d'}, or object coercible to class \code{Date}
#' @param user user account
#' @param password password
#' @param out.tz output timezone.
#' @param ... passed to httr functions.
#' @importFrom lubridate mdy_hms
#' @importFrom httr GET authenticate accept_json config
#' @importFrom RJSONIO fromJSON
#' @export
getGenFuelMixesForDay <- function(day = Sys.Date(), user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                                           out.tz = "America/New_York", ...){
  
  dd <- format(as.Date(day), "%Y%m%d")
  
  json <- get_path(path = paste0("/genfuelmix/day/", dd), user = user, password = password, ...)
  
  dat <- do.call(what = "rbind", 
                 lapply(json$GenFuelMixes$GenFuelMix, 
                        FUN = function(x) as.data.frame(x = x, stringsAsFactors = FALSE)))
  
  dat$BeginDate <- lubridate::ymd_hms(dat$BeginDate, tz = out.tz)
  
  return(dat)
  
}