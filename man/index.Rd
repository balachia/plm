\name{index}
\alias{index}
\alias{index.pdata.frame}
\alias{index.pindex}
\alias{index.pseries}
\alias{index.panelmodel}
\title{Extract the indexes of panel data}

\description{
  This function extracts the information about the structure of the
  individual and time dimensions of panel data. Grouping information
  can also be extracted if the panel data were created with a grouping
  variable.
}

\usage{
\method{index}{pindex}(x, which = NULL, \dots)
\method{index}{pdata.frame}(x, which = NULL, \dots)
\method{index}{pseries}(x, which = NULL, \dots)
\method{index}{panelmodel}(x, which = NULL, \dots)
}

\arguments{
  \item{x}{an object of class \code{"pindex"}, \code{"pdata.frame"},
  \code{"pseries"} or \code{"panelmodel"},}
  \item{which}{the index(es) to be extracted (see details),}
  \item{\dots}{further arguments.}
}

\value{
  A vector or an object of class \code{c("pindex", "data.frame")} containing either 
  one index, individual and time index, or (any combination of) individual, time 
  and group indexes.
}

\details{
  Panel data are stored in a \code{"pdata.frame"} which has an
  \code{"index"} attribute. Fitted models in \code{"plm"} have a
  \code{"model"} element which is also a \code{"pdata.frame"} and
  therefore also has an \code{"index"} attribute. Finally, each series,
  once extracted from a \code{"pdata.frame"}, becomes of class 
  \code{"pseries"}, which also has this \code{"index"} attribute. 
  \code{"index"} methods are available for all these objects.
  The argument \code{"which"} indicates
  which index should be extracted. If \code{which = NULL}, all indexes are
  extracted. \code{"which"} can also be a vector of length 1, 2, or 3 (3 only if the 
  pdata frame was constructed with an additional group index) containing either 
  characters (the names of the individual variable and/or of the
  time variable and/or the group variable or \code{"id"} and \code{"time"}) and \code{"group"} 
  or integers (1 for the individual index, 2 for the time index, and 3 for the group
  index (the latter only if the pdata frame was constructed with such).)
}
  
\seealso{
  \code{\link{pdata.frame}}, \code{\link{plm}}
}

\author{Yves Croissant}

\examples{
data("Grunfeld", package = "plm")
Gr <- pdata.frame(Grunfeld, index = c("firm", "year"))
m <- plm(inv ~ value + capital, data = Gr)
index(Gr, "firm")
index(Gr, "time")
index(Gr$inv, c(2, 1))
index(m, "id")

# with additional group index
data("Produc", package = "plm")
pProduc <- pdata.frame(Produc, index = c("state", "year", "region"))
index(pProduc, 3)
index(pProduc, "region")
index(pProduc, "group")

}

\keyword{attribute}
