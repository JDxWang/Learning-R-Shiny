library(shiny)
library(rvest)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  fluidRow(
    column(12,
           plotOutput(outputId = "tag_freq",
             hover = hoverOpts("hover")),
             div(style = "height:420px")
          ),
         ),
  fluidRow(
    column(6,
           h3("This app shows the frequency of tags for the newest X pages of Ozbargain posts."),
           numericInput("pages", label = "Choose the number of pages to load (1 to 10)", value = 10, max = 10, min = 1)
           ),
    column(6,
           h3("Hover over any column to see the top deal of that category!"),
           h4(uiOutput("top_deals"))
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
    link <- paste('https://www.ozbargain.com.au', link, sep="")
    upvote <- page %>% html_nodes('.voteup span') %>% html_text()
    downvote <- page %>% html_nodes('.votedown span') %>% html_text()
    page_data <- cbind(title, tags, link, upvote, downvote)
    
    # Storing all data in dataframe
    ozb_data <- rbind(ozb_data, page_data)
  } 
  
  # Output data based on user input
  output_tags <- reactive({
    head(ozb_data$tags, 30*input$pages) %>% table() %>% as.data.frame() %>% arrange(Freq)
  })
  
  output_topdeals <- ozb_data %>% group_by(tags) %>% slice(which.max(upvote))

  output$top_deals <- renderText({
    if(is.null(input$hover$x)) return()
    else {
      x_tags <- round(input$hover$x) == output_topdeals$tags %>% as.factor() %>% as.numeric
      output_topdeals$title[x_tags]
    }
  })
  
  output$tag_freq <- renderPlot({
    output_tags() %>% ggplot(aes(x=factor(output_tags()$., level=output_tags()$.), y=Freq, fill=.)) +
                               labs(title="Frequency of Tags", x="Tag", y="Frequency") +
                               geom_bar(stat="identity") +
                               geom_text(aes(label=Freq), vjust = 1.1, color = "black", size = 7) +
                               theme(legend.position = "none", text=element_text(size=20), axis.text.x = element_text(angle=45, hjust=1))
    },
    height = 800
    )
  }

shinyApp(ui = ui, server = server)
