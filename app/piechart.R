# Visualization prototype for industrial robot vibration monitoring
library(shiny)
library(ggplot2)
library(plotly)

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
      textOutput("warning_message"),
      plotOutput("pieChart"),
      plotlyOutput("gridPlot")
    )
  )
)

server <- function(input, output) {
  fake_data <- reactiveVal(NULL)

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

      # Simulated data is used here only to demonstrate the intended dashboard UI.
      set.seed(123)
      fake_data(data.frame(
        File = rep(files$name, each = 20),
        Value = sample(c(65, 80, 95, 130), nrow(files) * 20, replace = TRUE)
      ))
    }
  })

  output$pieChart <- renderPlot({
    if (input$option %in% c(
      "水平作動下馬達側(Xa)",
      "水平作動下惰輪側(Xb)"
    )) {
      data <- table(sample(c("65", "80", "95", "130"), 100, replace = TRUE))
    } else {
      data <- table(sample(c("220", "260", "300", "380"), 100, replace = TRUE))
    }

    pie(
      data,
      main = paste("圓餅圖 -", input$option)
    )
  })

  output$gridPlot <- renderPlotly({
    req(fake_data())

    grid_data <- data.frame(
      x = rep(1:5, each = 5),
      y = rep(1:5, times = 5),
      label = sample(c("65", "80", "95", "130"), 25, replace = TRUE)
    )

    p <- ggplot(
      grid_data,
      aes(x = x, y = y, fill = label, text = label)
    ) +
      geom_tile() +
      theme_minimal() +
      theme(
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank()
      )

    ggplotly(p, tooltip = "text")
  })
}

shinyApp(ui, server)
