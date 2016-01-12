#' \pkg{rISONE} an R package for the ISO New England API
#'
#' \code{rISONE} is comprised of a set of functions that interact with the ISO-NE RESTful \href{https://webservices.iso-ne.com/docs/v1.1/}{API}. 
#' The API employs basic authentication and provides an interface to energy 
#' and market data. Access credentials can be obtained at the \href{https://www.iso-ne.com/isoexpress/login?p_p_id=58&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-3&p_p_col_count=1&saveLastPath=0&_58_struts_action=\%2Flogin\%2Fcreate_account}{ISO Express Website}.
#' 
#' @examples
#' \dontrun{
#' 
#' # Credentials can be added to the environment as options or 
#' # passed explicitly to the functions
#' 
#' options(ISO_NE_USER = "your@email.com")
#' options(ISO_NE_PASSWORD = "yourPassword")
#' 
#' getAllHourlySystemLoadForecastForDay()
#' }
#'
#' @name rISONE
#' @docType package
NULL