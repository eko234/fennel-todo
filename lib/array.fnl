(local js (require :js))

(fn Array [t]
  (let [a (js.new js.global.Array)]
    (each [_ v (ipairs t)]
      (a:push v)) a))
