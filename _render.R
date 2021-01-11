quiet = "--quiet" %in% commandArgs(FALSE)
formats = commandArgs(TRUE)
travis = !is.na(Sys.getenv('CI', NA))

# provide default formats if necessary
if (length(formats) == 0) formats = c('rmdja::pdf_book_ja', 'rmdja::gitbook_ja')
# render the book to all formats unless they are specified via command-line args
for (fmt in formats) {
  cmd = sprintf("bookdown::render_book('index.Rmd', '%s', quiet = %s)", fmt, quiet)
  res = bookdown:::Rscript(c('-e', shQuote(cmd)))
  if (res != 0) stop('Failed to compile the book to ', fmt)
}
unlink('rmarkdown-cookbook.log')

r = '<body onload="window.location = \'https://bookdown.org/yihui\'+location.pathname">'
if (travis) for (f in list.files('docs', '[.]html$', full.names = TRUE)) {
  x = readLines(f)
  if (length(i <- grep('^\\s*<body>\\s*$', x)) == 0) next
  # patch HTML files in gh-pages if built on Travis, to redirect to bookdown.org
  x[i[1]] = r
  writeLines(x, f)
}

redirect = function(from, to, rootdir = "docs") {
  to = paste0('https://bookdown.org/yihui/rmarkdown-cookbook/', to)
  writeLines(sprintf(
    '<html><head><meta http-equiv="refresh" content="0; URL=\'%s\'" /></head><body><script>window.location = "%s";</script></html>', to, to
  ), file.path(rootdir, from))
}

redirect('r-markdown-components.html', 'rmarkdown-process.html')
redirect('acknowledgements.html', 'acknowledgments.html')

if (length(formats) > 1 && Sys.getenv('USER') == 'yihui') {
  bookdown::publish_book(account = 'yihui', server = 'bookdown.org')
}