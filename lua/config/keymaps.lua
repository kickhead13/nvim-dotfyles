-- Custom keymaps
local keymaps = {}

function keymaps.setup()
  -- wget keybind
  vim.keymap.set('n', '<leader>zl', function()
    vim.ui.input({
      prompt = "Enter Zuul ORG to wget: ",
      default = "",
    }, function(org)
      if not org or org == "" then return end
      
      local output = vim.fn.system("wget -qO- https://zuul-" .. vim.fn.shellescape(org) .. "-server.dyn.nesc.nokia.net/zuul_log/layout.yaml")
      
      if vim.v.shell_error == 0 then
        vim.cmd("enew")
        local lines = vim.split(output, "\n")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        vim.bo.filetype = "yaml"
        vim.notify("Downloaded: " .. org)
      else
        vim.notify("Download failed", vim.log.levels.ERROR)
      end
    end)
  end, { desc = "Download layout from specific org." })

  vim.keymap.set('n', '<leader>zs', function()
    vim.ui.input({
      prompt = "Enter Zuul ORG to wget: ",
      default = "",
    }, function(org)
      if not org or org == "" then return end
      
      local output = vim.fn.system("wget -qO- https://zuul-" .. vim.fn.shellescape(org) .. "-server.dyn.nesc.nokia.net/status.json | jq .")
      
      if vim.v.shell_error == 0 then
        vim.cmd("enew")
        local lines = vim.split(output, "\n")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        vim.bo.filetype = "json"
        vim.notify("Downloaded: " .. org)
      else
        vim.notify("Download failed", vim.log.levels.ERROR)
      end
    end)
  end, { desc = "Download status.json from specific org." })

  vim.keymap.set('n', '<leader>zkp', function()
    vim.ui.input({
      prompt = "Enter Zuul ORG get pods: ",
      default = "",
    }, function(org)
      if not org or org == "" then return end
      local output = vim.fn.system("sk ~/dev/k8s-deployment/kube/" .. vim.fn.shellescape(org) .. "-config")
      -- vim.cmd(":Kubectl view pods<CR>")
    end)
  end, { desc = "Set specific ORG config file." })

end

return keymaps

