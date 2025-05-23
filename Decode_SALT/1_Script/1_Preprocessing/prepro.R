library(tidyverse)
library(here)

here()
load("/Users/zhengyuanrui/Decoding_SALT/Decode_SALT/2_Data/AllData.RData")



df1a.v.ml <- df1a.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT) %>%
  dplyr::mutate(ExpNo = "Exp1a")

df1a.v.ml_basic <- df1a.v.ml %>% 
  group_by(Subject, BlockNo) %>% 
  summarise(n = n())


df1b.v.ml <- df1b.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT) %>%
  dplyr::mutate(ExpNo = "Exp1b")

df1b.v.ml_basic <- df1b.v.ml %>% 
  group_by(Subject, BlockNo) %>% 
  summarise(n = n())

df1c.v.ml <- df1c.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT) %>%
  dplyr::mutate(ExpNo = "Exp1c")

df1c.v.ml_basic <- df1c.v.ml %>% 
  group_by(Subject, BlockNo) %>% 
  summarise(n = n())

df3a.v.ml <- df3a.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT, Identity) %>%
  dplyr::mutate(ExpNo = "Exp3a")

df3a.v.ml_basic <- df3a.v.ml %>% 
  group_by(Subject, BlockNo) %>% 
  summarise(n = n())

df3b.v.ml <- df3b.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT, Identity) %>%
  dplyr::mutate(ExpNo = "Exp3b")

df3b.v.ml_basic <- df3b.v.ml %>% 
  dplyr::group_by(Subject, BlockNo) %>% 
  dplyr::summarise(n = n())

df4a.v.ml <- df4a.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT, Identity) %>%
  dplyr::mutate(ExpNo = "Exp4a")

df4a.v.ml_basic <- df4a.v.ml %>% 
  dplyr::group_by(Subject, BlockNo) %>% 
  dplyr::summarise(n = n())

df4b.v.ml <- df4b.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT, Identity) %>%
  dplyr::mutate(ExpNo = "Exp4b")

df4b.v.ml_basic <- df4b.v.ml %>% 
  dplyr::group_by(Subject, BlockNo) %>% 
  dplyr::summarise(n = n())

df5.v.ml <- df5.v %>%
  dplyr::select(Subject, BlockNo, TrialNo, Valence, Matchness, ACC, RT) %>%
  dplyr::mutate(ExpNo = "Exp5")

df5.v.ml_basic <- df5.v.ml %>% 
  dplyr::group_by(Subject, BlockNo) %>% 
  dplyr::summarise(n = n())

######## Exp1, Exp5 did not include self reference so bind together
df_no_ref <- rbind(df1a.v.ml, df1b.v.ml, df1c.v.ml, df5.v.ml) %>% 
  dplyr::group_by(Subject, ExpNo, BlockNo) %>% 
  dplyr::mutate(Valence1b = dplyr::lag(Valence, n = 1), 
         RT1b = dplyr::lag(RT, n = 1), 
         Matchness1b = dplyr::lag(Matchness, n = 1),
         ACC1b = dplyr::lag(ACC, n = 1),
         TrialNo1b = dplyr::lag(TrialNo, n = 1), 
         Valence2b = dplyr::lag(Valence, n = 2), 
         RT2b = dplyr::lag(RT, n = 2), 
         Matchness2b = dplyr::lag(Matchness, n = 2),
         ACC2b = dplyr::lag(ACC, n = 2),
         TrialNo2b = dplyr::lag(TrialNo, n = 2), 
         Valence3b = dplyr::lag(Valence, n = 3), 
         RT3b = dplyr::lag(RT, n = 3), 
         Matchness3b = dplyr::lag(Matchness, n = 3),
         ACC3b = dplyr::lag(ACC, n = 3),
         TrialNo3b = dplyr::lag(TrialNo, n = 3),
         Valence4b = dplyr::lag(Valence, n = 4), 
         RT4b = dplyr::lag(RT, n = 4), 
         Matchness4b = dplyr::lag(Matchness, n = 4),
         ACC4b = dplyr::lag(ACC, n = 4),
         TrialNo4b = dplyr::lag(TrialNo, n = 4)
  ) %>% 
  tidyr::drop_na() %>% 
  dplyr::filter(RT != 0) %>%
  dplyr::filter(RT1b != 0) %>% 
  dplyr::filter(RT2b != 0) %>% 
  dplyr::filter(RT3b != 0) %>% 
  dplyr::filter(RT4b != 0) %>% 
  dplyr::mutate(
    ismatch = dplyr::if_else(Matchness == "Match", 1, 0),
    ismatch1b = dplyr::if_else(Matchness1b == "Match", 1, 0),
    ismatch2b = dplyr::if_else(Matchness2b == "Match", 1, 0),
    ismatch3b = dplyr::if_else(Matchness3b == "Match", 1, 0),
    ismatch4b = dplyr::if_else(Matchness4b == "Match", 1, 0),
    Valence_G1b = dplyr::if_else(Valence1b == "Good", 1, 0), 
    Valence_N1b = dplyr::if_else(Valence1b == "Neutral", 1, 0), 
    Valence_B1b = dplyr::if_else(Valence1b == "Bad", 1, 0), 
    Valence_G2b = dplyr::if_else(Valence2b == "Good", 1, 0), 
    Valence_N2b = dplyr::if_else(Valence2b == "Neutral", 1, 0), 
    Valence_B2b = dplyr::if_else(Valence2b == "Bad", 1, 0), 
    Valence_G3b = dplyr::if_else(Valence3b == "Good", 1, 0), 
    Valence_N3b = dplyr::if_else(Valence3b == "Neutral", 1, 0), 
    Valence_B3b = dplyr::if_else(Valence3b == "Bad", 1, 0), 
    Valence_G4b = dplyr::if_else(Valence4b == "Good", 1, 0), 
    Valence_N4b = dplyr::if_else(Valence4b == "Neutral", 1, 0), 
    Valence_B4b = dplyr::if_else(Valence4b == "Bad", 1, 0), 
    label = dplyr::case_when(
      Valence == "Good" ~ 0, 
      Valence == "Neutral" ~ 1, 
      Valence == "Bad" ~ 2
    )
    ) %>% 
  dplyr::ungroup()

  
  
df_self_ref <- rbind(df3a.v.ml, df3b.v.ml, df4a.v.ml, df4b.v.ml) %>% 
  dplyr::group_by(Subject, ExpNo, BlockNo) %>% 
  dplyr::mutate(Valence1b = dplyr::lag(Valence, n = 1), 
         RT1b = dplyr::lag(RT, n = 1), 
         Matchness1b = dplyr::lag(Matchness, n = 1),
         ACC1b = dplyr::lag(ACC, n = 1),
         TrialNo1b = dplyr::lag(TrialNo, n = 1), 
         Valence2b = dplyr::lag(Valence, n = 2), 
         RT2b = dplyr::lag(RT, n = 2), 
         Matchness2b = dplyr::lag(Matchness, n = 2),
         ACC2b = dplyr::lag(ACC, n = 2),
         TrialNo2b = dplyr::lag(TrialNo, n = 2), 
         Valence3b = dplyr::lag(Valence, n = 3), 
         RT3b = dplyr::lag(RT, n = 3), 
         Matchness3b = dplyr::lag(Matchness, n = 3),
         ACC3b = dplyr::lag(ACC, n = 3),
         TrialNo3b = dplyr::lag(TrialNo, n = 3),
         Valence4b = dplyr::lag(Valence, n = 4), 
         RT4b = dplyr::lag(RT, n = 4), 
         Matchness4b = dplyr::lag(Matchness, n = 4),
         ACC4b = dplyr::lag(ACC, n = 4),
         TrialNo4b = dplyr::lag(TrialNo, n = 4)
  ) %>% 
  tidyr::drop_na() %>% 
  dplyr::filter(RT != 0) %>%
  dplyr::filter(RT1b != 0) %>% 
  dplyr::filter(RT2b != 0) %>% 
  dplyr::filter(RT3b != 0) %>% 
  dplyr::filter(RT4b != 0) %>% 
  dplyr::mutate(
    ismatch = dplyr::if_else(Matchness == "Match", 1, 0),
    ismatch1b = dplyr::if_else(Matchness1b == "Match", 1, 0),
    ismatch2b = dplyr::if_else(Matchness2b == "Match", 1, 0),
    ismatch3b = dplyr::if_else(Matchness3b == "Match", 1, 0),
    ismatch4b = dplyr::if_else(Matchness4b == "Match", 1, 0),
    Valence_G1b = dplyr::if_else(Valence1b == "Good", 1, 0), 
    Valence_N1b = dplyr::if_else(Valence1b == "Neutral", 1, 0), 
    Valence_B1b = dplyr::if_else(Valence1b == "Bad", 1, 0), 
    Valence_G2b = dplyr::if_else(Valence2b == "Good", 1, 0), 
    Valence_N2b = dplyr::if_else(Valence2b == "Neutral", 1, 0), 
    Valence_B2b = dplyr::if_else(Valence2b == "Bad", 1, 0), 
    Valence_G3b = dplyr::if_else(Valence3b == "Good", 1, 0), 
    Valence_N3b = dplyr::if_else(Valence3b == "Neutral", 1, 0), 
    Valence_B3b = dplyr::if_else(Valence3b == "Bad", 1, 0), 
    Valence_G4b = dplyr::if_else(Valence4b == "Good", 1, 0), 
    Valence_N4b = dplyr::if_else(Valence4b == "Neutral", 1, 0), 
    Valence_B4b = dplyr::if_else(Valence4b == "Bad", 1, 0), 
    label = dplyr::case_when(
      Valence == "Good" ~ 0, 
      Valence == "Neutral" ~ 1, 
      Valence == "Bad" ~ 2
    )
  ) %>% 
  dplyr::ungroup()


df_no_ref.v <- df_no_ref %>% 
  dplyr::select(Subject, ExpNo, BlockNo, TrialNo, TrialNo1b, 
         TrialNo2b, TrialNo3b, TrialNo4b, ACC, RT, ismatch, 
         ACC1b, RT1b, ismatch1b, Valence_G1b, Valence_B1b, Valence_N1b, 
         ACC2b, RT2b, ismatch2b, Valence_G2b, Valence_B2b, Valence_N2b,
         ACC3b, RT3b, ismatch3b, Valence_G3b, Valence_B3b, Valence_N3b,
         ACC4b, RT4b, ismatch4b, Valence_G4b, Valence_B4b, Valence_N4b,
         label)

df_self_ref.v <- df_self_ref %>% 
  dplyr::select(Subject, ExpNo, BlockNo, TrialNo, TrialNo1b, 
         TrialNo2b, TrialNo3b, TrialNo4b, Identity, ACC, RT, ismatch, 
         ACC1b, RT1b, ismatch1b, Valence_G1b, Valence_B1b, Valence_N1b, 
         ACC2b, RT2b, ismatch2b, Valence_G2b, Valence_B2b, Valence_N2b,
         ACC3b, RT3b, ismatch3b, Valence_G3b, Valence_B3b, Valence_N3b,
         ACC4b, RT4b, ismatch4b, Valence_G4b, Valence_B4b, Valence_N4b,
         label)


subnumno <- df_no_ref.v %>% dplyr::select(Subject)
subnumself <- df_self_ref.v %>% dplyr::select(Subject)
sub <- rbind(subnumno, subnumself)
length(unique(sub$Subject))
nrow(sub)

write_csv(df_no_ref.v, "df_no_ref.csv")
write_csv(df_self_ref.v, "df_self_ref.csv")

getwd()

