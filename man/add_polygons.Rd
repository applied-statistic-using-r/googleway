% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/google_map_layers.R
\name{add_polygons}
\alias{add_polygons}
\title{Add polygon}
\usage{
add_polygons(map, data = get_map_data(map), polyline = NULL, lat = NULL,
  lon = NULL, id = NULL, pathId = NULL, stroke_colour = NULL,
  stroke_weight = NULL, stroke_opacity = NULL, fill_colour = NULL,
  fill_opacity = NULL, info_window = NULL, mouse_over = NULL,
  mouse_over_group = NULL, draggable = NULL, editable = NULL,
  update_map_view = TRUE, layer_id = NULL, z_index = NULL)
}
\arguments{
\item{map}{a googleway map object created from \code{google_map()}}

\item{data}{data frame containing at least a \code{polyline} column,
or a \code{lat} and a \code{lon} column. If Null, the data passed into
\code{google_map()} will be used.}

\item{polyline}{string specifying the column of \code{data} containing
the encoded polyline}

\item{lat}{string specifying the column of \code{data} containing the
'latitude' coordinates. Coordinates must be in the order that defines the path.}

\item{lon}{string specifying the column of \code{data} containing the
'longitude' coordinates. Coordinates must be in the order that defines the path.}

\item{id}{string specifying the column containing an identifier for a polygon.}

\item{pathId}{string specifying the column containing an identifer for each
path that forms the complete polygon. Not required when using \code{polyline},
as each polyline is itself a path.}

\item{stroke_colour}{either a string specifying the column of \code{data}
containing the stroke colour of each polygon, or a valid hexadecimal numeric
HTML style to be applied to all the polygons}

\item{stroke_weight}{either a string specifying the column of \code{data}
containing the stroke weight of each polygon, or a number indicating the
width of pixels in the line to be applied to all the polygons}

\item{stroke_opacity}{either a string specifying the column of \code{data}
containing the stroke opacity of each polygon, or a value between 0 and 1
that will be applied to all the polygons}

\item{fill_colour}{either a string specifying the column of \code{data}
containing the fill colour of each polygon, or a valid hexadecimal numeric
HTML style to be applied to all the polygons}

\item{fill_opacity}{either a string specifying the column of \code{data}
containing the fill opacity of each polygon, or a value between 0 and 1 that
will be applied to all the polygons}

\item{info_window}{string specifying the column of data to display in an
info window when a polygon is clicked}

\item{mouse_over}{string specifying the column of data to display when the
mouse rolls over the polygon}

\item{mouse_over_group}{string specifying the column of data specifying
which groups of polygons to highlight on mouseover}

\item{draggable}{string specifying the column of \code{data} defining if
the polygon is 'draggable'. The column of data should be logical (either TRUE or FALSE)}

\item{editable}{string specifying the column of \code{data} defining if the polygon
is 'editable' (either TRUE or FALSE)}

\item{update_map_view}{logical specifying if the map should re-centre
according to the polyline.}

\item{layer_id}{single value specifying an id for the layer.}

\item{z_index}{single value specifying where the polygons appear in the layering
of the map objects. Layers with a higher \code{z_index} appear on top of those with
a lower \code{z_index}. See details.}
}
\description{
Add a polygon to a google map.
}
\details{
\code{z_index} values define the order in which objects appear on the map.
Those with a higher value appear on top of those with a lower value. The default
order of objects is (1 being underneath all other objects)

\itemize{
  \item{1. Polygon}
  \item{2. Rectangle}
  \item{3. Polyline}
  \item{4. Circle}
}

Markers are always the top layer
}
\note{
A polygon represents an area enclosed by a closed path. Polygon objects
are similar to polylines in that they consist of a series of coordinates in an ordered sequence.
Polygon objects can describe complex shapes, including

\itemize{
  \item{Multiple non-contiguous areas defined by a single polygon}
  \item{Areas with holes in them}
  \item{Intersections of one or more areas}
}

To define a complex shape, you use a polygon with multiple paths.

To create a hole in a polygon, you need to create two paths, one inside the other.
To create the hole, the coordinates of the inner path must be wound in the opposite
order to those defining the outer path. For example, if the coordinates of
the outer path are in clockwise order, then the inner path must be anti-clockwise.

You can represent a polygon in one of three ways
\itemize{
  \item{as a series of coordinates defining a path (or paths) with both an
  \code{id} and \code{pathId} argument that make up the polygon}
  \item{as an encoded polyline using an \code{id} column to specify multiple
  polylines for a polygon}
  \item{as a list column in a data.frame, where each row of the data.frame
  contains the polylines that comprise the polygon}

}

See Examples
}
\examples{
\dontrun{

map_key <- 'your_api_key'

## polygon with a hole - Bermuda triangle
## using one row per polygon, and a list-column of encoded polylines
pl_outer <- encode_pl(lat = c(25.774, 18.466,32.321),
      lon = c(-80.190, -66.118, -64.757))

pl_inner <- encode_pl(lat = c(28.745, 29.570, 27.339),
       lon = c(-70.579, -67.514, -66.668))

df <- data.frame(id = c(1, 1),
       polyline = c(pl_outer, pl_inner),
       stringsAsFactors = FALSE)

df <- aggregate(polyline ~ id, data = df, list)

google_map(key = map_key, height = 800) \%>\%
    add_polygons(data = df, polyline = "polyline")

## the same polygon, but using an 'id' to specify the polygon
df <- data.frame(id = c(1,1),
       polyline = c(pl_outer, pl_inner),
       stringsAsFactors = FALSE)

google_map(key = map_key, height = 800) \%>\%
    add_polygons(data = df, polyline = "polyline", id = "id")

## the same polygon, specified using coordinates, and with a second independent
## polygon
df <- data.frame(myId = c(1,1,1,1,1,1,2,2,2),
      lineId = c(1,1,1,2,2,2,1,1,1),
      lat = c(26.774, 18.466, 32.321, 28.745, 29.570, 27.339, 22, 23, 22),
      lon = c(-80.190, -66.118, -64.757, -70.579, -67.514, -66.668, -50, -49, -51),
      colour = c(rep("#00FF0F", 6), rep("#FF00FF", 3)),
      stringsAsFactors = FALSE)

google_map(key = map_key) \%>\%
  add_polygons(data = df, lat = 'lat', lon = 'lon', id = 'myId', pathId = 'lineId',
               fill_colour = 'colour')



}

}
\seealso{
\link{encode_pl}
}

