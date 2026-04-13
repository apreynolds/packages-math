\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Assignment-3063}
\LoadClass[12pt]{article}  

% Fakesection BASIC PACKAGES
\usepackage[margin=3.0cm]{geometry} %legalpaper if desired
%\RequirePackage{etoolbox} %is this necessary?
\RequirePackage[inline]{enumitem}
\RequirePackage{parskip} %no indent, skips line between paragraphs
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{xspace}
%\RequirePackage{systeme}
%\RequirePackage{soul} 
\RequirePackage{tikz}
\RequirePackage{siunitx}

% Fakesection FONTS

\RequirePackage{amssymb}
\RequirePackage{amsmath}
\let\CheckCommand\providecommand % https://tex.stackexchange.com/questions/511711/disable-microtype-warning
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting?
\RequirePackage[scaled=1.0]{newtxtext} %provides roman, ss, tt variants.
\RequirePackage[varqu,varl,scaled=0.95]{zi4}% inconsolata; teletype font
\RequirePackage[scaled=1.0,bigdelims,vvarbb]{newtxmath} % load after amsthm. Not compatible with fouriernc. Use option libertine if main font is libertine.
%\useosf % A newtx option. old style figures for text, not math (e.g. changes ntxlf to ntxosf); not defined for all fonts.
\RequirePackage[scaled=1.1,cal=euler, bb=ams, frak=euler, scr=boondoxo]{mathalfa} %lots of variants possible here
\RequirePackage{bm} %load after all to give access to bold math; not always necessary, but spacing is apparently better

% Fakesection XSIM

%\RequirePackage[use-files=true]{xsim}
\RequirePackage{xsim}

\DeclareExerciseTagging{difficulty}
\DeclareExerciseTagging{usage}
\DeclareExerciseTagging{mc}
\DeclareExerciseProperty{source}

\loadxsimstyle{layouts}

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
  \GetExercisePropertyT{subtitle}{ \textit{#1}} % <<< notice the space
}
{\endtrivlist}

\DeclareExerciseTranslations{points}{
  Fallback = points ,
  English = points ,
}
\DeclareExerciseTranslations{point}{
  Fallback = point ,
  English = point ,
}

\DeclareExerciseType{question}{
  exercise-env = question ,
  solution-env = qsolution ,
  exercise-name = Q,
  exercises-name = \XSIMtranslate{} ,
  solution-name = \XSIMtranslate{solution} ,
  solutions-name = \XSIMtranslate{solutions} ,
  exercise-template = mymargin ,
  solution-template = default ,
  exercise-heading = \subsection* ,
  solution-heading = \subsection*
}

\ifdefined\Solutions
\xsimsetup{%
qsolution/print = true
}
\fi

% Fakesection AtEndOfClass

\AtEndOfClass{

\newcommand*{\lsim}{\mathord{\sim}} %for use of tilde as negation
\everymath{\displaystyle}
\setlength{\fboxsep}{1.5pt}

% Fakesubsection Title
\def\AssessmentTitle{
\thispagestyle{empty}

{\LARGE\bfseries\sffamily Assignment \AssessmentNumber 
\ifdefined\Solutions
\space \textcolor{ForestGreen}{SOLUTIONS}
\else
\fi
\hfill\large Math \CourseNumber,\space \Term} 

\ifdefined\MyComments
  {\LARGE \sffamily\bfseries\textcolor{Red}{MARKER'S COPY}}
\fi


{\sffamily Due: \DueDate  \hfill \printtotalpoints }

\rule{\textwidth}{1pt}
\ifdefined\Solutions

\bigskip

{\sffamily \large
  \color{ForestGreen}{%
   These solutions are intended to help you understand both how to solve the problems and how to write up the solutions.
   There could be other valid ways to solve the problems. 

   \medskip
   If you have questions about how your work was graded, please be prepared to refer to these solutions.

   \bigskip

  }
 }
\ifdefined\MyComments
\notebox{Graders: notes in red are intended to give you some extra instructions (and are not visible to students). Please read them over if and when you encounter them.}
\fi
\else

\smallskip

\textbf{Instructions:} 
\medskip
\Instructions 
\rule{\textwidth}{1pt}

\fi

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
\makeatletter
\newcommand\noteinline[1]{%
\ifdefined\MyComments
{\sffamily\sethlcolor{BrickRed!15}\textcolor{BrickRed!80!Black}{\hl{#1}}}%
\else
\@gobble{#1}\ignorespaces
\fi
}
\newcommand\notebox[1]{%
\ifdefined\MyComments
\begin{tcolorbox}[%
 enhanced,
 breakable,
 oversize,
 left=5pt,
 right=5pt,
 top=9pt,
 boxrule=0.8mm,
 arc=3mm,
 colframe=BrickRed,
 colback=Red!5,
 coltitle=White,
 title={\ttfamily\bfseries\small note to marker:},
 attach boxed title to top left={xshift=12pt,yshift=-\tcboxedtitleheight/2},
 boxed title style={size=small,colback=BrickRed}
]
\sffamily #1
\end{tcolorbox}
\else
\@gobble{#1}\ignorespaces
\fi
}
\makeatother
} %END AtEndOfClass




% Fakesection AtEndPreamble HYPERREF

\AtEndPreamble{%
\RequirePackage{hyperref}
\hypersetup{%
      colorlinks    = true,%  Color text instead of boxes
      linkcolor     = Black!20!OliveGreen,% Color of internal links
      citecolor     = black,% Color of citations
      urlcolor      = Blue,%  Color of external urls
      pdfstartview  = Fit,%
      pdfmenubar    = true,%
      pdftoolbar    = true,%
      bookmarksopen = false,%
      %bookmarksopenlevel = 1,%
    }
  }
