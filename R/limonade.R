#' limonade
#'
#' limonade
#' @param filename filename
#' @param format format
#' @keywords limonade
#' @export
#' @examples
#' \dontrun{
#' limonade()
#' }

limonade <- function(filename,format){
  stopifnot(is.character(filename))
  stopifnot(is.character(format))

  limonade_object(filename=filename,format=format)
}

limonade_object <- function(filename,format){

  x <- filename
  format <- format

   object <- local({

     extract <- function(...){
       res <- switch(format,
         "netcdf" = extractNcdf4(x,...),
         #hdf5 = h5::h5file(name=x,mode="r"),
         (message=paste0("argument not valid: ", format,".")))
       return(res)
     }

     summary <- function(...) {
        res <- switch(format,
          "netcdf" = summaryNcdf4(x,...),
          #hdf5 = h5::h5file(name=x,mode="r"),
          (message=paste0("argument not valid: ", format,".")))
        return(res)
     }


     environment()
     })

     lockEnvironment(object, TRUE)
     structure(object, class=c("limonade", class(object)))

}
