# returns the minimum value of d[i,j], i != j, and the row/col attaining
# that minimum, for square symmetric matrix d; no special policy on ties
mind <- function(d) {
	n <- nrow(d)
	# add a column to identify row number for apply()
	dd <- cbind(d,1:n)
	wmins <- apply(dd[-n,,drop=F],1,imin)
	# wmins will be 2xn, 1st row being indices and 2nd being values
	i <- which.min(wmins[2,])
	j <- wmins[1,i]
	return(c(d[i,j],i,j))
}

imin <- function(x) {
 lx <- length(x)
 i <- x[lx] # original row number
 j <- which.min(x[(i+1):(lx-1)])
 k <- i+j
 return(c(k,x[k]))
}

x <- matrix(c(1,2,3,4,5,6),nrow=2)
y <- mind(x)
print(y)