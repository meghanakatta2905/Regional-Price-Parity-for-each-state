library(dplyr)
library(ggplot)
library(ggplot2)
require("micromapST")
library(micromapST)
library(reshape2)
install.packages("reshape2")
library(reshape2)
install.packages("corrplot")

# Bargraph to visualize the Regional Price Parity by each state:
data <- read.csv("/Users/Meghanakatta/Downloads/RPP.csv")
ggplot(data, aes(x=reorder(States, RPP), y=RPP, fill=RPP)) +
  geom_bar(stat="identity") +
  scale_fill_gradient(low="#ffcccc", high="#660000") +
  ggtitle("Regional Price Parities by State") +
  xlab("State") +
  ylab("Regional Price Parity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.y = element_text(size = 6))+
  geom_text(aes(label=RPP), size=1.0)+coord_flip()

# Micromap to plot the relationship between Gross Domestic Product (GDP) and the Average Personal Income:
state_data <- read.csv("/Users/aakashboenal/Downloads/RPP.csv")
state_data
state_data$Personal.Income <- state_data$Personal.Income / 1000
state_data$GDP <- state_data$GDP / 1000
type <-c('maptail','id','dot','dot')
lab1 <-c(NA,NA,'Average Personal Income','Gross domestic product')
#lab2 <-c(NA,NA,'with 95% confidence intervals','with 95% confidence intervals')
lab3 <-c(NA,NA,'(Values in 000"s)','(Values in 000"s)')
col1 <-c('States','States','Personal.Income','GDP')
col2 <-c(NA,NA,'Personal.Income','GDP')
col3 <-c(NA,NA,'Personal.Income','GDP')
panelDesc <-data.frame(type,lab1,lab3,col1,col2,col3)
panelDesc
fName = "state_data.pdf"
pdf(file=fName,width=7.5,height=10)
micromapST( state_data,
            panelDesc,rowNamesCol ='States',
            rowNames ='full',sortVar ='GDP',
            ascend =FALSE,
            title =c("Comparision of average personal income and GDP of states","Data sourced from the Bureau of Economic Analysis website"),
            ignoreNoMatches =TRUE)
dev.off()

# Correlation Matrix
cor_matrix <- cor(state_data[,2:4])
cor_matrix
corr_df <- reshape2::melt(cor_matrix)

# Create the heatmap (using ggplot2) to plot the relationship between RPP AND GDP:
ggplot(corr_df, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(low="blue", high="red", midpoint=0, limit=c(-1,1), space="Lab", name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(vjust = 1, size = 9),
        axis.text.y = element_text(size = 9))

# Create scatter plot of RPP vs GDP
ggplot(data, aes(x = GDP, y = RPP)) +
  geom_point() +
  labs(x = "GDP", y = "RPP") +
  ggtitle("Scatter Plot of RPP vs GDP")

# Add regression line to the scatter plot
ggplot(data, aes(x = GDP, y = RPP)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "GDP", y = "RPP") +
  ggtitle("Scatter Plot of RPP vs GDP with Regression Line")

