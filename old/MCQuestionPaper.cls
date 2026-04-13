%UPDATED 2024-09-29 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MCQuestionPaper}
\LoadClass[12pt]{article}  

% Fakesection COMPILATION INSTRUCTIONS

% latexmk is recommended for compilation, as the command below will generate, from a single .tex file, three different pdfs:
  % - one with no extras (named filename.pdf)
  % - one with solutions (named filename_SOLUTIONS.pdf)
  % - one with solutions, as well as marker-only comments (named filename_MARKER.pdf)

% latexmk -pdf -pdflatex="pdflatex \%O \%S" %  && latexmk -c % && latexmk -pdf -jobname=%:r_SOLUTIONS -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \input{\%S}'" % && latexmk -c -jobname=%:r_SOLUTIONS % &&  latexmk -pdf -jobname=%:r_MARKER -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \def\MyComments{1} \input{\%S}'" % && latexmk -c -jobname=%:r_MARKER % 

%Alternatively, one could use the "solutions" or "comments" class options, although one should then save as separate .tex files.

% Fakesection OPTIONS
\DeclareOption{tuesday}{
\def\Tuesday{1} 
\def\TueThu{1} 
}
\DeclareOption{thursday}{
\def\Thursday{1} 
\def\TueThu{1} 
}
\DeclareOption{solutions}{
\def\Solutions{1} 
}
\DeclareOption{comments}{
\def\Solutions{1} 
\def\MyComments{1} 
}
\DeclareOption{legal}{
\PassOptionsToPackage{legalpaper}{geometry}
}
\DeclareOption{short}{
\def\Short{1} 
}
\ProcessOptions\relax

% Fakesection Basic Packages
\RequirePackage[top=1.5cm, bottom=1.5cm, left=2.0cm, right=1.2cm]{geometry} %legalpaper if desired
\RequirePackage{forloop}
\RequirePackage{etoolbox}
\RequirePackage[inline]{enumitem}
\RequirePackage{parskip} %no indent, skips line between paragraphs
\RequirePackage{graphicx}
\RequirePackage{xspace}
\RequirePackage{systeme}
\RequirePackage{soul} 
\RequirePackage[dvipsnames]{xcolor}
\colorlet{TueBoxColor}{white}
\colorlet{ThuBoxColor}{white}
\ifdefined\Tuesday
 \colorlet{TueBoxColor}{black}
\fi
\ifdefined\Thursday
 \colorlet{ThuBoxColor}{black}
\fi
\RequirePackage[most]{tcolorbox}
\RequirePackage{tikz}
\RequirePackage{environ}
\RequirePackage{background}
\backgroundsetup{%
  contents={}
}

% generates only the cover page (points won't be calculated correctly)
\ifdefined\FirstPageOnly
\usepackage[1]{pagesel}
\fi

% Fakesection FONTS

\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting?
\RequirePackage[scaled=1.1]{newtxtext} %provides roman, ss, tt variants.
\RequirePackage[varqu,varl,scaled=0.95]{zi4}% inconsolata; teletype font

\RequirePackage[scaled=1.1,bigdelims,vvarbb]{newtxmath} % load after amsthm. Not compatible with fouriernc. Use option libertine if main font is libertine.
%\useosf % A newtx option. old style figures for text, not math (e.g. changes ntxlf to ntxosf); not defined for all fonts.
\RequirePackage[scaled=1.1,cal=euler, bb=ams, frak=euler, scr=boondoxo]{mathalfa} %lots of variants possible here
\RequirePackage{bm} %load after all to give access to bold math; not always necessary, but spacing is apparently better


% Fakesection XSIM

\RequirePackage{xsim}

\DeclareExerciseTagging{difficulty}
\DeclareExerciseTagging{usage}
\DeclareExerciseTagging{mc}
\DeclareExerciseProperty{source}

\loadxsimstyle{layouts}

\DeclareExerciseEnvironmentTemplate{mymarginmc}
{%
\trivlist
\item[\llap{%
\smash{%
\tabular[t]{@{}r@{}}
\textbf{\GetExerciseName\GetExerciseProperty{counter}.}
\endtabular
}%
}]\relax
}
{\endtrivlist}

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
}
{\endtrivlist}

\DeclareExerciseEnvironmentTemplate{mysolutionrunin}
  {%
    \par\vspace{\baselineskip}
    \Needspace*{2\baselineskip}
    \noindent
    %\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}}%
    \textbf{\textcolor{ForestGreen}{\XSIMmixedcase{\GetExerciseName}:}}%
    \GetExercisePropertyT{subtitle}{ \textit{#1}} % <<< notice the space
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


\DeclareExerciseTranslations{points}{
Fallback = points ,
English = marks ,
French = exercice ,
German = \"Ubung
}
\DeclareExerciseTranslations{point}{
Fallback = point ,
English = mark ,
French = exercice ,
German = \"Ubung
}
\DeclareExerciseTranslations{point-abbr}{
Fallback = p. ,
English = m's ,
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
exercise-template = mymarginmc ,
solution-template = mysolutionrunin ,
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

\ifdefined\Solutions
\xsimsetup{%
qsolution/print = true,
mcanswer/print = false
}
\fi
% Fakesection AtEndOfClass

\AtEndOfClass{

\everymath{\displaystyle}
\newcommand*{\lsim}{\mathord{\sim}} %for use of tilde as negation
\setlength{\fboxrule}{0.5pt}
\setlength{\fboxsep}{1.5pt}

\NewEnviron{TUE}{%
 \setlength{\fboxrule}{4pt}
 \setlength{\fboxsep}{8pt}
 \fcolorbox{TueBoxColor}{white}{% 
  \BODY
 }
}
\NewEnviron{THU}{%
 \setlength{\fboxrule}{4pt}
 \setlength{\fboxsep}{8pt}
 \fcolorbox{ThuBoxColor}{white}{% 
  \BODY
  %\huge\sffamily\bfseries \BODY
 }
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

% Fakesubsection Document structure

\newcommand\MCpage{
  \newpage
  \backgroundsetup{%
    contents={}%
  }
}

\newcommand\tvfill{
  \ifdefined\Solutions
  \else
  \vfill
  \fi
}
% Fakesubsubsection Short answer page

\newcommand\SApage{
  \newpage
  \ifdefined\Solutions
  \else
  \newgeometry{top=3.6cm, bottom=1.5cm, left=1.8cm, right=4cm}
  \backgroundsetup{%
    scale=1,
    angle=0,
    position=current page.south east,
    nodeanchor = south east,
    contents={
     \begin{tikzpicture}
       \fill[gray!30] (0,0) rectangle (3.7,24.3);
       \node[color=white, rotate=90] at (2.2,19) {%
        \sffamily \Huge
       please do not write in this space 
       };
     \end{tikzpicture}
    }
  }
  \fi
}

% Fakesubsubsection Extra page (with watermark); not present in Solutions
\newcommand\Extrapage{
  \newpage
  \ifdefined\Solutions
  \else
  \newgeometry{top=3.6cm, bottom=1.5cm, left=1.8cm, right=1.5cm}
  \backgroundsetup{%
    scale=5,
    angle=0,
    position=current page.center,
    nodeanchor = center,
    placement=center,
    color={gray!30},
    contents={
      Blank page for extra work
    }
  }
  \mbox{}
  \fi
}

% Fakesubsection Title
\def\AssessmentTitle{
%\thispagestyle{empty}

\ifdefined\TueThu
\begin{TUE}
  \textcolor{TueBoxColor}{%
   \parbox{1.8cm}{%
    \centering\sffamily\bfseries
    {\huge TUE}\\[1ex]
    {\large \Date} %
   }%
  }%
\end{TUE}
\hfill
\begin{minipage}[c]{11cm}%
\begin{center}
{\bfseries\sffamily \huge \AssessmentName \space\space\space \Large MATH \CourseNumber \space (\Term) 
\ifdefined\Solutions

 \bigskip
 \ifdefined\MyComments
  \ifdefined\Draft
  \else
  \space \textcolor{Red}{GRADER'S COPY}
  \fi
  \else
  \ifdefined\Draft
  \else
  \space \textcolor{ForestGreen}{SOLUTIONS}
  \fi
 \fi
\fi
}

\setlength{\fboxrule}{0.5pt}
\setlength{\fboxsep}{1.5pt}

\bigskip
\sffamily\InstructionsTop

\end{center}
\end{minipage}%
\hfill
\begin{THU}
  \textcolor{ThuBoxColor}{%
   \parbox{1.8cm}{%
    \centering\sffamily\bfseries
    {\huge THU}\\[1ex]
    {\large \Date} %
   }%
  }%
\end{THU}

\bigskip
\else
\begin{minipage}[b]{3cm}%
  {\bfseries\sffamily \huge \AssessmentName}
\end{minipage}%
\hfill
\begin{minipage}[b]{10cm}%
\begin{center}
{\bfseries\sffamily \Large MATH \CourseNumber \space (\Term) 
\ifdefined\Solutions

 \bigskip
 \ifdefined\MyComments
  \ifdefined\Draft
  \else
  \space \textcolor{Red}{GRADER'S COPY}
  \fi
  \else
  \ifdefined\Draft
  \else
  \space \textcolor{ForestGreen}{SOLUTIONS}
  \fi
 \fi
\fi
}

\setlength{\fboxrule}{0.5pt}
\setlength{\fboxsep}{1.5pt}

\end{center}
\end{minipage}%
\hfill
\begin{minipage}[b]{3cm}%
  \begin{flushright}
    {\bfseries\sffamily \Large \Date}
  \end{flushright}
\end{minipage}%

\begin{center}
\sffamily \InstructionsTop

\bigskip
\end{center}
\fi

\ifdefined\Solutions
 \vspace{1cm}
 \ifdefined\MyComments
  \notebox{Graders: notes in red are intended to give you some extra instructions (and are not visible to students). Please read them over if and when you encounter them.}
  \else
 {\sffamily \large
  \color{ForestGreen}{%
   These solutions are intended to help you understand both how to solve the problems and how to write up the solutions.
   There could be other valid ways to solve the problems. 

   \medskip
   If you have questions about how your work was graded, please be prepared to refer to these solutions.
  }
 }
 \fi
\fi

%\ifdefined\Short
%\else
 %\vfill
 
 %\Instructions 
%\fi
} %END title

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
\newcommand\draft[1]{%
\ifdefined\Draft{%
\hl{#1}%
}%
\else%
 #1%
\fi%
}

\newcommand\draftbox[1]{%
\ifdefined\Draft{%
\begin{tcolorbox}[%
 enhanced,
 breakable,
 oversize,
 left=5pt,
 right=5pt,
 top=9pt,
 boxrule=0.8mm,
 arc=3mm,
 leftrule=2.5mm,
 rightrule=2.5mm,
 colframe=Yellow,
 colback=yellow!40,
 coltitle=Gray,
 drop fuzzy shadow,
 title={\ttfamily\bfseries\small (draft-only note)},
 attach boxed title to top left={xshift=12pt,yshift=-\tcboxedtitleheight/2},
 boxed title style={size=small,colback=Yellow}
]
\sffamily #1
\end{tcolorbox}
}%
\else%
\@gobble{#1}\ignorespaces
\fi%
}
\makeatother

% For MC questions: Places box around correct answer in Solutions:
\newcommand\Answer[1]{%
  \ifdefined\Solutions
  \tcbox[tcbox raise base, colback=ForestGreen!10]{#1}
  \else
  #1
  \fi
}

} % END AtEndOfClass


