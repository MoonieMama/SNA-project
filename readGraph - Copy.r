# load the igraph library
# you may have to install this module if you haven't already
library(igraph)

# read in the graph in GML format
# it is a sampled collection of pages from a strange set of seed categories:
# Math, Sociology, and Chemistry
# Change this to be your local file location
#  if you are using Windows, replace the \ in the path with a double \, e.g.
# g = read.graph("C:\\Users\\rool\\Documents\\My Dropbox\\Education\\Social Network Analysis\\Week 3\\wikipedia.gml",format="gml")

g = read.graph("D:\\Courses\\Social Network Analysis\\project\\Amazon0302.txt",format="edgelist")

# obtain summary information about the graph
summary(g)

#global transitivity
transitivity(g,type=c("global"))

# fastgreedy community finding algorithm
fc = fastgreedy.community(as.undirected(g))

#label propagation community
lp = label.propagation.community(as.undirected(g))

#walktrap community
wc = walktrap.communities(as.undirected(g))

#InfoMap community
imc = infomap.communities(g)

# community sizes
sizes(fc)

#colouring community
#plot(g,vertex.color=colors[membership(fc)], layout=layout.fruchterman.reingold)

#contracting vertices belonging to same cluster
cg <- contract.vertices(g, membership(fc))
summary(cg)
#assigning sizes to super nodes based on original cluster sizes (number of nodes in them)
V(cg)$size <- sizes(fc)
#removing self-loops
cg2 <- simplify(cg, remove.loops=TRUE)
#number of nodes in cg2 - assigning vertex colours
colors <- rainbow(vcount(cg2))
lsize <- V(cg2)$size
plot(cg2,vertex.color=colors[V(cg2)],vertex.label=NA,vertex.size=(lsize[V(cg2)]*15/50000 + 2),layout=layout.fruchterman.reingold)
#calculation depends on max and min sizes of communities in fc

write((V(g)[membership(fc)==2]),"D:\\Courses\\Social Network Analysis\\project\\fg2.txt")

# subg1 <- induced.subgraph(g, which(membership(lp)==k))
# now run community finding algorithm on subg1, with communities wc11 and lp11
# write((V(g)[membership(wc11)==11]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc11.txt")
# > write((V(g)[membership(wc11)==21]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc21.txt")
# > write((V(g)[membership(wc11)==7]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc7.txt")
# > write((V(subg1)[membership(lp11)==76]),"D:\\Courses\\Social Network Analysis\\project\\fg11lp76.txt")
# > write((V(subg1)[membership(lp11)==26]),"D:\\Courses\\Social Network Analysis\\project\\fg11lp26.txt")
# > write((V(subg1)[membership(wc11)==11]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc11.txt")
# > write((V(subg1)[membership(wc11)==21]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc21.txt")
# > write((V(subg1)[membership(wc11)==7]),"D:\\Courses\\Social Network Analysis\\project\\fg11wc7.txt")


#computation of intra cluster density
sapply(unique(membership(fc)), function(k) {
    subg1<-induced.subgraph(g, which(membership(fc)==k)) #membership id differs for each cluster
    ecount(subg1)/ecount(g)
})

sapply(unique(membership(lp)), function(k) {
    subg1<-induced.subgraph(g, which(membership(lp)==k)) #membership id differs for each cluster
    ecount(subg1)/ecount(g)
})

#Community comparison of fast greedy and label propagation
compare(fc,lp)