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

# fastgreedy community finding algorithm
fc = fastgreedy.community(as.undirected(g))

#label propagation community
lp = label.propagation.community(as.undirected(g))

# community sizes
sizes(fc)

#colouring community
#plot(g,vertex.color=colors[membership(fc)], layout=layout.fruchterman.reingold)

cg <- contract.vertices(g, membership(fc))
summary(cg)
V(cg)$size <- sizes(fc)
cg2 <- simplify(cg, remove.loops=TRUE)
#number of nodes in cg2
colors <- rainbow(vcount(cg2))
lsize <- V(cg2)$size
plot(cg2,vertex.color=colors[V(cg2)],vertex.label=NA,vertex.size=(lsize[V(cg2)]*15/50000 + 2),layout=layout.fruchterman.reingold)
#calculation depends on max and min sizes of communities in fc

write((V(g)[membership(fc)==2]),"D:\\Courses\\Social Network Analysis\\project\\fg2.txt")


sapply(unique(membership(fc)), function(k) {
    subg1<-induced.subgraph(g, which(membership(fc)==k)) #membership id differs for each cluster
    ecount(subg1)/ecount(g)
})

sapply(unique(membership(lp)), function(k) {
    subg1<-induced.subgraph(g, which(membership(lp)==k)) #membership id differs for each cluster
    ecount(subg1)/ecount(g)
})