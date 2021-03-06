\name{model.frame.pFormula}
\alias{model.frame.pFormula}
\alias{model.matrix.pFormula}
\alias{model.matrix.plm}
\alias{model.matrix}
\alias{model.frame}


\title{model.frame and model.matrix for panel data}

\description{Methods to create model frame and model matrix for panel data.
}

\usage{

\S3method{model.frame}{pFormula}(formula, data, \dots, lhs = NULL, rhs = NULL)

\S3method{model.matrix}{pFormula}(object, data,
             model = c("pooling", "within", "Between", "Sum",
                       "between", "mean", "random", "fd"), 
             effect = c("individual", "time", "twoways", "nested"),
             rhs = 1,
             theta = NULL,
             cstcovar.rm = NULL,
             \dots)
                                  
\S3method{model.matrix}{plm}(object, \dots)
}

\arguments{
 \item{object, formula}{an object of class \code{"pFormula"} or an
 estimated model object of class \code{"plm"},}
 \item{data}{a \code{pdata.frame}, see \bold{Details},}
 \item{effect}{the effects introduced in the model, one of
  \code{"individual"}, \code{"time"}, \code{"twoways"} or \code{"nested"},}
 \item{model}{one of \code{"pooling"}, \code{"within"}, \code{"Sum"}, \code{"Between"},
    \code{"between"}, \code{"random",} \code{"fd"} and \code{"ht"},}
 \item{theta}{the parameter for the transformation if \code{model = "random"},}
 \item{cstcovar.rm}{remove the constant columns, one of \code{"none", "intercept", "covariates", "all")},}
 \item{lhs}{inherited from package \code{\link[Formula]{Formula}} (see there),}
 \item{rhs}{inherited from package \code{\link[Formula]{Formula}} (see there),}
 \item{\dots}{further arguments.}
}

\value{
The \code{model.frame} methods return a \code{pdata.frame}.\cr
The \code{model.matrix} methods return a \code{matrix}.
}

\details{
The \code{lhs} and \code{rhs} arguments are inherited from \code{Formula}, see there for
more details.\cr
The \code{model.frame} methods return a \code{pdata.frame} object suitable as an input
to plm's \code{model.matrix}.\cr
The \code{model.matrix} methods builds a model matrix
with transformations performed as specified by the \code{model} and \code{effect}
arguments (and \code{theta} if \code{model = "random"} is requested), in this case the
supplied \code{data} argument should be a model frame created by plm's \code{model.frame}
method. If not, it is tried to construct the model frame from the data.
Constructing the model frame first ensures proper NA handling, see \bold{Examples}.
}

% \references{
% }
\seealso{
  \code{\link{pmodel.response}} for (transformed) response variable.\cr
  \code{\link{pFormula}}, especially for coercing a \code{formula} to a \code{pFormula}.\cr
  \code{\link[Formula]{Formula}} from package \code{Formula}, especially for
  the \code{lhs} and \code{rhs} arguments.
}

\examples{
# First, make a pdata.frame
data("Grunfeld", package = "plm")
pGrunfeld <- pdata.frame(Grunfeld)

# then make a model frame from a pFormula and a pdata.frame
pform <- pFormula(inv ~ value + capital)
mf <- model.frame(pform, data = pGrunfeld)

# then construct the (transformed) model matrix (design matrix)
# from formula and model frame
modmat <- model.matrix(pform, data = mf, model = "within")


## retrieve model frame and model matrix from an estimated plm object
fe_model <- plm(pform, data = pGrunfeld, model = "within")
model.frame(fe_model)
model.matrix(fe_model)

# same as constructed before
all.equal(mf, model.frame(fe_model), check.attributes = FALSE) # TRUE
all.equal(modmat, model.matrix(fe_model), check.attributes = FALSE) # TRUE
}

\author{Yves Croissant}

\keyword{classes}
