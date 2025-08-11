return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		-- This should be executed before you configure any language server
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- This is where you enable features that only work
		-- if there is a language server active in the file
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end,
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								telemetry = {
									enable = false,
								},
							},
						},
						on_init = function(client)
							local join = vim.fs.joinpath
							local path = client.workspace_folders[1].name

							-- Don't do anything if there is project local config
							if
								vim.uv.fs_stat(join(path, ".luarc.json"))
								or vim.uv.fs_stat(join(path, ".luarc.jsonc"))
							then
								return
							end

							local nvim_settings = {
								runtime = {
									-- Tell the language server which version of Lua you're using
									version = "LuaJIT",
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
									library = {
										-- Make the server aware of Neovim runtime files
										vim.env.VIMRUNTIME,
										vim.fn.stdpath("config"),
									},
								},
							}

							client.config.settings.Lua =
								vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
						end,
					})
				end,
			},
		})

		---
		-- Autocompletion config
		---
		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if not entry then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						end
						cmp.confirm()
					else
						fallback()
					end
				end, { "i", "s", "c" }),
			}),
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
		})
	end,
}
