
library(tidymodels)

# ------------------------------------------------------------------------------

tidymodels_prefer()
theme_set(theme_bw())
options(pillar.advice = FALSE, pillar.min_title_chars = Inf)

# ------------------------------------------------------------------------------
# how to use the summary method

model <-
  linear_reg() %>%
  set_engine("lm") %>%
  fit(mpg ~ ., mtcars)

model %>% 
  # This pulls the lm object (a.k.a. the "engine" fit) out of 
  # the parsnip model object:
  extract_fit_engine() %>% 
  summary()

model %>% 
  extract_fit_engine() %>% 
  tidy()

model %>% 
  extract_fit_engine() %>% 
  glance()

# ------------------------------------------------------------------------------
# How are the data nonlinear

# A linear versus nonlinear fit
deliveries %>% 
  ggplot(aes(hour, time_to_delivery)) + 
  geom_point(alpha = .5) + 
  geom_smooth() + 
  geom_smooth(method = lm, se = FALSE, col = "red")

# Oh no, there are different nonlinear trends on different days.
# This is a nonlinear interaction. 
deliveries %>% 
  ggplot(aes(hour, time_to_delivery, col = day)) + 
  # geom_point(alpha = .5) + 
  geom_smooth(se = FALSE)

# ------------------------------------------------------------------------------
# How to optimize parameters? 

library(rules)
# First, mark them for optimization via tune() and then use one of the
# functions that starts with tune_* to get good values. 
cubist_rules(committees = tune())