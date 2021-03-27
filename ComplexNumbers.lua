local complex = {}
function complex.new(re, im) -- complex.new(float real, float imaginary) (real+imaginary*i)
	local tab = newproxy(true)
	local meta = getmetatable(tab)
	if type(re) ~= "number" then
		if type(re) == "userdata" and re["GetReal"] then
			meta.re = re:GetReal()
		else
			error("invalid argument #1 to 'new' (number expected, got "..type(re)..")")
		end
	else
		meta.re = re
	end
	if type(im) ~= "number" then
		if type(im) == "userdata" and im["GetReal"] then
			meta.im = im:GetImaginary()
		else
			error("invalid argument #2 to 'new' (number expected, got "..type(im)..")")
		end
	else
		meta.im = im
	end
	function meta.strupdate()
		if meta.im >= 0 then
			meta.str = tostring(meta.re.."+"..math.abs(meta.im).."i")
		else
			meta.str = tostring(meta.re..meta.im.."i")
		end
		return meta.str
	end
	meta.strupdate()
	meta.__metatable = "The metatable is locked"
	function meta.__len()
		error("attempt to get length of a complex number value")
	end
	local meta2 = {}
	function meta2.__index(t, i)
		error("attempt to index complex number with '"..tostring(i).."'")
	end
	local complexfunctions = {}
	function complexfunctions:GetReal()
		return meta.re
	end
	function complexfunctions:GetImaginary()
		return meta.im
	end
	meta.__index = setmetatable(complexfunctions, meta2)
	function meta.__newindex(t, i)
		return meta2.__index(t, i)
	end
	function meta.__tostring()
		return meta.str
	end
	-- Operators
	function meta.__unm()
		meta.re = -meta.re
		meta.im = -meta.im
		meta.strupdate()
		return tab
	end
	function meta.__add(l, r)
		if type(l) == "userdata" and l["GetReal"] and l["GetImaginary"] then
			-- l is complex
			if type(r) == "userdata" and r["GetReal"] and r["GetImaginary"] then
				-- both are complex
				local real = l:GetReal()+r:GetReal()
				local imaginary = l:GetImaginary()+r:GetImaginary()
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			else
				-- l is complex, r is not complex
				local real = l:GetReal()+r
				local imaginary = l:GetImaginary()
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			end
		else
			-- l is not complex, r must be complex
			local real = r:GetReal()+l
			local imaginary = r:GetImaginary()
			meta.re = real
			meta.im = imaginary
			meta.strupdate()
			return tab
		end
	end
	function meta.__sub(l, r)
		if type(l) == "userdata" and l["GetReal"] and l["GetImaginary"] then
			-- l is complex
			if type(r) == "userdata" and r["GetReal"] and r["GetImaginary"] then
				-- both are complex
				local real = l:GetReal()-r:GetReal()
				local imaginary = l:GetImaginary()-r:GetImaginary()
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			else
				-- l is complex, r is not complex
				local real = l:GetReal()-r
				local imaginary = l:GetImaginary()
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			end
		else
			-- l is not complex, r must be complex
			local real = r:GetReal()-l
			local imaginary = r:GetImaginary()
			meta.re = real
			meta.im = imaginary
			meta.strupdate()
			return tab
		end
	end
	function meta.__mul(l, r)
		if type(l) == "userdata" and l["GetReal"] and l["GetImaginary"] then
			-- l is complex
			if type(r) == "userdata" and r["GetReal"] and r["GetImaginary"] then
				-- both are complex
				local real1 = l:GetReal()*r:GetReal()
				local real2 = l:GetImaginary()*r:GetImaginary()*-1
				local imaginary1 = l:GetReal()*r:GetImaginary()
				local imaginary2 = l:GetImaginary()*r:GetReal()
				local real = real1+real2
				local imaginary = imaginary1+imaginary2
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			else
				-- l is complex, r is not complex
				local real = l:GetReal()*r
				local imaginary = l:GetImaginary()*r
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			end
		else
			-- l is not complex, r must be complex
			local real = l*r:GetReal()
			local imaginary = l*r:GetImaginary()
			meta.re = real
			meta.im = imaginary
			meta.strupdate()
			return tab
		end
	end
	function meta.__div(l, r)
		if type(l) == "userdata" and l["GetReal"] and l["GetImaginary"] then
			-- l is complex
			if type(r) == "userdata" and r["GetReal"] and r["GetImaginary"] then
				-- both are complex
				local l1r1 = l:GetReal()*r:GetReal()
				local l2r2 = l:GetImaginary()*r:GetImaginary()
				local r1_2 = r:GetReal()*r:GetReal()
				local r2_2 = r:GetImaginary()*r:GetImaginary()
				local l2r1 = l:GetImaginary()*r:GetReal()
				local l1r2 = l:GetReal()*r:GetImaginary()
				local real = (l1r1+l2r2)/(r1_2+r2_2)
				local imaginary = (l2r1-l1r2)/(r1_2+r2_2)
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			else
				-- l is complex, r is not complex
				local real = l:GetReal()/r
				local imaginary = l:GetImaginary()/r
				meta.re = real
				meta.im = imaginary
				meta.strupdate()
				return tab
			end
		else
			-- l is not complex, r must be complex
			local r1 = r:GetReal()
			local r2 = r:GetImaginary()
			local r1_2 = r:GetReal()*r:GetReal()
			local r2_2 = r:GetImaginary()*r:GetImaginary()
			local real = l*(r1/(r1_2+r2_2))
			local imaginary = l*(r2/(r1_2+r2_2))*-1
			meta.re = real
			meta.im = imaginary
			meta.strupdate()
			return tab
		end
	end
	return tab
end
return complex