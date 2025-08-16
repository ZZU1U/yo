---@diagnostic disable: undefined-global

return {
    s({ trig="be([^%s]+)", regTrig=true },
        fmta("<>.begin(), <>.end()", {
			f(function(_, s) return s.captures[1] end),
			f(function(_, s) return s.captures[1] end),
		})
    )
}
