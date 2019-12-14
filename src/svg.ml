type point = int * int

type child =
  | Line of point * point
  | Arc of point * point * bool

type svg = { width : int
           ; height : int
           ; stroke : int
           ; zoom : float
           ; children : child list
           }

let string_of_child svg =
  let path_of_child = function
    | Line ((x1, y1), (x2, y2)) -> Printf.sprintf "M%d,%d L%d,%d" x1 y1 x2 y2
    | Arc ((x1, y1), (x2, y2), clockwise) -> (
        let arc_sweep = if clockwise then "1,1" else "0,0"
        in Printf.sprintf "M%d,%d A1,1 0 %s %d,%d" x1 y1 arc_sweep x2 y2
      )
  in Printf.sprintf "<path d=\"%s\" />" (path_of_child svg)

let viewbox width height zoom =
  let width' = float_of_int width
  and height' = float_of_int height
  in
  Printf.sprintf "%f %f %f %f"
    ((width' *. (1.0 -. zoom)) /. 2.0)
    ((height' *. (1.0 -. zoom)) /. 2.0)
    (zoom *. width')
    (zoom *. height')

let string_of_svg { width ; height ; zoom ; stroke ; children } =
  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"%s\">
      <g fill=\"none\" stroke=\"black\" stroke-width=\"%d\" stroke-linecap=\"round\">%s</g>
    </svg>"
    (viewbox width height zoom)
    stroke
    (String.concat "" (List.map string_of_child children))

let rec collatz n =
  if n = 1
  then [1]
  else n :: (collatz (if n mod 2 == 0
                      then n / 2
                      else 3 * n + 1))

exception EmptyListException
let max_of_int_list xs =
  let rec inner best = function
    | [] -> raise EmptyListException
    | [x] -> max best x
    | x::xs -> inner (max best x) xs
  in inner 0 xs

let rec deltas = function
  | a::b::xs -> abs (a - b) :: deltas (b :: xs)
  | _ -> []

let svg_of_collatz n =
  let nums = collatz n
  in let max_num = max_of_int_list nums
  in let max_gap = deltas nums |> max_of_int_list
  in let rec arcs_of_markov_chain counter = function
      | a::b::xs ->
        let (a', b') = (min a b, max a b)
        in Arc ((a', max_gap / 2), (b', max_gap / 2), counter)
           :: arcs_of_markov_chain (not counter) (b::xs)
      | _ -> []
  in
  { width = max_num
  ; height = max_gap
  ; children = arcs_of_markov_chain (0 = n mod 2) nums
  ; zoom = 1.25
  ; stroke = max 1 (max_num / 1000)
  }
  |> string_of_svg
