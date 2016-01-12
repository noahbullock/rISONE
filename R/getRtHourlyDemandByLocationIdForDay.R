#' Get Current Realtime Hourly Demand
#' 
#' May need to add \code{config(ssl.verifypeer = FALSE)} if SSL cert cant be found.
#' 
#' @param day date in YYYY-MM-DD format, or object coercible to class \code{Date}
#' @param locId location id of load zone (see details)
#' @param user user account
#' @param password password
#' @param out.tz output timezone.
#' @param ... passed to httr functions.
#' @details Table of Load Zones:
#' \tabular{ll}{
#' Location \tab Location ID \cr
#' .Z.MAINE \tab 4001 \cr
#' .Z.NEWHAMPSHIRE \tab 4002 \cr
#' .Z.VERMONT \tab 4003 \cr
#' .Z.CONNECTICUT \tab 4004 \cr
#' .Z.RHODEISLAND \tab 4005 \cr
#' .Z.SEMASS \tab 4006 \cr
#' .Z.WCMASS \tab 4007 \cr
#' .Z.NEMASSBOST \tab 4008 
#' }
#' Note that historical hourly load zone information may not be available for a few days.
#' @importFrom lubridate mdy_hms
#' @importFrom httr GET authenticate accept_json config
#' @importFrom RJSONIO fromJSON
#' @export
getRtHourlyDemandByLocationIdForDay <- function(day = Sys.Date() - 3, locId = 4008, user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                                           out.tz = "America/New_York", ...){
  
  dd <- format(as.Date(day), "%Y%m%d")
  
  json <- get_path(path = paste0("/realtimehourlydemand/day/", dd, "/location/", locId), user = user, password = password, ...)
  
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