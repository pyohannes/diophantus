#lang racket/base

(provide template-main
         template-help
         template-about)

(define template-main #<<EOF
Content-Type: text/html

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8"/>
    <link rel="icon" href="diophantus_icon.png"/>
    <title>Diophantus</title>
    <script type="text/javascript">
        function diowebOpen(formula) {
            formula = encodeURIComponent(formula);
            location.href = location.pathname + '?' + formula;
        }
    </script>
    <link rel="stylesheet" type="text/css" href="diophantus.css"/>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"> </script>
    <script src="https://wzrd.in/standalone/function-plot@1.14.0"> </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML"> </script>
  </head>
  <body>
    <span class="header">
      <a class="base navbar" href="javascript:diowebOpen('about');">About</a>
      <a class="base navbar" href="javascript:diowebOpen('help');">Help</a>
    </span>
    <h1>&Delta;iophantus</h1>
    <form action="javascript:diowebOpen(document.getElementById('formula').value);">
      <input type="text" id="formula" value="~a"/>
      <input type="submit" value="Show"/>
    </form>
    ~a
  </body>
</html>
EOF
)

(define template-help #<<EOF
<div class="textflow">
  <h2>Help</h2>
  <p>Diophantus is supposed to give derivatives and plots for arbitrary 
  elementary functions. Currently supported operations are:
    <ul>
      <li>arithmetic operations \(+ - \times \div\)</li>
      <li>exponentials</li><li>logarithms</li>
      <li>the constants \(\pi\) and \( e \)</li>
      <li>the trigonometric functions \(\sin\), \(\cos\) and \(\tan\)</li>
    </ul>
  </p>
  <p>A function can be entered in the input field as infix or as s-expression, 
  on confirmation the function is simplified, plotted and the derivative is 
  calculated.</p>
  <p>The following table shows what operations can be entered. Infix and 
  s-expressions must not be mixed.</p>
  <table class="base help">
    <tr class="header">
      <td>Operation</td>
      <td>infix</td>
      <td>sexpr</td>
    </tr>
    <tr>
      <td>\(x + 1\)</td>
      <td>x + 1</td>
      <td>(+ x 1)</td>
    </tr>
    <tr>
      <td>\(x - 1\)</td>
      <td>x - 1</td>
      <td>(- x 1)</td>
    </tr>
    <tr>
      <td>\(x \times 1\)</td>
      <td>x * 1</td>
      <td>(* x 1)</td>
    </tr>
    <tr>
      <td>\(\frac{1}{x}\)</td>
      <td>1/x</td>
      <td>(/ 1 x)</td>
    </tr>
    <tr>
      <td>\(x^2\)</td>
      <td>x^2</td>
      <td>(expt x 2)</td>
    </tr>
    <tr>
      <td>\( \ln(x) \)</td>
      <td>ln(x)</td>
      <td>(ln x)</td>
    </tr>
    <tr>
      <td>\( \log(x) \)</td>
      <td>log(x)</td>
      <td>(log x)</td>
    </tr>
    <tr>
      <td>\( \pi \)</td>
      <td>pi</td>
      <td>pi</td>
    </tr>
    <tr>
      <td>\( e \)</td>
      <td>e</td>
      <td>e</td>
    </tr>
    <tr>
      <td>\( \sin(x) \)</td>
      <td>sin(x)</td>
      <td>(sin x)</td>
    </tr>
    <tr>
      <td>\( \cos(x) \)</td>
      <td>cos(x)</td>
      <td>(cos x)</td>
    </tr>
    <tr>
      <td>\( \tan(x) \)</td>
      <td>tan(x)</td>
      <td>(tan x)</td>
    </tr>
  </table>
  <p>In the expressions above \( x \) can be replaced by any other expression. 
  For example, entering </p>
  <p class="formula">(e^tan(x))/(1 - x^2)</p>
  <p>yields the function</p>
  <p>$$\frac{e^{tan(x)}}{1 - x^2}$$</p>
  <p>This software is still work in progress and may give incorrect and 
  suboptimal results in some cases. In case you have any problems, questions 
  or suggestions, please contact <a class="base" 
  href="mailto:johannes@johannes.tax">johannes@johannes.tax</a>.</p>
</div>
EOF
)

(define template-about #<<EOF
<div class="textflow">
  <h2>About</h2>
  <p>Diophantus is a CGI executable written in <a class="base" 
  href="https://www.racket-lang.org">Racket</a>. It serves as a web frontend 
  for the racket-symalg library.</p>
  <p>racket-symalg is a Racket library which I developed as a pet project of 
  mine. It allows one to express and manipulate algebraic expressions in 
  Racket.</p>
  <p>Diophantus makes use of:
    <ul>
      <li><a class="base" href="https://www.mathjax.org">MathJax</a> to display 
      formulas,</li>
      <li><a class="base" href="https://mauriciopoppe.github.io/function-plot">
      function-plot</a> to plot functions of one variable and</li>
      <li>the <a class="base" href="https://github.com/google/roboto">Roboto</a> 
      font.</li>
    </ul>
  </p>
  <p>All source code can be found on github:
    <ul>
      <li><a class="base" href="https://github.com/pyohannes/racket-symalg">
      racket-symalg</a></li>
      <li><a class="base" href="https://github.com/pyohannes/diophantus">
      diophantus</a></li>
    </ul>
  </p>
  <p>You can contact the author at <a class="base" 
  href="mailto:johannes@johannes.tax">johannes@johannes.tax</a>.</p>
</div>
EOF
)
