let data = File.ReadAllLines("puzzle_input_6.txt").[0]

let rec find_marker_pos (msg : string) (marker_size : int) : int =
  let char_set = msg.Substring(0, marker_size) |> Seq.toList |> Set.ofList
  if char_set.Count < marker_size then 1 + (find_marker_pos (msg.Substring(1)) marker_size) else marker_size

printf "Answer 1: %d\n\n" (find_marker_pos data 4)
printf "Answer 2: %d\n\n" (find_marker_pos data 14)