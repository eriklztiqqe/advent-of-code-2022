
translate_choice <- function(rps_choice) {
  dplyr::case_when(
    rps_choice == "A" | rps_choice == "X" ~ "Rock",
    rps_choice == "B" | rps_choice == "Y" ~ "Paper",
    rps_choice == "C" | rps_choice == "Z" ~ "Scissor",
    TRUE ~ "")
}

get_rock_paper_scissor_score <- function(rps_choice) {
  dplyr::case_when(
    rps_choice == "Rock" ~ 1,
    rps_choice == "Paper" ~ 2,
    rps_choice == "Scissor" ~ 3,
    TRUE ~ 0)
}


get_session_result <- function(choice1, choice2) {
  dplyr::case_when(
    choice1 == choice2 ~ "Draw",
    choice1 == "Rock" & choice2 == "Paper" ~ "Win",
    choice1 == "Paper" & choice2 == "Scissor" ~ "Win",
    choice1 == "Scissor" & choice2 == "Rock" ~ "Win",
    TRUE ~ "Lose"
  )
}

get_session_score <- function(result, rps_score) {
  dplyr::case_when(
    result == "Lose" ~ 0 + rps_score,
    result == "Draw" ~ 3 + rps_score,
    result == "Win" ~ 6 + rps_score,
    TRUE ~ 0
  )
}

data1 <- readr::read_table("puzzle_input_2.txt", col_names = FALSE, skip_empty_rows = FALSE) |>
  dplyr::mutate(elf_choice=translate_choice(X1),
                my_choice=translate_choice(X2)) |>
  dplyr::mutate(session_result=get_session_result(elf_choice, my_choice)) |>
  dplyr::mutate(my_rps_score=get_rock_paper_scissor_score(my_choice)) |>
  dplyr::mutate(session_score=get_session_score(session_result, my_rps_score))

# 1st
print(sum(data1$session_score))

translate_result <- function(result) {
  dplyr::case_when(
    result == "X" ~ "Lose",
    result == "Y" ~ "Draw",
    result == "Z" ~ "Win",
    TRUE ~ ""
  )
}

select_my_choice <- function(elf_choice, session_result) {
  dplyr::case_when(
    session_result == "Draw" ~ elf_choice,
    session_result == "Win" & elf_choice == "Rock" ~ "Paper",
    session_result == "Win" & elf_choice == "Paper" ~ "Scissor",
    session_result == "Win" & elf_choice == "Scissor" ~ "Rock",
    session_result == "Lose" & elf_choice == "Rock" ~ "Scissor",
    session_result == "Lose" & elf_choice == "Paper" ~ "Rock",
    session_result == "Lose" & elf_choice == "Scissor" ~ "Paper"
  )
}

data2 <- readr::read_table("puzzle_input_2.txt", col_names = FALSE, skip_empty_rows = FALSE) |>
  dplyr::mutate(elf_choice=translate_choice(X1),
                session_result=translate_result(X2),
                my_choice=select_my_choice(elf_choice, session_result)) |>
  dplyr::mutate(my_rps_score=get_rock_paper_scissor_score(my_choice)) |>
  dplyr::mutate(session_score=get_session_score(session_result, my_rps_score))

# 2nd
print(sum(data2$session_score))
