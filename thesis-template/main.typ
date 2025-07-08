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


// set thesis information here
#show: thesis.with(
  // if set to true, show all page include title page and blank page
  full: true,
  // if set to true, disable title page and cover page
  only-content: false,
  // If you use Chinese to write your thesis, you can set this to true if you need to preview, because Typst has a bug to render CJK font in preview mode, if you need to export as PDF, set this back to false.
  disable-custom-font: false,
  // chinese department
  zh-department: "？？？？？系？？班",
  // english department
  en-department: "Department of ????",
  // chinese degree, 碩士 or 博士
  zh-degree: "？？",
  // english degree, Master or Ph.D. or PhD
  en-degree: "??",
  // chinese title, set none to disable
  zh-title: "標題",
  // english title, set none to disable
  en-title: "Title",
  // chinese name, set none to disable
  zh-researcher: "你自己",
  // english name, set none to disable
  en-researcher: "Yourself",
  // advisor chinese name, set none to disable
  zh-advisor: "指導教授",
  // advisor english name, set none to disable
  en-advisor: "Advisor",
  // chinese date
  zh-date: [#minguo-year-month(datetime.today())],
  // english date
  en-date: [#datetime.today().display("[month repr:long] [year]")],
  // chinese abstract content, none to disable
  zh-abstract: zh-abstract,
  // english abstract content, none to disable
  en-abstract: en-abstract,
  // chinese keywords, must set an array
  zh-keywords: zh-keywords,
  // english keywords, must set an array
  en-keywords: en-keywords,
  // acknowledgements content
  acknowledgements: acknowledgements,
  // max heading level will be record in table of content
  max-heading-record-in-toc: 3,
  // set true to make acknowledgements, 
  //  table of content, list of tables, and list of figures
  //  use english title
  use-en: true,
  // set Texbib file path, or set none to disable auto refenance
  ref-bib: "ref.bib",
  // set BibTex showing style,
  // common styles: 
  // apa, ieee, mla, vancouver
  bib-style: "ieee",
  // show list of tables
  show-lot: true,
  // show list of figures
  show-lof: true,
  // show list of equation
  show-loe: false,
  // ascii font, default is "Times New Roman"
  en-font: "Times New Roman",
  // non-ascii font, default is "DFKai-SD"(標楷體)
  zh-font: "DFKai-SB",
  // text languages, if you write in Chinese, you can set this to "zh"
  lang: "en",
  // text region, if you write in Chinese, you should always set this to "TW" or "CN" to fix prunction render problem
  region: "US",
  // numbering string/function for enum
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
  image("logo/ntut-logo-with-label.png", width: 80%),
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
    image("logo/ntut-logo-with-label.png", width: 80%)
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

ref: \
@A \
@B \
@C \
@D
