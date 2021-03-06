# FUNCTION: Transdorms the results of the 
# INPUT: df that is the result of get_emotions_google()
# OUTPUT: A tibble containing the coordinates and labels for plotting
# EXAMPLE: create_plot_labels(result)


library(dplyr)
library(stringr)

create_plot_labels <- function(df) {
    df %>%
        # filter(!str_detect(value, "very unlikely")) %>% # Exclude very unlikely predictions
        group_by(face_id, xmax, xmin, ymax, ymin) %>%
        summarise(label = paste0(emotion, ": ", value) %>% paste(collapse = "\n")) %>% 
        full_join(df %>% select(-emotion, -value), by = c("face_id","xmax","xmin","ymax","ymin")) %>% 
        filter(!duplicated(face_id)) # %>% 
        # mutate(label = if_else(is.na(label), "not recognized", label))
}
