return {
  {
    "cormacrelf/dark-notify",
    name = "dark-notify",
    lazy = false,
    config = function()
      -- NOTE: The module uses an underscore "_", not a dash "-"
      require("dark_notify").run({
        schemes = {
          dark = { colorscheme = "github_dark_high_contrast" },
          light = { colorscheme = "github_light_high_contrast" },
        },
      })
    end,
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
}
