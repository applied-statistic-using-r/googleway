% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/google_place_details.R
\name{google_place_details}
\alias{google_place_details}
\title{Google place details}
\usage{
google_place_details(place_id, language = NULL, simplify = TRUE, key)
}
\arguments{
\item{place_id}{\code{string} A textual identifier that uniquely identifies a
place, usually of the form \code{ChIJrTLr-GyuEmsRBfy61i59si0}, returned from
a place search}

\item{language}{\code{string} The language code, indicating in which language
the results should be returned, if possible. Searches are also biased to the
selected language; results in the selected language may be given a higher ranking.
See the list of supported languages and their codes
\url{https://developers.google.com/maps/faq#languagesupport}}

\item{simplify}{\code{logical} Indicates if the returned JSON should be coerced into a list}

\item{key}{\code{string} A valid Google Developers Places API key}
}
\description{
Once you have a place_id from a Place Search, you can request more details
about a particular establishment or point of interest by initiating a Place
Details request. A Place Details request returns more comprehensive information
about the indicated place such as its complete address, phone number, user
rating and reviews.
}
\examples{
\dontrun{
## search for a specific restaurant, Maha, in Melbourne, firstly using google_places()
res <- google_places(search_string = "Maha Restaurant, Melbourne, Australia",
                     radius = 1000,
                     key = key)

## request more details about the restaurant using google_place_details()
google_place_details(place_id = res$results$place_id, key = key)

}
}
\seealso{
\link{google_places}
}

