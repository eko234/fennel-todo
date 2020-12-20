;; https://github.com/ofunc/mithril/blob/master/init.lua
(local js (require :js))
(local m js.global.m)

(local mt {:__index (fn [_ key] (. m key))
           :__call (fn [_ ...] (m nil ...))})

(setmetatable {} mt)
