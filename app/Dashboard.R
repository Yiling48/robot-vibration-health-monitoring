# Prototype R Shiny dashboard for industrial robot vibration monitoring
library(shiny)

ui <- fluidPage(
  titlePanel("機械手臂振動情況與健康度"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "option",
        "選擇作動位置:",
        choices = c(
          "水平作動下馬達側(Xa)",
          "水平作動下惰輪側(Xb)",
          "垂直作動下馬達側(Ya)",
          "垂直作動下惰輪側(Yb)"
        )
      ),
      fileInput(
        "file",
        "上傳文件(至多25個):",
        multiple = TRUE,
        accept = ".txt"
      ),
      actionButton("process", "處理文件")
    ),
    mainPanel(
      verbatimTextOutput("fileInfo"),
      textOutput("file_count"),
      textOutput("warning_message")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$process, {
    req(input$file)
    files <- input$file

    if (nrow(files) > 25) {
      output$warning_message <- renderText("上傳的文件數量不能超過25個。")
      output$file_count <- renderText("")
      output$fileInfo <- renderText("")
    } else {
      output$warning_message <- renderText("")
      output$file_count <- renderText(
        paste("上傳的文件數量為:", nrow(files))
      )

      output$fileInfo <- renderPrint({
        switch(
          input$option,
          "水平作動下馬達側(Xa)" = paste("You chose Xa and uploaded", files$name),
          "水平作動下惰輪側(Xb)" = paste("You chose Xb and uploaded", files$name),
          "垂直作動下馬達側(Ya)" = paste("You chose Ya and uploaded", files$name),
          "垂直作動下惰輪側(Yb)" = paste("You chose Yb and uploaded", files$name),
          "Unknown option"
        )
      })
    }
  })
}

shinyApp(ui, server)
