type req
type res

(* res methods *)
external set_header : res -> string -> string -> unit = "setHeader" [@@bs.send]
external status: res -> int -> unit = "status" [@@bs.send]
external send: res -> string -> unit = "send" [@@bs.send]

(* params on the request *)
type query
external _query : req -> query = "query" [@@bs.get]
external _get : query -> string -> string = "" [@@bs.get_index]

let query req = _get (_query req)
