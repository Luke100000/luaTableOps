local cache = { }
local function getLambda(lambda)
	if type(lambda) == "string" then
		if not cache[lambda] then
			local s = lambda:find("->")
			local ok, f = load(string.format("return function(%s) return %s end", lambda:sub(1, s - 1), lambda:sub(s + 2)))
			if ok then
				cache[lambda] = ok()
			else
				error(f)
			end
		end
		return cache[lambda]
	else
		return lambda
	end
end

local arrayMeta, dictMeta
local arrayConstructor, dictContstructor

local root = (...)
local common = require(root .. "/common")
local array = require(root .. "/array")
local dict = require(root .. "/dict")

--arrays and dicts share common functions
for i,v in pairs(common) do
	dict[i] = v
	array[i] = v
end

--metatable for arrays
arrayMeta = {
	__call = function(self, a, b, ...)
		return setmetatable(b and {a, b, ...} or a or { }, arrayMeta)
	end,
	__index = array,
	__tostring = function(self)
		return "[" .. table.concat(self:map("a -> tostring(a)"), ", ") .. "]"
	end,
}

--constructor for tables
arrayConstructor = function(a, b, ...)
	return setmetatable(b and {a, b, ...} or a or { }, arrayMeta)
end

--metatable for dictionaries
dictMeta = {
	__call = function(self, a)
		return setmetatable(a or { }, dictMeta)
	end,
	__index = dict,
	__tostring = function(self)
		return "{" .. table.concat(self:keyValues():map("a -> tostring(a[1]) .. ': ' .. tostring(a[2])"), ", ") .. "}"
	end,
}

--constructor for dictionaries
dictContstructor = function(a)
	return setmetatable(a or { }, dictMeta)
end

--additional fields
array.iter = ipairs
dict.iter = pairs

array.getLambda = getLambda
dict.getLambda = getLambda

array.dict = dictContstructor
dict.array = arrayConstructor

return {arrayConstructor, dictContstructor, getLambda}