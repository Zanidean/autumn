#'Many Models Evaluation Matrix
#'@description Plot from auto_mm
#'@param dataframe Dataframe to operate on. Must come from auto_mm
#'@param sort_values Which variable to sort models by?
#'@export plot_mm

plot_mm = function(dataframe, sort){
  df %>%
    mutate(value_1 = fct_reorder(value_1, {{sort}}) %>% fct_rev,
           value_2 = fct_reorder(value_2, {{sort}}) %>% fct_rev) %>%
    ggplot(aes(x = value_1, y = value_2)) +
    geom_tile(aes(fill = {{sort}}), color = "white") +
    #geom_text(aes(x = value_1, y = value_2, label = comma(n))) +
    scale_fill_viridis_c() +
    theme_minimal() +
    theme(axis.title = element_blank())
}



