#' Save Rows
#'
#' @param df Data frame object with rows and columns
#' @param x Percentage of populated rows to keep, as a decimal.
#'
#' @returns Data frame
#' @import dplyr
#' @export
#'
#' @examples
#' df<-data.frame(col1=c('cat','dog','bird','fish'),
#' col2=c(2,3,NA,NA),
#' col3=c('a','b','c','d'),
#' stringsAsFactors = FALSE
#' )
#'
#' result_df<-save_rows(df,0.33)

save_rows<-function(df,x) {

  orig_cols<-ncol(df)#create separate var to capture original len of cols

  df$score_temp=0

  for(i in 1:nrow(df)) { #first looping by row
    for (j in 1:ncol(df)) { #then checks by col
      if (is.na(df[i,j])) {
        #print("it's null")
        df$score_temp[i]<- df$score_temp[i] + 1
        df$percent_full[i]<-1-(df$score_temp[i]/orig_cols)
      }
      else{
        df$score_temp[i]<- df$score_temp[i]
        df$percent_full[i]<-1-(df$score_temp[i]/orig_cols)

      }
    }
  }
  result<-df %>% dplyr::filter(df$percent_full >= x) %>% mutate(across(c('percent_full'),round,2))
  result<-subset(result,select=-c(score_temp))
  print(result)
  return(result)
}
