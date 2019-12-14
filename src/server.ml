type server
type req
type res

external express: unit -> server = "express" [@@bs.module]

external get: server -> string -> (req -> res -> res) -> server = "get" [@@bs.send]
external send: res -> string -> res = "send" [@@bs.send]
external listen: server -> int -> server = "listen" [@@bs.send]

let () =
  let srv = express ()
  in listen (
    get srv "/" (fun req res -> send res "Hello, world!")
  ) 8080;
  print_endline "Ok."
