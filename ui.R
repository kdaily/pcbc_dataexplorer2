
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  navbarPage("PCBC Data Explorer", theme=shinytheme("cerulean"),
             
             tabPanel("mRNA",
                      sidebarLayout(
                        sidebarPanel(h3("mRNA Sidebar"),
                                     h4("List of gene symbols:"),
                                     tags$textarea(id="gene_list",
                                                   rows=8, cols=20,
                                                   paste0(sample_gene_list, collapse='\n')), width=3),
                        mainPanel(h2("mRNA-based View"),
                                  p("The input is based on genes. This updates other views using a gene ID mapping."),
                                  tabsetPanel(
                                    tabPanel("mRNA",
                                             h3('Heatmap from selected genes')),
                                    tabPanel("miRNA",
                                             h3('Show heatmap of miRNAs targeting selected genes')),
                                    tabPanel("Methylation",
                                             h3('Show methylation heatmap of selected genes.')),
                                    selected="mRNA"),
                                  width=9
                        )
                      )
             ),

             tabPanel("miRNA",
                      sidebarLayout(
                        sidebarPanel(h3("miRNA Sidebar"),
                                     h4("List of miRNA names:"),
                                     tags$textarea(id="mirna_list",
                                                   rows=8, cols=20,
                                                   paste0(sample_mirna_list, collapse='\n')), width=3),
                        mainPanel(h2("microRNA-based View"),
                                  p("The input is based on micro-RNAs. This updates other views using a miRNA ID mapping."),
                                  tabsetPanel(
                                    tabPanel("mRNA",
                                             h3('Show heatmap of genes targeted by the selected miRNAs')),
                                    tabPanel("miRNA",
                                             h3('miRNA heatmap from selected miRNAs')),
                                    tabPanel("Methylation",
                                             h3('Show methylation heatmap of genes targeted by miRNAs.')),
                                    selected="miRNA"
                                    )
                        )
                      )
             ),
             
             tabPanel("DNA",
                      sidebarLayout(
                        sidebarPanel(h3("DNA Sidebar"),
                                     h4("List of chromosomal locations:"),
                                     tags$textarea(id="methyl_list",
                                                   rows=8, cols=30,
                                                   paste0(sample_methyl_list, collapse='\n')), width=3),
                        mainPanel(h2("DNA-based View"),
                                  p("The input is based on methylated regions. This updates other views using chromosomal locations."),
                                  tabsetPanel(
                                    tabPanel("mRNA",
                                             h3("Show heatmap of genes in chromosomal regions")),
                                    tabPanel("miRNA",
                                             h3("Show heatmap of miRNAs targeting genes in chromosomal regions")),
                                    tabPanel("Methylation",
                                             h3("Show heatmap of methylation probes in chromosomal regions")),
                                    selected="Methylation")
                        )
                      )
             )
             
             
  )
)

