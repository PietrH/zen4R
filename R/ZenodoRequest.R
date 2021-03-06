#' ZenodoRequest
#'
#' @docType class
#' @export
#' @keywords Zenodo Request
#' @return Object of \code{\link{R6Class}} for modelling a generic Zenodo request
#' @format \code{\link{R6Class}} object.
#'
#' @section Methods:
#' \describe{
#'  \item{\code{new(url, type, request, data, file, token, logger)}}{
#'    This method is used to instantiate a object for doing an Zenodo request
#'  }
#'  \item{\code{getRequest()}}{
#'    Get the request payload
#'  }
#'  \item{\code{getRequestHeaders()}}{
#'    Get the request headers
#'  }
#'  \item{\code{getStatus()}}{
#'    Get the request status code
#'  }
#'  \item{\code{getResponse()}}{
#'    Get the request response
#'  }
#'  \item{\code{getException()}}{
#'    Get the exception (in case of request failure)
#'  }
#'  \item{\code{getResult()}}{
#'    Get the result \code{TRUE} if the request is successful, \code{FALSE} otherwise
#'  }
#' }
#' 
#' @note Abstract class used internally by \pkg{zen4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#'
ZenodoRequest <- R6Class("ZenodoRequest",
  inherit = zen4RLogger,                    
  #private methods
  private = list(
    url = NA,
    type = NA,
    request = NA,
    requestHeaders = NA,
    data = NA,
    file = NULL,
    status = NA,
    response = NA,
    exception = NA,
    result = NA,
    token = NULL,
    
    #prepareData
    #---------------------------------------------------------------    
    prepareData = function(data){
      if(is(data, "ZenodoRecord")){
        data <- as.list(data)
        data[[".__enclos_env__"]] <- NULL
        for(prop in names(data)){
          if(is(data[[prop]],"function")){
            data[[prop]] <- NULL
          }
        }
        if(!data[["submitted"]]) data[["submitted"]] <- NULL
        if(length(data[["files"]])==0) data[["files"]] <- NULL
        if(length(data[["metadata"]])==0) data[["metadata"]] <- NULL
        data[["links"]] <- NULL
        data[["verbose.info"]] <- NULL
        data[["verbose.debug"]] <- NULL
        data[["loggerType"]] <- NULL
        data <- data[!sapply(data, is.null)]
      }else if(is(data, "list")){
        meta <- data$metadata
        if(!is.null(meta$prereserve_doi)) meta$prereserve_doi <- NULL
        data <- list(metadata = meta)
      }
      
      data <- as(toJSON(data, pretty=T, auto_unbox=T), "character")
      
      return(data)
    },
    
    #GET
    #---------------------------------------------------------------
    GET = function(url, request){
      req <- paste(url, request, sep="/")
      self$INFO(sprintf("Fetching %s", req))
      headers <- c("Authorization" = paste("Bearer",private$token))
      
      r <- NULL
      if(self$verbose.debug){
        r <- with_verbose(GET(req, add_headers(headers)))
      }else{
        r <- GET(req, add_headers(headers))
      }
      responseContent <- content(r, type = "application/json", encoding = "UTF-8")
      response <- list(request = request, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    },
    
    #POST
    #---------------------------------------------------------------    
    POST = function(url, request, data, file = NULL){
      req <- paste(url, request, sep="/")
      if(!is.null(file)){
        contentType <- "multipart/form-data"
        data <- list(file = file, filename = data)
      }else{
        contentType <- "application/json"
        data <- private$prepareData(data)
      }
      
      #headers
      headers <- c("Content-Type" = contentType,
                   "Authorization" = paste("Bearer",private$token))
      
      #send request
      if(self$verbose.debug){
        r <- with_verbose(httr::POST(
          url = req,
          add_headers(headers),
          encode = ifelse(is.null(file),"json", "multipart"),
          body = data
        ))
      }else{
        r <- httr::POST(
          url = req,
          add_headers(headers),
          encode = ifelse(is.null(file),"json", "multipart"),
          body = data
        )
      }
      
      responseContent <- content(r, type = "application/json", encoding = "UTF-8")
      response <- list(request = data, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    },
    
    #PUT
    #---------------------------------------------------------------    
    PUT = function(url, request, data){
      req <- paste(url, request, sep="/")
      
      data <- private$prepareData(data)
      
      #headers
      headers <- c("Content-Type" = "application/json",
                   "Authorization" = paste("Bearer",private$token))
      
      #send request
      if(self$verbose.debug){
        r <- with_verbose(httr::PUT(
          url = req,
          add_headers(headers),    
          body = data
        ))
      }else{
        r <- httr::PUT(
          url = req,
          add_headers(headers),    
          body = data
        )
      }
      
      responseContent <- content(r, type = "application/json", encoding = "UTF-8")
      response <- list(request = data, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    },
    
    #DELETE
    #---------------------------------------------------------------    
    DELETE = function(url, request, data){
      req <- paste(url, request, data, sep="/")
      #headers
      headers <- c("Authorization" = paste("Bearer",private$token))
      if(self$verbose.debug){
        r <- with_verbose(httr::DELETE(
          url = req,
          add_headers(headers)
        ))
      }else{
        r <- httr::DELETE(
          url = req,
          add_headers(headers)
        )
      }
      responseContent <- content(r, type = "application/json", encoding = "UTF-8")
      response <- list(request = data, requestHeaders = headers(r),
                       status = status_code(r), response = responseContent)
      return(response)
    }
      
  ),
  #public methods
  public = list(
    #initialize
    initialize = function(url, type, request, data = NULL, file = NULL,
                          token, logger = NULL, ...) {
      super$initialize(logger = logger)
      private$url = url
      private$type = type
      private$request = request
      private$data = data
      private$file = file
      private$token = token
     
    },
    
    #execute
    execute = function(){
      
      req <- switch(private$type,
        "GET" = private$GET(private$url, private$request),
        "POST" = private$POST(private$url, private$request, private$data, private$file),
        "PUT" = private$PUT(private$url, private$request, private$data),
        "DELETE" = private$DELETE(private$url, private$request, private$data)
      )
      
      private$request <- req$request
      private$requestHeaders <- req$requestHeaders
      private$status <- req$status
      private$response <- req$response
      
      if(private$type == "GET"){
        if(private$status != 200){
          private$exception <- sprintf("Error while executing request '%s'", req$request)
          self$ERROR(private$exception)
        }
      }
    },
    
    #getRequest
    getRequest = function(){
      return(private$request)
    },
    
    #getRequestHeaders
    getRequestHeaders = function(){
      return(private$requestHeaders)
    },
    
    #getStatus
    getStatus = function(){
      return(private$status)
    },
    
    #getResponse
    getResponse = function(){
      return(private$response)
    },
    
    #getException
    getException = function(){
      return(private$exception)
    },
    
    #getResult
    getResult = function(){
      return(private$result)
    },
    
    #setResult
    setResult = function(result){
      private$result = result
    }
    
  )
)