#' @title Multiplot for ggplot
#'
#' @description
#' Arranges ggplot objects into a grid
#'
#' @param plotlist [\code{list()}]\cr
#'   A list of ggplot objects. Default is \code{plotlist = NULL}
#' @param cols [\code{integer(1)}]\cr
#'   Number of columns for the grid
#' @param layout [\code{matrix()}]\cr
#'   A matrix specifying the layout. If present, \code{cols} is ignored.
#' @param ...
#' If ggplot objects are not handed over as a list, insert them manually
#'
#' @return NULL
#' @import checkmate
#' @import BBmisc
#' @importFrom grid grid.newpage
#' @importFrom grid pushViewport
#' @importFrom grid viewport
#' @importFrom grid grid.layout
#' @examples
#' library(ggplot2)
#' p1 = ggplot(ChickWeight, aes(x = Time, y = weight, colour = Diet, group=Chick)) +
#'   geom_line() +
#'   ggtitle("Growth curve for individual chicks")
#'
#' # Second plot
#' p2 = ggplot(ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
#'   geom_point(alpha = 0.3) +
#'   geom_smooth(alpha = 0.2, size = 1) +
#'   ggtitle("Fitted growth curve per diet")
#'
#' # Third plot
#' p3 = ggplot(subset(ChickWeight, Time == 21), aes(x = weight, colour = Diet)) +
#'   geom_density() +
#'   ggtitle("Final weight, by diet")
#'
#' # Fourth plot
#' p4 = ggplot(subset(ChickWeight, Time == 21), aes(x = weight, fill = Diet)) +
#'  geom_histogram(colour = "black", binwidth = 50) +
#'  facet_grid(Diet ~ .) +
#'  ggtitle("Final weight, by diet") +
#'  theme(legend.position="none")
#' #multiplot the ggplots
#' multiplot(p1, p2, p3, p4, cols = 2)
#'
#' @export
multiplot = function(..., plotlist = NULL, cols = 1, layout = NULL) {
  # Make a list from the ... arguments and plotlist
  plots = c(list(...), plotlist)
  assertList(plotlist, null.ok = TRUE)
  for (i in seq_along(plots)) {
    assertClass(plots[[i]], classes = c("gg", "ggplot"))
  }
  assertInt(cols, null.ok = FALSE)
  assertMatrix(layout, null.ok = TRUE)



  num.plots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout = matrix(seq(1, cols * ceiling(num.plots / cols)),
      ncol = cols, nrow = ceiling(num.plots / cols))
  }

  if (num.plots == 1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in seq.int(num.plots)) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx = as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
        layout.pos.col = matchidx$col))
    }
  }
}
