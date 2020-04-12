open Fmlib
open Common


module Browser = Fmlib_js.Browser



module Appl = Web_application.Make (Browser)

module Vdom = Appl.Dom

module Attribute = Appl.Attribute

let model: string =
    ""


let view (model: string): string Vdom.t =
    let open Vdom in
    let open Attribute in
    div
        []
        [   input
                [   placeholder "Text to reverse"
                ;   value model
                ;   onInput identity
                ]
                []
        ;   div [] [text (String.reverse model)]
        ]


let update (message: string) (_: string): string =
    message



let _ =
    let module Program = Browser.Make (Appl) in
    Program.sandbox model view update
