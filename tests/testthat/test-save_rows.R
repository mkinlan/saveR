test_that("save_rows saves 33% of a df", {
  expect_equal(save_rows(
    test_df<-data.frame(col1=c('cat','dog','bird','fish'),
                        col2=c(2,3,NA,NA),
                        col3=c('a','b','c','d')),
    0.33),
    data.frame(col1=c('cat','dog','bird','fish'),
               col2=c(2,3,NA,NA),
               col3=c('a','b','c','d'),
               percent_full=c(1.0000000,1.0000000,0.6666667,0.6666667))
  )
})

