library(shiny)
library(rvest)
library(dplyr)

ui <- fluidPage(
  
  titlePanel("Ozbargain Tags"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      helpText("This app shows the frequency of tags for the newest X pages of Ozbargain posts."),
      
      numericInput("pages", label = "Choose the number of pages to load (1 to 10)", value = 10, max = 10, min = 1)
      
    ),
    
    mainPanel(
      
      plotOutput("tag_freq")
      
    )
  )
)


server <- function(input, output) {
  
  ozb <- "https://www.ozbargain.com.au/deals?page="
  
  ozb_tags <- c()

  for(i in c(1:10)){
      
    page <- read_html(paste(ozb, i, sep=""))
    
    tags <- page %>% html_nodes('.tag a') %>% html_text()
    
    ozb_tags <- c(ozb_tags, tags)
    
  } 
  
  output_tags <- reactive({
    
    head(ozb_tags, 30*input$pages)
    
  })
  
  output$tag_freq <- renderPlot({
    
    output_tags() %>% table() %>% pie()
    
  })
  
}


shinyApp(ui = ui, server = server)





