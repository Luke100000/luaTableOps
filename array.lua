local array = { }

function array:count()
	return #self
end

function array:filter(lambda)
	local l = self.getLambda(lambda)
	local c = self()
	for _,v in self.iter(self) do
		if l(v) then
			table.insert(c, v)
		end
	end
	return c
end

function array:map(lambda)
	local l = self.getLambda(lambda)
	local c = self()
	for _,v in self.iter(self) do
		table.insert(c, l(v))
	end
	return c
end

function array:distinct()
	local c = self()
	local found = { }
	for _,v in self.iter(self) do
		if not found[v] then
			table.insert(c, v)
			found[v] = true
		end
	end
	return c
end

function array:limit(limit)
	local c = self()
	for i = 1, math.min(#self, limit) do
		table.insert(c, self[i])
	end
	return c
end

function array:skip(skip)
	local c = self()
	for i = skip + 1, #self do
		table.insert(c, self[i])
	end
	return c
end

function array:sorted(lambda)
	table.sort(self, self.getLambda(lambda))
	return self
end

function array:toDict()
	local c = self.dict()
	for i,v in self.iter(self) do
		c[v] = i
	end
	return c
end

function array:flatMap(lambda)
	local l = self.getLambda(lambda)
	local c = self()
	for _,v in self.iter(self) do
		for _, v2 in ipairs(l(v)) do
			table.insert(c, v2)
		end
	end
	return c
end

return array