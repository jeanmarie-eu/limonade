# limonade

limonade focuses on making easy the extraction of datasets from any format.

The package will evolve according to my projects.

The public package works only with ncdf4 so far.

Without any effort:

i- get a sum-up of the variables and the dimension of their respective dataset.

ii- extract datasets

## Installation

```R
# install.packages("devtools")
devtools::install_github("jeanmarielepioufle/limonade")
```

## Usage

```R
library("limonade")

# filename
filename <-  "/path/to/your/file/filename"

# parameters of your file
format <- "netcdf"
varid <- "mean_temperature"

test <- limonade(filename=file,format=format)
test$summary()
test$summary("mean_temperature")

# dataset
test$extract(2L)$val
test$extract(varid)
test$extract(varid,"time")
test$extract(varid,3L)

```

I am working on making a vignette.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
