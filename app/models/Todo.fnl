(local nanoid (require :lib.nanoid.non_secure))
(local utils (require :lib.utils))

(local map utils.map)
(local trim utils.trim)

{:current ""
 :list [{:id (nanoid) :task "Do something more productive" :done false}]
 :submit (fn [self]
           (if (~= "" (trim self.current))
             (table.insert self.list {:id (nanoid)
                                      :task self.current
                                      :done false})))
 :check (fn [self id]
          (tset self
                :list
                (map self.list
                     #(if (= (. $1 :id) id)
                        (do
                          (let [a $1] (tset a :done (not a.done)) a)) $1))))}
