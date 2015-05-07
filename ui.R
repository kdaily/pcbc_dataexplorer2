
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

mySidebar <- sidebarPanel(
  tabsetPanel(id='searchMode',
              tabPanel(
                "mRNA",
                
                selectInput("mrna_search", "Search by:",
                            c("Gene Symbols" = "symbol",
                              "Pathway" = "pathway")),
                
                conditionalPanel(condition = "input.mrna_search == 'symbol'",
                                 h4("Gene symbols:"),
                                 tags$textarea(id="gene_list",
                                               rows=8, cols=20,
                                               paste0(sample_gene_list, collapse='\n'))),
                conditionalPanel(condition = "input.mrna_search == 'pathway'",
                                 selectInput("mrna_pathway",
                                             h5("Pathways:"),
                                             choices = c("Foo", "Bar", "Baz"),
                                             selectize=T, multiple=F))
              ),
              tabPanel("miRNA",
                       h4("miRNA symbols:"),
                       tags$textarea(id="mirna_list",
                                     rows=8, cols=20,
                                     paste0(sample_mirna_list, collapse='\n'))),
              tabPanel("DNA",
                       h4("Chromosomal locations:"),
                       tags$textarea(id="methyl_list",
                                     rows=8, cols=25,
                                     paste0(sample_methyl_list, collapse='\n'))),
              selected="mRNA"),
  width=2)

myMain <- mainPanel(
  h2("View"),
  tabsetPanel(
    tabPanel("mRNA",
             conditionalPanel(
               condition = "input.searchMode == 'mRNA'",
               h3('Selected genes')),
             conditionalPanel(
               condition = "input.searchMode == 'miRNA'",
               h3('Genes targeting selected miRNAs')),
             conditionalPanel(
               condition = "input.searchMode == 'DNA'",
               h3('Genes in selected regions'))
    ),
    tabPanel("miRNA",
             conditionalPanel(
               condition = "input.searchMode == 'mRNA'",
               h3('miRNAs targeting selected genes')),
             conditionalPanel(
               condition = "input.searchMode == 'miRNA'",
               h3('Selected miRNAs')),
             conditionalPanel(
               condition = "input.searchMode == 'DNA'",
               h3('miRNAs in selected regions'))
    ),
    tabPanel("Methylation",
             conditionalPanel(
               condition = "input.searchMode == 'mRNA'",
               h3('Methylation of selected genes')),
             conditionalPanel(
               condition = "input.searchMode == 'miRNA'",
               h3('Search not available.')),
             conditionalPanel(
               condition = "input.searchMode == 'DNA'",
               h3('Methylation of selected regions.'))
    )), width=9)

shinyUI(
  fluidPage(title="PCBC Data Explorer",
            theme=shinytheme("united"),
            sidebarLayout(sidebarPanel=mySidebar, 
                          mainPanel=myMain)
  )
)
