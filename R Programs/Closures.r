counter <- function () {
 ctr <- 0
 f <- function() {
 ctr <<- ctr + 1
 cat("this count currently has value",ctr,"\n")
 }
}

c1 <- counter()
c2 <- counter()