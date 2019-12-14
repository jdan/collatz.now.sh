open Server;;

let default _ res =
  send res "
    <p>visit [number].svg for example: <a href=\"/123.svg\">/123.svg</a></p>
    <img width=\"300\" src=\"/api/collatz?num=123\">
  "
