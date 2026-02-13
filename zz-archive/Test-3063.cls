%UPDATED 2024-12-13
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Test}
\LoadClass[12pt]{article}  
%asdf

%TODO 2024-12-16 Add tikz option
%TODO bring in the IfThenBoxes and clean them up
%TODO (eventually) revamp the whole Tue/Thu left/right box thing, it's very hacky

%-------------------------
% Fakesection COMPILATION 
%-------------------------

%*********************************
% LATEKMK compilation (preferred):
%*********************************

% The commands below will generate three pdfs from a single .tex file:

% To generate the actual test paper:
% latexmk -pdf -pdflatex="pdflatex \%O \%S" filename.tex

% To generate the test paper with solutions (named filename-solutions.pdf):
% latexmk -pdf -jobname=%A-solutions -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \input{\%S}'" filename.tex 

% To generate the test paper with solutions as well as marker-only comments (named filename-marker.pdf):
% latexmk -pdf -jobname=%A-marker -pdflatex="pdflatex --shell-escape \%O '\def\Solutions{1} \def\MyComments{1} \input{\%S}'" filename.tex 
%****************
% ALTERNATIVELY:
%****************

% To generate the actual test paper:
% use \documentclass[]{Test} in filename.tex

% To generate the test paper with solutions (named filename-solutions.pdf):
% Copy filename.tex to filename-solutions.tex and use \documentclass[solutions]{Test} 

% To generate the test paper with solutions and marker-only comments (named filename-marker.pdf):
% Copy filename.tex to filename-marker.tex and use \documentclass[comments]{Test} 


%---------------------
% Fakesection OPTIONS
%---------------------
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

%----------------------------
% Fakesection BASIC PACKAGES
%----------------------------
\RequirePackage[top=3.6cm, bottom=1.5cm, left=2.0cm, right=1.5cm]{geometry} %legalpaper if desired
\RequirePackage{etoolbox}
\RequirePackage[inline]{enumitem}
\RequirePackage{parskip} %no indent, skips line between paragraphs
\RequirePackage{graphicx}
\RequirePackage{xspace}
\RequirePackage{multicol}
%\RequirePackage{soul}  %obsolete?
\RequirePackage{siunitx} 
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

\RequirePackage{silence}% for suppression of warnings
\WarningFilter[mybackgroundwarnings]{everypage}{Functionality similar to this package} 
\WarningFilter[mybackgroundwarnings]{everypage}{You appear to be running a version of LaTeX}
\ActivateFilters[mybackgroundwarnings]
\RequirePackage{background}
\backgroundsetup{%
  contents={}
}


\RequirePackage{systeme}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\newcommand*{\lsim}{\mathord{\sim}} %for use of tilde as negation
\newcommand*{\hreq}{\overset{HR}{=}} %l'hospital's rule

% generates only the cover page (points won't be calculated correctly)
\ifdefined\FirstPageOnly
\usepackage[1]{pagesel}
\fi

%-------------------
% Fakesection FONTS
%-------------------

\let\CheckCommand\providecommand % https://tex.stackexchange.com/questions/511711/disable-microtype-warning
\RequirePackage[tracking = true]{microtype} %makes pdflatex do cleaner typesetting?
\RequirePackage[scaled=1.0]{newtxtext} %provides roman, ss, tt variants.
\RequirePackage[varqu,varl,scaled=0.95]{zi4}% inconsolata; teletype font

\RequirePackage[scaled=1.0,bigdelims,vvarbb]{newtxmath} % load after amsthm. Not compatible with fouriernc. Use option libertine if main font is libertine.
%\useosf % A newtx option. old style figures for text, not math (e.g. changes ntxlf to ntxosf); not defined for all fonts.
\RequirePackage[scaled=1.0,cal=euler, bb=ams, frak=euler, scr=boondoxo]{mathalfa} %lots of variants possible here
\RequirePackage{bm} %load after all to give access to bold math; not always necessary, but spacing is apparently better


%-----------------------
% Fakesection XSIM, ETC
%-----------------------
\RequirePackage{xsim}

\DeclareExerciseTagging{difficulty}
\DeclareExerciseTagging{usage} %probably obsolete
\DeclareExerciseTagging{mc} %probably obsolete
\DeclareExerciseProperty{source}

\loadxsimstyle{layouts}

% Fakesubsection mymargin
\DeclareExerciseEnvironmentTemplate{mymargin}
{% 
  \trivlist 
\item[\llap{% 
    \smash{% 
      \tabular[t]{@{}r@{}} 
      \textbf{\XSIMmixedcase{\GetExerciseName}\GetExerciseProperty{counter}}.
      \IfExercisePropertySetT{points}{% 
        \tabularnewline% 
        \fbox{\ttfamily\small\bfseries\printgoal{\GetExerciseProperty{points}}% 
        \GetExercisePropertyT{bonus-points}{+\printgoal{#1}}% 
      \,\XSIMtranslate{point-abbr}}% 
      }% 
      \endtabular 
    }% 
  }]\relax 
} 
{\endtrivlist}

%\DeclareExerciseEnvironmentTemplate{mymargin}
%{%
  %\trivlist
  %\item[\llap{%
      %\smash{%
        %\tabular[t]{@{}r@{}}
        %\textbf{\GetExerciseName\GetExerciseProperty{counter}.}
        %\endtabular
      %}%
    %}]\relax
%}
%{\endtrivlist}

% Fakesubsection mymargindetails
\DeclareExerciseEnvironmentTemplate{mymargindetails}
{%
  \trivlist
\item[\llap{%
    \smash{% 
      \tabular[t]{@{}r@{}} 
      \textbf{\XSIMmixedcase{\GetExerciseName}\GetExerciseProperty{counter}}.
      \IfExercisePropertySetT{points}{% 
        \tabularnewline% 
        \fbox{\ttfamily\small\bfseries\printgoal{\GetExerciseProperty{points}}% 
        \GetExercisePropertyT{bonus-points}{+\printgoal{#1}}% 
      \,\XSIMtranslate{point-abbr}}% 
      }% 
      \endtabular 
    }% 
  }]\relax
  \GetExercisePropertyTF{subtitle}{ \textit{(#1)}}{} % <<< notice the space
  {%
    \IfInsideSolutionF
    {%
      \GetExercisePropertyT{topics}
      { {\ttfamily\bfseries\textcolor{Black!60}{\PropertyValue}\nobreakspace}}%
      \GetExercisePropertyT{source}
      { \hfill{\ttfamily\textcolor{Black!60}{\PropertyValue}}\nobreakspace}%
      \GetExercisePropertyT{difficulty}
      { {\ttfamily\textcolor{Red}{\PropertyValue}}}%
      \newline
      \GetExercisePropertyT{tags}
      { {\ttfamily\textcolor{Black!60}{\PropertyValue}}}%
      \GetExercisePropertyT{ID}
      { \hfill{\ttfamily\textcolor{Gray}{\PropertyValue}}\par}%
    }%
  }
}
{\endtrivlist}

% Fakesubsection mysolutionrunin
\DeclareExerciseEnvironmentTemplate{mysolutionrunin}
{%
  \par\vspace{\baselineskip}
  \Needspace*{2\baselineskip}
  \noindent
  %\textbf{\XSIMmixedcase{\GetExerciseName}~\GetExerciseProperty{counter}}%
  \begin{tcolorbox}[%
    parbox=false,
    enhanced,
    breakable,
    oversize,
    left=15pt,
    right=15pt,
    top=9pt,
    boxrule=0.1mm,
    arc=0mm,
    outer arc=0mm,
    colframe=ForestGreen!50,
    colback=ForestGreen!3,
    colbacktitle=ForestGreen,
    coltitle=White,
    title={\ttfamily\bfseries\small \GetExerciseName},
    attach boxed title to top left={xshift=5pt,yshift=-\tcboxedtitleheight/2},
    boxed title style={size=small,boxrule=0pt,arc=0pt,colback=ForestGreen!30, outer arc=0mm,top=0pt,left=0pt,right=0pt,bottom=0pt}
    ]
    %\textbf{\textcolor{ForestGreen}{\XSIMmixedcase{\GetExerciseName}:}}%
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
{\end{tcolorbox}}


% Fakesubsection Point Translations (probably unnecessary)
\DeclareExerciseTranslations{points}{
  Fallback = points ,
  English = points ,
}
\DeclareExerciseTranslations{point}{
  Fallback = point ,
  English = point ,
}
\DeclareExerciseTranslations{point-abbr}{
  Fallback = pts ,
  English = pt. ,
}

% Fakesubsection Exercise Types
\DeclareExerciseType{multiplechoice}{
  exercise-env = multiplechoice ,
  solution-env = mcsolution ,
  exercise-name = MC,
  solution-name = solution ,
  solutions-name = solutions ,
  exercise-template = mymargin ,
  solution-template = mysolutionrunin ,
  exercise-heading = \subsection* ,
  solution-heading = \subsection*
}

\DeclareExerciseType{question}{
  exercise-env = question ,
  solution-env = qsolution ,
  exercise-name = Q,
  solution-name = solution ,
  solutions-name = \XSIMtranslate{solutions} ,
  exercise-template = mymargin ,
  solution-template = mysolutionrunin ,
  exercise-heading = \subsection* ,
  solution-heading = \subsection*
}

\DeclareExerciseType{subquestion}{
  exercise-env = subquestion ,
  solution-env = subqsolution ,
  exercise-name = Q,
  solution-name = solution ,
  solutions-name = solutions ,
  exercise-template = mymargin ,
  solution-template = mysolutionrunin ,
  exercise-heading = \subsection* ,
  the-counter=\thequestion\alph{subquestion},
  solution-heading = \subsection*
}

% Fakesubsection Setups
\ifdefined\Solutions
  \xsimsetup{%
    qsolution/print = true,
    subqsolution/print = true,
    mcsolution/print = true
  }
\fi

\ifdefined\MyComments
  \xsimsetup{%
    multiplechoice/template = mymargindetails ,
    question/template = mymargindetails ,
    subquestion/template = mymargindetails
  }
\fi

%Not an xsim setting, but appropriate to declare here:
\counterwithin{equation}{question}
%2025-12-27 OBSOLETE-FOR-NOW:
%\newcommand\mypointscd[2]{%
 %\addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1 pt. \mdseries(C+D=#2)}} 
%}
%\newcommand\mypointscdp[2]{%
  %\addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1  pt. \mdseries(C+D+P=#2)}} 
%}
%\newcommand\mypoints[1]{%
  %\addpoints*{#1} {\fbox{\ttfamily\small\bfseries #1  pt.}} 
%}

\newcommand{\answerbox}[3][0.5\textwidth]{%
  \ifdefined\Solutions
  \else
    \begingroup
    \vfill
    \setlength{\fboxsep}{-\fboxrule}%
    \hfill\framebox[#1]{
      \parbox[t][#2][t]{#1}{%
        \smallskip 
        \, {\ttfamily\small #3}}%
      }
    %\hfill\framebox[#1]{\rule{0pt}{#2}}%
    \endgroup
  \fi
}
\newcommand\testvspace[1]{
  \ifdefined\Solutions
  \else
    \vspace{#1}
  \fi
}
\newcommand\testvfill{
  \ifdefined\Solutions
  \else
    \vfill
  \fi
}
\newcommand\testnewpage{
  \ifdefined\Solutions
  \else
    \newpage
  \fi
}

%--------------------------
% Fakesection AtEndOfClass
%--------------------------

\AtEndOfClass{

\everymath{\displaystyle}
\setlength{\fboxrule}{0.5pt}
\setlength{\fboxsep}{1.5pt}

\NewEnviron{TUE}{%
 \setlength{\fboxrule}{2pt}
 \setlength{\fboxsep}{5pt}
 \fcolorbox{TueBoxColor}{white}{% 
  \BODY
 }
}
\NewEnviron{THU}{%
 \setlength{\fboxrule}{2pt}
 \setlength{\fboxsep}{5pt}
 \fcolorbox{ThuBoxColor}{white}{% 
  \BODY
 }
}

% Fakesubsection Document structure

\newcommand\MCpage{
  \newpage
  \backgroundsetup{%
    contents={}
  }
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
  %\newgeometry{top=3.6cm, bottom=1.5cm, left=1.8cm, right=1.5cm} %unnecessary?
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
  \backgroundsetup{%
  }
  \fi
}

% Fakesubsection Title
\newcommand\AssessmentTitle{
  \thispagestyle{empty}

  % NAME and ID box:
  \vspace*{-3.2cm}
  \framebox[9.3cm][c]{% 
    \parbox[align][2.5cm][c]{9cm}{
      {\sffamily\bfseries NAME:} \\[4ex]
      {\sffamily\bfseries ID:} 
    }%
  }
  \medskip

  \ifdefined\TueThu
    \begin{TUE}
      \textcolor{TueBoxColor}{%
        \parbox{1.8cm}{%
          \centering\sffamily\bfseries
          {\Large TUE}\\[0.5ex]
          {\Date} %
        }%
      }%
    \end{TUE}
    \hfill
    \begin{minipage}[c]{10cm}%
      \begin{center}
        {\bfseries\sffamily 
          \Large MATH \CourseNumber \space (\Term)

          \medskip
          \AssessmentName  
          \ifdefined\Solutions
            \ifdefined\MyComments

              \medskip
              \space \textcolor{Red}{GRADER'S COPY}
            \else
              \space \textcolor{ForestGreen}{SOLUTIONS}
            \fi
          \fi
        }%
        \setlength{\fboxrule}{0.5pt}
        \setlength{\fboxsep}{1.5pt}
      \end{center}
    \end{minipage}%
    \hfill
    \begin{THU}
      \textcolor{ThuBoxColor}{%
        \parbox{1.8cm}{%
          \centering\sffamily\bfseries
          {\Large THU}\\[0.5ex]
          {\Date} %
        }%
      }%
    \end{THU}
  \else
    \begin{center}
      {\bfseries\sffamily 
        \Large MATH \CourseNumber \space (\Term)

        \medskip
        \AssessmentName \space(\Date)
        \ifdefined\Solutions
          \ifdefined\MyComments

            \medskip
            \space \textcolor{Red}{GRADER'S COPY}
          \else
            \space \textcolor{ForestGreen}{SOLUTIONS}
          \fi
        \fi
      }%
      \setlength{\fboxrule}{0.5pt}
      \setlength{\fboxsep}{1.5pt}
    \end{center}
  \fi

  \ifdefined\Solutions
    \vspace{1cm}
    \ifdefined\MyComments
      \begin{MyCommentBox}{0em}
        Graders: notes are intended to give you some extra instructions (and are not visible to students). Please read them over if and when you encounter them.
      \end{MyCommentBox}
    \else
      {\sffamily \large
        \color{ForestGreen}{%
          These solutions are intended to help you understand both how to solve the problems and how to write up the solutions.
          There could be other valid ways to solve the problems. 

          \smallskip
          If you have questions about how your work was graded, please be prepared to refer to these solutions.
        }
      }
    \fi
  \fi

  \ifdefined\Short
    \begin{center}
      {\sffamily \Instructions }
    \end{center}
  \else
    \bigskip
    \begin{description}
      \item[{\sffamily Time:}] \Time
      %\item[Format:] \Format \space (\Points).
    \item[{\sffamily Format:}] \Format
    \item[{\sffamily Coverage:}] \Coverage
    \end{description}

    \bigskip
    {\sffamily\bfseries INSTRUCTIONS:}

    \Instructions 
  \fi
} %END title

% Fakesubsection IFTHENBOXES
\RequirePackage{IfThenBoxes} %custom_package

} % END AtEndOfClass
