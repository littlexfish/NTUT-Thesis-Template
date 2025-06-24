
#let margin = (x: 2.5cm, top: 2.5cm, bottom: 2.75cm)
#let A4 = (width: 210mm, height: 297mm)
#let A4_content_size = (width: 210mm - 5cm, height: 297mm - 5.25cm)
#let watermark = image("logo/watermark.png", width: 64%)

#let title_page(
  has_watermark_background: true, zh_department: "？？？？？系？？班",
  en_department: "Department of ????", zh_degree: "？？", en_degree: "??",
  zh_title: none, en_title: none, zh_researcher: none, en_researcher: none,
  zh_advisor: none, en_advisor: none, zh_date: none,
  en_date: [#datetime.today().display("[month repr:long] [year]")],
) = context {
  // page before content
  let title_en_degree = if en_degree != none { en_degree + " Thesis" } else { "" }
  let title_zh_author = if zh_researcher != none { "研究生：" + zh_researcher } else { none }
  let title_en_author = if en_researcher != none { "Researcher: " + en_researcher } else { none }
  let title_zh_advisor = if zh_advisor != none { "指導教授：" + zh_advisor + " 博士" } else { none }
  let title_en_advisor = if en_advisor != none { "Advisor: " + en_advisor + ", Ph.D." } else { none }
  let date = if en_date != none { en_date } else { zh_date }
  page(background: if has_watermark_background { watermark } else { none }, {
    set align(center)
    set par(leading: 0.65em)
    set text(24pt, weight: "bold")
    align(center, image("logo/ntut-logo-with-label.png", width: 13cm))
    // school name
    // department & degree
    {
      zh_department
      linebreak()
      en_degree + " Thesis"
      linebreak()
      en_department
      linebreak()
      zh_degree + "學位論文"
    }
    v(1fr)
    // title
    set par(leading: 32pt - 0.65em)
    {
      if zh_title != none {
        text(24pt, weight: "bold", zh_title)
        linebreak()
      }
      if en_title != none {
        text(20pt, weight: "bold", en_title) 
      }
      linebreak()
    }
    v(1fr)
    // researcher
    set text(18pt)
    set par(leading: 0.65em)
    v(1fr)
    if title_zh_author != none { title_zh_author }
    else { " " }
    linebreak()
    if title_en_author != none { title_en_author }
    else { " " }
    v(1fr)
    // advisor
    if title_zh_advisor != none { title_zh_advisor }
    else { " " }
    linebreak()
    if title_en_advisor != none { title_en_advisor }
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
  only_content: false,
  // if write with CJK(Chinese) and trying to view preview, the CJK words is weird, you can set this to true to preview readable CJK words, but you should set this back to false to use correct font if you need to export pdf
  disable_custom_font: false,
  // chinese department
  zh_department: "？？？？？系？？班",
  // english department
  en_department: "Department of ????",
  // chinese degree, 碩士 or 博士
  zh_degree: "？？",
  // english degree, Master or Ph.D. or PhD
  en_degree: "??",
  // chinese title, set none to disable
  zh_title: none,
  // english title, set none to disable
  en_title: none,
  // chinese name, set none to disable
  zh_researcher: none,
  // english name, set none to disable
  en_researcher: none,
  // advisor chinese name, set none to disable
  zh_advisor: none,
  // advisor english name, set none to disable
  en_advisor: none,
  // chinese date
  zh_date: [#datetime.today().display("[month repr:long] [year]")],
  // english date
  en_date: [#datetime.today().display("[month repr:long] [year]")],
  // chinese abstract content, none to disable
  zh_abstract: none,
  // english abstract content, none to disable
  en_abstract: none,
  // chinese keywords, must set an array
  zh_keywords: (),
  // english keywords, must set an array
  en_keywords: (),
  // acknowledgements content, set none to disable
  acknowledgements: none,
  // max heading level will be record in table of content
  max_heading_record_in_toc: 3,
  // set true to make acknowledgements, 
  //  table of content, list of tables, and list of figures
  //  use english title
  use_en: true,
  // set BibTex file path, or set none to disable auto refenance
  ref_bib: none,
  // set BibTex showing style,
  // common styles: 
  // apa, ieee, mla, vancouver
  bib_style: "apa",
  // show list of tables
  show_lot: true,
  // show list of figures
  show_lof: true,
  // show list of equation
  show_loe: false,
  // ascii font
  en_font: "Times New Roman",
  // non-ascii font
  zh_font: "DFKai-SB",
  // languages
  lang: "en",
  // region
  region: "US",
  // numbering string/function for enum
  enum_numbering: ("1.", "(1)", "i.", "(i)")
) = {
  // set pdf info
  let author = if zh_researcher != none { zh_researcher } else { en_researcher }
  let keyword = () + en_keywords + zh_keywords
  let title = if zh_title != none { zh_title } else { en_title }
  set document(author: author, date: datetime.today(), keywords: keyword, title: title)
  // set watermark and margin
  set page(margin: margin, background: watermark)
  // set text font, only disable CJK font if `disable_custom_font` is true
  let font = if disable_custom_font { (en_font) } else { (en_font, zh_font) }
  set text(font: font, lang: lang, region: region)
  // fix cjk prunction narrowing
  show regex("[　、。〃〇〈〉《》「」『』【】〔〕〖〗〘〙〚〛〜〝〞〟﹐﹑，､︑]"): it => {
    h(1pt)
    it
    h(1pt)
  }
  // set strong force use bold
  show strong: it => text(weight: "bold", it)
  // override original bold process
  show text.where(weight: "bold"): it => {
    if it.text.contains(regex("[^\u0001-\u007f]")) {
      text(weight: "regular", stroke: 0.02em, it)
    }
    else { it }
  }
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)
  show heading: it => {
    let size = 22pt - 2pt * it.level
    text(size, it)
    if it.level != 1 {
      v(-1em)
    }
    text(12pt, linebreak())
  }
  show heading.where(level: 1): align.with(center)

  if not only_content {
    if full {
      title_page(has_watermark_background: false, zh_department: zh_department,
        en_department: en_department, zh_degree: zh_degree, en_degree: en_degree,
        zh_title: zh_title, en_title: en_title, zh_researcher: zh_researcher,
        en_researcher: en_researcher, zh_advisor: zh_advisor, en_advisor: en_advisor,
        zh_date: zh_date, en_date: en_date)
  
      page(background: none)[] // blank page
    }
  
    // cover page
    title_page(has_watermark_background: true, zh_department: zh_department,
      en_department: en_department, zh_degree: zh_degree, en_degree: en_degree,
      zh_title: zh_title, en_title: en_title, zh_researcher: zh_researcher,
      en_researcher: en_researcher, zh_advisor: zh_advisor, en_advisor: en_advisor,
      zh_date: zh_date, en_date: en_date)
  }

  counter(page).update(1)
  set page(numbering: "i")
  // abstract
  if zh_abstract != none {
    set par(leading: 1.5em)
    [= 摘要]
    [
      關鍵詞：#zh_keywords.join("、")\ \
      #par(first-line-indent: 2em, zh_abstract)
    ]
    pagebreak()
  } // if zh_abstract != none

  if en_abstract != none {
    set par(leading: 1.5em)
    [= ABSTRACT]
    [
      Keywords: #en_keywords.join(", ") \ \
      #par(first-line-indent: 2em, en_abstract)
    ]
    pagebreak()
  } // if en_abstract != none

  if acknowledgements != none {
    set par(leading: 1.5em)
    heading(if use_en [Acknowledgements] else [誌謝])
    set text(12pt)
    set par(first-line-indent: 2em)
    acknowledgements
  }
  
  // toc
  page({
    let indent_size = 2em
    set text(12pt)
    heading(if use_en [Table Of Contents] else [目錄])
    set par(first-line-indent: 0pt, leading: 1.5em)
    outline(title: none, target: heading.where(outlined: true),
      indent: indent_size, depth: max_heading_record_in_toc)
  }) // page
  
  // lot
  if show_lot {
    page({
      set text(12pt)
      heading(if use_en [List of Tables] else [表目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: figure.where(kind: table))
    }) // page
  } // if show_lot
  
  // lof
  if show_lof {
    page({
      set text(12pt)
      heading(if use_en [List of Figures] else [圖目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: figure.where(kind: image))
    }) // page
  } // if show_lof

  // loe
  if show_loe {
    page({
      set text(12pt)
      heading(if use_en [List of Equations] else [函數目錄])
      set par(first-line-indent: 0pt, leading: 1.5em)
      outline(title: none, target: math.equation.where(block: true))
    }) // page
  } // if show_loe
  
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
      return if use_en [Chapter #numbering("1", l)]
      else [第 #numbering("一", l) 章]
    }
  }, supplement: it => {
    // here set to none because numbering in h1 already have "Chapter N"
    return if it.depth == 1 { none }
    else { "Section" }
  })
  // set table in figure will show caption on top of table
  show figure.where(kind: table): set figure.caption(position: top)
  set math.equation(numbering: "(1)")
  set enum(full: true, numbering: (..nums) => {
    let size = nums.pos().len()
    return numbering(enum_numbering.at(size - 1), nums.at(-1))
  })

  counter(page).update(1)
  page(numbering: "1")[
    #content
    #if ref_bib != none {
      pagebreak()
      bibliography(ref_bib, style: bib_style, title: [Reference])
    }
  ]
}

#let zh_date(
  datetime,
  use_roc_year: true,
  prefix: "",
  enable_year: true,
  year_suffix: "年",
  enable_month: true,
  month_suffix: "月",
  enable_day: true,
  day_suffix: "日"
) = {
  let year = datetime.year()
  let month = datetime.month()
  let day = datetime.day()
  if use_roc_year {  year -= 1911 }
  let out = prefix
  if enable_year { out += numbering("一", year) + year_suffix }
  if enable_month { out += numbering("一", month) + month_suffix }
  if enable_day { out += numbering("一", day) + day_suffix }
  return out
}

#let semester_to_chinese(
  datetime,
  use_roc_year: true,
  enable_year: true
) = {
  let year = datetime.year()
  let month = datetime.month()
  if month < 8 { year -= 1 }
  if use_roc_year { year -= 1911 }
  
  let c_semester = numbering("一", year) + "學年度 "

  c_semester += "第"
  if month < 8 { c_semester += "二" }
  else { c_semester += "一" }
  c_semester += "學期"

  return c_semester
}