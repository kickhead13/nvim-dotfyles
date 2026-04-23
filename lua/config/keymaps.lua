-- Custom keymaps
local keymaps = {}

function keymaps.setup()
  -- wget keybind
  --
  vim.keymap.set('n', '<leader>sta', function()
    vim.ui.input({
      prompt = "TopicLabels: ",
      default = "",
    }, function(topic)
      if not topic or topic == "" then return end
      
      vim.ui.input({
        prompt = "Task: ",
        default = "",
      }, function(task)
        if not task or task == "" then return end
        vim.fn.system("st add -T " .. vim.fn.shellescape(topic))
        vim.fn.system("st add -T " .. vim.fn.shellescape(topic) .. " -a " .. vim.fn.shellescape(task))
        if not vim.v.shell_error == 0 then
          vim.notify("st failed", vim.log.levels.ERROR)
        end
        local base = ".st/topics/" .. topic .. "/" .. task .. "/"
        local files = {
          "DESC.md",
          "SHORT_DESC.md",
          "LABELS",
          "NOTES.md"
        }

        -- Open the first file in the current window
        vim.cmd("edit " .. base .. files[1])
        -- Open the rest in vertical splits
        for i = 2, #files do
          vim.cmd("vsplit " .. base .. files[i])
        end
      end)
    end)
  end, { desc = "Download layout from specific org." })

  vim.keymap.set('n', '<leader>stl', function()
    vim.ui.input({
      prompt = "Topic: ",
      default = "",
    }, function(topic)
      if not topic or topic == "" then return end
      
      vim.ui.input({
        prompt = "Labels: ",
        default = "",
      }, function(labels)
        local output
        if not labels or labels == "" then 
          output = vim.fn.system("st list -T " .. vim.fn.shellescape(topic) .. " -Mvn")
        else
          output = vim.fn.system("st list -T " .. vim.fn.shellescape(topic) .. " -Mvnl'" .. vim.fn.shellescape(labels) .. "'")
        end
        if vim.v.shell_error == 0 then
          vim.cmd("enew")
          local lines = vim.split(output, "\n")
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          vim.bo.filetype = "markdown"
        else
          vim.notify("st failed", vim.log.levels.ERROR)
        end
      end)
    end)
  end, { desc = "Download layout from specific org." })

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

