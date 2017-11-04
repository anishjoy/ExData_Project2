# Download Data and U/nzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","data.zip")
unzip("data.zip")

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load the library dplyr
library(dplyr)
# Summarize by the year using on data from Baltimore
sum_balti_year_NEI<-NEI %>% filter(fips == "24510") %>% 
        group_by(year) %>% 
        summarize(TotalEmission=sum(Emissions))
# open PNG device and plot the graph
png("Plot2.png")
barplot(sum_balti_year_NEI$TotalEmission,names.arg = (sum_balti_year_NEI$year),
        ylab="PM 25 Emissions (in Tons)", xlab="Year", 
        main="PM25 Emissions in Baltimore over the years 1999-2008")
dev.off()
# The graph clearly shows the PM25 Emissions have gone down between 
#1999 and 2008 but 2005 showed showed an increase as compared to 2002
