(local js (require :js))
(local window js.global)
(local document window.document)

(local m (require :lib.mithril))
(local TodoList (require :app.views.TodoList))

(local root (document:getElementById "app"))

(m:mount root TodoList)
