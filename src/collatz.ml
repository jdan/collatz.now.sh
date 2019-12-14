open Server;;

let default req res =
  status res 200;
  set_header res "Content-Type" "image/svg+xml";
  query req "num"
  |> int_of_string
  |> Svg.svg_of_collatz
  |> send res;
