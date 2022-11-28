#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_download_modal_server(
    id         = "download_modal_1",
    content_df = reactive(iris),
    title      = "TITLE",
    size       = "s"
  )
}
