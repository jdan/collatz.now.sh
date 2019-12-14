type server
type req
type res

external express: unit -> server = "express" [@@bs.module]

external get: server -> string -> (req -> res -> res) -> server = "get" [@@bs.send]
external send: res -> string -> res = "send" [@@bs.send]
external listen: server -> int -> server = "listen" [@@bs.send]

external set: res -> string -> string -> res = "set" [@@bs.send]

type params
external _params : req -> params = "params" [@@bs.get]
external _param : params -> string -> string = "" [@@bs.get_index]

let param req s = _param (_params req) s

let () =
  express ()
  |. get "/:num.svg" (fun req res -> 
      set res "Content-Type" "image/svg+xml"
      |. send (param req "num" |> int_of_string |> Svg.svg_of_collatz)
    )
  |. listen 8080;
  print_endline "Ok."
