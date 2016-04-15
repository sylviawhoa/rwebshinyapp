
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(visNetwork)

shinyUI(
  fluidPage(
    titlePanel("Visualizing the Integers as a Directed Graph of Factors"), #Web page title
   # sidebarLayout(position = "right",
                #  sidebarPanel("more"),
                  mainPanel(
                    visNetworkOutput("graph",width="100%", height="600px")
                    
                  )
    #)
  )
)
  