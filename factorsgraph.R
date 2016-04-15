#install.packages("shiny")
#install.packages("visNetwork")

library(shiny)
library(visNetwork)

factors <- read.csv("factors.csv", header=FALSE)

newsize = 153
numnodes = 64
factors2 = factors[(1:newsize),(1:2)]

primes  <- read.csv("numfactors.csv", header=FALSE)

nedges = matrix(c(2:2*numnodes-1),nrow=numnodes-1, ncol = 2)

for (i in 2:numnodes){
  if (primes[i,2]==2){
    nedges[i-1,2]="Prime Numbers"
  }
  else if (i%%2 == 0){
    nedges[i-1,2]="Even Numbers"
  }
  else{
    nedges[i-1,2]="Odd Numbers"
  }
}


#TO CREATE NODES
nodes<-data.frame(id = 2:numnodes, label = paste(2:numnodes),group = nedges[,2],font.size = c(20))

#TO CREATE EDGES
edges<-data.frame(from = factors2$V2, to = factors2$V1, arrows = list(to = factors2$V1, enabled=TRUE), font.size = c(20), font.color =c ("black"))



shinyApp(
  ui = fluidPage(
    titlePanel("Visualizing the Integers as a Directed Graph of Factors"), #Web page title
                  mainPanel(
                    visNetworkOutput("graph",width="100%", height="600px")
                    
                  )
  
  )
  ,
  server = shinyServer(
    function(input, output) {
      output$graph<-renderVisNetwork(visNetwork(nodes,edges, legend = TRUE) %>%
                                       visNodes(title = nodes$title, x = nodes$x, y= nodes$y, size = 30, shadow = TRUE, font = (size = 26))  %>%
                                      visEdges(color = "black")%>%
                                       visGroups(groupname = "Odd Numbers", color  = "lightblue")%>% 
                                       visGroups(groupname = "Even Numbers", color = "red")%>% 
                                       visGroups(groupname = "Prime Numbers", color = "yellow")%>% 
                                       visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
                                        visInteraction(hover = TRUE, zoomView = TRUE) %>%
                                       visPhysics(solver = "forceAtlas2Based", forceAtlas2Based = list(gravitationConstant = -20))
      )
    }
  )
    
)