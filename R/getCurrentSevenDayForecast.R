#' Get Current Seven Day Forecast
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
getCurrentSevenDayForecast <- function(user = getOption(x = "ISO_NE_USER"), password = getOption(x = "ISO_NE_PASSWORD"), 
                                    out.tz = "America/New_York", ...){
  
  json <- get_path(path = "/morningreport/current", user = user, password = password, ...)
  
  nonList <- sapply(X = json$MorningReports$MorningReport[[1]], class) != "list"
  
  MorningReport <- as.data.frame(json$MorningReports$MorningReport[[1]][nonList], stringsAsFactors = FALSE)
  
  MorningReport$BeginDate <- lubridate::ymd_hms(MorningReport$BeginDate, tz = out.tz)
  MorningReport$CreationDate <- lubridate::ymd_hms(MorningReport$CreationDate, tz = out.tz)
  MorningReport$PeakLoadYesterdayHour <- lubridate::ymd_hms(MorningReport$PeakLoadYesterdayHour, tz = out.tz)
  MorningReport$PeakLoadTodayHour <- lubridate::ymd_hms(MorningReport$PeakLoadTodayHour, tz = out.tz)
  
  lists <- json$MorningReports$MorningReport[[1]][!nonList]
  
  for(i in 1:length(lists)){
    lists[[i]] <- do.call("rbind", lapply(lists[[i]], FUN = function(x) as.data.frame(x = x, stringsAsFactors = FALSE)))
  }
  
  dat <- append(list(MorningReport = MorningReport), lists)
  
  return(dat)
}

.MarketDay <- function(){
  
}

