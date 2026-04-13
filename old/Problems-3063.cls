%UPDATED 2024-08-23 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Problems}
\LoadClass[11pt]{article}  

% Fakesection BASIC PACKAGES
\usepackage[margin=2cm]{geometry} %legalpaper if desired
\RequirePackage{etoolbox}
\RequirePackage[inline]{enumitem}
\RequirePackage{parskip} %no indent (works in tex4ht), skips line between paragraphs
\RequirePackage{graphicx}
\RequirePackage{systeme}
\RequirePackage{soul} 
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{tikz}


% Fakesection FONTS AND SYMBOLS


\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting?
\RequirePackage[scaled=1.0]{newtxtext} %provides roman, ss, tt variants.
\RequirePackage[varqu,varl,scaled=0.95]{zi4}% inconsolata; teletype font
\RequirePackage[scaled=0.9]{helvet} %provides only ss, obviously
\RequirePackage[scaled=1.0,bigdelims,vvarbb]{newtxmath} % load after amsthm. Not compatible with fouriernc. Use option libertine if main font is libertine.
%\useosf % A newtx option. old style figures for text, not math (e.g. changes ntxlf to ntxosf); not defined for all fonts.
\RequirePackage[scaled=1.1,cal=euler, bb=ams, frak=euler, scr=boondoxo]{mathalfa} %lots of variants possible here
\RequirePackage{bm} %load after all to give access to bold math; not always necessary, but spacing is apparently better




% Fakesection TITLES  (KEEP EDITING)

\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\setcounter{secnumdepth}{0}

%\setlength{\droptitle}{-5em}
\pretitle{\noindent\huge\sffamily\bfseries}
%\posttitle{\par\vskip 0.5em}
\posttitle{\par}
\preauthor{\noindent\Large\sffamily}
\postauthor{\par}
\predate{\noindent}
\postdate{}


%usage: 
%\titleformat{command}[shape]
%{format}{label}{sep}
%{before-code}[after-code]


\titleformat{\section}[block]
{\sffamily\bfseries\Huge}{\thesection.}{0.7em}
{}[]

\titleformat{\subsection}[block]
{\sffamily\bfseries\LARGE}{\thesubsection}{1em}
{}[]

\titleformat{\subsubsection}[block]
{\sffamily\bfseries\itshape}{\colorbox{gray!10}{\thesubsubsection}}{1em}
{}[]

\titlecontents{pchapter}[0em]
{\bfseries}
{\thecontentslabel. \enspace }
{\enspace}
{ \titlerule*[0.3pc]{.} \thecontentspage}[]  

\titlecontents{psection}[1em]
{}
{\bfseries\thecontentslabel. \normalfont \enspace }
{\normalfont\enspace}
{ \titlerule*[0.2pc]{.} \bfseries \thecontentspage}[\vspace{-0.5em}]  % Using this titlerule produces

\titlecontents{psubsection}[2.5em]
{\small}
{\thecontentslabel. \enspace }
{\enspace}
{\hfill  \thecontentspage}[\vspace{-0.5em}]

\titlecontents{psubsubsection}[3.5em]
{\small}
{\thecontentslabel. \enspace }
{\enspace}
{\hfill \thecontentspage}[]

\titlecontents{chapter}[0em]
{\bfseries}
{\thecontentslabel. \enspace }
{\enspace}
{ \titlerule*[0.3pc]{.} \thecontentspage}[]  

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
\titlespacing*{\subsection}{0pt}{1.0em}{0.3em}
\titlespacing*{\subsubsection}{0pt}{1em}{0.3em}
\contentsmargin{1em}
%\renewcommand\contentsname{Table of Contents}




% Fakesection XSIM

\RequirePackage{xsim}

\DeclareExerciseTagging{difficulty}
\DeclareExerciseTagging{usage}
\DeclareExerciseTagging{mc}
\DeclareExerciseProperty{source}

\loadxsimstyle{layouts}

\DeclareExerciseEnvironmentTemplate{mysolutionrunin}{%
 \par\vspace{\baselineskip}
 \Needspace*{2\baselineskip}
 \noindent
 %\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}}%
 \textbf{\textcolor{ForestGreen}{\XSIMmixedcase{\GetExerciseName}:}}%
 %\GetExercisePropertyT{subtitle}{ \textit{#1}} % <<< notice the space
 \IfInsideSolutionF{%
   \GetExercisePropertyT{points}{%
     \marginpar{%
       \printgoal{\PropertyValue}%
       \GetExercisePropertyT{bonus-points}{+\printgoal{\PropertyValue}}%
       \,\IfExerciseGoalSingularTF{points}
           {\XSIMtranslate{point}}
           {\XSIMtranslate{points}}%
     }%
   }%
 }%
}
{}

\DeclareExerciseEnvironmentTemplate{mymargin}
{%
\trivlist
\item[\llap{%
\smash{%
\tabular[t]{@{}r@{}}
\textbf{\GetExerciseName\GetExerciseProperty{counter}.}
\endtabular
}%
}]\relax
\GetExercisePropertyT{subtitle}{ \textit{(#1).}} % <<< notice the space
{%
\IfInsideSolutionF
{%
\GetExercisePropertyT{topics}
{ {\sffamily\bfseries\PropertyValue\nobreakspace}}%
\GetExercisePropertyT{tags}
{ {\normalfont\itshape\textcolor{RoyalBlue}{\PropertyValue}}}%
\GetExercisePropertyT{difficulty}
{ \hfill{\ttfamily\textcolor{Red}{\PropertyValue}}}%
\newline
\GetExercisePropertyT{usage}
{ {\sffamily\bfseries\textcolor{Purple}{\PropertyValue.}}}%
\GetExercisePropertyT{source}
{ {\ttfamily\textcolor{OliveGreen}{\PropertyValue}}\nobreakspace}%
\GetExercisePropertyT{ID}
{ \hfill{\ttfamily\textcolor{Gray}{\PropertyValue}}\par}%
}%
}
}
{\endtrivlist}


\DeclareExerciseTranslations{points}{
Fallback = points ,
English = points ,
French = exercice ,
German = \"Ubung
}
\DeclareExerciseTranslations{point}{
Fallback = point ,
English = point ,
French = exercice ,
German = \"Ubung
}

\DeclareExerciseType{multiplechoice}{
exercise-env = multiplechoice ,
solution-env = mcanswer ,
exercise-name = MC,
%exercises-name = \XSIMtranslate{} ,
solution-name = Answer ,
solutions-name = \XSIMtranslate{qwers} ,
exercise-template = mymargin ,
solution-template = runin ,
exercise-heading = \subsection* ,
solution-heading = \subsection*
}
\DeclareExerciseType{question}{
exercise-env = question ,
solution-env = qsolution ,
exercise-name = Q,
exercises-name = \XSIMtranslate{} ,
solution-name = \XSIMtranslate{solution} ,
solutions-name = \XSIMtranslate{solutions} ,
exercise-template = mymargin ,
solution-template = mysolutionrunin ,
exercise-heading = \subsection* ,
solution-heading = \subsection*
}

\xsimsetup{%
qsolution/print = true,
mcanswer/print = true
}


% Fakesection AtEndOfClass

\AtEndOfClass{

\everymath{\displaystyle}
\setlength{\fboxsep}{1.5pt}

% question tcolorbox:
\newtcolorbox{qbox}{%
 enhanced,
 oversize,
 breakable,
 left=12mm,
 colframe=Gray!50,
 colback=White
}

% test-specific vfill
\newcommand\tvfill{
  \ifdefined\Solutions
  \else
  \vfill
  \fi
}

%2024-02-16 Linewidth rule:
\newcommand\myrule{%
\noindent\makebox[\linewidth]{\rule{\linewidth}{2pt}}
}

% Fakesubsection MyPoints commands

\newcommand\mypointscd[2]{%
 \addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1 pt. \mdseries(C+D=#2)}} 
}
\newcommand\mypointscdp[2]{%
  \addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1  pt. \mdseries(C+D+P=#2)}} 
}
\newcommand\mypoints[1]{%
  \addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1  pt.}} 
}

% Fakesubsection Instructor/Grader-only stuff
\newcommand\noteinline[1]{%
{\sffamily\sethlcolor{BrickRed!15}\textcolor{BrickRed!80!Black}{\hl{#1}}}%
}

\newcommand\reflection[1]{%
\begin{tcolorbox}[%
 enhanced,
 breakable,
 left=5pt,
 right=5pt,
 top=9pt,
 boxrule=0.8mm,
 arc=3mm,
 colframe=SkyBlue,
 colback=SkyBlue!15,
 coltitle=White,
 title={\ttfamily\bfseries\small reflection:},
 attach boxed title to top left={xshift=12pt,yshift=-\tcboxedtitleheight/2},
 boxed title style={size=small,colback=SkyBlue}
]
\sffamily #1
\end{tcolorbox}
}
\newcommand\notebox[1]{%
\begin{tcolorbox}[%
 enhanced,
 breakable,
 %oversize,
 left=5pt,
 right=5pt,
 top=9pt,
 boxrule=0.8mm,
 arc=3mm,
 colframe=BrickRed!50,
 colback=Red!5,
 coltitle=White,
 title={\ttfamily\bfseries\small note to marker:},
 attach boxed title to top left={xshift=12pt,yshift=-\tcboxedtitleheight/2},
 boxed title style={size=small,colback=BrickRed!50}
]
\sffamily #1
\end{tcolorbox}
}

% For MC questions: Places box around correct answer in Solutions:
\newcommand\Answer[1]{%
  \tcbox[tcbox raise base, colback=ForestGreen!10]{#1}
}


% Fakesubsection Title
\def\ProblemSetTitle{
\thispagestyle{empty}

{\Huge\bfseries\sffamily \ProblemSetName } 

\rule{\textwidth}{4.5pt}

\vspace*{5mm}
}

} %AtEndOfClass


% Fakesection AtEndPreamble: HYPERREF  2022-09-08 added, copid from stackexchange and changed linkcolor

\AtEndPreamble{%
\RequirePackage{hyperref}
\hypersetup{%
      colorlinks    = true,%  Color text instead of boxes
      linkcolor     = Black!20!OliveGreen,% Color of internal links
      citecolor     = black,% Color of citations
      urlcolor      = RoyalBlue,%  Color of external urls
      pdfstartview  = Fit,%
      pdfmenubar    = true,%
      pdftoolbar    = true,%
      bookmarksopen = false,%
      %bookmarksopenlevel = 1,%
    }
  }


