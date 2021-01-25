library(shiny)
library(rvest)
library(dplyr)

ui <- fluidPage(
  
  titlePanel("Ozbargain Tags"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      helpText("This app shows the frequency of tags for the newest 10 pages of Ozbargain posts.")
      
    ),
    
    mainPanel(plotOutput("tag_freq"))
    
  )
)


server <- function(input, output) {
  
  ozb <- "https://www.ozbargain.com.au/deals?page="
  
  tags <- c()
  
  pages <- 10
  
  
  for(i in c(1:pages)){
    
    page <- read_html(paste(ozb, i, sep=""))
    
    page <- html_nodes(page, '.tag a')
    
    page <- html_text(page)
    
    tags <- c(tags, page)
    
  }
  
  output$tag_freq <- tags %>% table() %>% pie() %>% renderPlot()
  
}


shinyApp(ui = ui, server = server)





