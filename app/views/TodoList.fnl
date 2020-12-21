(local js (require :js))
(local console js.global.console)

(local m (require :lib.mithril))

(local Object (require :lib.object))
(local Array (require :lib.array))
(local utils (require :lib.utils))
(local map utils.map)
(local filter utils.filter)

(local Todo (require :app.models.Todo))

(local Container (require :app.components.Container))
(local Grid (require :app.components.Grid))
(local Cell (require :app.components.Cell))

(Object {:view (fn [_ vnode]
                 (m Container
                    (m "h1" "Todo App")
                    (m Grid
                       (m Cell
                          (m "h2" "Todo")
                          (m ".menu"
                             (Array (map (filter Todo.list #(= (. $1 :done) false))
                                         #(m "a.menu-item"
                                             (Object {:style "width: 90%;"
                                                      :onclick (fn [] (Todo:check (. $1 :id)))})
                                             (. $1 :task) (m ".pull-right" "+")))))
                       (m Cell
                          (Object {:class "-bottom"})
                          (m "h3" "Done")
                          (m ".menu"
                             (Array (map (filter Todo.list #(= (. $1 :done) true))
                                         #(m "a.menu-item"
                                             (Object {:style "width: 90%;"
                                                      :onclick (fn [] (Todo:check (. $1 :id)))})
                                             (. $1 :task) (m ".pull-right" "-")))))))
                     (m Cell
                        (m "h2" "Add a task")
                        (m "form.form"
                           (Object {:onsubmit (fn [_ e]
                                                (e:preventDefault)
                                                (Todo:submit)
                                                (tset Todo :current ""))})
                           (m "fieldset.form-group"
                              (m "input[type=text][placeholder=Add todo...].form-control"
                                 (Object {:value Todo.current
                                          :oninput (fn [_ e]
                                                     (tset Todo :current e.target.value))})))
                         (m ".form-actions"
                            (m "button[type=submit].btn.btn-primary.btn-block"
                               "Add")))))
                         (m "footer"
                            (Object {:style "
                                    border-top: 1px solid #ccc;
                                    margin-top: 80px;
                                    margin-top: 5rem;
                                    padding: 48px 0;
                                    padding: 3rem 0;
                                    "})
                            "Made with <3 by "
                            (m "a"
                               (Object {:href "https://github.com/mrtnpwn"})
                               "mrtnpwn")
                            ".")))})
