(local m (require :lib.mithril))
(local Object (require :lib.object))

(Object {:view (fn [_ vnode]
                 (m ".grid" vnode.children))})
