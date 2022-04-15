\name{gjamConditionalParameters}
\alias{gjamConditionalParameters}
\title{Parameters for gjam conditional prediction}
\description{
  Conditional parameters quantify the direct effects of predictors including those that come through other species.
}
\usage{
  gjamConditionalParameters(output, conditionOn, nsim = 2000)
}
\arguments{
  \item{output}{object of \code{\link{class}} "gjam".}

  \item{conditionOn}{a \code{character} vector of responses to condition on (see \bold{Details}).}
  
  \item{nsim}{number of draws from the posterior distribution.}
}
\details{
Responses in \code{ydata} are random with a joint distribution that comes through the residual covariance having mean matrix \code{parameters$sigMu} and standard error matrix \code{parameters$sigSe}. Still, it can be desirable to use some responses, along with covariates, as predictors of others. The responses (columns) in \code{ydata} are partitioned into two groups, a group to condition on (the names included in \code{character vector conditionOn}) and the remaining columns. \code{conditionOn} gives the names of response variables (\code{colnames} for \code{ydata}). The conditional distribution is parameterized as the sum of effects that come directly from predictors in \code{xdata}, in a matrix \code{C}, and from the other responses, i.e., those in \code{conditionOn}, a \code{matrix A}. A third matrix \code{P} holds the conditional covariance.

See examples below.
}
\value{

 \item{\code{Amu}}{posterior mean for matrix \code{A}.} 
 
 \item{\code{Ase}}{standard error for matrix \code{A}.}
 
 \item{\code{Atab}}{parameter summary for matrix \code{A}.}
 
 \item{\code{Cmu}}{posterior mean for matrix \code{C}.} 
 
 \item{\code{Cse}}{standard error for matrix \code{C}.}
 
 \item{\code{Ctab}}{parameter summary for matrix \code{C}.}
 
 \item{\code{Pmu}}{posterior mean for matrix \code{P}.} 
 
 \item{\code{Pse}}{standard error for matrix \code{P}.}
 
 \item{\code{Ptab}}{parameter summary for matrix \code{P}.}
 
}
\examples{
\dontrun{
f   <- gjamSimData(n = 200, S = 10, Q = 3, typeNames = 'CA') 
ml  <- list(ng = 2000, burnin = 50, typeNames = f$typeNames, holdoutN = 10)
output <- gjam(f$formula, f$xdata, f$ydata, modelList = ml)

# condition on three species
gjamConditionalParameters( output, conditionOn = c('S1','S2','S3') )
}
}

\author{
James S Clark, \email{jimclark@duke.edu}
}
\references{
Qiu, T., S. Shubhi, C. W. Woodall, and J.S. Clark. 2021. Niche shifts from trees to fecundity to recruitment that determine species response to climate change. Frontiers in Ecology and Evolution 9, 863. 'https://www.frontiersin.org/article/10.3389/fevo.2021.719141'.
}
\seealso{
\code{\link{gjamSimData}} simulates data

\code{\link{gjam}} fits the model

A more detailed vignette is can be obtained with:

\code{browseVignettes('gjam')}

web site 'http://sites.nicholas.duke.edu/clarklab/code/'.
}

