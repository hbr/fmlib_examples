# Examples using fmlib (functional monadic library)


`fmlib` is an ocaml library developed with the Alba compiler. In order to use
it, you should have an installation of `opam` (the ocaml package manager).

With opam, it is easy to install `fmlib`.

    opam install alba

or
    opam pin https://github.com/hbr/albatross/zipball/<branch>

The second command is needed, if you need some features of `fmlib` which are not
yet released to the opam repository. The branch `feature` is usually the most
recent branch.


`fmlib` is currently packaged with the alba compiler. If there is sufficient
usage of the library, it will be released as a standalone package.

This repository contains some examples to demonstrate the usage of the library.

- [Web applications](web)



# Contributions

Since `fmlib` is developed as part of the alba compiler, the main functionality
of the `fmlib` package is driven by the needs of the compiler. However `fmlib`
is designed to be a general purpose library. Pull requests which augment the
library with functions in the spirit of the main design are welcome.
