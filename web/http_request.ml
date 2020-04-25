open Fmlib


module Browser = Fmlib_js.Browser

module App = Web_application.Make (Browser)

module Vdom = App.Dom

module Attribute = App.Attribute

module Command = App.Command

module Program = Browser.Make (App)


type model = {
    url: string;
    response: string;
}

type message =
    | No_operation
    | Update_url of string
    | Response of string
    | Request



let http_request (url: string): message Command.t =
    Command.Http (
        "GET"
        , url
        , ""
        , function
            | Ok response ->
                Response response
            | Error code ->
                Response ("ERROR: " ^ string_of_int code)
    )



let init (url: string): model * message Command.t =
    { url; response = "" },
    if url = "" then
        Command.None
    else
        http_request url



let update (message: message) (model: model): model * message Command.t =
    match message with
    | No_operation ->
        model, Command.None

    | Update_url url ->
        {model with url},
        Command.None

    | Response response ->
        {model with response},
        Command.None

    | Request ->
        if model.url = "" then
            model, Command.None
        else
            {model with response = "Waiting ..."},
            http_request model.url



let view (model: model): message Vdom.t =
    let open Vdom in
    let open Attribute in
    div []
        [ h3 [] [text "Http Request"]
        ; p []
            [
                input [ placeholder "Enter url"
                      ; type_ "url"
                      ; style "width" "90%"
                      ; onInput
                          (fun url -> Update_url url)
                      ; onKeyUp
                            (fun key ->
                                if key = "Enter" && model.url <> "" then
                                    Request
                                else
                                    No_operation)
                      ]
                      []
            ]
        ; pre [] [text model.response]
        ]




let subscription (_: 'model): 'msg App.Subscription.t =
    App.Subscription.None



let _ =
    Program.element
        Browser.Decoder.string
        init
        view
        update
        subscription
