local file = io.open("handwrite.lua")
local newfile = io.open("OldZhuang.lua","w")
local width = 55
local output = ""
for l in file:lines() do 
	if l:find("%-%-") then
		print("find title")
		newfile:write(output .."\n")
		output = ""  
		newfile:write(l)
	else
		if l:find("%s+") then
			newfile:write(output)
			output = ""
			l = "\n"..utf8.char(12288,12288).. l:match("%S+")
		end
		output = output .. l 
		while utf8.len(output)>= width do 
			local endpos = utf8.offset(output,width+1)-1
			local able_out = output:sub(1,endpos)
			newfile:write(able_out .. "\n")
			output = output:sub(endpos+1)
		end
	end
end