Open a matlab instance in the background, and send it commands from Neovim.

# Setup
Install using your favorite package manager.

#### Packer
```lua
use 'BalderHolst/matlab.nvim'
```
Make sure to have Matlab installed.

## Configuration
You can now configure and enable the plugin by calling the `setup()` function.

This is the default configuration:
```lua
require("matlab").setup({

    -- Path to the matlab executable. If `matlab` is already in your $PATH, just leave this.
    matlab_path = "matlab",

    -- How to open the matlab window. There are 4 options for now:
        -- split
        -- splitdown
        -- vsplit
        -- vsplitright
    open_window = require("matlab.openers").vsplit,

    -- Display the matlab splash screen on startup
    splash = true,

    -- A list of any other flags you want to add, when launching matlab
    matlab_flags = {},

})
```


# Functions

Evaluate a string as a matlab command.
```vim
MatlabEval <expr>
```

```lua
require("matlab").evaluate("<matlab cmd>")
```

Evaluate currently opened matlab script.
```vim
MatlabEvalFile
```

```lua
require("matlab").evaluate_current_file()
```

Evaluate a matlab script file.
```lua
require("matlab").evaluate_file(path)
```

Evaluate the block under the cursor. Matlab blocks are separated by comments beginning with `%%`.
```vim
MatlabEvalBlock
```

```lua
require("matlab").evaluate_block()
```

Evaluate currently highlighted text.
```vim
MatlabEvalVisual
```

```lua
require("matlab").evaluate_visual()
```

Evaluate a table of strings as matlab commands.
```lua
require("matlab").evaluate_lines(lines)
```

Open documentation of the function under cursor.
```lua
require("matlab").open_documentation_at_cursor()
```

Open documentation of an arbitrary function.
```vim
MatlabDoc <matlab-function>
```

Close window and end matlab process.
```vim
MatlabClose
```

```lua
require("matlab").close()
```

Open the matlab "workspace" (variable explorer).
```vim
MatlabWorkspace
```

```lua
require("matlab").open_workspace()
```


# TODO:
- [ ] Matlab output inserted as comments under command

