open System.IO

// Get 3rd item in a tuple
let third (_, _, c) = c

let getPriority (value:char): int = 
  let priorities = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  priorities.IndexOf(value)

let string2set (s: string): Set<char> = s |> Seq.toList |> Set.ofList

let split2Sets (itemData: string) =
  let splitPos = itemData.Length / 2
  (itemData.Substring(0, splitPos) |> string2set, itemData.Substring(splitPos) |> string2set)

let makeSetSequence (items: seq<string>): seq<Set<char>>  = Seq.map string2set items

let getIntersectItemPair (pair: Set<char> * Set<char>) = Set.intersect (fst pair) (snd pair)

let getIntersectItemSequence (items: seq<Set<char>>) = Seq.reduce Set.intersect items

let getSetItemValue (item: Set<char>) = (Set.toList item).Head |> getPriority


let data = File.ReadAllLines("puzzle_input_3.txt")
let first = data |>
  Array.map (fun s -> split2Sets s) |> // Split rucksack into two compartment sets
  Array.map getIntersectItemPair |>    // Get set of shared items
  Array.map getSetItemValue |>         // Get priority value of shared items
  Array.sum                            // Sum priority values

let second = seq { 0 .. 3 .. (data.Length-2) } |>
  Seq.map (fun x -> seq { data[x]; data[x+1]; data[x+2] }) |> // Form groups of rucksack items
  Seq.map makeSetSequence |>          // Convert sequence of rucksack strings to sets
  Seq.map getIntersectItemSequence |> // Get set of shared items
  Seq.map getSetItemValue |>          // Get priority value of shared items
  Seq.sum

printf "First %d, second %d\n" first second

 