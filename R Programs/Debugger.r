f <- function() {
	a <- 1
	return(g(a)+a)
}
g <- function(aa) {
	b <- 2
	showframe(0)
	showframe(1)
	aab <- h(aa+b)
	showframe(1)
	return(aab)
}
h <- function(aaa) {
c <- 3
return(aaa+c)
}

showframe <- function(upn) {
# determine the proper environment
	if (upn < 0) {
	env <- .GlobalEnv
	} else {
		env <- parent.frame(n=upn+1)
	}
	# get the list of variable names
	vars <- ls(envir=env)
	# for each variable name, print its value
	for (vr in vars) {
		vrg <- get(vr,envir=env)
		if (!is.function(vrg)) {
			cat(vr,":\n",sep="")
			print(vrg)
		}
	}
}

f()