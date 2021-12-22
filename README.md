# LuaTableOps
Stream-like table operations and lambda functions to simplify common tasks.
Lambdas are converted to Lua and cached when first used and therefore have no impact on performance.
All operations return a copy of the data, if not otherwise specified.
Unlike Lua, we differ between array and dictionaries, since they both have a different set of operations available.
Besides their additional functions, they still behave like ordinary tables.

## Usage
```lua
# load library
local array, dict, getLambda = unpack(require("luaTableOps"))

# ways to create arrays
local empty_array = array()
local use_array = array({1, 2, 3})
local create_array = array(1, 2, 3)

# ways to create dictionaries
local empty_dict = dict()
local use_dict = dict({key = value})

# ways to manually create functions from lambda expressions
local lambda = getLambda("x -> x * 2")
local value = lambda(2)

# apply functions
print(array(1, 2, 3):filter("x -> x >= 2"):map("x -> x * 2"))
print(array(1, 2, 3):filter("x >= 2"):map("x * 2"))
```

## Lambdas
Lambdas are defined as an arbitrary amount of args (including none) and an expression separated by `->`.
If `->` is missing, a single default arg `x` is assumed.
```lua
local valid_1 = "x -> x * 2"
local valid_2 = "a, b -> a + b"
local valid_3 = "-> 5"
local valid_4 = "x^2"

local invalid_1 = "123"
local invalid_2 = "x -> local c = x * 2 return c"
```

## Common functions
```lua
# flat copy
copy()

# returns the count of entries
count()

# filters according to lambda
filter(lambda)

# maps one value to another
map(lambda)

# true if all match
allMatch(lambda)

# true if at least one match
anyMatch(lambda)

# true of none match
noneMatch(lambda)

# returns the first matching value
findFirst(lambda)

# returns arithmetic minimum
min()

# returns minimum value according to given comparator
min(lambda)

# returns arithmetic maximum
max()

# returns maximum value according to given comparator
max(lambda)
```

## Array functions
```lua
# removes duplicates
distinct()

# returns the first n elements
limit(int)

# skips the first n elements, returns the rest
skip(int)

# sort using default arithmetic comparator
sorted(lambda)

# sort using given comparator
sorted(lambda)

# converts to a dictionary by swapping index and value
toDict()

# replaces every element with the elements from the array returned by the lambda
flatMap(lambda)
```

## Dict functions
```lua
# returns an array with all keys
keys()

# returns an array with all values
values()

# returns an array with {key, value} pairs
keyValues()
```
