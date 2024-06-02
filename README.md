# Germinal

Check out `:help plugin` for more documentation. All the
stuff in the plugin folder gets executed before we get to
the neovim start screen. The second folder is called lua
and it does not automatically get executed but it is 
available to the user.

We will most likely not need anything to be executed
immediately but rather wait for the user to require
germinal and make notes.

## Features

Would be nice to make notes on code. In visual mode,
highlighting the text to quote and begin writing in 
a separate folder filled with notes.

It would be nice to immediately create a diary entry.

## Contributing

After making changes to the help doc, run `:helptags ALL`
so Neovim can generate help tags for you.
