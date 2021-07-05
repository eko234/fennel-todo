package.preload["app.components.Cell"] = package.preload["app.components.Cell"] or function(...)
  local m = require("lib.mithril")
  local Object = require("lib.object")
  local function _0_(_, vnode)
    return m(".cell", vnode.attrs, vnode.children)
  end
  return Object({view = _0_})
end
package.preload["app.components.Grid"] = package.preload["app.components.Grid"] or function(...)
  local m = require("lib.mithril")
  local Object = require("lib.object")
  local function _0_(_, vnode)
    return m(".grid", vnode.children)
  end
  return Object({view = _0_})
end
package.preload["app.components.Container"] = package.preload["app.components.Container"] or function(...)
  local m = require("lib.mithril")
  local Object = require("lib.object")
  local function _0_(_, vnode)
    return m(".container", vnode.children)
  end
  return Object({view = _0_})
end
package.preload["lib.nanoid.non_secure"] = package.preload["lib.nanoid.non_secure"] or function(...)
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
end
package.preload["app.models.Todo"] = package.preload["app.models.Todo"] or function(...)
  local nanoid = require("lib.nanoid.non_secure")
  local utils = require("lib.utils")
  local map = utils.map
  local trim = utils.trim
  local function _0_(self, id)
    local function _1_(_241)
      if ((_241).id == id) then
        local a = _241
        a["done"] = not a.done
        return a
      else
        return _241
      end
    end
    self["list"] = map(self.list, _1_)
    return nil
  end
  local function _1_(self)
    if ("" ~= trim(self.current)) then
      return table.insert(self.list, {done = false, id = nanoid(), task = self.current})
    end
  end
  return {check = _0_, current = "", list = {{done = false, id = nanoid(), task = "Do something more productive"}}, submit = _1_}
end
package.preload["lib.utils"] = package.preload["lib.utils"] or function(...)
  local function map(t, f)
    local out = {}
    for i, v in ipairs(t) do
      out[i] = f(v)
    end
    return out
  end
  local function filter(t, f)
    local out = {}
    for _, v in ipairs(t) do
      if f(v) then
        table.insert(out, v)
      end
    end
    return out
  end
  local function trim(s)
    return ((s:match("^()%s*$") and "") or s:match("^%s*(.*%S)"))
  end
  return {filter = filter, map = map, trim = trim}
end
package.preload["lib.array"] = package.preload["lib.array"] or function(...)
  local js = require("js")
  local function Array(t)
    local a = js.new(js.global.Array)
    for _, v in ipairs(t) do
      a:push(v)
    end
    return a
  end
  return Array
end
package.preload["lib.object"] = package.preload["lib.object"] or function(...)
  local js = require("js")
  local function Object(t)
    local o = js.new(js.global.Object)
    for k, v in pairs(t) do
      assert(((type(k) == "string") or (js.typeof(k) == "symbol")), "JavaScript only has string and symbol keys")
      o[k] = v
    end
    return o
  end
  return Object
end
package.preload["app.views.TodoList"] = package.preload["app.views.TodoList"] or function(...)
  local js = require("js")
  local console = js.global.console
  local m = require("lib.mithril")
  local Object = require("lib.object")
  local Array = require("lib.array")
  local utils = require("lib.utils")
  local map = utils.map
  local filter = utils.filter
  local Todo = require("app.models.Todo")
  local Container = require("app.components.Container")
  local Grid = require("app.components.Grid")
  local Cell = require("app.components.Cell")
  local function _0_(_, vnode)
    local function _1_(_241)
      return ((_241).done == false)
    end
    local function _2_(_241)
      local function _3_()
        return Todo:check((_241).id)
      end
      return m("a.menu-item", Object({onclick = _3_, style = "width: 90%;"}), (_241).task, m(".pull-right", "+"))
    end
    local function _3_(_241)
      return ((_241).done == true)
    end
    local function _4_(_241)
      local function _5_()
        return Todo:check((_241).id)
      end
      return m("a.menu-item", Object({onclick = _5_, style = "width: 90%;"}), (_241).task, m(".pull-right", "-"))
    end
    local function _5_(_0, e)
      e:preventDefault()
      Todo:submit()
      Todo["current"] = ""
      return nil
    end
    local function _6_(_0, e)
      Todo["current"] = e.target.value
      return nil
    end
    return m(Container, m("h1", "Todo App"), m(Grid, m(Cell, m("h2", "Todo"), m(".menu", Array(map(filter(Todo.list, _1_), _2_))), m(Cell, Object({class = "-bottom"}), m("h3", "Done"), m(".menu", Array(map(filter(Todo.list, _3_), _4_))))), m(Cell, m("h2", "Add a task"), m("form.form", Object({onsubmit = _5_}), m("fieldset.form-group", m("input[type=text][placeholder=Add todo...].form-control", Object({oninput = _6_, value = Todo.current}))), m(".form-actions", m("button[type=submit].btn.btn-primary.btn-block", "Add"))))), m("footer", Object({style = "\n                                    border-top: 1px solid #ccc;\n                                    margin-top: 80px;\n                                    margin-top: 5rem;\n                                    padding: 48px 0;\n                                    padding: 3rem 0;\n                                    "}), "Made with <3 by ", m("a", Object({href = "https://github.com/mrtnpwn"}), "mrtnpwn"), "."))
  end
  return Object({view = _0_})
end
package.preload["lib.mithril"] = package.preload["lib.mithril"] or function(...)
  local js = require("js")
  local m = js.global.m
  local mt
  local function _0_(_, ...)
    return m(nil, ...)
  end
  local function _1_(_, key)
    return m[key]
  end
  mt = {__call = _0_, __index = _1_}
  return setmetatable({}, mt)
end
local js = require("js")
local window = js.global
local document = window.document
local m = require("lib.mithril")
local TodoList = require("app.views.TodoList")
local root = document:getElementById("app")
return m:mount(root, TodoList)
