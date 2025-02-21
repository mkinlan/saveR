#if row is x percent populated, then keep row
save_row<-function(df,x) {

  orig_cols<-ncol(df)#create separate var to capture original len of cols

  df$score = 0

  for(i in 1:nrow(df)) { #first looping by row
    for (j in 1:ncol(df)) { #then checks by col
      if (is.na(df[i,j])) {
        #print("it's null")
        df$score[i]<- df$score[i] + 1
        df$percent_full[i]<-1-(df$score[i]/orig_cols)
      }
      else{
        df$score[i]<- df$score[i]
        df$percent_full[i]<-1-(df$score[i]/orig_cols)

      }
    }
  }
  df<-df %>% dplyr::filter(df$percent_full >= x)
  return(df)
}
