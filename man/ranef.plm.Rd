\name{ranef.plm}
\alias{ranef.plm}
\alias{ranef}
\title{Extract the Random Effects}

\description{
  Function to calculate the random effects from a \code{plm} object (random effects model).
}

\usage{
\method{ranef}{plm}(object, effect = NULL, \dots)
}

\arguments{
  \item{object}{an object of class \code{"plm"}, needs to be a fitted random effects model,}
  \item{effect}{\code{NULL}, \code{"individual"}, or \code{"time"}, the effects to be 
  extracted, see \bold{Details},}
  \item{\dots}{further arguments (currently not used).}
}

\value{
  A named numeric with the random effects per dimension (individual or time).
}

\details{
Function \code{ranef} calculates the random effects of a fitted random effects model.
For one-way models, the effects of the estimated model are extracted (either individual 
or time effects).
For two-way models, extracting the individual effects is the default (both, argument 
\code{effect = NULL} and \code{effect = "individual"} will give individual effects).
Time effects can be extracted by setting \code{effect = "time"}.

Not all random effect model types are supported (yet?).
}

\seealso{
  \code{\link{fixef}} to extract the fixed effects from a fixed effects model (within model). 
}

\author{Kevin Tappe}

\examples{
data("Grunfeld", package = "plm")
m1 <- plm(inv ~ value + capital, data = Grunfeld, model = "random")
ranef(m1) # individual random effects

# compare to random effects by ML estimation via lmer from package lme4
\dontrun{
  library(lme4)
  m2 <- lmer(inv ~ value + capital + (1 | firm), data = Grunfeld) 
  cbind("plm" = ranef(m1), "lmer" = unname(ranef(m2)$firm))
}

# two-ways RE model, calculate individual and time random effects
data("Cigar", package = "plm")
tw <- plm(sales ~ pop + price, data = Cigar, model = "random", effect = "twoways")
ranef(tw)                   # individual random effects
ranef(tw, effect = "time")  # time random effects

}


%\references{
%}

\keyword{regression}