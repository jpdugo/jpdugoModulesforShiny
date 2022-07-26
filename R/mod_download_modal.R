#' download_modal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @export
#' @importFrom shiny NS tagList
mod_download_modal_ui <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("show_modal"), "Download", icon = icon("download"))
  )
}

#' download_modal Server Functions
#'
#' Module used for creating a modalDialog with a download button and options to customize the dataframe to be downloaded.
#'
#' @param id Internal parameters for {shiny}.
#' @param content_df \code{reactive}. A dataframe to download
#' @param title \code{character}. The title of the modal
#' @param size \code{character}. The size of the modal
#' @export
#' @examples
#' library(shiny)
#'
#' if (interactive()) {
#'   ui <- fluidPage(
#'     mod_download_modal_ui("download_modal_1")
#'   )
#'
#'   server <- function(input, output, session) {
#'     mod_download_modal_server(
#'       "download_modal_1",
#'       content_df = reactive(iris),
#'       title      = "TITLE",
#'       size       = "s"
#'     )
#'   }
#'
#'   shinyApp(ui, server)
#' }
mod_download_modal_server <- function(id, content_df, title, size) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    observeEvent(input$show_modal, {
      showModal(
        modalDialog(
          tagList(
            textInput(ns("file_title"), "Enter the Title of the File")
          ),
          title = title,
          size = size,
          footer = downloadButton(ns("download"), "Download"),
          easyClose = TRUE
        )
      )
    })

    output$download <- downloadHandler(
      filename = function() {
        input$file_title
      },
      content = function(file) {
        readr::write_csv(x = content_df(), file = file)
      }
    )
  })
}

## To be copied in the UI
# mod_download_modal_ui("download_modal_1")

## To be copied in the server
# mod_download_modal_server("download_modal_1")
