-- MIT License
-- Copyright (c) 2020 Martín Aguilar

local url =
  'ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW'

local nanoid = {
  _VERSION = '1.0.0'
}

function nanoid.custom_alphabet(alphabet, size)
  return function()
    local id = ''

    for _ = 1, size do
      local i = math.floor(math.random(1, #alphabet))

      id = id .. string.sub(alphabet, i, i)
    end

    return id
  end
end

function nanoid.nanoid(size)
  local id = ''

  for _ = 1, size do
    local i = math.floor(math.random(1, #url))

    id = id .. string.sub(url, i, i)
  end

  return id
end

setmetatable(nanoid, {
  __call = function(_, size)
    return nanoid.nanoid(size and tonumber(size) or 21)
  end
})

return nanoid
