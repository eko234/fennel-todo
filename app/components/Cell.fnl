(local m (require :lib.mithril))
(local Object (require :lib.object))

(Object {:view (fn [_ vnode]
                 (m ".cell" vnode.attrs vnode.children))})
