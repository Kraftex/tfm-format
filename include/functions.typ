#let tern(bool-expr, true-value, false-value) = if bool-expr { true-value } else { false-value }

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  } else if it == linebreak() {
    "\n"
  }
}

// Not used
#let blankpage() =  context {
  set page(numbering: none, header: none)
  pagebreak()
  pagebreak()
}

#let code-style(styling, body) = {
  [
    #show raw.where(block: true): it => styling(it)
    #body
  ]
}

// Code Styles
#let code-default(it) = it
#let code-default-lines(it) = {
  [
    #for code-line in it.lines {
      [
        #code-line.number #box(height: 11pt)[#line(length: 165%, angle: 90deg, start: (0%, -30%))] #code-line.body \
      ]
    }
  ]
}
#let code-pretty(it) = {
  [
    #show: block.with(fill: luma(240), inset: 1em, radius: 0.5em, width: 100%)
    #show: box.with(fill: luma(240), inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
    #for code-line in it.lines {
      [
        #code-line.number #box(height: 11pt)[#line(length: 165%, angle: 90deg, start: (0%, -30%))] #code-line.body \
      ]
    }
  ]
}
#let code-pretty-no-lines(it) = {
  [
    #show: block.with(fill: luma(240), inset: 1em, radius: 0.5em, width: 100%)
    #show: box.with(fill: luma(240), inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
    #for code-line in it.lines {
      [
        #code-line.body \
      ]
    }
  ]
}
#let code-pretty-no-colour(it) = {
  [
    #show: block.with(fill: luma(240), inset: 1em, radius: 0.5em, width: 100%)
    #show: box.with(fill: luma(240), inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
    #for code-line in it.lines {
      [
        #code-line.number #box(height: 11pt)[#line(length: 165%, angle: 90deg, start: (0%, -30%))] #code-line.text \
      ]
    }
  ]
}

// note function
// Colorful notes to annotate things
#let info-color = color.hsl(203deg, 50%, 75%)
#let question-color = color.hsl(22deg, 88%, 58%) // Like warnning?
#let question-color-stronger = color.hsl(16deg, 88%, 54%)
#let exclamation-color = color.hsl(5deg, 90%, 51%) // Like error?
#let exclamation-color-stronger = color.hsl(2deg, 80%, 47%)
#let note(body) = {
  let lines-str = to-string(body).split("\n")
  let last-line = lines-str.last()
  let lines = lines-str.len()
  let text-color = black
  let sel-color = info-color
  if last-line.contains(regex("\?\?+$")) {
    sel-color = question-color-stronger
    text-color = white
  }
  else if last-line.contains(regex("\?$")) {
    sel-color = question-color
  }
  else if last-line.contains(regex("\!\!+$")) {
    sel-color = exclamation-color-stronger
    text-color = white
  }
  else if last-line.contains(regex("\!$")) {
    sel-color = exclamation-color
  }
  if lines > 1 {
    [
      #show: block.with(fill: sel-color, inset: 1em, radius: 0.5em, width: 100%)
      #show: box.with(fill: sel-color, inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
      #text(text-color)[
        #strong[NOTA:\ ]
        #body
      ]
    ]
  }
  else {
    [
      #show: box.with(fill: sel-color, inset: (x: 3pt), outset: (y: 3pt), radius: 2pt)
      #text(text-color)[
        #strong[NOTA: ]
        #body
      ]
    ]
  }
}

//inner-numbering
#let letters = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
#let inner-numbering(style, n) = {
  if style == "1." {
    return n
  }
  else if style == "A." {
    return letters.at(n - 1)
  }
}

// make-outline-entry
#let make-outline-entry(label, body) = {
  let filler = box(width: 1fr, repeat[.])
  let content = body + " " + filler + counter(page).display()
  block(link(label, strong(content)))
}