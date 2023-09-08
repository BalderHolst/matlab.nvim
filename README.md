Open a matlab instance in the background, and send it commands from Neovim.

# Setup
Install using your favorite package manager.

#### Packer
```lua
use 'BalderHolst/matlab.nvim'
```

Make sure to have matlab installed, and available in the PATH.

You must be able to run matlab by simply entering `matlab` into a terminal.


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
- [ ] Open matlab windows like workspace

