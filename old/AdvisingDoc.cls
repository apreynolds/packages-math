\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{AdvisingDoc}[2025-07-16]

\LoadClass[11pt]{article}  

\newcommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand*{\@subtitle}{}%
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}
\newcommand*{\@studentid}{}%
\newcommand*{\program}[1]{\gdef\@program{#1}}
\newcommand*{\@program}{}%


\def\maketitle{%
  \par{\LARGE\bfseries\sffamily\@title,  \liningnums{\@studentid} -- \@program}
\par{\Large\itshape Advising Notes, updated \@date}
\vspace{2em}
}

% Fakesection BASIC PACKAGES
\RequirePackage{parskip} %no indent, skips line between paragraphs
\RequirePackage[inline]{enumitem}
\RequirePackage[dvipsnames]{xcolor} 
\RequirePackage[most]{tcolorbox}

% Fakesection DATETIME
%\RequirePackage[nodayofweek]{datetime}
%\ddmmyyyydate % will produce dd/mm/yyyy
%\longdate %will produce long date; NOTE that order of ddmmyyyydate matters, and NOTE the nodayof week option
% Fakesection FONTS
% Fakesubsection TYPEFACE SELECTIONS
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

 %SANS:
\RequirePackage[
sf,
sflining, % or sfoldstyle,
scaled=0.85
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

% Fakesubsection TYPEFACE-DEPENDENT STUFF:
\newcommand{\course}[2][MATH]{%
{{\small #1} #2}%
}
\AtBeginEnvironment{tabular}{\LibertinusSerifTLF}
\renewcommand*{\oldstylenums}[1]{{\LibertinusSerifOsF #1}}
\newcommand*{\liningnums}[1]{{\LibertinusSerifTLF #1}}
%\useosf  % for osf in normal text; load after math package

% Fakesection MARGINNOTE
\RequirePackage{marginnote}

% Fakesection TITLESEC
\RequirePackage[sf,bf,clearempty]{titlesec}
%\assignpagestyle{\chapter}{empty}
\setcounter{secnumdepth}{0}

% Fakesection GEOMETRY
\RequirePackage{geometry}
\newlength{\alphabet} % Will be used to set textwidth
\settowidth{\alphabet}{\normalfont abcdefghijklmnopqrstuvwxyz}
%\geometry{showframe}
\geometry{textwidth=2.6\alphabet}
\geometry{head=15pt}
%\geometry{twoside}
\makeatletter
\if@twoside
  \geometry{hmarginratio={2:3}}
\else
  \geometry{hmarginratio={1:1}}
\fi
\makeatother
\geometry{marginparwidth=0.7\dimexpr\paperwidth-1.0in-\hoffset-\oddsidemargin - \textwidth\relax}

% Fakesection FANCYHDR
\RequirePackage[]{fancyhdr}
\makeatletter
\if@twoside
  \fancyhead[LO,RE]{}
  \fancyhead[LE,RO]{{\scshape\nouppercase{\rightmark}}}
\else
  \fancyhead[L]{}
  \fancyhead[R]{{\scshape\nouppercase{\rightmark}}}
\fi
\makeatother
\fancyhead[C]{}
\fancyfoot[L]{}
\fancyfoot[C]{\thepage}
\fancyfoot[R]{}

% Fakesection FUZZ
\hfuzz 2pt
\overfullrule 25pt
\vfuzz 2pt
\hbadness=500
\vbadness=1000

% Fakesection AtEndOfClass
\AtEndOfClass{

  % Fakesubsection HYPERREF
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

% Fakesection AtBeginDocument
\AtBeginDocument{
% Fakesection DATETIME
\RequirePackage[british]{datetime2} % \today = 1st January 2000

} %END AtBeginDocument
