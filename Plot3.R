setwd("C:/Users/anish/Desktop/Coursera/ExData_Project2")
# Download Data and Unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","./data/data.zip")
unzip("./data/data.zip",exdir="./data")

# read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Load the library dplyr
library(dplyr)
library(ggplot2)
# Summarize baltimore data by type and year
sum_balti_yrSCC_NEI<-NEI %>% filter(fips == "24510") %>% 
  group_by(type,year) %>% 
  summarize(TotalEmission=sum(Emissions))
# open PNG device and plot the graph
png("Plot3.png")
ggplot(sum_balti_yrSCC_NEI,aes(as.factor(year),TotalEmission)) + 
        geom_bar(stat="identity")+facet_grid(.~type) +
        xlab("Year") + ylab("Total PM25 Emissions(in Tons)") +
        ggtitle("Emission in Baltimore by Source Type")
dev.off()
# The graph clearly shows that almost all the SCC types have shown a drop in
# Emissions. Only point Emissions have gone up


