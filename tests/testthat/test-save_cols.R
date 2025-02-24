test_that("save_cols saves 33% of a df", {
  expect_equal(save_cols(
    test_df<-data.frame(col1=c('cat','dog','bird','fish'),
                        col2=c(2,3,NA,NA),
                        col3=c('a','b','c','d')),
    0.33),
    data.frame(col1=c('cat','dog','bird','fish'),
                        col2=c(2,3,NA,NA),
                        col3=c('a','b','c','d'))
    )
})
