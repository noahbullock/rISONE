#' Read ISO-NE csv file
#' 
#' Read an ISO-NE csv data file
#' 
#' @param filepath file path
#' @export
readIsoNeCsvFile <- function(filepath){
  f <- file(description = filepath, open = "rb")
  ll <- readLines(con = f)
  close(f)
  
  # line key
  lko <- paste0(unlist(lapply(strsplit(ll, split = ",", fixed = T), FUN = "[", 1)), collapse = "\n")
  lineKey <- read.csv(textConnection(object = lko), header = FALSE, stringsAsFactors = FALSE)
  
  # headers 
  hhlines <- paste0(ll[which(lineKey == "H")], collapse = "\n")
  headers <- read.csv(textConnection(object = hhlines), stringsAsFactors = FALSE, header = FALSE)
  headers <- as.matrix(headers[,-1])
  headers <- gsub(pattern = " ", replacement = "_", x = headers)
  headers <- apply(headers, MARGIN = 2, FUN = function(x){
    paste0(na.omit(x), collapse = ".")
  })
  
  # data
  ddlines <- paste0(ll[which(lineKey == "D")], collapse = "\n")
  ldata <- read.csv(textConnection(object = ddlines), stringsAsFactors = FALSE, header = FALSE)[,-1]
  names(ldata) <- headers
  
  # T + C
  cc <- ll[which(lineKey == "C")]
  tt <- ll[which(lineKey == "T")]
  tmeta <- list(C = read.csv(textConnection(cc), stringsAsFactors = FALSE, header = FALSE)[,-1],  
                Lines = read.csv(textConnection(tt), stringsAsFactors = FALSE, header = FALSE)[,-1])
  attr(ldata, which = "meta") <- tmeta
  
  return(ldata)
  
}