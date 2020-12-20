(fn map [t f]
  (let [out {}]
    (each [i v (ipairs t)]
      (tset out i (f v))) out))

(fn filter [t f]
  (let [out {}]
    (each [_ v (ipairs t)]
      (when (f v)
        (table.insert out v))) out))

{:map map :filter filter}
