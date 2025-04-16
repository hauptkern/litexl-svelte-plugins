-- mod-version:3
local core = require "core"
local config = require "core.config"
local common = require "core.common"
local style = require "core.style"
local command = require "core.command"
local keymap = require "core.keymap"

-- Check if lsp plugin is available
local lsp_available, lsp = pcall(require, "plugins.lsp")
if not lsp_available then
  error("LSP plugin is required but not available. Please install it first.")
end

-- Configuration
config.plugins.svelte_lsp = common.merge({
  -- LSP config for svelte-language-server
  config = {
    -- The command that starts the language server
    -- We're assuming it's globally installed
    command = { "svelte-language-server", "--stdio" },
    
    -- Root directory patterns to recognize Svelte projects
    root_dir = { "package.json", "svelte.config.js", "svelte.config.cjs" },
    
    -- Settings that will be passed to the language server
    settings = {
      svelte = {
        plugin = {
          -- You can add Svelte plugin specific settings here
          html = { completions = { enable = true, emmet = true } },
          css = { completions = { enable = true, emmet = true } },
          typescript = { diagnostics = { enable = true } },
        },
        -- Validation settings
        format = {
          enable = true,
        },
      },
    },
    
    -- Default initialization options
    init_options = {
      configuration = {
        typescript = {
          serverPath = "", -- Set this if you have a specific TypeScript server path
        },
      },
    },
    
    -- File patterns that this server should handle
    file_patterns = { "%.svelte$" },
  }
}, config.plugins.svelte_lsp)

-- Register Svelte with LSP
local function setup_svelte_lsp()
  if lsp_available then
    -- Register the server
    lsp.add_server({
      name = "svelte-language-server",
      language = "svelte",
      file_patterns = config.plugins.svelte_lsp.config.file_patterns,
      command = config.plugins.svelte_lsp.config.command,
      root_dir = config.plugins.svelte_lsp.config.root_dir,
      settings = config.plugins.svelte_lsp.config.settings,
      init_options = config.plugins.svelte_lsp.config.init_options,
      verbose = false, -- Set to true for debugging
    })
  end
end

-- Commands
command.add(nil, {
  ["svelte-lsp:restart-server"] = function()
    if lsp_available then
      core.log("Restarting Svelte language server...")
      local doc = core.active_view.doc
      if doc and common.match_pattern(doc.filename or "", "%.svelte$") then
        lsp.stop_server("svelte-language-server")
        setup_svelte_lsp()
        lsp.start_server("svelte-language-server")
      end
    end
  end,
})

-- Key bindings
keymap.add {
  ["ctrl+shift+s"] = "svelte-lsp:restart-server",
}

-- Set up server integration on plugin init
setup_svelte_lsp()

-- Command for checking Svelte LSP status
command.add(nil, {
  ["svelte-lsp:check-status"] = function()
    local server = lsp.get_server("svelte-language-server")
    if server then
      if server.proc then
        core.log("Svelte language server is running")
      else
        core.log("Svelte language server is not running")
      end
    else
      core.log("Svelte language server is not registered")
    end
  end,
})

-- Log when the plugin is loaded
core.log("Svelte LSP plugin loaded")
