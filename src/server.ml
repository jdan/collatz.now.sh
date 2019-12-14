type server
type req
type res

external express: unit -> server = "express" [@@bs.module]

external get: server -> string -> (req -> res -> res) -> server = "get" [@@bs.send]
external send: res -> string -> res = "send" [@@bs.send]
external listen: server -> int -> server = "listen" [@@bs.send]

type params
external _params : req -> params = "params" [@@bs.get]
external _param : params -> string -> string = "" [@@bs.get_index]

let param req s = _param (_params req) s

let () =
  express ()
  |. get "/:name" (fun req res -> send res (param req "name" ^ "!!"))
  |. listen 8080;
  print_endline "Ok."
