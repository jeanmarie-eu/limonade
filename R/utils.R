extractOrigin <- function(timeUnit){
  tmp <- gsub("[^0-9]", "",timeUnit)
  #year <- as.numeric(substr(tmp, 1, 4))
  #month <- as.numeric(substr(tmp, 5, 6))
  #day <- as.numeric(substr(tmp, 7, 8))
  res <- timeManip::YYYYmmdd_chr(tmp)
  return(res)
}

extractUnit <- function(timeUnit){
  if (length(grep("seconds ",timeUnit)))  {
    res <- "second"
  } else if (length(grep("minutes ",timeUnit)))  {
    res <- "minute"
  } else if (length(grep("hours ",timeUnit))) {
    res <- "hourly"
  } else if (length(grep("days ",timeUnit))) {
    res <- "daily"
  } else stop("problem with timeUnit")
  return(res)
}

#' @export
print.limonade <- function(x,...){
  str(x$summary(...))
}
