#'Automate Many Model Analysis
#'@description Automated many-model approach using functional programming.
#'
#'@param dataframe Dataframe to operate on
#'@param model_function Model function to test with
#'@param vars Variables to cut data with
#'@param min_sample_size Minimum sample size of the groups
#'@param model_metrics Metrics to pull from model
#'@import dplyr
#'@import purrr
#'@import tidyr
#'@import broom
#'@import rlang
#'@export auto_mm
#'@export extract_model_metric
#'@export model_maker

require(dplyr)
require(purrr)
require(tidyr)
require(rlang)

auto_mm = function(dataframe, model, split_vars, min_sample_size = 30){
  map_df(split_vars, function(split_var){
    split_var = as.name(split_var)
    dataframe %>%
      group_nest({{split_var}})%>%
      mutate(n = map_dbl(data, nrow)) %>%
      filter(n > min_sample_size) %>%
      gather(variable, value, -data, -n) %>%
      mutate(value = as.character(value))}) %>%
    mutate(model = map(data, model))
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
  function(dataframe){.f(enquo(formula), ..., data = dataframe)}
}











