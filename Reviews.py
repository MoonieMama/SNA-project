# see http://networkx.lanl.gov/ for a tutorial on NetworkX
import networkx as nx
from sets import Set

# your GML file
filename = "D:\\Courses\\Social Network Analysis\\project\\pid_cid_edges_weighted2.txt"

# read in the graph using networkX
G = nx.read_weighted_edgelist(filename,create_using=nx.DiGraph())

num_nodes = G.number_of_nodes()
print 'number of nodes: ' + str(num_nodes)

# number of edges
num_edges = G.number_of_edges()
print 'number of edges: ' + str(num_edges)

#pass in appropriate id as argument to the predecessors function. Here, we have id 2
incoming_reviewers = G.predecessors("2")
subgr = Set([])
probable_products = dict([])

for reviewer in incoming_reviewers:
	neighbour_products = G.neighbors(reviewer)
	subgr.add(reviewer)
	for product in neighbour_products:
		subgr.add(product)

G1 = G.subgraph(list(subgr))

		
for reviewer in incoming_reviewers:
	neighbour_products = G1.neighbors(reviewer)
	for product in neighbour_products:
		in_deg_prod = 0.05*G.in_degree(product) + 0.9*G1.in_degree(product)
		probable_products[product] = in_deg_prod
		
f1 = open("D:\\Courses\\Social Network Analysis\\project\\2reco_1.txt",'w')
for prod in sorted(probable_products, key=probable_products.get, reverse=True):
	f1.write(str(prod))
	f1.write(": ")
	f1.write(str(probable_products[prod]))
	f1.write("\n")
	

