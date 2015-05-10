library(dplyr)
library(tidyr)
library(readxl)
library(magrittr)
library(readr)
eng.wg <- read_excel('[English_WG].xlsx') %>%
  filter(!is.na(uni_lemma)) %>%
  mutate(language = "English")

nor.wg <- read_excel('[Norwegian_WG].xlsx')
nor.wg <- nor.wg[,1:(ncol(nor.wg)-1)] %>%
  filter(!is.na(uni_lemma)) %>%
  mutate(language = "Norwegian")

cro.wg <- read_csv('[Croatian_WG].csv') %>%
  mutate(language = "Croatian")


diff <- bind_rows(anti_join(nor.wg,cro.wg, by = "uni_lemma"),
                  anti_join(cro.wg,nor.wg, by = "uni_lemma")) %>%
  select(language,uni_lemma,definition,category) %>%
  arrange(uni_lemma)

