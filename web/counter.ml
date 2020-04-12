open Fmlib


module Browser = Fmlib_js.Browser


module Appl = Web_application.Make (Browser)

module Vdom = Appl.Dom

module Attribute = Appl.Attribute



type message =
    | Increment
    | Decrement


let model: int = 0

let view (model: int): message Vdom.t =
    let open Vdom in
    let open Attribute in
    div
        []
        [ button [onClick Decrement] [text "-"]
        ; div [] [text (string_of_int model)]
        ; button [onClick Increment] [text "+"]
        ]

let update (message: message) (model: int): int =
    match message with
    | Decrement -> model - 1
    | Increment -> model + 1


let _ =
    let module Program = Browser.Make (Appl) in
    Program.sandbox model view update
