;; https://gist.github.com/daurnimator/5a7fa933e96e14333962093322e0ff95
(local js (require :js))

(fn Object [t]
  (let [o (js.new js.global.Object)]
    (each [k v (pairs t)]
      (assert
        (or
          (= (type k) "string")
          (= (js.typeof k) "symbol"))
          "JavaScript only has string and symbol keys")
      (tset o k v)) o))
