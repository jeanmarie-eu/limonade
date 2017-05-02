summaryNcdf4 <- function(x,varid=NULL){
  if(is.null(varid)) {
    res <- list(variable = summaryNcdf4_var(x))
  } else if (!is.null(varid)) {
    variableDim <- summaryNcdf4_vardim(x,varid)
    dim <- summaryNcdf4_dim(x,varid)
    res <- list(variable = varid, variableDim = variableDim, dim = dim)
  }
  return(res)
}

extractNcdf4 <- function(x,varid=NULL,vardimid=NULL,offset=NULL,count=NULL){
  if((!is.null(varid)) && (is.null(vardimid))){
     res <- ncdf_variable(x,varid,offset,count)
  } else if((!is.null(varid)) && (!is.null(vardimid))){
     res <- ncdf_dim(x,varid,vardimid,offset,count)
  } else stop("Missing varid or vardimid")
  return(res)
}


ncdf_variable <- function(x,varid,offset,count){
  nc <- ncdf_open(x)
  indice_var <- i_varid(nc,varid)
  varid2 <- as.character(nc$var[[indice_var]]$name)
  variable <- list()
  variable$name <- nc$var[[indice_var]]$name
  variable$longname <- nc$var[[indice_var]]$longname
  variable$units <-  nc$var[[indice_var]]$units
  if ((!is.null(offset)) & (!is.null(count))) {
    variable$vals <- ncdf4::ncvar_get(nc, varid=varid2,start=c(offset$i,offset$j,offset$k), count=c(count$i,count$j,count$k))
  } else variable$vals <- ncdf4::ncvar_get(nc, varid=varid2)

  ncdf_close(nc)
  return(variable)
}

ncdf_dim <- function(x,varid,vardimid,offset,count){
  nc <- ncdf_open(x)
  indice_var <- i_varid(nc,varid)
  indice_dim <- i_vardimid(nc,indice_var,vardimid)

  dim <- list()
  dim$name  <-  nc$var[[indice_var]]$dim[[indice_dim]]$name
  dim$units <-  nc$var[[indice_var]]$dim[[indice_dim]]$units
  if ((!is.null(offset)) & (!is.null(count))) {
    dim$vals  <-  nc$var[[indice_var]]$dim[[indice_dim]]$vals[offset:(offset+count-1)]
  } else dim$vals  <-  nc$var[[indice_var]]$dim[[indice_dim]]$vals
  ncdf_close(nc)
  return(dim)
}

i_varid <- function(nc,varid){
  if (is.character(varid)) {
     indice_var <- which(names(nc$var)==varid)
  } else if (is.integer(varid)) {
    indice_var <- varid
  } else stop("varid is neither a character nor an integer")
  return(indice_var)
}

i_vardimid <- function(nc,indice_var,vardimid){
  if (is.character(vardimid)) {
     indice_dim <- which(lapply(nc$var[[indice_var]]$dim,function(x) x$name)==vardimid)
  } else if (is.integer(vardimid)) {
    indice_dim <- vardimid
  } else stop("vardimid is neither a character nor an integer")
  return(indice_dim)
}

summaryNcdf4_var <- function(x){
  nc <- ncdf_open(x)
  tmp <- names(nc$var)
  ncdf_close(nc)
  return(tmp)
}

summaryNcdf4_vardim <- function(x,varid=NULL){
  if(!is.null(varid)){
     nc <- ncdf_open(x)
     indice_var <- i_varid(nc,varid)
     vardim <- unlist(lapply(nc$var[[indice_var]]$dim,function(x) x$name))
     ncdf_close(nc)
  } else stop("Missing varid")
  return(vardim)
}

summaryNcdf4_dim <- function(x,varid=NULL){
  if(!is.null(varid)){
     nc <- ncdf_open(x)
     indice_var <- i_varid(nc,varid)
     dim <- nc$var[[indice_var]]$size
     ncdf_close(nc)
  } else stop("Missing varid")
  return(dim)
}

ncdf_open <- function(x){
  nc <- ncdf4::nc_open(x)
  return(nc)
}

ncdf_close <- function(nc){
  ncdf4::nc_close(nc)
  invisible()
}
