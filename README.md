# SupportEmacs
Support for editing TorXakis models on Emacs. Currently, this mode offers only
syntax highlighting.

![Screenshot of torxakis mode](https://files.gitter.im/TorXakis/Lobby/FKOI/torxakis-mode.png)

This package is not yet published to MELPA, so to use it make sure you copy
`torxakis-mode.el` to your `elisp` folder, and edit your `.init.el` file as
follows:

``` elisp
;; Make sure to add your elisp folder to the `load-path`, for instance:
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'torxakis-mode)
```
