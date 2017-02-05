var marked = require('marked');
marked.setOptions({
  renderer: new marked.Renderer(),
  gfm: true,
  tables: true,
  breaks: false,
  pedantic: false,
  sanitize: false,
  smartLists: true,
  smartypants: false
});

fs = require('fs')
fs.readFile('slides/1.md', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  console.log(marked(data));
});

