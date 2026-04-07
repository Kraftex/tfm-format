// This is needed to do the headers easier
#import "@preview/hydra:0.6.2": hydra
#import "functions.typ": *

#let upm-title-page(
  title,
  author,
  tutor,
  work-type,
  degree-type,
  degree-name,
  date: none,
  author-pretext: none,
  tutor-pretext: none
) = {
  // Images and Univeristy & College name
  grid(
    columns: (1fr, 3fr, 1fr),
    align: center,
    image("EscUpm.png"),
    grid(
      columns: auto,
      align: center,
      text(20pt)[Universidad Politécnica\ de Madrid],
      text(14pt)[\ *Escuela Técnica Superior de\ Ingenieros Informáticos*]
    ),
    image("FacInformatica.png", width: 80%)
  )

  // Degree info
  v(1cm)
  align(center)[#text(14pt)[#degree-type Universitario en #degree-name]]
  v(.7cm)
  align(center)[#text(20pt)[#work-type]]

  // Title
  v(.25cm)
  align(center)[#text(21pt)[*#title*]]

  // Author & Tutor
  v(5cm)
  align(left)[#text(14pt)[#author-pretext: #author\ #tutor-pretext: #tutor]]

  // Date
  v(4cm)
  align(center)[Madrid, #date]
  
  pagebreak()
}

#let upm-preface(
  title,
  author,
  tutor,
  work-type,
  degree-type,
  degree-name,
  date: none,
  author-pretext: none,
  tutor-pretext: none,
  tutor-department: none
) = {
  [Este Trabajo Fin de Máster se ha depositado en la ETSI Informáticos de la Universidad Politécnica de Madrid para su defensa.]
  v(4cm)

  // Summary
  [
    #emph(work-type)\
    #emph[#degree-type Universitario en #degree-name]
    #grid(
      columns: (auto, auto),
      gutter: 4pt,
      emph[Título:],
      to-string(title).replace("\n", " ").replace(regex("[ ]+"), " ")
    )
    #date
  ]

  // Autor & Tutor
  v(4cm)
  grid(
    columns: (auto, auto),
    gutter: 4pt,
    row-gutter: 7pt,
    emph[#author-pretext:], [#author],
    emph[#tutor-pretext:], [#tutor\
                            #tutor-department\
                            ETSI Informáticos\
                            Universidad de Madrid]
    )
}

#let upm-tfm(
  title: [Título del Trabajo, con Mayúscula en
    Todas las Palabras que no Sean
    Conectivas (Artículos, Preposiciones,
    Conjunciones)],
  author: "<<Autor del trabajo>>",
  tutor: "<<Tutor del trabajo>>",
  tutor-department: "<<Departamento del tutor>>",
  master: "<<Título del máster>>",
  lang: "es",
  abs-lang: "en",
  text-font: "Bookman Old Style",
  code-font: "Consolas",
  code-style: code-default,
  title-page: upm-title-page,
  preface: upm-preface,
  pre-extra-files: (),
  author-pretext: "Autor(a)",
  tutor-pretext: "Tutor(a)",
  date: "<<mes año>>",
  section-dir: none,
  section-files: (),
  bibliography: bibliography("../references.bib", style: "ieee"),
  post-extra-files: (),
  experimental: (
    annexe-show: false,
    annexe-as-tag: false,
    check-exist-files: false
  ),
  // show-instructions: false, // TODO: Do it?
  body
) = {
  // Error handling
  //// Files exists?
  if "check-exist-files" in experimental and experimental.check-exist-files {
    let files = pre-extra-files
    if type(files) == str {
      files = (pre-extra-files, )
    }
    [
      #for file in files {
        check-file("../" + file)
      }
    ]
    files = section-files
    if type(files) == str {
      files = (pre-extra-files, )
    }
    [
      #for file in files {
        check-file("../" + section-dir + "/" + file)
      }
    ]
    files = post-extra-files
    if type(files) == str {
      files = (post-extra-files, )
    }
    [
      #for file in files {
        check-file("../" + file)
      }
    ]
    return
  }

  // Configuration I
  show link: set text(font: code-font)
  set math.equation(numbering: "(1)")
  set heading(supplement: [Hidden])
  set list(indent: 1.5em, spacing: 1.3em)
  set enum(indent: 1.5em, spacing: 1.3em)
  set document(title: title, author: (author, tutor))
  set text(lang: lang, font: text-font, size: 11pt)
  set page(paper: "a4", margin: (top: 3cm, bottom: 3cm, left: 2.54cm, right: 2.54cm))

  // Code blocks
  show raw: set text(font: code-font, size: 11pt)
  show raw.where(block: true): it => code-style(it)

  // Title page
  title-page(title, author, tutor, "Trabajo Fin de Máster", "Máster", master,
    date: date,
    author-pretext: author-pretext,
    tutor-pretext: tutor-pretext
  )

  // Configuration II
  set par(justify: true)

  // Preface
  preface(title, author, tutor, "Trabajo Fin de Máster", "Máster", master,
    date: date,
    author-pretext: author-pretext,
    tutor-pretext: tutor-pretext,
    tutor-department: tutor-department
  )

  // Configuration III
  set page(numbering: "i")
  counter(page).update(1)
  show heading: it => {
    if it.level == 1 {
      // https://github.com/typst/typst/discussions/3122
      state("content.switch").update(false)
      pagebreak(weak: true, to:"odd")
      state("content.switch").update(true)
      
      if counter(heading).get().first() == 0 {
        block[
          #v(3cm)
        ]
      } else {
        block[
          #v(2.5cm)
          #text(size: 21pt)[#it.supplement #inner-numbering(it.numbering, counter(heading).get().first())]
          #v(0.5cm)
        ]
      }
      block[
        #text(size: 25pt)[#it.body]\ \ \
      ]
    }
    else {
      it
    }
  }
  set page(
    header: context {
      let page = here().page()
      let is-start-chapter = query(heading.where(level:1))
        .map(it => it.location().page())
        .contains(page)
      if not state("content.switch", false).get() and not is-start-chapter {
        return
      }
      state("content.pages", (0,)).update(it => {
            it.push(page)
            return it
          })
    },
    footer: context { // To control page numbering
      let has-content = state("content.pages", (0,)).get()
        .contains(here().page())
      if has-content {
        align(center, counter(page).display())
      }
    }
  )
  
  // Add Resumen & Abstract
  include "../resumen.typ"
  set text(lang: abs-lang)
  include "../abstract.typ"
  set text(lang: lang)

  // Include extra files
  if type(pre-extra-files) == array {
    for file in pre-extra-files {
      include "../" + file
    }
  } else if type(pre-extra-files) == str {
    include "../" + pre-extra-files
  }

  // Content table
  let outline-entry-function
  let select-outline-function = "annexe-show" in experimental and experimental.annexe-show and "annexe-as-tag" in experimental and experimental.annexe-as-tag
  if select-outline-function {
    outline-entry-function = it => {
      let label-annexe = <annexe>
      let is-set-annexe = state("is-set-annexe", false)
      if it.element.supplement == [Hidden] {none}
      else if it.element.level == 1 {
        context if not is-set-annexe.get() {
          let found = query(selector(label-annexe).before(it.element.location()))
          if found.len() > 0 {
            show link: set text(font: text-font)
            show repeat: none
            v(1em)
            block(link(label-annexe, strong({
              "Anexo "
              box(width: 1fr, it.fill)
              it.page()
            })))
            is-set-annexe.update(true)
          }
        }
        show repeat: none
        v(1em)
        strong(it)
      }
      else {
        it
      }
    }
  }
  else {
    outline-entry-function = it => {
      if it.element.supplement == [Hidden] {none}
      else if it.element.level == 1 {
        show repeat: none
        v(1em)
        strong(it)
      }
      else {
        it
      }
    }
  }
  show outline.entry: outline-entry-function
  heading(level: 1)[Tabla de contenidos]
  outline(title: none)
  
  // Configuration V (body)
  set heading(numbering: "1.", supplement: [Capítulo])
  set page(numbering: "1")
  set page(header: 
    context {
      // Adding things to fix the starting of chapters in odd pages
      let n_page = here().page()
      let is-start-chapter = query(heading.where(level:1))
        .map(it => it.location().page())
        .contains(n_page)
      if not state("content.switch", false).get() and not is-start-chapter {
        return
      }
      state("content.pages", (0,)).update(it => {
            it.push(n_page)
            return it
          })
        
      // Using hydra to display headers with the name of the chapter
      if calc.odd(counter(page).get().first()) {
        hydra(display: (ctx, content) => [
          *#counter(heading).get().first(). #content.body*
          #line(length: 100%, stroke: 0.2mm)
        ], 1)
      } else {
        hydra(display: (ctx, content) => [
          #align(right, content)
          #line(length: 100%, stroke: 0.2mm)
        ], skip-starting: false, 2)
      }
    }
  )
  
  // Body
  context {
    counter(page).update(calc.rem(counter(page).get().first(), 2))
  }
  
  if type(section-dir) == str {
    for file in section-files {
      include "../" + section-dir + "/" + file
    }
  }
  else {
    body
  }

  // Resetting things for the rest of the document
  show heading.where(level: 1): set heading(numbering: none, supplement: "Bibliografía")
  counter(heading).update(0)
  
  // References
  bibliography

  // Setting up format for Annexe
  show heading.where(level: 1): set heading(numbering: "A.", supplement: "Apéndice")
  counter(heading).update(0)

  // Annexe entry to show up in the table content
  let annexe-fallback = "annexe-as-tag" not in experimental or not experimental.annexe-as-tag
  annexe-fallback = annexe-fallback and "annexe-show" in experimental and experimental.annexe-show
  if annexe-fallback {
    show heading: none
    heading(numbering: none)[Anexo]
  }

  // Annexe or other files
  if type(post-extra-files) == array {
    for file in post-extra-files {
      include "../" + file
    }
  } else if type(post-extra-files) == str {
    include "../" + post-extra-files
  }
}
