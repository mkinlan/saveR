#if col is x percent populated, then keep col
#' Save Cols
#'
#' @param df Data frame
#' @param x Percentage of populated cols to keep, as a decimal.
#'
#' @returns Data frame
#' @export
#'
#' @examples
#' df<-data.frame(
#' col1=c('cat','dog','bird','fish'),
#' col2=c(2,3,NA,NA),
#' col3=c('a','b','c','d'))
#'
#' result_df<-save_cols(df,0.33)
#'
save_cols<-function(df,x) {
  #matrix filled with 0s with same dims as df. This will store the sum of the columns
  m<-matrix(0,nrow=nrow(df),ncol=ncol(df), dimnames = list(rownames(df),colnames(df)))

  #1-row matrix with same colnames as df. This will store the number of rows per col so that can be subtracted from m
  rowcount_matrix<-matrix(nrow(df),nrow=1,ncol=ncol(df),dimnames = list(c("rowcount_matrix"),colnames(df)))

  for(j in 1:ncol(df)) { #first looks at first col
    for(i in 1:nrow(df)){
      if (is.na(df[i,j])) {
        #print("it's null")
        m[i,j] = m[i,j]+1
      }
      else{
        print("values here")
      }
    }
  }
  #now that matrix has been populated with 1s for each NA, need to sum each column
  colsum_matrix<-colSums(m)

  #bind to matrix containing the number of rows per col
  #use rowwise division to divide the count of NAs per col from total obs. per col.
  colsum_matrix<-rbind(colsum_matrix,rowcount_matrix)
  div_list<-apply(colsum_matrix,MARGIN = 2,function(x) 1.0-(x[1]/x[2]))
  div_df<-data.frame(div_list)

  #filtering by x
  div_df<-div_df %>% filter(div_df$div_list >= x)

  #creating a vector of the rownames, which are actually the column names from the original df
  vec<-rownames(div_df)

  #select appropriate cols only
  df<-df %>% select(any_of(vec))

  return(df)
}
