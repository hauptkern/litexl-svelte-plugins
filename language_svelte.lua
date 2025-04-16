-- mod-version:3
local syntax = require "core.syntax"

-- Get existing JavaScript/TypeScript and CSS syntaxes to reuse
local js_syntax = syntax.get("JavaScript")
local css_syntax = syntax.get("CSS")

syntax.add {
  name = "Svelte",
  files = { "%.svelte$" },
  comment = "<!--", -- HTML-style comments

  patterns = {
    -- Script and style tags
    {
      pattern = { "<script[^>]*>", "</script>" },
      type = "keyword",
      syntax = ".js"
    },
    {
      pattern = { "<style[^>]*>", "</style>" },
      type = "keyword",
      syntax = ".css"
    },

    -- HTML comments
    { pattern = { "<!--", "-->" }, type = "comment" },

    -- Svelte control flow - prioritized before generic patterns
    { pattern = "{#if%s.-}",        type = "keyword" },
    { pattern = "{:else if%s.-}",   type = "keyword2" },
    { pattern = "{:else}",          type = "keyword2" },
    { pattern = "{/if}",            type = "keyword" },
    { pattern = "{#each%s.-}",      type = "keyword" },
    { pattern = "{/each}",          type = "keyword" },
    { pattern = "{#await%s.-}",     type = "keyword" },
    { pattern = "{:then%s.-}",      type = "keyword2" },
    { pattern = "{:catch%s.-}",     type = "keyword2" },
    { pattern = "{/await}",         type = "keyword" },

    -- Remaining generic Svelte directives
    { pattern = "{#.-}", type = "keyword" },
    { pattern = "{/.-}", type = "keyword" },
    { pattern = "{:.-}", type = "keyword" },
    { pattern = "{%.-%}", type = "operator" },

    -- Strings
    { pattern = { '"', '"', '\\' }, type = "string" },
    { pattern = { "'", "'", '\\' }, type = "string" },
    { pattern = { "`", "`", '\\' }, type = "string" },

    -- HTML attributes with event handlers and bindings
    { pattern = "on:[%a_][%w_%-]*", type = "function" },
    { pattern = "bind:[%a_][%w_%-]*", type = "keyword2" },
    { pattern = "use:[%a_][%w_%-]*", type = "keyword2" },
    { pattern = "transition:[%a_][%w_%-]*", type = "keyword2" },
    { pattern = "animate:[%a_][%w_%-]*", type = "keyword2" },
    { pattern = "class:[%a_][%w_%-]*", type = "keyword2" },

    -- HTML tag attributes
    { pattern = "[%a_:][%w_:%-]*=", type = "keyword2" },

    -- HTML tags
    { pattern = "<%w+", type = "keyword" },
    { pattern = "</%w+>", type = "keyword" },
    { pattern = "/>", type = "keyword" },
    { pattern = ">", type = "keyword" },

    -- Numbers
    { pattern = "0x[%da-fA-F]+", type = "number" },
    { pattern = "-?%d+[%d%.eE]*", type = "number" },
    { pattern = "-?%.?%d+", type = "number" },

    -- Operators
    { pattern = "%s[%+%-=/%*%^%%<>!~|&]%s", type = "operator" },

    -- Function calls
    { pattern = "[%a_][%w_]*%f[(]", type = "function" },

    -- Variables/Identifiers
    { pattern = "[%a_][%w_]*", type = "normal" },
  },

  symbols = {
    -- Svelte blocks
    ["#if"] = "keyword",
    ["#each"] = "keyword",
    ["#await"] = "keyword",
    ["/if"] = "keyword",
    ["/each"] = "keyword",
    ["/await"] = "keyword",
    [":else"] = "keyword2",
    [":then"] = "keyword2",
    [":catch"] = "keyword2",

    -- HTML tags
    ["div"] = "function",
    ["span"] = "function",
    ["p"] = "function",
    ["main"] = "function",
    ["header"] = "function",
    ["footer"] = "function",
    ["nav"] = "function",
    ["section"] = "function",
    ["article"] = "function",
    ["aside"] = "function",
    ["h1"] = "function",
    ["h2"] = "function",
    ["h3"] = "function",
    ["h4"] = "function",
    ["h5"] = "function",
    ["h6"] = "function",
    ["ul"] = "function",
    ["ol"] = "function",
    ["li"] = "function",
    ["a"] = "function",
    ["button"] = "function",
    ["input"] = "function",
    ["form"] = "function",
    ["img"] = "function",
    ["table"] = "function",
    ["tr"] = "function",
    ["td"] = "function",
    ["th"] = "function",
    ["pre"] = "function",
    ["code"] = "function",

    -- JS literals
    ["true"] = "literal",
    ["false"] = "literal",
    ["null"] = "literal",
    ["undefined"] = "literal",

    -- JavaScript keywords
    ["async"] = "keyword",
    ["await"] = "keyword",
    ["break"] = "keyword",
    ["case"] = "keyword",
    ["catch"] = "keyword",
    ["class"] = "keyword",
    ["const"] = "keyword",
    ["continue"] = "keyword",
    ["debugger"] = "keyword",
    ["default"] = "keyword",
    ["delete"] = "keyword",
    ["do"] = "keyword",
    ["else"] = "keyword",
    ["export"] = "keyword",
    ["extends"] = "keyword",
    ["finally"] = "keyword",
    ["for"] = "keyword",
    ["function"] = "keyword",
    ["if"] = "keyword",
    ["import"] = "keyword",
    ["in"] = "keyword",
    ["instanceof"] = "keyword",
    ["let"] = "keyword",
    ["new"] = "keyword",
    ["return"] = "keyword",
    ["static"] = "keyword",
    ["super"] = "keyword",
    ["switch"] = "keyword",
    ["throw"] = "keyword",
    ["try"] = "keyword",
    ["typeof"] = "keyword",
    ["var"] = "keyword",
    ["void"] = "keyword",
    ["while"] = "keyword",
    ["with"] = "keyword",
    ["yield"] = "keyword",

    -- Common Svelte imports
    ["onMount"] = "function",
    ["onDestroy"] = "function",
    ["beforeUpdate"] = "function",
    ["afterUpdate"] = "function",
    ["createEventDispatcher"] = "function",
    ["tick"] = "function",
    ["setContext"] = "function",
    ["getContext"] = "function",

    -- TypeScript
    ["as"] = "keyword",
    ["implements"] = "keyword",
    ["interface"] = "keyword",
    ["namespace"] = "keyword",
    ["type"] = "keyword",
    ["public"] = "keyword",
    ["private"] = "keyword",
    ["protected"] = "keyword",
    ["readonly"] = "keyword",
  }
}

