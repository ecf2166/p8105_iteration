read_lotr = function(r, m){
  
  ret_df = read_excel("data/LoTR_Words.xlsx", range = r) |> 
    mutate(movie = m) |> 
    janitor::clean_names() |> 
    pivot_longer(
      female:male,
      names_to = "sex",
      values_to = "words"
    )
  
  return(ret_df)
  
}