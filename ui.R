
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(visNetwork)

factors <- read.csv("factors.csv", header=FALSE)

newsize = 216
numnodes = 64
factors2 = factors[(1:newsize),(1:2)]

primes  <- read.csv("numfactors.csv", header=FALSE)

nedges = matrix(c(2:2*numnodes-1),nrow=numnodes-1, ncol = 2)

for (i in 2:numnodes){
  if (primes[i,2]==2){
    nedges[i-1,2]="groupprime"
  }
  else if (i%%2 == 0){
    nedges[i-1,2]="groupeven"
  }
  else{
    nedges[i-1,2]="groupodd"
  }
}


#TO CREATE NODES
nodes<-data.frame(id = 2:numnodes, label = paste(2:numnodes),group = nedges[,2],font.size = c(20))

#TO CREATE EDGES
edges<-data.frame(from = factors2$V2, to = factors2$V1, arrows = list(to = factors2$V1, enabled=TRUE), font.size = c(20), font.color =c ("black"))




shinyUI(
  fluidPage(
    titlePanel("Factors"), #Web page title
   # sidebarLayout(position = "right",
                #  sidebarPanel("more"),
                  mainPanel(
                    visNetworkOutput("graph",width="100%", height="600px")
                    
                  )
    #)
  )
)
  