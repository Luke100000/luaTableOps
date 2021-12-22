local dict = { }

function dict:count()
	local c = 0
	for _,_ in self.iter(self) do
		c = c + 1
	end
	return c
end

function dict:filter(lambda)
	local l = self.getLambda(lambda)
	local c = self()
	for i,v in self.iter(self) do
		if l(v) then
			c[i] = v
		end
	end
	return c
end

function dict:map(lambda)
	local l = self.getLambda(lambda)
	local c = self()
	for i,v in self.iter(self) do
		c[i] = l(v)
	end
	return c
end

function dict:keys()
	local c = self.array()
	for i,_ in pairs(self) do
		table.insert(c, i)
	end
	return c
end

function dict:values()
	local c = self.array()
	for _,v in pairs(self) do
		table.insert(c, v)
	end
	return c
end

function dict:keyValues()
	local c = self.array()
	for i,v in pairs(self) do
		table.insert(c, {i, v})
	end
	return c
end

return dict