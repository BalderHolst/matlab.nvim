Open a matlab instance in the background, and send it commands from Neovim.

# Setup
Install using your favorite package manager.

#### Packer
```lua
use 'BalderHolst/matlab.nvim'
```
Make sure to have Matlab installed.

## Configuration
If the `matlab` executable is in your `$PATH`, the plugin should already work, but you can configure the plugin with the `setup` function.

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

```lua
-- Evaluate a string as a matlab command.
require("matlab").evaluate("<matlab cmd>")
```

```lua
-- Evaluate a table of strings as matlab commands.
require("matlab").evaluate_lines(lines)
```

```lua
-- Evaluate a matlab script file.
require("matlab").evaluate_file(path)
```

```lua
-- Evaluate currently opened matlab script.
require("matlab").evaluate_current_file()
```

```lua
-- Evaluate the block under the cursor. Matlab blocks are separated by comments beginning with `%%`.
require("matlab").evaluate_block()
```

```lua
-- Evaluate currently highlighted text.
require("matlab").visual_evaluate()
```

```lua
-- Close window and end matlab process.
require("matlab").close()
```

# TODO:
- [x] Block evaluation
- [ ] Configuration
    - [ ] matlab window
    - [x] matlab command
    - [x] matlab flags
- [ ] Matlab output inserted as comments under command

