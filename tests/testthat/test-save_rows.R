testthat::test_that("save_rows saves 33% of a df", {
  testthat::expect_equal(save_rows(
    test_df<-data.frame(col1=c('cat','dog','bird','fish'),
                        col2=c(2,3,NA,NA),
                        col3=c('a','b','c','d')),
    0.33),
    data.frame(col1=c('cat','dog','bird','fish'),
               col2=c(2,3,NA,NA),
               col3=c('a','b','c','d'),
               percent_full=c(1.00,1.00,0.67,0.67))
  )
})

