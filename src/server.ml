type server
type req
type res

external express: unit -> server = "express" [@@bs.module]

(* express server methods *)
external get: server -> string -> (req -> res -> res) -> server = "get" [@@bs.send]
external listen: server -> int -> server = "listen" [@@bs.send]

(* res methods *)
external set_header : res -> string -> string -> res = "setHeader" [@@bs.send]
external status: res -> int -> res = "status" [@@bs.send]
external send: res -> string -> res = "send" [@@bs.send]

(* params on the request *)
type query
external _query : req -> query = "query" [@@bs.get]
external _get : query -> string -> string = "" [@@bs.get_index]

let query req = _get (_query req)

let default req res =
  status res 200;
  set_header res "Content-Type" "image/svg+xml";
  send res (query req "num" |> int_of_string |> Svg.svg_of_collatz);
