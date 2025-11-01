#import "lib.typ": *

= Information Retrieval

== Lecture 1

#pinkbox("Incidence Matrices", [
  *rows*: terms extracted from the collection

  *Columns*: documents

  *To answer the query*: Bitwise AND of term vectors

  *Issues*:
  - Big and sparse
])

#pinkbox("Inverted Index", [
  for each term, store a list of all documents that contain it, identify each by a `docID`

  Dictionary terms are sorted alphabetically

  - merge: `AND` $O(n + m)$

  - Big and sparse, grows fast
])

#yellowbox("Initial stages of text processing", [
  - Tokenization
  - Normalization (U.S.A. == USA)
  - Stemming (authorization $->$ authorize)
  - Stop Words (remove: the, a, to, of)
])

#yellowbox("Phrase Queries", [
  - a group of words acting like a grammatical unit
])

#pinkbox("Bi-Word indexes", [
  index every consecutive pair of terms in the document as a phrase

  - issues:
    - false positives
    - index blowup
    - impossible for more than bi words, way too big
])

#pinkbox("Posting Lists", [
  - with positional indexes
    - store for each term the positions in which tokens of it appear
  - without positional indexes
    - store just the documents that contain them
])

