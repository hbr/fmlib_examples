# Simple Web Applications

- [A counter, which can be incremented and decremented (the *hello world* of web
  applications)](https://hbr.github.io/fmlib_examples/web/counter.html)

- [An input field with text reversal](https://hbr.github.io/fmlib_examples/web/text_reverse.html)

- [A simple todo list](https://hbr.github.io/fmlib_examples/web/simple_todo.html)

Each web application has a `<name>.ml` source file and a `<name>.html` file.
Just type

    dune build ./<name>.js

to compile the web application and then point your browser to `<name>.html` to
see the application in action.
