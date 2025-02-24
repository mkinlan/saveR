
<!-- README.md is generated from README.Rmd. Please edit that file -->

# saveR

<!-- badges: start -->
<!-- badges: end -->

The goal of saveR is to provide the user with more flexibility during
EDA by removing rows or columns from a data frame based on the
percentage of data present in the row or column.

## Installation

You can install the development version of saveR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mkinlan/saveR")
```

## Example

Say you have a data set with nulls (aka, every data set) about the
residents of a city:

``` r
library(saveR)
## 
df <- data.frame(
  ID    = c(1234,2145,3468,2487,1222),
  Product_Name = c("ProdA", "ProdB", "ProdC", "ProdD", "ProdE"),
  Weight      = c(NA, 30, 22, 28, 35),
  Shipping_Zip  = c("12345", "23456", "34567", "45678", "56789"),
  Cost    = c(50000, NA, 55000, NA, NA),
  Phase    = c("Dev", "Prod", "Dev", "Obsolete", "Prod"),
  stringsAsFactors = FALSE  
)

df
#>     ID Product_Name Weight Shipping_Zip  Cost    Phase
#> 1 1234        ProdA     NA        12345 50000      Dev
#> 2 2145        ProdB     30        23456    NA     Prod
#> 3 3468        ProdC     22        34567 55000      Dev
#> 4 2487        ProdD     28        45678    NA Obsolete
#> 5 1222        ProdE     35        56789    NA     Prod
```

You can easily clean a data set like this using a number of methods to
remove nulls throughout the df:

``` r
df1<-na.omit(df)
df1
#>     ID Product_Name Weight Shipping_Zip  Cost Phase
#> 3 3468        ProdC     22        34567 55000   Dev
```

or

``` r
df2<-df %>% filter(is.na(df$Cost))
df2
#> Time Series:
#> Start = 1 
#> End = 5 
#> Frequency = 1 
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> 1   NA   NA   NA   NA   NA   NA
#> 2   NA   NA   NA   NA   NA   NA
#> 3 5866    7   NA    7   NA    6
#> 4   NA   NA   NA   NA   NA   NA
#> 5   NA   NA   NA   NA   NA   NA
```

``` r
df3<-df %>% tidyr::drop_na()
df3
#>     ID Product_Name Weight Shipping_Zip  Cost Phase
#> 1 3468        ProdC     22        34567 55000   Dev
```

or

``` r
#select rows that are complete for column "Income"
df4<-df[complete.cases(df[ , 5]),]
df4
#>     ID Product_Name Weight Shipping_Zip  Cost Phase
#> 1 1234        ProdA     NA        12345 50000   Dev
#> 3 3468        ProdC     22        34567 55000   Dev
```

But, maybe you don’t want to get rid of all of the nulls in a row or
column. For me, this is often because I’m exploring and cleaning a wide
data set, and sometimes there so many columns that the easiest thing to
do is to cut the whole thing down by chopping out the columns with
blanks.

But, by doing that, one risks the possibility of losing columns that are
majority non-null, simply because they contain some null values. In
situations like this, there might be some value in filtering out
percentages of nulls. Then, the remaining data frame could be further
assessed to determine if it would be worth it to take steps to try and
fill in the remaining missing data.

For example, in the data set above, Cost is missing a number of data
points, but Weight is only missing one. Additionally, Weight likely
refers to a product weight, which is probably standardized. It’s likely
that there is a table of product weights somewhere, and this could be
used to fill in missing data.

Using the save_cols function from saveR would let us easily locate
columns like Weight, where filling in missing data might be a fairly
easy fix:

``` r
result<-save_cols(df,0.75)
result
#>     ID Product_Name Weight Shipping_Zip    Phase
#> 1 1234        ProdA     NA        12345      Dev
#> 2 2145        ProdB     30        23456     Prod
#> 3 3468        ProdC     22        34567      Dev
#> 4 2487        ProdD     28        45678 Obsolete
#> 5 1222        ProdE     35        56789     Prod
```

The resulting data frame has lost the Cost column, which was majority
blank, but kept the Weight column, because 75% of the column contained
non-null data.
