local H = require('test.functional.helpers')
local session, source, eq, vim = H.clear, H.source, H.eq, H.meths

local function ok(commands)
	source(commands)
	return eq( {}, vim.get_vvar('errors') )
end

describe('curly-braces names', function()
  session()
  it('curly-braced name', function()
	ok([[
		:function Eq(expected, actual)
		:call assert_true( exists("a:actual") && a:expected == a:actual )
		:endfunction

		:let aa = 'a'
		:let gg = 'g'
		:let  a = 1
		:let  g = 2
		:let ga = 3

		:let x = {aa}
		:call Eq(a, x)
		:let x = {gg}
		:call Eq(g, x)
		:let x = {gg}{aa}
		:call Eq(ga, x)
		:let x = {a{aa}}
		:call Eq(a, x)

		:let x = g:{aa}
		:call Eq(a, x)
		:let x = {gg}:aa
		:call Eq(aa, x)
		:let x = {gg}:{aa}
		:call Eq(a, x)
	]])
  end)
end)
