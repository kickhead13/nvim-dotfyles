return {
  {
    "ramilito/kubectl.nvim",
    -- use a release tag to download pre-built binaries
    version = "2.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'make build',
    -- OR if you use nix, build from source with:
    -- build = 'nix run .#build-plugin',
    dependencies = "saghen/blink.download",
    config = function()
      require("kubectl").setup()
      local set = vim.keymap.set
      set("n", "<leader>kp", ":Kubectl view pods<CR>", { desc = "Kubectl view pods." })
      set('n', '<leader>kDn', function()
        vim.ui.input({
          prompt = "Enter node to be debugged (something like 'worker-1' for example): ",
          default = "",
        }, function(input)
          if input and input ~= "" then
            vim.cmd(":Kubectl debug nodes/" .. input .. " -it --image=debian")
          end
        end)
      end, {desc = "Start a node debugger in current namespace."})
    end,
  },
}
