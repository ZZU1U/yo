---@diagnostic disable: undefined-global

return {
	-- math modes
	s({ trig = "mt", snippetType = "autosnippet" },
		fmta("$<>$ ", { i(1) })
	),
	s({ trig = "mmt", snippetType = "autosnippet" },
		fmta("$ <> $ ", { i(1) })
	),
	s({ trig = "([^%s]+)t", regTrig = true },
		fmta("(<>)^(<>) ", {
			f(function(_, s) return s.captures[1] end),
			i(1)
		})
	),
}
