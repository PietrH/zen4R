% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zen4R_downloader.R
\name{download_zenodo}
\alias{download_zenodo}
\title{download_zenodo}
\usage{
download_zenodo("10.5281/zenodo.2547036")
}
\arguments{
\item{doi}{a Zenodo DOI or concept DOI}

\item{path}{the target directory where to download files}

\item{logger}{a logger to print messages. The logger can be either NULL, 
"INFO" (with minimum logs), or "DEBUG" (for complete curl http calls logs)}

\item{...}{any other arguments for parallel downloading (more information at
\link{ZenodoManager}, \code{downloadFiles()} documentation)}
}
\description{
\code{download_zenodo} allows to download archives attached to a Zenodo
record, identified by its DOI or concept DOI.
}
