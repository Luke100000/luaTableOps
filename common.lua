local common = { }

function common:copy()
	local c = self()
	for i,v in self.iter(self) do
		c[i] = v
	end
	return c
end

function common:allMatch(lambda)
	local l = self.getLambda(lambda)
	for _,v in self.iter(self) do
		if not l(v) then
			return false
		end
	end
	return true
end

function common:anyMatch(lambda)
	local l = self.getLambda(lambda)
	for _,v in self.iter(self) do
		if l(v) then
			return true
		end
	end
	return false
end

function common:noneMatch(lambda)
	return not self:anyMatch(lambda)
end

function common:findFirst(lambda)
	local l = self.getLambda(lambda)
	for _,v in self.iter(self) do
		if l(v) then
			return v
		end
	end
	return nil
end

function common:min(lambda)
	if lambda then
		if #self > 0 then
			local l = self.getLambda(lambda)
			local min = l(self[0])
			local value = self[0]
			for i = 2, #self do
				local v = self[i]
				local nv = l(v)
				if nv < min then
					value = v
					min = nv
				end
			end
			return value
		end
	else
		local c = math.huge
		for _,v in self.iter(self) do
			if v < c then
				c = v
			end
		end
		return c
	end
end

function common:max(lambda)
	if lambda then
		if #self > 0 then
			local l = self.getLambda(lambda)
			local max = l(self[0])
			local value = self[0]
			for i = 2, #self do
				local v = self[i]
				local nv = l(v)
				if nv > max then
					value = v
					max = nv
				end
			end
			return value
		end
	else
		local c = -math.huge
		for _,v in self.iter(self) do
			if v > c then
				c = v
			end
		end
		return c
	end
end

return common