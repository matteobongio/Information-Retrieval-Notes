#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.1"
#import "@preview/pinit:0.2.2": *

#let generalbox(color, title, text, ..opts) = {
  showybox(
    title-style: (
      weight: 900,
      color: color.darken(40%),
      sep-thickness: 0pt,
      align: center
    ),
    frame: (
      title-color: color.lighten(80%),
      border-color: color.darken(40%),
      body-color: color.lighten(90%),
      thickness: (left: 1pt),
      radius: (top-right: 5pt, bottom-right:5pt, rest: 0pt)
    ),
    title: title,
    text,
    ..opts
  )
}

// I'm so functional
#let bluebox(title, text, ..opts) = {
  generalbox(blue, title, text, ..opts)
}

#let pinkbox(title, text, ..opts) = {
  generalbox(fuchsia, title, text, ..opts)
}


#let purplebox(title, text, ..opts) = {
  generalbox(purple, title, text, ..opts)
}

#let redbox(title, text, ..opts) = {
  generalbox(red, title, text, ..opts)
}

#let DefCounters = state("defs", 0)

#let Definitionbox(title, text, ..opts) = {
  let defTitle = "Definitions"
  if title != "" {
    DefCounters.update(x => x + 1)
    let c = context DefCounters.get()
    defTitle = "Definition " + c + ": " + title
  }
  generalbox(teal, defTitle, text, ..opts)
}

#let TheoremCnts = state("theorems", 0)

#let TheoremBox(title, text, ..opts) = {
  TheoremCnts.update(x => x + 1)
  let c = context TheoremCnts.get()
  let TheoremTitle = [Theorem ] + c
  if title != "" {
    TheoremTitle += [: ] + title
  }
  generalbox(green, TheoremTitle, text, ..opts)
}


#let ExCnts = state("exmples", 0)

#let Examplebox(text, ..opts) = {
  ExCnts.update(x => x + 1)
  let c = context ExCnts.get()
  generalbox(orange, "Example " + c, text, ..opts)
}


#let Notationbox(text, ..opts) = {
  generalbox(red, "Notation", text, ..opts)
}


