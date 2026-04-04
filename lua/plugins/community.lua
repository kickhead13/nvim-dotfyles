return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },  -- TokyoNight
  -- You can add multiple themes and switch between them later
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },  -- Live preview
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },  -- Better rendering
  { import = "astrocommunity.docker.lazydocker" },  -- Better rendering
  { import = "astrocommunity.pack.rust" },  -- Better rendering
  { import = "astrocommunity.pack.bash" },  -- Better rendering
    -- Then configure lazydocker to load on startup
  {
    "mikesmithgh/lazydocker.nvim",
    lazy = false,  -- This makes it load on startup instead of lazily
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("lazydocker").setup({
        -- Optional: Auto-start lazydocker when Neovim opens in a Docker context
        -- This will check if you're in a directory with docker-compose.yml or Dockerfile
        auto_start = true,  -- This will make it load automatically
        
        -- Or you can set a keybinding to open it quickly
        keys = {
          { "<leader>ld", "<cmd>LazyDocker<CR>", desc = "Open LazyDocker" },
        },
      })
    end,
  },
  -- { import = "astrocommunity.markdown-and-latex.nvim-table-md" },        -- Table formatting
  { import = "astrocommunity.media.img-clip-nvim" },                     -- Paste images
}
