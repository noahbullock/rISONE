#' Get Current Realtime Hourly Demand
#' 
#' May need to add \code{config(ssl.verifypeer = FALSE)} if SSL cert cant be found.
#' 
#' @param user user account
#' @param password password
#' @param out.tz output timezone.
#' @param ... passed to httr functions.
#' @importFrom lubridate mdy_hms
#' @importFrom httr GET authenticate accept_json config
#' @importFrom RJSONIO fromJSON
#' @export
getCurrentRtHourlyDemand <- function(user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                                           out.tz = "America/New_York", ...){
  
  json <- get_path(path = "/realtimehourlydemand/current", user = user, password = password, ...)
  
  dat <- do.call(what = "rbind", 
                 lapply(json$HourlyRtDemands$HourlyRtDemand, 
                        FUN = function(x){
                          dd <- as.data.frame(x = x, stringsAsFactors = FALSE)
                          locId <- dd[1,"Location"]
                          dd <- dd[2,]
                          dd$locId <- locId
                          dd
                        } ))
  
  dat$BeginDate <- lubridate::ymd_hms(dat$BeginDate, tz = out.tz)
  
  rownames(dat) <- 1:nrow(dat)
  
  return(dat)
}