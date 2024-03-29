
gjamPriorTemplate <- function(formula, xdata, ydata, lo = NULL, hi = NULL){
  
  # template for prior coefficient matrix
  # lo   - list of lower limits
  # hi   - list of upper limits
  
  tmp <- grep('_',colnames(ydata))
  if(length(tmp) > 0)stop("remove '_' from colnames(ydata)")
  tmp <- grep('_',colnames(xdata))
  if(length(tmp) > 0)stop("remove '_' from colnames(xdata)")
  
  if( !is.character(formula) )formula <- as.formula( formula )
  
  x      <- model.matrix( formula, xdata )
  S      <- ncol(ydata)                    # no. responses
  Q      <- ncol(x)                        # no. predictors
  xnames <- colnames(x)
  xnames[1] <- 'intercept'
  ynames <- colnames(ydata)
  beta   <- matrix(0,Q,S)
  rownames(beta) <- xnames         
  colnames(beta) <- ynames
  
  loBeta <- beta - Inf
  hiBeta <- beta + Inf
  
  if( !is.null(lo) ){
    loBeta <- .setLoHi(plist = lo, pmat = loBeta, xnames, ynames)
  }
  if( !is.null(hi) ){
    hiBeta <- .setLoHi(plist = hi, pmat = hiBeta, xnames, ynames)
  }
  
  
  wna <- which( sapply(lo, is.na) )
  if(!is.null(hi))wna <- c( wna, which( sapply(hi, is.na) ) )
  if(length(wna) > 0){
    rc <- columnSplit( names(wna), '_')
    rc <- rc[ rc[,2] %in% rownames(loBeta), ]             # reference level for factors will be absent
    loBeta[ rc[,2], rc[,1] ] <- hiBeta[ rc[,2], rc[,1] ] <- 0
  }
  
  attr(loBeta,'formula') <- attr(hiBeta,'formula') <- formula
  
  list(lo = loBeta, hi = hiBeta)
}


  
