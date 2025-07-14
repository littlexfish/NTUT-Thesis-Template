
#let margin = (x: 2.5cm, top: 2.5cm, bottom: 2.75cm)
#let A4 = (width: 210mm, height: 297mm)
#let A4-content-size = (width: 210mm - 5cm, height: 297mm - 5.25cm)
#let watermark = image("logo/watermark.png", width: 64%)

#let zh-date(
  datetime,
  use-roc-year: true,
  prefix: "",
  enable-year: true,
  year-suffix: "年",
  enable-month: true,
  month-suffix: "月",
  enable-day: true,
  day-suffix: "日"
) = {
  let year = datetime.year()
  let month = datetime.month()
  let day = datetime.day()
  if use-roc-year {  year -= 1911 }
  let out = prefix
  if enable-year { out += numbering("一", year) + year-suffix }
  if enable-month { out += numbering("一", month) + month-suffix }
  if enable-day { out += numbering("一", day) + day-suffix }
  return out
}

#let semester-to-chinese(
  datetime,
  use-roc-year: true,
  enable-year: true
) = {
  let year = datetime.year()
  let month = datetime.month()
  if month < 8 { year -= 1 }
  if use-roc-year { year -= 1911 }
  
  let c-semester = numbering("一", year) + "學年度 "

  c-semester += "第"
  if month < 8 { c-semester += "二" }
  else { c-semester += "一" }
  c-semester += "學期"

  return c-semester
}

#let minguo-year-month(
  datetime
) = {
  let year = datetime.year()
  let month = datetime.month()

  let c-year = "中華民國" + numbering("一", year - 1911) + "年"
  let c-month = numbering("一", month) + "月"

  return c-year + c-month
}

#let title-page(
  has-watermark-background: true, zh-department: "？？？？？系？？班",
  en-department: "Department of ????", zh-degree: "？？", en-degree: "??",
  zh-title: none, en-title: none, zh-researcher: none, en-researcher: none,
  zh-advisor: none, en-advisor: none,
  date: [#datetime.today().display("[month repr:long] [year]")]
) = context {
  // page before content
  let title-en-degree = if en-degree != none { en-degree + " Thesis" } else { "" }
  let title-zh-author = if zh-researcher != none { "研究生：" + zh-researcher } else { none }
  let title-en-author = if en-researcher != none { "Researcher: " + en-researcher } else { none }
  let title-zh-advisor = if zh-advisor != none { "指導教授：" + zh-advisor + " 博士" } else { none }
  let title-en-advisor = if en-advisor != none { "Advisor: " + en-advisor + ", Ph.D." } else { none }
  page(background: if has-watermark-background { watermark } else { none }, {
    set align(center)
    set par(leading: 0.65em)
    set text(24pt, weight: "bold")
    align(center, image("logo/ntut-logo-with-label.png", width: 13cm))
    // school name
    // department & degree
    {
      strong(text(24pt, zh-department))
      linebreak()
      strong(text(24pt, zh-degree + "學位論文"))
      linebreak()
      strong(text(18pt, en-department))
      linebreak()
      strong(text(18pt, en-degree + " Thesis"))
    }
    v(1fr)
    // title
    set par(leading: 32pt - 0.65em)
    {
      if zh-title != none {
        text(24pt, weight: "bold", zh-title)
        linebreak()
      }
      if en-title != none {
        text(20pt, weight: "bold", en-title) 
      }
      linebreak()
    }
    v(1fr)
    // researcher
    set text(18pt)
    set par(leading: 0.65em)
    v(1fr)
    if title-zh-author != none { title-zh-author }
    else { " " }
    linebreak()
    if title-en-author != none { title-en-author }
    else { " " }
    v(1fr)
    // advisor
    if title-zh-advisor != none { title-zh-advisor }
    else { " " }
    linebreak()
    if title-en-advisor != none { title-en-advisor }
    else { " " }
    v(1fr)
    date
  }) // page
}

#let thesis(
  // thesis content
  content,
  // if set to true, show all page include title page and blank page
  full: true,
  // if set to true, disable title page and cover page
  only-content: false,
  // if write with CJK(Chinese) and trying to view preview, the CJK words is weird, you can set this to true to preview readable CJK words, but you should set this back to false to use correct font if you need to export pdf
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
  zh-title: none,
  // english title, set none to disable
  en-title: none,
  // chinese name, set none to disable
  zh-researcher: none,
  // english name, set none to disable
  en-researcher: none,
  // advisor chinese name, set none to disable
  zh-advisor: none,
  // advisor english name, set none to disable
  en-advisor: none,
  // chinese date
  zh-date: [#minguo-year-month(datetime.today())],
  // english date
  en-date: [#datetime.today().display("[month repr:long] [year]")],
  // chinese abstract content, none to disable
  zh-abstract: none,
  // english abstract content, none to disable
  en-abstract: none,
  // chinese keywords, must set an array
  zh-keywords: (),
  // english keywords, must set an array
  en-keywords: (),
  // acknowledgements content, set none to disable
  acknowledgements: none,
  // after-ref content, will show after reference and with page number, none to disable, you can put appendix, mathematical symbols and formulas
  after-ref: none,
  // appendix section numbering
  after-ref-section-numbering: "A.I.a.i.",
  // max heading level will be record in table of content
  max-heading-record-in-toc: 3,
  // set true to make acknowledgements, 
  //  table of content, list of tables, and list of figures
  //  use english title
  use-en: true,
  // set BibTex file path, or set none to disable auto refenance
  ref-bib: none,
  // set BibTex showing style,
  // common styles: 
  // apa, ieee, mla, vancouver
  bib-style: "apa",
  // show list of tables
  show-lot: true,
  // show list of figures
  show-lof: true,
  // show list of equation
  show-loe: false,
  // set figure numbering will show according chapter as "1.1" instead of just only number as "1"
  figure-numbering-according-chapter: false,
  // ascii font
  en-font: "Times New Roman",
  // non-ascii font
  zh-font: "DFKai-SB",
  // languages
  lang: "en",
  // region
  region: "US",
  // numbering string/function for enum
  enum-numbering: ("1.", "(1)", "i.", "(i)")
) = {
  // set pdf info
  let author = if not use-en { zh-researcher } else { en-researcher }
  let keyword = () + en-keywords + zh-keywords
  let title = if not use-en { zh-title } else { en-title }
  set document(author: author, date: datetime.today(), keywords: keyword, title: title)
  // set watermark and margin
  set page(margin: margin, background: watermark)
  // set text font, only disable CJK font if `disable-custom-font` is true
  let font = if disable-custom-font { (en-font) } else { (en-font, zh-font) }
  set text(font: font, lang: lang, region: region)
  // fix cjk prunction narrowing
  show regex("[　、。〃〇〈〉《》「」『』【】〔〕〖〗〘〙〚〛〜〝〞〟﹐﹑，､︑]"): it => {
    h(1pt)
    it
    h(1pt)
  }
  // set strong force use bold
  show strong: it => text(weight: "bold", it)
  // override original bold process for cjk
  show text.where(weight: "bold"): it => {
    if it.text.contains(regex("[^\u0001-\u007f]")) {
      text(weight: "regular", stroke: 0.02em, it)
    }
    else { it }
  }
  // set paragraph size
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)
  // set heading font size
  show heading: it => {
    let size = 22pt - 2pt * it.level
    text(size, it)
    if it.level != 1 {
      v(-1em)
    }
    text(12pt, linebreak())
  }
  // reset figure and equation counter if needed
  show heading.where(level: 1): it => {
    it
    counter(math.equation).update(0)
    if figure-numbering-according-chapter {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
    }
  }
  // align heading
  show heading.where(level: 1): align.with(center)
  // set figure image
  show figure.where(kind: image): set figure(
    // set supplement as en or ch
    supplement: if use-en { "Figure" } else { "圖" },
    // set numbering according to chapter if needed
    numbering: it => {
      if figure-numbering-according-chapter {
        let ch = counter(heading.where(level: 1)).get().at(0)
        let eq-count = counter(figure.where(kind: image)).get().at(0)
        return str(ch) + "." + str(eq-count)
      }
      else { return numbering("1", it) }
    })
  // set figure table
  show figure.where(kind: table): set figure(
    // set supplement as en or ch
    supplement: if use-en { "Table" } else { "表" },
    // set numbering according to chapter if needed
    numbering: it => {
      if figure-numbering-according-chapter {
        let ch = counter(heading.where(level: 1)).get().at(0)
        let eq-count = counter(figure.where(kind: table)).get().at(0)
        return str(ch) + "." + str(eq-count)
      }
      else { return numbering("1", it) }
    })


  let date = if use-en { en-date } else { zh-date }
  if not only-content {
    if full {
      title-page(has-watermark-background: false, zh-department: zh-department,
        en-department: en-department, zh-degree: zh-degree, en-degree: en-degree,
        zh-title: zh-title, en-title: en-title, zh-researcher: zh-researcher,
        en-researcher: en-researcher, zh-advisor: zh-advisor, en-advisor: en-advisor,
        date: date)
  
      page(background: none)[] // blank page
    }
  
    // cover page
    title-page(has-watermark-background: true, zh-department: zh-department,
      en-department: en-department, zh-degree: zh-degree, en-degree: en-degree,
      zh-title: zh-title, en-title: en-title, zh-researcher: zh-researcher,
      en-researcher: en-researcher, zh-advisor: zh-advisor, en-advisor: en-advisor,
      date: date)
  }

  // update page number
  counter(page).update(1)
  set page(numbering: "i")
  // abstract
  if zh-abstract != none {
    set par(leading: 1.5em)
    [= 摘要]
    [
      關鍵詞：#zh-keywords.join("、")\ \
      #par(first-line-indent: 2em, zh-abstract)
    ]
    pagebreak()
  } // if zh-abstract != none

  if en-abstract != none {
    set par(leading: 1.5em)
    [= ABSTRACT]
    [
      Keywords: #en-keywords.join(", ") \ \
      #par(first-line-indent: 2em, en-abstract)
    ]
    pagebreak()
  } // if en-abstract != none

  if acknowledgements != none {
    set par(leading: 1.5em)
    heading(if use-en [Acknowledgements] else [誌謝])
    set text(12pt)
    set par(first-line-indent: 2em)
    acknowledgements
  }
  
  // toc
  page({
    let indent-size = 2em
    set text(12pt)
    heading(if use-en [Table of Contents] else [目錄])
    set par(first-line-indent: 0pt, leading: 1.5em)
    outline(title: none, target: heading.where(outlined: true),
      indent: indent-size, depth: max-heading-record-in-toc)
  }) // page
  
  // lot
  if show-lot {
    page({
      set text(12pt)
      heading(if use-en [List of Tables] else [表目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: figure.where(kind: table))
    }) // page
  } // if show-lot
  
  // lof
  if show-lof {
    page({
      set text(12pt)
      heading(if use-en [List of Figures] else [圖目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: figure.where(kind: image))
    }) // page
  } // if show-lof

  // loe
  if show-loe {
    page({
      set text(12pt)
      heading(if use-en [List of Equations] else [函數目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: math.equation.where(block: true))
    }) // page
  } // if show-loe
  
  // set text rule
  set text(12pt)
  set par(leading: 1.5em, spacing: 1.5em, first-line-indent: 2em, justify: true)
  // set heading numbering
  set heading(numbering: (..it) => {
    if it.pos().len() > 1 {
      return numbering("1.1", ..it)
    }
    else {
      let l = it.pos().at(0)
      return if use-en [Chapter #numbering("1", l)]
      else [第 #numbering("一", l) 章]
    }
  }, supplement: it => {
    // here set to none because numbering in h1 already have "Chapter N"
    return if it.depth == 1 { none }
    // In Chinese, there are multiple ways to refer to a section. Therefore, we don't provide supplements when use-en is true.
    else { if use-en [Section] else { none } }
  })
  // set table in figure will show caption on top of table
  show figure.where(kind: table): set figure.caption(position: top)
  // set equation numbering will contain chapter
  set math.equation(numbering: it => {
    let ch = counter(heading.where(level: 1)).get().at(0)
    let eq-count = counter(math.equation).get().at(0)
    return "(" + str(ch) + "." + str(eq-count) + ")"
  })
  // set enum numbering
  set enum(full: true, numbering: (..nums) => {
    let size = nums.pos().len()
    let numbering-idx = calc.rem(size - 1, enum-numbering.len())
    return numbering(enum-numbering.at(numbering-idx), nums.at(-1))
  })

  // update page number
  counter(page).update(1)
  page(numbering: "1")[
    #content
    #if ref-bib != none {
      pagebreak()
      bibliography(ref-bib, style: bib-style, title: if use-en [References] else [參考文獻])
    }
    // content after reference
    #if after-ref != none {
      // set heading numbering
      set heading(numbering: (..it) => {
        let n = it.pos()
        if n.len() > 1 {
          n.remove(0)
          return numbering(after-ref-section-numbering, ..n)
        }
        else {
          return ""
        }
      })
      // remove h1 numbering, because appendix didn't need numbering, and prevent a space before title
      show heading.where(level: 1): set heading(numbering: none)
      after-ref
    }
  ]
}
