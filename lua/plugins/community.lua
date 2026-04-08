return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },  -- TokyoNight
  -- You can add multiple themes and switch between them later
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },  -- Live preview
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },  -- Better rendering
  { import = "astrocommunity.pack.rust" },  -- Better rendering
  { import = "astrocommunity.pack.bash" },  -- Better rendering
  { import = "astrocommunity.pack.go" },  -- Better rendering
    -- Then configure lazydocker to load on startup
  
  -- { import = "astrocommunity.markdown-and-latex.nvim-table-md" },        -- Table formatting
  { import = "astrocommunity.media.img-clip-nvim" },                     -- Paste images
}
