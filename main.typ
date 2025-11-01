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

== Lecture 2

datasets are too big for memory, we need to use disk

external sorting algorithms because seek time on disks are too slow

#pinkbox("Blocked Sort Based Indexing (BSBI)", [
  + Divide the data set
  + build a mapping term $->$ termID
  + Fetch a block onto memory
  + Sort it based on termIf $->$ docId, then sort inside each term's posting list by docID
  + store results and repeat
  + when done with all blocks, fetch $n$ rows from each block and merge positings list
    from lowest to highest termID
  + after dealing with each termID store it on disk and fetch next $m$ rows
])

#pinkbox("Single Pass In-Memory Indexing", [
  + Block Construction
    - read one doc at a time
    - tokenize into terms
    - insert each term into the in-memory dictionary
    - add the document ID to that term's postings list
    - if memory is full: 
      - Sort the dictionary by terms, write to block, clear memory
  + Block Merging
    - open all blocks from disk
    - merge them term by term
    - for each term combine postings lists
    - write the merged result to the final index

  - Compression of terms and postings
])

#yellowbox("Distributed Indexing", [
  Data collections are often large, so we do them on several machines

  - Master machine
    - fault tolerant,
    - break construction of inverted index into parallel tasks and assign machines to them
    - transform term-partitioned index into document-partitioned index
      - *term-partitioned*: one maching handles a range of terms
      - *document-partitioned*: one machine handles a range od documents, each machine has its own
        inverted index
])

#pinkbox("Zipf's Law", [
  Approximates the Frequency of the ith most used term
  $
    c_(f i) = k/i
  $
  - $k$ is the normalising constant
  - most frequent term occurs $c_(f 1)$ times
  - secound most frequent term occurs $c_(f 1/2)$ times
])

== Lecture 3

#pinkbox("Reference Collections", [
  Labelled dataset required to evaluate an IR system
])

#yellowbox("Retrieval Metrics", [
  - *Precision and recall*
    - *Precision*: fraction of retrieved documents that are relevant
    - *Recall*: fraction of relevant documents that are retrieved
    - *Issues*:
      - Estimation of maximum recall is impossible, data sets are too big
      - averaging may not show anomalies
  - *Single Value summaries*
    - *Average Precision at n*: average precision with the first n results
    - *Mean Average Precision (MAP)*
    - *R-Precision*\
      compute precision at the Rth position in the results:\
      R: number of relevant docs 
    - *Mean reciprocal rank*
    - *E-measure*: combination of precision and recall, user specified weights to each
    - *F-measure*: harmonic mean precision and recall
  - *User Oriented Measures*
    - *Coverage Ratio*: fraction of documents known and relevant that are in the answer set
    - *Novelty Ratio*: fraction of relevant documents in the answer set that are unknown to the
      user
  - *Discounted Cumulative Gain*
    - Highly relevant documents should be at the top, if they aren't, that s bad
  - *Rank Correlation Metrics*
])

== Lecture 4 & 5

#pinkbox("Natural Language Processing", [
  make machines understand human language
  - Tokenization
  - Stop Words (remove: the, a, to, of)
  - Normalization (U.S.A. == USA)
    - Lemmatisation
])

#pinkbox("Forward List", [
  Inverted Index, but the indexed dictionary is by document name $->$ list of terms
])


#greenbox("Wildcard Queries", [
  "\*" \
  search trees work well for trailing wildcard. also: B-trees, reverse B-trees exist

  - *k-gram indexes*: store k-length sections of words, and search against those
  - *spelling correction*: 
    - *edit-distance (Levenshtein Distance)*:
      minimum number of edit operations required to transform string 1 into string 2
        (insert, delete, replace)
    - *k-gram overlap*
])


#pinkbox("Heaps' Law", [
  number of distinct words in a distance of size $n$ = $K n^beta$, where $K$ and $beta$ are
    empirecally determind constants

  basically, number of distinct words grows exponentially with number of documents
])


#pinkbox("Vector Space Model", [
  create term by document matrix:
  - generate $m times n$ matrix where
    - $m$: number of unique terms in documents
    - $n$ number of documents
  - very sparse
  *Just and incidence matrix*

  - Do vector comparision like 
    - cosine operator
    - Euclidian Distance
    - Manhattan Distance
    - Pearson correlation
    - spearman correlation
  using a query vector and matric columns to find the closest
])

#pinkbox("Term Frequency Model", [
  - issues:
    - facors long documents
    - easy to cheat
    - repetition does not mean terms are relevant

  $
    f_(i j) log( n / (sum_j chi(f_(i j))))
  $
])

== Lecture 6

#greenbox( "Term Frequency", [
  Frequent terms in a document are more important
  - Raw count: $t f(t, d) = f_(t,d)$
  - Normalized: $t f(t, d) = f_(t,d)/(max_t^' f_(t,d))$
      prevents bias toward longer documents
  - log-scaled: $t f(t, d) = 1 +  log(f_(t,d))$
      diminishing returns for high counts
])

#greenbox("Term Frequency - Inverse Document Frequency", [
  High if frequent in a document but rare across the dataset

  $w_(t,d) = t f (t,d) times log(N/(d f(t)))$
])

#pinkbox("Vector Space Model", [
  - each dimension correspondes to a term in the vocabulary
  - similarity between a query and a document is measured e.g. cosine similarity.

  - relevance feedback is a process of adjusting the query vector so that it points closer 
    to relevant documents and further from non-relevant ones

  - pros:
    - simple
    - good performance
    - partial matching
    - term wighting
  - cons:
    - high dimensionality
    - no term ordering
    - assumes term independence
    - no handling synonyms
])

#bluebox("Rocchio algorithm", [
  - relevance feedback
  - improve search queries bsaed on user feedback
  + ask the user which documents are relevant and which are not relevant, 
    move the query towards the centroid of relevant docs, move away from center of 
    non-relevant docs, keep part of the origional quet so that it doesn t drift too far

  New Query = Original Query + Boost from Relevant Docs – Penalty from Non-Relevant Docs.

  - Issues:
    - easier to know what is relevant than what is not relevant
    - non relevant documents are not in a group, they are dispersed

  - *Variants*:
    - *positive-only feedback*
    - *IDE dev-hi*
      (use only the highest ranked non-relevant document, dec-hi = decrement-highest weight)
])

#greenbox("Probabilistice Model of Relevance/Binary Independence Model", [
  - attempts to fix Rocchio by not assuming that relevance 
    can be represented by a single controid in vector space

  - Binary representation (word is in or not in document, not counted)
  - Query term independence (terms in queries are independent of each other)
  - the probability of one term being in a document has no effect on the probability of another
    term being in the same document

  *Retrieval Status Value (RSV)*:
  probability of a document being relevant / probability of it not being relevant

  calculated using Bayes' theorem

  $
    R S V(D, Q) = frac( product_(i = 1)^n P(d_i | R, Q) ,product_(i = 1)^n P(d_i | not R, Q) )
  $
])

#yellowbox("Query Expansion Methods", [
  addresses synonymy and vocabulary mismatch

  + user query
  + term suggestion
  + query modification
  + re-execution of query
  + result evaluation
])

