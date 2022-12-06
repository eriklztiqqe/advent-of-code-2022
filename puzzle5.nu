#!/usr/bin/env nu
let init_data = (open puzzle_input_5.txt | lines | take until ($it | str starts-with " 1") | reverse)
let move_data = (
  open puzzle_input_5.txt | lines | skip until ($it | str starts-with "move") | 
  parse "move {itemcount} from {from} to {to}" |
  into int itemcount from to)
let vs = ($init_data | parse --regex ".(?P<v1>.). .(?P<v2>.). .(?P<v3>.). .(?P<v4>.). .(?P<v5>.). .(?P<v6>.). .(?P<v7>.). .(?P<v8>.). .(?P<v9>.).")
let stacks = ([
  " "
  ($vs | get v1 | str join | str trim)
  ($vs | get v2 | str join | str trim)
  ($vs | get v3 | str join | str trim)
  ($vs | get v4 | str join | str trim)
  ($vs | get v5 | str join | str trim)
  ($vs | get v6 | str join | str trim)
  ($vs | get v7 | str join | str trim)
  ($vs | get v8 | str join | str trim)
  ($vs | get v9 | str join | str trim)
])

def crate_mover_9000 [from:string cut_index:int] {
  $from | str substring [$cut_index ($from | str length)] | str reverse
}

def crate_mover_9001 [from:string cut_index:int] {
  $from | str substring [$cut_index ($from | str length)]
}


let $result1 = ($move_data | reduce --fold $stacks { |it, acc|
  let from_stack_index = $it.from
  let to_stack_index = $it.to
  let from_string = ($acc | get $from_stack_index)

  let cut_from = (($from_string | str length) - $it.itemcount)
  let moveitems = crate_mover_9000 $from_string $cut_from

  let old_to_string = ($acc | get $to_stack_index)
  let new_to_string = ([$old_to_string $moveitems] | str join)
  let new_from_string = ($from_string | str substring [0 $cut_from] )

  $acc | update $from_stack_index $new_from_string | update $to_stack_index $new_to_string
})

let $result2 = ($move_data | reduce --fold $stacks { |it, acc|
  let from_stack_index = $it.from
  let to_stack_index = $it.to
  let from_string = ($acc | get $from_stack_index)

  let cut_from = (($from_string | str length) - $it.itemcount)
  let moveitems = crate_mover_9001 $from_string $cut_from

  let old_to_string = ($acc | get $to_stack_index)
  let new_to_string = ([$old_to_string $moveitems] | str join)
  let new_from_string = ($from_string | str substring [0 $cut_from] )

  $acc | update $from_stack_index $new_from_string | update $to_stack_index $new_to_string
})

#$result1
echo 'Answer 1:' ($result1 | each { |it| ($it | str reverse | str substring [0 1] )} | str join)

#$result2
echo 'Answer 2: ' ($result2 | each { |it| ($it | str reverse | str substring [0 1] )} | str join)
