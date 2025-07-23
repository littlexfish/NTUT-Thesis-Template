#import "func.typ": *

///////////////////////////////////////////////////////////
//                                                       //
// Note:                                                 //
//   Before you start using this template,               //
//   you should read the documents on how to use Typst   //
// https://typst.app/docs                                //
//                                                       //
///////////////////////////////////////////////////////////

#let zh-abstract = [
  // write Chinese abstract here or set `zh-abstract` as `none` to disable
  #lorem(100)
]

#let en-abstract = [
  // write English abstract here or set `en-abstract` as `none` to disable
  #lorem(100)
]

#let zh-keywords = (
  // put your thesis's Chinese keywords here as array
  "關鍵字 一", "關鍵字 二", // ...
)

#let en-keywords = (
  // put your thesis's English keywords here as array
  "Keyword 1", "Keyword 2", // ...
)

#let acknowledgements = [
  // write your acknowledgements here, you can use Chinese or English according to `use-en`
  #lorem(100)
]

#let after-ref = [
  #pagebreak()
  = Appendix

  You can put appendix here, or move `after-ref` into new file and use `#include`.
]

// set thesis information here
#show: thesis.with(
  full: true,
  only-content: false,
  disable-custom-font: false,
  zh-department: "？？？？？系？？班",
  en-department: "Department of ????",
  zh-degree: "？？",
  en-degree: "??",
  zh-title: "標題",
  en-title: "Title",
  zh-researcher: "你自己",
  en-researcher: "Yourself",
  zh-advisor: "指導教授",
  en-advisor: "Advisor",
  zh-date: [#minguo-year-month(datetime.today())],
  en-date: [#datetime.today().display("[month repr:long] [year]")],
  zh-abstract: zh-abstract,
  en-abstract: en-abstract,
  zh-keywords: zh-keywords,
  en-keywords: en-keywords,
  acknowledgements: acknowledgements,
  after-ref: after-ref,
  max-heading-record-in-toc: 3,
  use-en: true,
  ref-bib: "ref.bib",
  bib-style: "ieee",
  show-lot: true,
  show-lof: true,
  show-loe: false,
  figure-numbering-according-chapter: true,
  en-font: "Times New Roman",
  zh-font: "DFKai-SB",
  lang: "en",
  region: "US",
  enum-numbering: ("1.", "(1)", "i.", "(i)")
)

// put your thesis content here

= Title Example

== Section Header Level 1 (1-1)

#lorem(20) (@qwe)

$ sin alpha plus.minus sin beta=2sin 1/2 (alpha plus.minus beta) cos 1/2 (alpha minus.plus beta) $<qwe>

=== Section Header Level 2 (1-1-1)

#lorem(20) (@BBB)

#figure(
  image("logo/ntut-logo-with-label.jpg", width: 80%),
  caption: "Figure Example BBB."
) <BBB>

#figure(
  table(
    columns: (25%, 25%, 25%, 25%),
    rows: (2em, 2em, 2em),
  ),
  caption: "Table Example AAA."
) <AAA>

// you must break pages before chapter by your self
#pagebreak()
= The Title can be separate into 2 lines if it is too long <C2>

In @C2, ...

In @C2-1, ...

== Section Header Level 1 (2-1) <C2-1>

#lorem(20) (@CCC)

#figure(
  table(
    columns: (25%, 25%, 25%, 25%),
    rows: (2em, 2em),
  ),
  caption: "Table example CCC."
) <CCC>

=== Section Header Level 2 (2-1-2)

#lorem(20)

#figure(
  block(fill: luma(230),
    inset: 1em,
    radius: 0.5em,
    image("logo/ntut-logo-with-label.jpg", width: 80%)
  ),
  kind: image,
  caption: "Figure Example DDD."
) <DDD>

// if your equation's ref need follow chapter number, you can custom numbering by `set math.equation(numbering: ...)`
$ x=(-b plus.minus sqrt(b^2-4a c))/(2a) $

// note that there is no ref for enum, you must insert that by hard coded
+ Enum 1
  + Enum (1)
    + Enum i
      + Enum (i)
        // + Enum ? // if you need to numbering the enum that depth more than 5, you should set `enum-numbering` in `thesis` function to support more numbering method

#par[] // force parbreak
// Using the style "thieme" and "trends" will include multiple citations in a single bracket.
#set cite(style: "trends")
ref:
@A @B, @B @C @D

// Note that if you are using a different style, you must change the style back to what you are using in your thesis so that the citation style will be the same as the reference style (including the full author count, etc.).
#set cite(style: "ieee", form: "prose")
ref with name:
@A proposed ...

