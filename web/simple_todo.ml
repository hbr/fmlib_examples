open Fmlib


module Browser = Fmlib_js.Browser

module Appl = Web_application.Make (Browser)

module Vdom = Appl.Dom

module Attribute = Appl.Attribute




type entry = {
    id: int;
    description: string;
    completed: bool;
}


type show =
    | All
    | Active
    | Completed


type model = {
    task: string;
    entries: entry list;
    next_id: int;
    show: show;
}


type message =
    | No_operation
    | Update_task of string
    | Add
    | Delete of int
    | Check of int * bool
    | Show of show




let model: model =
    {
        task = "";
        entries = [];
        next_id = 0;
        show = All;
    }



let update (msg: message) (model: model): model =
    match msg with
    | No_operation ->
        model

    | Update_task task ->
        {model with task}

    | Add ->
        assert (model.task <> "");
        { model with
            task = "";
            next_id = model.next_id + 1;
            entries =
                model.entries
                @
                [{ description = model.task
                 ; completed   = false
                 ; id = model.next_id
                 }]
        }

    | Delete id ->
        { model with
            entries =
                List.filter (fun e -> e.id <> id) model.entries
        }

    | Check (id, completed) ->
        {model with
            entries =
                List.map
                    (fun e ->
                        if e.id = id then
                            {e with completed}
                        else
                            e)
                    model.entries}

    | Show show ->
        { model with show }



let view_filters (show: show): message Vdom.t =
    let open Vdom in
    let open Attribute in
    let make_button name my_show show: message Vdom.t =
        if show = my_show then
            button
                [ onClick (Show my_show); style "background-color" "lightgrey" ]
                [ text name ]
        else
            button [onClick (Show my_show)] [ text name ]
    in
    p []
      [ text "Show: "
      ; make_button "All" All show
      ; make_button "Active" Active show
      ; make_button "Completed" Completed show
      ]



let view_entry (show: show) (e: entry): message Vdom.t option =
    let open Vdom in
    let open Attribute in
    if  show = All
        || (show = Active && not e.completed)
        || (show = Completed && e.completed)
    then
        Some (
            p []
              [ input [ type_ "checkbox"
                      ; checked e.completed
                      ; onCheck
                            (fun completed -> Check (e.id, completed))
                      ]
                      []
              ; text e.description
              ; input [ type_ "button"
                      ; value "x"
                      ; onClick (Delete e.id)]
                      []
              ]
            )
    else
        None


let view (model: model): message Vdom.t =
    let open Vdom in
    let open Attribute in
    div []
        ( [ h1 [] [text "todo list"]
          ; p []
              [input [ placeholder "new task"
                     ; value model.task
                     ; onInput (fun task -> Update_task task)
                     ; onKeyUp
                        (fun key ->
                            if key = "Enter" && model.task <> "" then
                                Add
                            else
                                No_operation)
                     ]
                     []
              ]
         ]
         @
         List.map_and_filter
            (view_entry model.show)
            model.entries
         @
         [view_filters model.show]
       )



let _ =
    let module Program = Browser.Make (Appl) in
    Program.sandbox model view update
