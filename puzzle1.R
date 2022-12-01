
data <- readr::read_table("puzzle_input_1.txt", col_names = FALSE, skip_empty_rows = FALSE)
calorie_counts <- purrr::reduce(data$X1, .init = c(0), .f = function(input, next_val) {
  if (is.na(next_val)) {
    input[length(input)+1] <- 0
  } else {
    input[length(input)] <- input[length(input)] + next_val
  }
  input
})

# 1st
max(calorie_counts)

# 2nd
sum(sort(calorie_counts, decreasing = TRUE)[1:3])
