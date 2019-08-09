library(sRa)
library(autumn)

df = diamonds %>%
  auto_mm(model_maker(lm, price ~ x + y + z),
          split = c("cut", "color"),
          permutations = 2) %>%
  extract_model_metric("p.value") %>%
  extract_model_metric("r.squared")

plot_mm(df, sort = r.squared)
