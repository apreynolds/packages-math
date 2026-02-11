\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LectureNotes}[2025-08-28]

%TODO redefine bigskip, medskip, smallskip

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% StudentCopy will give 14pt font, and larger margins:
\DeclareOption{lecturecopy}{
  \def\LectureCopy{1} 
}

\newif\if@loadsysteme %\@loadsystemefalse by default
\DeclareOption{systeme}{\@loadsystemetrue}
% (I got the above from https://tex.stackexchange.com/questions/203387/declare-package-options-and-loading-packages-leads-to-options-section-error)

\newif\ifApexstuff 
\DeclareOption{apex}{\Apexstufftrue}

\DeclareOption{instructor}{
  \def\InstructorNotes{1} 
  \def\Solutions{1} 
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % any other unknown options get passed to extarticle

\PassOptionsToPackage{dvipsnames}{xcolor} % Options need to be passed to xcolor before it gets loaded by other packages

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection LOAD CLASS AND GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifdefined\LectureCopy
% Larger font and narrow margins for lecture hall projector:
  \LoadClass[17pt]{extreport} 
  \RequirePackage[top=0.25in,bottom=0.75in,textwidth=7.75in,letterpaper]{geometry}
\else
% Smaller font and larger margins:
  \LoadClass[14pt]{extreport} 
  \RequirePackage[top=0.5in,bottom=0.75in,left=0.5in,textwidth=6.382in,letterpaper]{geometry}
  \geometry{marginparwidth=1.3in}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection TITLE, SUBTITLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand*{\@subtitle}{}%

\def\maketitle{%
  \vspace*{1em}
  \par{\huge\bfseries\sffamily\@title}
  \par{\Large\sffamily \@subtitle}
  \par{\small\itshape Updated \@date \space \InstructorNote{\normalsize\bfseries Instructor Copy}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection FONTS AND SYMBOLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{amsthm}
\let\CheckCommand\providecommand % https://tex.stackexchange.com/questions/511711/disable-microtype-warning
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting?
\RequirePackage[scaled=1.0]{newtxtext} %provides roman, ss, tt variants.
\RequirePackage[scale=0.96]{newtxtt}
\RequirePackage[scaled=1.0,bigdelims,vvarbb]{newtxmath} 
\RequirePackage[scaled=1.0,cal=euler, bb=ams, frak=euler, scr=boondoxo]{mathalfa} %lots of variants possible here
\RequirePackage{bm} %load after all to give access to bold math; not always necessary, but spacing is apparently better

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection BASIC PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{soul} 
\RequirePackage[inline]{enumitem}
\RequirePackage[skip=1em]{parskip} 
\RequirePackage[most]{tcolorbox} %loads amsmath, environ, etoolbox, xcolor, etc etc

\RequirePackage[en-GB]{datetime2}
\DTMlangsetup[en-GB]{ord=raise,monthyearsep={,\space}}

\RequirePackage{tabularray} % TODO replace with tabularray
\UseTblrLibrary{booktabs}
\UseTblrLibrary{siunitx}
%\RequirePackage{booktabs} % TODO replace with tabularray
%\RequirePackage{multirow} % TODO replace with tabularray

\RequirePackage{marginnote}
\RequirePackage{ragged2e}

\RequirePackage{siunitx}
\if@loadsysteme
  \RequirePackage{systeme}
\fi

\RequirePackage{tikz}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection COLOR DEFINITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\colorlet{MyGreen}{Green!70!Black}

\definecolor{flashcardA}{RGB}{247,244,58}
\definecolor{flashcardB}{RGB}{123,104,238}
\definecolor{flashcardC}{RGB}{247,58,241}
\definecolor{flashcardD}{RGB}{118,247,58}
\definecolor{flashcardE}{RGB}{247,165,58}

\definecolor{ThmColor}{named}{Gray}
\definecolor{NoteColor}{named}{RoyalBlue}
\definecolor{CautionColor}{named}{Red}
\definecolor{BasicBGColor}{named}{Red}
\definecolor{AdvancedBGColor}{named}{ForestGreen}
\definecolor{CheckInColor}{named}{BrickRed}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection TITLES, HEADERS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[]{fancyhdr}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
\fancyfoot[C]{\small\thepage}

\RequirePackage{titlesec}
\RequirePackage{titletoc}
\setcounter{secnumdepth}{1}
\setcounter{tocdepth}{3}
\newcommand{\subsectionbreak}{\clearpage}

%usage: titleformat{command}[shape]
%{format}
%{label}{sep}{before-code}[after-code]
\titleformat{\section}[block]
{\sffamily\bfseries\Large}
{\thesection}{0.7em}{}[]

\titleformat{\subsection}[block]
{\sffamily\bfseries\large}
{\thesection-\thesubsection asdd}{0.7em}{}[]

\titleformat{\subsubsection}[block]
{\sffamily\bfseries\itshape}
{\thesection}{1em}{}[]

%\titlecontents{psection}[1em]
%{}
%{\bfseries\thecontentslabel. \normalfont \enspace }
%{\normalfont\enspace}
%{ \titlerule*[0.2pc]{.} \bfseries \thecontentspage}[\vspace{-0.5em}]  % Using this titlerule produces

%\titlecontents{psubsection}[2.5em]
%{\small}
%{\thecontentslabel. \enspace }
%{\enspace}
%{\hfill  \thecontentspage}[\vspace{-0.5em}]

%\titlecontents{psubsubsection}[3.5em]
%{\small}
%{\thecontentslabel. \enspace }
%{\enspace}
%{\hfill \thecontentspage}[]

\titlecontents{section}[1em]
{}
%{\bfseries}
{\bfseries\thecontentslabel. \normalfont \enspace }
{\normalfont\enspace}
{ \titlerule*[0.8pc]{.} \bfseries \thecontentspage}[]  

\titlecontents{subsection}[2.5em]
{\small}
{\thecontentslabel. \enspace }
{\enspace}
{\hfill  \thecontentspage}[]

\titlecontents{subsubsection}[3.5em]
{\small}
{\thecontentslabel. \enspace }
{\enspace}
{\hfill \thecontentspage}[]

%USAGE: \titlespacing*{command}{left}{before-sep}{after-sep}[right-sep]
\titlespacing*{\section}{0em}{2em}{1em}[0em]
\titlespacing*{\subsection}{0pt}{1.0em}{1.0em}
\titlespacing*{\subsubsection}{0pt}{1em}{0.3em}
\contentsmargin{1em}
%\renewcommand\contentsname{Table of Contents}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection MATH SETTINGS and COMMANDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\everymath{\displaystyle}

\newcommand*{\lsim}{\mathord{\sim}} %for use of tilde as negation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection APEX STUFF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifApexstuff
%% (From  docinfo/macros  element)
%% Plus three from PTX for XML characters
  \newcommand{\highlight}[1]{{\color{blue}{#1}}}
  \newcommand{\apex}{\mbox{\hbox{A}\kern -1pt \lower -2pt\hbox{P}\kern -4pt \lower .7ex\hbox{E}\kern -1pt \hbox{X}}}
  \newcommand{\colorlinecolor}{blue!95!black!30}
  \newcommand{\bwlinecolor}{black!30}
  \newcommand{\thelinecolor}{\colorlinecolor}
  \newcommand{\colornamesuffix}{}
  \newcommand{\linestyle}{[thick, \thelinecolor]}
  \newcommand{\bmx}[1]{\left[\hskip -3pt\begin{array}{#1} }
  \newcommand{\emx}{\end{array}\hskip -3pt\right]}
  \newcommand{\ds}{\displaystyle}
  \newcommand{\fp}{f'}
  \newcommand{\fpp}{f''}

  \newcommand{\lz}[2]{\frac{d#1}{d#2}}
  \newcommand{\lzn}[3]{\frac{d^{#1}#2}{d#3^{#1}}}
  \newcommand{\lzo}[1]{\frac{d}{d#1}}
  \newcommand{\lzoo}[2]{{\frac{d}{d#1}}{\left(#2\right)}}
  \newcommand{\lzon}[2]{\frac{d^{#1}}{d#2^{#1}}}
  \newcommand{\lzoa}[3]{\left.{\frac{d#1}{d#2}}\right|_{#3}}
  \newcommand{\plz}[2]{\frac{\partial#1}{\partial#2}}
  \newcommand{\plzoa}[3]{\left.{\frac{\partial#1}{\partial#2}}\right|_{#3}}

  \newcommand{\inflim}[1][n]{\lim\limits_{#1 \to \infty}}

  \newcommand{\infser}[1][1]{\sum_{n=#1}^\infty}

  \newcommand{\Fp}{F\primeskip'}
  \newcommand{\Fpp}{F\primeskip''}
  \newcommand{\yp}{y\primeskip'}
  \newcommand{\gp}{g\primeskip'}
  \newcommand{\dx}{\Delta x}
  \newcommand{\dy}{\Delta y}
  \newcommand{\ddz}{\Delta z}
  \newcommand{\thet}{\theta}
  \newcommand{\norm}[1]{\left\lVert#1\right\rVert}
  \newcommand{\vnorm}[1]{\left\lVert\vec #1\right\rVert}
  \newcommand{\snorm}[1]{\left|\left|\,#1\,\right|\right|}
  \newcommand{\la}{\left\langle}
  \newcommand{\ra}{\right\rangle}
  \newcommand{\dotp}[2]{\vec #1 \cdot \vec #2}
  \newcommand{\proj}[2]{\text{proj}_{\,\vec #2}{\,\vec #1}}
  \newcommand{\crossp}[2]{\vec #1 \times \vec #2}
  \newcommand{\veci}{\vec i}
  \newcommand{\vecj}{\vec j}
  \newcommand{\veck}{\vec k}
  \newcommand{\vecu}{\vec u}
  \newcommand{\vecv}{\vec v}
  \newcommand{\vecw}{\vec w}
  \newcommand{\vecx}{\vec x}
  \newcommand{\vecy}{\vec y}
  \newcommand{\vrp}{\vec r\hskip0.75pt '}
  \newcommand{\vrpp}{\vec r\hskip0.75pt ''}
  \newcommand{\vsp}{\vec s\hskip0.75pt '}
  \newcommand{\vrt}{\vec r(t)}
  \newcommand{\vst}{\vec s(t)}
  \newcommand{\vvt}{\vec v(t)}
  \newcommand{\vat}{\vec a(t)}
  \newcommand{\px}{\partial x}
  \newcommand{\py}{\partial y}
  \newcommand{\pz}{\partial z}
  \newcommand{\pf}{\partial f}
  \newcommand{\unittangent}{\vec{{}T}}
  \newcommand{\unitnormal}{\vec{N}}
  \newcommand{\unittangentprime}{\vec{{}T}\hskip0.75pt '}
  \newcommand{\mathN}{\mathbb{N}}
  \newcommand{\surfaceS}{\mathcal{S}}
  \newcommand{\zerooverzero}{\ds \raisebox{8pt}{\text{``\ }}\frac{0}{0}\raisebox{8pt}{\textit{ ''}}}
  \newcommand{\deriv}[2]{\myds\frac{d}{dx}\left(#1\right)=#2}
  \newcommand{\myint}[2]{\myds\int #1\, dx= {\ds #2}}
  \newcommand{\primeskip}{\hskip.75pt}
  \newcommand{\abs}[1]{\left\lvert #1\right\rvert}
  \newcommand{\sech}{\operatorname{sech}}
  \newcommand{\csch}{\operatorname{csch}}
  \newcommand{\curl}{\operatorname{curl}}
  \newcommand{\divv}{\operatorname{div}}
  \newcommand{\Hess}{\operatorname{Hess}}
  \newcommand{\lt}{<}
  \newcommand{\gt}{>}
  \newcommand{\amp}{&}
  %% End: Author-provided macros
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection CONDITIONAL BOXES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\InstructorNote[1]{%
  \ifdefined\InstructorNotes
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
\NewEnviron{InstructorComment}{%
  \ifdefined\InstructorNotes
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
      title={\ttfamily\bfseries\small instructor},
      attach boxed title to top left={xshift=5pt,yshift=-\tcboxedtitleheight/2},
      boxed title style={size=small,boxrule=0pt,arc=0pt,colback=Lavender!70, outer arc=0mm,top=0pt,left=0pt,right=0pt,bottom=0pt}
      ]
      \sffamily \BODY 
    \end{tcolorbox}
  \else
    \@gobble{\BODY}\ignorespaces
    %\ifthenelse{\equal{#1}{}}{\vfill}{\vspace{#1}}
  \fi
}
\newcommand\Answer[1]{%
  \ifdefined\InstructorNotes
    \tcbox[tcbox raise base, colframe=ForestGreen, colback=ForestGreen!3, arc = 0mm, outer arc = 0mm, boxrule=0.2mm, left=2pt, right=2pt, top=2pt, bottom=2pt]{#1}
  \else
    #1
  \fi
}

% Example use case: "See \hyerref[label]{this note}", where label is in a separate section (inputted by MyCommentInput); if I want I can anchor the margin comment with hypertarget command (google-able)
\newcommand\MarginComment[1]{%
  \ifdefined\InstructorNotes
    \marginnote{%
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
    \textcolor{Red}{\sffamily\bfseries #1}
  }
  \else
  \fi
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection THEOREMS, DEFINITIONS, REMARKS, ETC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\myboxRuleThin}{0.5pt}
\newcommand{\myboxRuleThick}{2.0pt}
\newcommand{\myboxmargin}{6pt}
\newcommand{\myboxTopMarginSmall}{6pt}
\newcommand{\myboxTopMarginLarge}{9pt}

% Fakesubsection Theoremstyle:plain
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem*{theorem*}{Theorem}
\newtheorem{prop}[theorem]{Proposition}
\newtheorem*{prop*}{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem*{corollary*}{Corollary}

\tcolorboxenvironment{theorem}{
  enhanced,parbox=true,frame hidden,colback=white,top=\myboxTopMarginSmall,borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}
\tcolorboxenvironment{theorem*}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall, borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}
\tcolorboxenvironment{lemma}{
  enhanced,parbox=true,frame hidden,colback=white,top=\myboxTopMarginSmall,borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}
\tcolorboxenvironment{lemma*}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall, borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}
\tcolorboxenvironment{corollary}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall, borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}
\tcolorboxenvironment{corollary*}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall, borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}

% Fakesubsection Theoremstyle:definition
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem*{definition*}{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem*{example*}{Example}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{axiom}[theorem]{Axiom}
\newtheorem*{axiom*}{Axiom}

\tcolorboxenvironment{definition}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall,borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}

\tcolorboxenvironment{axiom}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginSmall,borderline west={\myboxRuleThin}{0pt}{ThmColor}, borderline north={\myboxRuleThin}{0pt}{ThmColor}
}

% Fakesubsection Theoremstyle:note
\newtheoremstyle{note}% see amsthm documentation
{3pt}{3pt}
{}{}
{\sffamily\bfseries\color{NoteColor}}{:}
{ }{}

\theoremstyle{note}
\newtheorem{keyidea}[theorem]{Key Idea}
\newtheorem*{takeaway*}{TAKEAWAY}
\newtheorem*{tip*}{TIP}
\newtheorem*{remarkbasic*}{REMARK for the \emph{SURVIVING}}
\newtheorem*{remarkadvanced*}{REMARK for the \emph{THRIVING}}
\newtheorem*{practice*}{PRACTICE}

\tcolorboxenvironment{keyidea}{
  colback=NoteColor!4,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick
}
\tcolorboxenvironment{takeaway*}{
  colback=NoteColor!4,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick
}
\tcolorboxenvironment{practice*}{
  colback=NoteColor!4,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick
}
\tcolorboxenvironment{tip*}{
  colback=NoteColor!4,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick
}
\tcolorboxenvironment{remarkbasic*}{
  colback=BasicBGColor!10,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick,
  %borderline={\myboxRuleThick}{0mm}{NoteColor,dashed},
}
\tcolorboxenvironment{remarkadvanced*}{
  colback=AdvancedBGColor!10,
  colframe=NoteColor,
  sharp corners,
  boxrule=\myboxRuleThick
}

% Fakesubsection Theoremstyle:checkin
\newtheoremstyle{checkin}% see amsthm documentation
{3pt}{3pt}
{}{}
{\sffamily\bfseries\color{CheckInColor}}{.}
{ }{}

\theoremstyle{checkin}
\newtheorem*{checkin*}{Check In}

\tcolorboxenvironment{checkin*}{
  enhanced,frame hidden,colback=white,top=\myboxTopMarginLarge,borderline west={\myboxRuleThick}{0pt}{CheckInColor}, borderline north={\myboxRuleThick}{0pt}{CheckInColor}
}

% Fakesubsection Theoremstyle:caution
\newtheoremstyle{caution}% see amsthm documentation
{3pt}{3pt}
{}{}
{\sffamily\bfseries\color{CautionColor}}{.}
{ }{}

\theoremstyle{caution}
\newtheorem*{caution*}{!CAUTION!}

\tcolorboxenvironment{caution*}{
  colback=CautionColor!4,
  colframe=CautionColor,
  arc=0pt,outer arc=0pt,
  boxrule=\myboxRuleThick
}

% Fakesubsection Prepwork (deprecated?)
\newtcolorbox{Prepwork}{%
  enhanced,
  colframe=MyGreen,
  colbacktitle=MyGreen,
  colback=Green!15,
  coltitle=White,
  boxrule=3pt,
  top=16pt,
  left=6pt,
  right=6pt,
  bottom=6pt,
  outer arc=0pt,
  arc=0pt,
  fonttitle=\bfseries,
  attach boxed title to top left={xshift=18pt,yshift=-\tcboxedtitleheight/2},
  boxed title style={outer arc=0pt,top=3pt,bottom=3pt,colback=MyGreen},
  title={\sffamily\bfseries PREPWORK\ldots }
}
% Fakesubsection Summary (deprecated?)
\newtcolorbox{Summary}{%
  enhanced,
  colframe=MyGreen,
  colbacktitle=MyGreen,
  colback=Green!15,
  coltitle=White,
  boxrule=3pt,
  top=16pt,
  left=6pt,
  right=6pt,
  bottom=6pt,
  outer arc=0pt,
  arc=0pt,
  fonttitle=\bfseries,
  attach boxed title to top right={xshift=-18pt,yshift=-\tcboxedtitleheight/2},
  boxed title style={outer arc=0pt,top=3pt,bottom=3pt,colback=MyGreen},
  title={\sffamily\bfseries \ldots SUMMARY}
}


% Fakesection FLASHCARD LETTERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\mcA}{\setlength{\fboxsep}{8pt}\colorbox{flashcardA}{\sffamily\textbf{A}}\setlength{\fboxsep}{2pt}}
\newcommand{\mcB}{\setlength{\fboxsep}{8pt}\colorbox{flashcardB}{\sffamily\textcolor{white}{\textbf{B}}}\setlength{\fboxsep}{2pt}}
\newcommand{\mcC}{\setlength{\fboxsep}{8pt}\colorbox{flashcardC}{\sffamily\textcolor{white}{\textbf{C}}}\setlength{\fboxsep}{2pt}}
\newcommand{\mcD}{\setlength{\fboxsep}{8pt}\colorbox{flashcardD}{\sffamily\textbf{D}}\setlength{\fboxsep}{2pt}}
\newcommand{\mcE}{\setlength{\fboxsep}{8pt}\colorbox{flashcardE}{\sffamily\textcolor{white}{\textbf{E}}}\setlength{\fboxsep}{2pt}}
\newcommand{\mcextra}{\setlength{\fboxsep}{8pt}\colorbox{Gray}{\sffamily\textcolor{Gray}{\textbf{E}}}\setlength{\fboxsep}{2pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection AtEndOfClass (currently empty)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtEndOfClass{
} %AtEndOfClass

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection AtEndPreamble: HYPERREF  2022-09-08 added, copid from stackexchange and changed linkcolor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndPreamble{%
  \RequirePackage{hyperref}
  \hypersetup{%
    colorlinks    = true,%  Color text instead of boxes
    %linkcolor     = Black!20!OliveGreen,% Color of internal links
    linkcolor     = black,% Color of internal links
    citecolor     = black,% Color of citations
    urlcolor      = RoyalBlue,%  Color of external urls
    pdfstartview  = Fit,%
    pdfmenubar    = true,%
    pdftoolbar    = true,%
    bookmarksopen = false,%
    %bookmarksopenlevel = 1,%
  }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fakesection AtBeginDocument: (currently empty)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{
%\RequirePackage[en-GB]{datetime2}
%\DTMlangsetup[en-GB]{ord=raise,monthyearsep={,\space}}
} %END AtBeginDocument
