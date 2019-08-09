#'Automate Many Model Analysis
#'@description Automated many-model approach using functional programming.
#'
#'@param dataframe Dataframe to operate on
#'@param model_function Model function to test with
#'@param vars Variables to cut data with
#'@param min_sample_size Minimum sample size of the groups
#'@param model_metrics Metrics to pull from model
#'@param permutations how many permutations to use?
#'@export auto_mm
#'@export extract_model_metric
#'@export model_maker

auto_mm = function(dataframe, model, split_vars, min_sample_size = 30, permutations = 1){
  if(permutations == 1){
    map_df(split_vars, function(split_var){
      split_var = as.name(split_var)
      dataframe %>%
        group_nest({{split_var}})%>%
        mutate(n = map_dbl(data, nrow)) %>%
        filter(n > min_sample_size) %>%
        gather(variable, value, -data, -n) %>%
        mutate(value = as.character(value))}) %>%
      mutate(model = map(data, model)) %>%
      select(data, model, n, everything())

  } else if (permutations == 2){
    split_vars %>%
      expand.grid(., . ) %>%
      as.tibble() %>%
      rename(var1 = 1, var2 = 2) %>%
      filter(var1 != var2) %>%
      mutate_all(as.character) %>%
      pmap_df(function(var1, var2){
        var1 = as.name(var1)
        var2 = as.name(var2)
        dataframe %>%
          group_nest({{var1}}, {{var2}}) %>%
          gather(variable_1, value_1, -c(2:data)) %>%
          gather(variable_2, value_2, -c(data:value_1)) %>%
          mutate(n = map_dbl(data, nrow)) %>%
          filter(n > min_sample_size) %>%
          mutate(model = map(data, model)) %>%
          select(data, model, n, everything())
      })
  } else {warning("Only 1 or 2 permutations are possible.")}


}

extract_model_metric = function(dataframe, model_metric){
  require(broom)
  dataframe %>%
    mutate({{model_metric}} := map_dbl(model, function(model){
      s = broom::glance(model)
      y = s[[model_metric]]
      return(y)
    }))
  }

model_maker = function(.f, formula, ...){
  function(dataframe){.f({{formula}}, ..., data = dataframe)}
}











