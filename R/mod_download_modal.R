#' download_modal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import devtools
mod_download_modal_ui <- function(id){
  ns <- NS(id)
  tagList(
    load_all



  )
}

#' download_modal Server Functions
#'
#' @noRd
mod_download_modal_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_download_modal_ui("download_modal_1")

## To be copied in the server
# mod_download_modal_server("download_modal_1")
