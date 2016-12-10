Pep8-vim
========

This is simple vim plugin, which provide command ``:Pep8`` which check for PEP8_
rules on python code in current buffer.

Unlike any other available *vim-pep8* plugins, it doesn't parse output of
``pep8`` command line tool, but relies on ``pep8`` module, therefore ``pep8``
has to be present in the system using system package manager or ``pip``.

Although usable, this plugin is kind of deprecated in favor of pluggable
validators like Syntastic_.

Installation
------------

To use this plugin either ``+python`` or ``+python3`` feature compiled in vim is
required. To check it, issue ``:version`` in vim instance and look for python
entries.

To install it, any kind of Vim package manager can be used, like NeoBundle_,
Pathogen_, Vundle_ or vim-plug_.

For manual installation, copy subdirectories from this repository to your
``~/.vim`` directory.

Now you'll have new command ``:Pep8`` which in case of any ``PEP8`` violation
will display quickfix window with appropriate errors.

License
-------

This work is licensed on 3-clause BSD license. See LICENSE file for details.

.. _Pathogen: https://github.com/tpope/vim-pathogen
.. _Vundle: https://github.com/gmarik/Vundle.vim
.. _NeoBundle: https://github.com/Shougo/neobundle.vim
.. _vim-plug: https://github.com/junegunn/vim-plug
.. _PEP8: https://www.python.org/dev/peps/pep-0008
.. _Syntastic: https://github.com/vim-syntastic/syntastic
