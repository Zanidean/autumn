# autumn

Automated Many-Models

```
library(tidyverse)
library(autumn)

diamonds %>% 
  auto_mm(model = model_maker(lm, price ~ x + y + z), 
          split = c("cut", "color", "clarity")) %>% 
  extract_model_metric("p.value") %>% 
  extract_model_metric("r.squared")

```
