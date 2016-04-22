local H = require('test.functional.helpers')
local session, source, eq, vim = H.clear, H.source, H.eq, H.meths

local function ok(commands)
	source(commands)
	return eq( {}, vim.get_vvar('errors') )
end

describe('cscope', function()
  session()
  it('cscoperelative', function()
	ok([[
		:function Eq(expected, actual)
		:call assert_true( exists("a:actual") && a:expected == a:actual )
		:endfunction

		:echo "Rebuild cscope file"
		:!rm cscope.out
		:!cscope -bR

		:echo "Change session to a subdirectory not containing source nor cscope files"
		:!rmdir y
		:!mkdir y
		:cd y

		:echo "Connect to cscope file w/o prepend path"
		:cscope add ../cscope.out
		:cscope show

		:echo "Try to find local and external symbols"
		:cstag x " not found
		:echo v:exception
		:cstag getcwd " found
		:echo v:exception

		:echo "Set relative path option and try again"
		:set cscoperelative
		:cstag x " found
		:echo v:exception
		:cstag getcwd " not found
		:echo v:exception

		:echo "Reconnect to cscope file with prepend path and try again"
		:cscope kill -1
		:cscope add ../cscope.out /var/tmp/bugs/cscope_bug
		:cscope show
		:cstag x " found
		:echo v:exception
		:cstag getcwd " found
		:echo v:exception
	]])
  end)
end)
