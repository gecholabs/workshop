library (rjson)
library (MASS)

map_data = fromJSON (file = "2011.json")
data = list ()

order = c ('1/2/2011', '1/9/2011', '1/16/2011', '1/23/2011', '1/30/2011', '2/6/2011', '2/13/2011', '2/20/2011', '2/27/2011', '3/6/2011', '3/13/2011', '3/20/2011', '3/27/2011', '4/3/2011', '4/10/2011', '4/17/2011', '4/24/2011', '5/1/2011', '5/8/2011', '5/15/2011', '5/22/2011', '5/29/2011', '6/5/2011', '6/12/2011', '6/19/2011', '6/26/2011', '7/3/2011', '7/10/2011', '7/17/2011', '7/24/2011', '7/31/2011', '8/7/2011', '8/14/2011', '8/21/2011', '8/28/2011', '9/4/2011', '9/11/2011', '9/18/2011', '9/25/2011', '10/2/2011', '10/9/2011', '10/16/2011', '10/23/2011', '10/30/2011', '11/6/2011', '11/13/2011', '11/20/2011', '11/27/2011', '12/4/2011', '12/11/2011', '12/18/2011', '12/25/2011')

data = matrix (nrow = length(map_data$features), ncol = length (order))

for (i in 1:length (map_data$features)) {
    prop = map_data$features[[i]]$properties
    for (j in 1:length (order)) {
        key = order[j]
        data[i, j] = prop[[key]]
    }
}

fit = cmdscale (dist (data), k = 2, eig = TRUE, x.ret = TRUE)
#fit = isoMDS (dist (data), k = 2)
x = fit$points[,1]
y = fit$points[,2]

print (dim (fit$x))

write ("[", file = "output")
for (i in 1:length (x)) {
    write ("[", file = "output", append = TRUE)
    write (x[[i]], file = "output", append = TRUE)
    write (",", file = "output", append = TRUE)
    write (y[[i]], file = "output", append = TRUE)
    write ("]", file = "output", append = TRUE)
    if (i < length (x))
        write (",", file = "output", append = TRUE)
}
write ("]", file = "mds_out", append = TRUE)