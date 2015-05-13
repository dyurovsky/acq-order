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

spa.wg <-  read_excel('[Spanish_WG].xlsx')
spa.wg <- spa.wg[,1:(ncol(spa.wg)-1)] %>%
  mutate(language = "Spanish")

tur.wg <- read_csv('[Turkish_WG].csv') %>%
  mutate(language = "Turkish")


diff <- bind_rows(anti_join(tur.wg,eng.wg, by = "uni_lemma"),
                  anti_join(eng.wg,tur.wg, by = "uni_lemma")) %>%
  select(language,uni_lemma,definition,category) %>%
  arrange(uni_lemma)

