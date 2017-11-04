setwd("C:/Users/anish/Desktop/Coursera/ExData_Project2")
# Download Data and Unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","./data/data.zip")
unzip("./data/data.zip",exdir="./data")

# read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Load the library dplyr
library(dplyr)
#Summarize Data by year
summary_year_NEI<-NEI %>% group_by(year) %>% summarize(TotalEmission=sum(Emissions))
# open PNG device and plot the graph
png("Plot1.png")
barplot(summary_year_NEI$TotalEmission/10^5,names.arg = (summary_year_NEI$year),
     ylab="PM 25 Emissions (in 10^5 Tons)", xlab="Year", 
     main="PM25 Emissions in US over the years 1999-2008")
dev.off()
# The graph clearly shows the PM25 Emissions have gone down


