# User Inputs
folder <- 87
file_number <- 9

# Get data from file

file_name <- paste(folder,"-",file_number,sep="")
dir <- "C:/Users/Jim Tai/Documents/GitHub/Project-Spinosa/Data Visualization - Music Notation/HOMUS/"

subdirectory <- paste(dir,folder,"/",sep="")
setwd(subdirectory)

raw_output <- read.table(paste(file_name,".txt",sep=""), sep="", header=TRUE, fill=FALSE, stringsAsFactors = FALSE)

# Extract the data

extractCoordinateList <- function(row){
  xy_coord <- unlist(strsplit(toString(row[[1]]),";"))
  extractCoordinates <- function(xy){
    tmpout <- strsplit(xy,",")
    data.frame(x=as.numeric(tmpout[[1]][1]), y=as.numeric(tmpout[[1]][2]))
  }
  do.call("rbind",lapply(strsplit(xy_coord," "),extractCoordinates))
}
output <- do.call("rbind",lapply(split(raw_output, seq(nrow(raw_output))),extractCoordinateList))


# Plot the coordinate points
plot_size <- max(output$x,output$y) + 5

plot(0:plot_size,-plot_size:0,type="n")
points(output$x, -output$y, col="black", cex=0.5)
