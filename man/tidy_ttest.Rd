% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model-t.R
\name{tidy_ttest}
\alias{tidy_ttest}
\title{T-test}
\usage{
tidy_ttest(data, model)
}
\arguments{
\item{data}{Data frame with grouping and variable of interest.}

\item{model}{The model specified as the measured variable predicted by
group.}
}
\value{
A tidy summary with fit and coef tibbles
}
\description{
Conducts a t-test, comparing two groups along single variable
}
\examples{

## compre pp_ideology b/w those who follow and don't follow trump
polcom \%>\%
  tidy_ttest(pp_ideology ~ follow_trump) \%>\%
  tidy_summary()

}
