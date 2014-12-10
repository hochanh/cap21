jekyll_it <- function(dir=getwd(), images.dir=dir, images.url='',
                      out_ext='.md', in_ext='.rmd', recursive=FALSE) {
  require(knitr, quietly=TRUE, warn.conflicts=TRUE)
  
  # Scan folder for .Rmd files
  files <- list.files(path=dir, pattern=in_ext, 
                     ignore.case=TRUE, recursive=FALSE)
  
  # Check if files converted then not scan
  if (file.exists("knitr.dat")) {
    files2 <- readLines("knitr.dat")
    for (fil in files2) message(paste("Not scan ", fil, sep=''))
    files <- setdiff(files, files2)
  }
  
  # Scanning files not converted
  for (fil in files) {
    message(paste("Scanning ", fil, sep=''))
    files2 <- c(files2, fil)
    content <- readLines(fil)
    message(paste('Processing ', fil, sep=''))
    chap <- unlist(strsplit(content[1], ':'))[2]
    chap <- sub('[[:space:]]+$', '', chap)
    chap <- sub('^[[:space:]]+', '', chap)
    content[nchar(content) == 0] <- ' '
    content[1] <- paste("---\n", "layout: post\n",
    			 				"title: ",chap,
    			 				"\nconverted: yes\n",
    			 				"---\n",
    							content[1],
    							sep="")
    outFile <- paste0("../_posts/",
                      substr(fil, 1, (nchar(fil)-(nchar(in_ext)))),
                      out_ext, sep='')
    outFig <- paste0("../figures/",
                     substr(fil, 12, (nchar(fil)-(nchar(in_ext)))),
                     "/", sep='')
    render_markdown(strict=TRUE)
    render_jekyll(highlight='pygments')
    opts_knit$set(out.format='markdown')
    opts_knit$set(base.dir=images.dir)
    opts_knit$set(base.url=images.url)
    opts_chunk$set(fig.path=outFig,fig.height=5,fig.width=10)
    try(knit(text=content, output=outFile), silent=FALSE)
  }
  
  # Write converted files to knitr.dat
  if (!is.null(setdiff(files, files2))) writeLines(files2, "knitr.dat")
  invisible()
}
jekyll_it()