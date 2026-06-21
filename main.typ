// UPM guidelines: https://www.fi.upm.es/docs/estudios/muii/1957_Guia_elaboracion_TFMUII.pdf
// Using this as an example: https://github.com/bsp0109/ieee-typst-template/blob/main/template.typ
// To include another file: https://forum.typst.app/t/how-to-embed-one-document-in-another/1045
#import "include/configuration.typ": *

#show: upm-tfm.with(
  // title: Title of your TFM
  //    It can be a content or a string
  title: [Título del Trabajo, con Mayúscula en
    Todas las Palabras que no Sean
    Conectivas (Artículos, Preposiciones,
    Conjunciones)],

  // author: Your full name
  author: "<<Autor del trabajo>>",

  // tutor: Your profesor full name in charge of your work
  tutor: "<<Tutor del trabajo>>",

  // tutor-department: Your profesor department name
  //    Here you can find it: https://www.fi.upm.es/?id=estructura/departamentos
  //    Or just ask your tutor
  tutor-department: "<<Departamento del tutor>>",

  // master: Name of your master degree
  master: [Ingeniería Informática],

  // lang: Languange to have spell checking for the whole document
  lang: "es",

  // abs-lang: To get check language spelling in the abstract
  abs-lang: "en",

  // text-font: Default font to use, they recommend the following
  //    - URW Bookman (similar to Bookman Old Style)
  //    - EB Garamond (similar to Garamond)
  //    - Gelasio (similar to Georgia)
  //    - P052 (similar to Palatino Linotype)
  text-font: "URW Bookman",

  // code-font: Default font to use to display code, they recommend the following
  //    - Inconsolata (similar to Consolas)
  //    - Roboto Mono
  code-font: "Inconsolata",

  // code-style: A function that tells how to display code blocks
  //    You can write your own function but there are severals predifined:
  //    - code-default: Default format
  //    - code-default-lines: Default format but adding numbering lines
  //    - code-pretty: Put the default format into a round grey box with numbering lines
  //    - code-pretty-no-lines: Put the default format into a round grey box
  //    - code-pretty-no-colour: Put the text format into a round grey box
  code-style: code-pretty-no-colour,

  // title-page: Default function on how to display the title page
  //    In this way you can create your own function or just modify upm-title-page
  //title-page: upm-title-page,

  // preface: Default function on how to display the preface
  //    In this way you can create your own function or just modify upm-preface
  //preface: upm-preface,

  // pre-extra-files: Array of extra files to be put between Abstract and Content table
  //    Useful if you want to add your Acknowledgements
  pre-extra-files: (),

  // extra-outlines: A list of dictionaries with the keys of title, target or other argument for outline function
  //    The following targets are useful:
  //    - Para las imágenes:  figure.where(kind: image)
  //    - Para las tablas:    figure.where(kind: table)
  extra-outlines: ( // Ejemplo
    (title: [Índice de figuras], target: figure.where(kind: image)),
    (title: [Índice de tablas], target: figure.where(kind: table)),
  ),
  
  // author-pretext: Pretext that introduce author name
  author-pretext: "Autor(a)",

  // tutor-pretext: Pretext that introduce tutor name
  tutor-pretext: "Tutor(a)",

  // date: Text of the date with the following format: month year
  date: "<<mes año>>",

  // section-dir: When this param is set to a string, it enables writting using sections that are typst files that can be found in that directory
  section-dir: "sections",

  // section-files: Array of files to be the main content instead of what find here in the main body
  // If you don't want to have anything in the same file, you can use sections
  //  in that way you could write any chapter in a separate file
  section-files: (
    "1 introduction.typ",
    "2 development.typ",
    "3 results.typ",
  ),

  // bibliography: Bibliography type of Typst usually comes from calling 'bibliography' function
  //bibliography: bibliography("references.bib"),

  // post-extra-files: Array of extra files to be put at the end of the work
  //    Useful if you want to add an Annexe
  post-extra-files: ("annexe.typ"),

  // experimental: Extra functionality that is not fully tested, doesn't have the best result or provokes some warnings. Be careful using it.
  experimental: (
    // Add annexe on the content table
    annexe-show: false,

    // Fix page anchor for Annexe entry, use tag <annexe> as describe in annexe.typ
    //  Emits a warnning when there's more than one appendix
    annexe-as-tag: false,

    // Try to check if files exists before procesing, but not works correctly
    check-exist-files: false,
  )
)