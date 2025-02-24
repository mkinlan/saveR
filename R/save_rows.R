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
#' df<-data.frame(
#' col1=c('cat','dog','bird','fish'),
#' col2=c(2,3,NA,NA),
#' col3=c('a','b','c','d'))
#'
#' result_df<-save_rows(df,0.33)

save_rows<-function(df,x) {

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
  df<-subset(df,select=-c(score))
  return(df)
}
