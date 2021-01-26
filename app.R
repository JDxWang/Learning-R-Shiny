library(shiny)
library(rvest)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  
  titlePanel("Ozbargain Tags"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # User input for number of pages to load
      
      helpText("This app shows the frequency of tags for the newest X pages of Ozbargain posts."),
      
      numericInput("pages", label = "Choose the number of pages to load (1 to 10)", value = 10, max = 10, min = 1)
      
    ),
    
    mainPanel(
      
      # Pie chart output
      
      plotOutput("tag_freq")
      
    )
  )
)


server <- function(input, output) {
  
  ozb <- "https://www.ozbargain.com.au/deals?page="
  
  ozb_data <- data.frame()

  for(i in c(0:9)){
      
    page <- read_html(paste(ozb, i, sep=""))
    
    # Extracting relevant information by reading the HTML
    
    tags <- page %>% html_nodes('.tag a') %>% html_text()
    
    title <- page %>% html_nodes('#is0 .title a') %>% html_text()

    link <- page %>% html_nodes('#is0 .title a') %>% html_attr('href')
    link <- paste('https://www.ozbargain.com.au', link, sep = "")
    
    upvote <- page %>% html_nodes('.voteup span') %>% html_text()

    downvote <- page %>% html_nodes('.votedown span') %>% html_text()

    page_data <- cbind(title, tags, link, upvote, downvote)
    
    # Storing all data in dataframe
    
    ozb_data <- rbind(ozb_data, page_data)
    
  } 
  
  # Output data based on user input
  
  output_tags <- reactive({
    
    head(ozb_data$tags, 30*(input$pages+1))
    
  })
  
  output$tag_freq <- renderPlot({
    
    output_tags() %>% table() %>% pie()
    
  })
  
}


shinyApp(ui = ui, server = server)
