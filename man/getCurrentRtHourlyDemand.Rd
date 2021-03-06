% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getCurrentRtHourlyDemand.R
\name{getCurrentRtHourlyDemand}
\alias{getCurrentRtHourlyDemand}
\title{Get Current Realtime Hourly Demand}
\usage{
getCurrentRtHourlyDemand(user = getOption(x = "ISO_NE_USER"),
  password = getOption(x = "ISO_NE_PASSWORD"), out.tz = "America/New_York",
  ...)
}
\arguments{
\item{user}{user account}

\item{password}{password}

\item{out.tz}{output timezone.}

\item{...}{passed to httr functions.}
}
\description{
May need to add \code{config(ssl.verifypeer = FALSE)} if SSL cert cant be found.
}

