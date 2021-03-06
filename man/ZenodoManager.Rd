% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ZenodoManager.R
\docType{class}
\name{ZenodoManager}
\alias{ZenodoManager}
\title{ZenodoManager}
\format{
\code{\link{R6Class}} object.
}
\value{
Object of \code{\link{R6Class}} for modelling an ZenodoManager
}
\description{
ZenodoManager
}
\note{
Main user class to be used with \pkg{zen4R}
}
\section{Methods}{

\describe{
 \item{\code{new(url, token, logger)}}{
   This method is used to instantiate the \code{ZenodoManager}. By default,
   the url is set to "https://zenodo.org/api". For tests, the Zenodo sandbox API 
   URL can be used: https://sandbox.zenodo.org/api .
   
   The token is mandatory in order to use Zenodo API deposit actions. By default, 
   \pkg{zen4R} will first try to get it from environment variable 'ZENODO_PAT'.
   
   The logger can be either NULL, "INFO" (with minimum logs), or "DEBUG" 
   (for complete curl http calls logs)
 }
 \item{\code{getLicenses(pretty)}}{
   Get the list of licenses. By default the argument \code{pretty} is set to 
   \code{TRUE} which will returns the list of licenses as \code{data.frame}.
   Set \code{pretty = FALSE} to get the raw list of licenses.
 }
 \item{\code{getLicenseById(id)}}{
   Get license by Id
 }
 \item{\code{getCommunities(pretty)}}{
   Get the list of communities. By default the argument \code{pretty} is set to 
   \code{TRUE} which will returns the list of communities as \code{data.frame}.
   Set \code{pretty = FALSE} to get the raw list of communities.
 }
 \item{\code{getCommunityById(id)}}{
   Get community by Id
 }
 \item{\code{getGrants(pretty)}}{
   Get the list of grants. By default the argument \code{pretty} is set to 
   \code{TRUE} which will returns the list of grants as \code{data.frame}.
   Set \code{pretty = FALSE} to get the raw list of grants.
 }
 \item{\code{getGrantById(id)}}{
   Get grant by Id
 }
 \item{\code{getFunders(pretty)}}{
   Get the list of funders. By default the argument \code{pretty} is set to 
   \code{TRUE} which will returns the list of funders as \code{data.frame}.
   Set \code{pretty = FALSE} to get the raw list of funders.
 }
 \item{\code{getFunderById(id)}}{
   Get funder by Id
 }
 \item{\code{getDepositions(q, size, all_versions, exact)}}{
   Get the list of Zenodo records deposited in your Zenodo workspace. By defaut
   the list of depositions will be returned by page with a size of 10 results per
   page (default size of the Zenodo API). The parameter \code{q} allows to specify
   an ElasticSearch-compliant query to filter depositions (default query is empty 
   to retrieve all records). The argument \code{all_versions}, if set to TRUE allows
   to get all versions of records as part of the depositions list. The argument \code{exact}
   specifies that an exact matching is wished, in which case paginated search will be
   disabled (only the first search page will be returned).
   Examples of ElasticSearch queries for Zenodo can be found at \href{http://help.zenodo.org/guides/search/}{http://help.zenodo.org/guides/search/}.
 }
 \item{\code{getDepositionByConceptDOI(conceptdoi)}}{
   Get a Zenodo deposition record by concept DOI (generic DOI common to all deposition record versions)
 }
 \item{\code{getDepositionByDOI(doi)}}{
   Get a Zenodo deposition record by DOI.
 }
 \item{\code{getDepositionById(recid)}}{
   Get a Zenodo deposition record by its Zenodo specific record id.
 }
 \item{\code{getDepositionByConceptId(conceptrecid)}}{
   Get a Zenodo deposition record by its Zenodo concept id.
 }
 \item{\code{depositRecord(record, publish)}}{
   A method to deposit/update a Zenodo record. The record should be an object
   of class \code{ZenodoRecord}. The method returns the deposited record
   of class \code{ZenodoRecord}. The parameter \code{publish} (default value
   is \code{FALSE}) can be set to \code{TRUE} (to use CAUTIOUSLY, only if you
   want to publish your record)
 }
 \item{\code{depositRecordVersion(record, publish)}}{
   A method to deposit a new version for a published record. For details about
   the behavior of this function, see \href{https://developers.zenodo.org/#new-version}{https://developers.zenodo.org/#new-version}
 }
 \item{\code{deleteRecord(recordId)}}{
   Deletes a Zenodo record based on its identifier.
 }
 \item{\code{deleteRecordByDOI(doi)}}{
   Deletes a Zenodo record based on its DOI. This DOI is necessarily a pre-reserved DOI corresponding to a draft record,
    and not a published DOI, as Zenodo does not allow to delete a record already published.
 }
 \item{\code{deleteRecords(q)}}{
   Deletes all Zenodo deposited (unpublished) records. The parameter \code{q} allows 
   to specify an ElasticSearch-compliant query to filter depositions (default query 
   is empty to retrieve all records). Examples of ElasticSearch queries for Zenodo 
   can be found at \href{http://help.zenodo.org/guides/search/}{http://help.zenodo.org/guides/search/}. 
 }
 \item{\code{createEmptyRecord()}}{
   Creates an empty record in the Zenodo deposit. Returns the record
   newly created in Zenodo, as an object of class \code{ZenodoRecord}
   with an assigned identifier.
 }
 \item{\code{editRecord(recordId)}}{
   Unlocks a record already submitted. This is required to edit metadata of a Zenodo
   record already published.
 }
 \item{\code{discardChanges(recordId)}}{
   Discards changes operated on a record.
 }
 \item{\code{publishRecord(recordId)}}{
   Publishes a deposited record online.
 }
 \item{\code{getFiles(recordId)}}{
   Get the list of uploaded files for a deposited record
 }
 \item{\code{uploadFile(path, recordId)}}{
   Uploads a file for a given Zenodo deposited record
 }
 \item{\code{deleteFile(recordId, fileId)}}{
   Deletes a file for a given Zenodo deposited record
 }
 \item{\code{getRecords(q, size, all_versions, exact)}}{
   Get the list of Zenodo records. By defaut the list of records will be returned by
    page with a size of 10 results per page (default size of the Zenodo API). The parameter 
    \code{q} allows to specify an ElasticSearch-compliant query to filter depositions 
    (default query is empty to retrieve all records). The argument \code{all_versions}, 
    if set to TRUE allows to get all versions of records as part of the depositions list. 
    The argument \code{exact} specifies that an exact matching is wished, in which case 
    paginated search will be disabled (only the first search page will be returned).
    Examples of 
   ElasticSearch queries for Zenodo can be found at \href{http://help.zenodo.org/guides/search/}{http://help.zenodo.org/guides/search/}.
 }
 \item{\code{getRecordByConceptDOI(conceptdoi)}}{
   Get a Zenodo published record by concept DOI (generic DOI common to all record versions)
 }
 \item{\code{getRecordByDOI(doi)}}{
   Get a Zenodo published record by DOI.
 }
 \item{\code{getRecordById(recid)}}{
   Get a Zenodo published record by its Zenodo specific record id.
 }
 \item{\code{getRecordByConceptId(conceptrecid)}}{
   Get a Zenodo published record by its Zenodo concept id.
 }
}
}

\examples{
\dontrun{
  ZENODO <- ZenodoManager$new(
     url = "https://sandbox.zenodo.org/api",
     token = "<your_token>",
     logger = "INFO"
  )
  
  #create (deposit) an empty record
  newRec <- ZENODO$createEmptyRecord()
  
  #create and fill a local (not yet deposited) record
  myrec <- ZenodoRecord$new()
  myrec$setTitle("my R package")
  myrec$setDescription("A description of my R package")
  myrec$setUploadType("software")
  myrec$addCreator(
    firstname = "John", lastname = "Doe",
    affiliation = "Independent", orcid = "0000-0000-0000-0000"
   )
  myrec$setLicense("mit")
  myrec$setAccessRight("open")
  myrec$setDOI("mydoi") #use this method if your DOI has been assigned elsewhere, outside Zenodo
  myrec$addCommunity("ecfunded")
  
  #deposit the record 
  myrec <- ZENODO$depositRecord(myrec)
  
  #publish a record (with caution!!)
  #this method will PUBLISH the deposition done earlier
  ZENODO$publishRecord(myrec$id)
  #With even more caution the publication can be done with a shortcut argument at deposit time
  ZENODO$depositRecord(myrec, publish = TRUE)
  
  #delete a record (by id)
  #this methods only works for unpublished deposits 
  #(if a record is published, it cannot be deleted anymore!)
  ZENODO$deleteRecord(myrec$id)
  
  #HOW TO UPLOAD FILES to a deposit
  
  #upload a file
  ZENODO$uploadFile("path/to/your/file", myrec$id)
  
  #list files
  zen_files <- ZENODO$getFiles(myrec$id)
  
  #delete a file?
  ZENODO$deleteFile(myrec$id, zen_files[[1]]$id)
}

}
\author{
Emmanuel Blondel <emmanuel.blondel1@gmail.com>
}
\keyword{manager}
\keyword{zenodo}
