required_packages <- c(
  "shiny",
  "ggplot2",
  "plotly"
)

missing_packages <- required_packages[
  !required_packages %in% rownames(installed.packages())
]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}
