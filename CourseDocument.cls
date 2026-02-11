\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CourseDocument}[2025-08-25]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifLegalPaper
\DeclareOption{legalpaper}{\LegalPapertrue}

\newif\ifNiceMargins
\DeclareOption{nicemargins}{\NiceMarginstrue}

\newif\ifGit
\DeclareOption{git}{\Gittrue}

\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption{comments}{
  \def\Solutions{1} 
  \def\Comments{1} 
}

\PassOptionsToPackage{dvipsnames}{xcolor} % Options need to be passed to xcolor before it gets loaded by other packages

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection LOAD CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[]{article}  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection TITLE and SUBTITLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand*{\@subtitle}{}%

\def\maketitle{%
  \par{\huge\bfseries\sffamily\color{Black!40!OliveGreen}\@title}
  \vspace{0.5em}
  \par{\Large\sffamily \@subtitle}
  \par{\small\itshape Updated \@date \space at \DTMcurrenttime}
  \vspace{0.5em}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{geometry}
\ifNiceMargins
  \newlength{\alphabet} % Will be used to set textwidth
  \settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}
  \geometry{textwidth=2.6\alphabet}
  \geometry{head=15pt}
  %\geometry{twoside}
  \if@twoside
    \geometry{hmarginratio={2:3}}
  \else
    \geometry{hmarginratio={1:1}}
  \fi
  \geometry{marginparwidth=0.7\dimexpr\paperwidth-1.0in-\hoffset-\oddsidemargin - \textwidth\relax}
\fi

\ifLegalPaper
  \geometry{legalpaper}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection BASIC PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\RequirePackage{showframe} %no indent, skips line between paragraphs
\RequirePackage{soul}  %for strikeouts \st{}
\RequirePackage[inline]{enumitem}
\RequirePackage{parskip} %no indent, skips line between paragraphs
\RequirePackage[most]{tcolorbox} %loads amsmath, environ, etoolbox, xcolor, etc etc
\RequirePackage[]{xfrac} %for nice fractions
\RequirePackage{marginnote}
\RequirePackage{ragged2e}

\RequirePackage[en-GB]{datetime2}
\DTMlangsetup[en-GB]{ord=raise,monthyearsep={,\space}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection TABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[]{tabularray}
\UseTblrLibrary{booktabs}
\usepackage[]{changepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection FONTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------
% Fakesubsection TYPEFACE SELECTIONS
%----------------------------------
\let\CheckCommand\providecommand % https://tex.stackexchange.com/questions/511711/disable-microtype-warning
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting; doesn't need to be loaded after font anymore.

\RequirePackage[T1]{fontenc}

% SERIF:
\RequirePackage[
semibold,
lining,
serif, %prevents loading sans serif
tt=false %prevents loading mono
]{libertinus} %libertinus-type1 

% SANS:
\RequirePackage[
sf,sflining,scaled=0.85
]{merriweather} %scaled roughly halfway between matching lowercase x (0.8) and uppercase X (0.9)

% TELETYPE:
\RequirePackage[
scale=0.96
]{newtxtt}

% MATH:
\RequirePackage[
libertinus, libaltvw, liby, 
amsthm,
nosymbolsc, cmbraces, smallerops, timesmathacc, upint,
scaled=1.0
]{newtxmath} 

%----------------------------------
% Fakesubsection TYPEFACE-DEPENDENT STUFF:
%----------------------------------
\newcommand{\course}[2][MATH]{%
  {#1 #2}%
}
\AtBeginEnvironment{tabular}{\LibertinusSerifTLF}
\renewcommand*{\oldstylenums}[1]{{\LibertinusSerifOsF #1}}
\newcommand*{\liningnums}[1]{{\LibertinusSerifTLF #1}}
%\useosf  % for osf in normal text; load after math package

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection TITLES, SECTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{titlesec}
\setcounter{secnumdepth}{3}
%\RequirePackage{titletoc}

%usage: titleformat{command}[shape]{format}{label}{sep}{before-code}[after-code]

\titleformat{\section}[block]
{\LARGE\sffamily\bfseries\color{Black!20!OliveGreen}}{\thesection.}{0.3em}{}
\titlespacing*{\section}
{0pt}{6ex plus 1ex minus .2ex}{3ex plus .2ex}

\titleformat{\subsection}[block]
{\Large\sffamily\bfseries\color{Black!20!OliveGreen}}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}
{0pt}{4.5ex plus 1ex minus .2ex}{2ex plus .2ex}

\titleformat{\subsubsection}[block]
{\sffamily\bfseries\itshape\color{Black!20!OliveGreen}}{\thesubsubsection}{0.5em}{}
\titlespacing*{\subsection}
{0pt}{4.5ex plus 1ex minus .2ex}{2ex plus .2ex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection FANCYHDR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[]{fancyhdr}

\fancypagestyle{myfancy}{
  \renewcommand{\headrulewidth}{0.4pt}
  \fancyhf{}
  \fancyhead[R]{{\scshape\nouppercase{\leftmark}}}
  \fancyfoot[C]{\thepage}
  \ifGit
    \fancyfoot[R]{\fbox{\ttfamily\tiny\today \space \space (\gitVer{})}}
  \fi
}

\fancypagestyle{toc}{
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \ifGit
    \fancyfoot[R]{\fbox{\ttfamily\tiny\today \space \space (\gitVer{})}}
  \fi
  \fancyfoot[C]{\thepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection FUZZ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\hfuzz 2pt
\overfullrule 25pt
\vfuzz 2pt
\hbadness=500
\vbadness=1000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection CONDITIONAL BOXES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\Comment[1]{%
  \ifdefined\Comments
    \tcbox[
    on line,
    left=1pt,
    right=1pt,
    top=1pt,
    bottom=1pt,
    boxrule=0.3mm,
    arc=0mm,
    outer arc=0mm,
    colframe=Lavender!90,
    colback=Lavender!9
    ]
    {\sffamily #1}
  \else
    \@gobble{#1}\ignorespaces
  \fi
}
\NewEnviron{CommentBox}{%
  \ifdefined\Comments
    \begin{tcolorbox}[%
      parbox=false,
      enhanced,
      breakable,
      oversize,
      left=15pt,
      right=15pt,
      top=9pt,
      boxrule=0.3mm,
      arc=0mm,
      outer arc=0mm,
      colframe=Lavender!90,
      colback=Lavender!9,
      colbacktitle=Lavender,
      coltitle=White,
      title={\ttfamily\bfseries\small comment},
      attach boxed title to top left={xshift=5pt,yshift=-\tcboxedtitleheight/2},
      boxed title style={size=small,boxrule=0pt,arc=0pt,colback=Lavender!70, outer arc=0mm,top=0pt,left=0pt,right=0pt,bottom=0pt}
      ]
      \sffamily \BODY 
    \end{tcolorbox}
  \else
    \@gobble{\BODY}\ignorespaces
  \fi
}
% Fakesection marginnote
% Example use case: "See \hyerref[label]{this note}", where label is in a separate section (inputted by MyCommentInput); if I want I can anchor the margin comment with hypertarget command (google-able)
\newcommand\MarginComment[1]{%
  \ifdefined\Comments
    \marginnote{%
    \textcolor{Red}{\sffamily\bfseries \RaggedRight #1}
  }
  \else
  \fi
}
%\newcommand\MarginComment[1]{%
  %\ifdefined\Comments
    %\marginnote{%
    %\begin{tcolorbox}[%
      %%parbox=false,
      %breakable,
      %left=1pt,
      %right=1pt,
      %top=1pt,
      %bottom=1pt,
      %boxrule=0.3mm,
      %arc=0mm,
      %outer arc=0mm,
      %colframe=Lavender!90,
      %colback=Lavender!9,
      %colbacktitle=Lavender,
      %]
      %\sffamily\small \RaggedRight #1
    %\end{tcolorbox}
    %%\textcolor{Red}{\sffamily\bfseries #1}
  %}
  %\else
  %\fi
%}

\newcommand\InputComments[1]{% Example use case: A section of comments/notes for fellow instructors
  \ifdefined\Comments
    \input{#1}
  \else
  \fi
}
% Fakesection AtEndOfClass
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndOfClass{

  %\RequirePackage{IfThenBoxes} %custom_package

  %----------------------------------
  % Fakesubsection HYPERREF
  %----------------------------------
  \RequirePackage{hyperref}
  \hypersetup{%
    colorlinks    = true,%  Color text instead of boxes
    linkcolor     = Black!20!OliveGreen,% Color of internal links
    citecolor     = black,% Color of citations
    urlcolor      = Black!20!RoyalBlue,%  Color of external urls
    pdfstartview  = Fit,%
    pdfmenubar    = true,%
    pdftoolbar    = true,%
    bookmarksopen = false,%
    %bookmarksopenlevel = 1,%
  }

  \newcommand*{\fullautoref}[1]{\hyperref[{#1}]{\autoref*{#1} \nameref*{#1}}} % One single link
  \newcommand*{\fullref}[1]{\hyperref[{#1}]{\ref*{#1} \nameref*{#1}}} % One single link

} %END AtEndOfClass
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection AtBeginDocument
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{
  \ifGit
    \RequirePackage[noheader]{gitver}
  \fi
} %END AtBeginDocument
