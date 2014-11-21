import gzip
from sets import Set

def parse(filename):
  f = gzip.open(filename, 'r')
  f1 = open("pid.gdf",'w')
  ctr=0
  f1.write("nodedef>name,label varchar(200),label1 varchar(10)\n")
  for l in f:
	l = l.strip()
	if "discontinued" in l:
		f1.write(",,")
	if "Id:" in l:
		f1.write("\n")
		if ctr>262112:
			break
		ctr = ctr + 1
		colonPos = l.find(':')
		f1.write(l[colonPos+4:])
	if "title" in l:
		f1.write(",")
		colonPos = l.find(':')
		f1.write(l[colonPos+2:])
	if "group" in l:
		f1.write(",")
		colonPos = l.find(':')
		f1.write(l[colonPos+2:])
  f2 = open("D:\\Courses\\Social Network Analysis\\project\\Amazon0302.txt")
  f1.write("edgedef>node1,node2\n")
  for l in f2:
	l = l.strip()
	spacePos = l.find('\t')
	f1.write(l[:spacePos])
	f1.write(',')
	f1.write(l[spacePos+1:])
	f1.write("\n")
		
def parseCustomer(filename):
	f = gzip.open(filename, 'r')
	f1 = open("D:\\Courses\\Social Network Analysis\\project\\pid_cid_edges.txt",'w')
	#f2 = open("pid_cid_nodes.txt",'w')
	nodes = Set([])
	prevId = ""
	ctr=0
#	f1.write("*Vertices\n")
	#f1.write("*Arcs\n")
	#f1.write("edgedef>node1,node2,weight DOUBLE\n")
	for l in f:
		l = l.strip()
		if "Id:" in l:
			if ctr>262112:
				break
			ctr = ctr + 1
			colonPos = l.find(':')
			prevId = (l[colonPos+4:])
			# f1.write("# ")
			# f1.write(prevId)
			# f1.write("\n")
			#nodes.add(prevId)
		if "cutomer" in l:
			colonPos = l.find(':')
			l1 = l[colonPos+2:]
			l1 = l1.strip()
			spacePos = l1.find(' ')
			rColPos = l1.find(':')
			customer = l1[:spacePos]
			nodes.add(customer)
			f1.write(customer)
			f1.write(" ")
			f1.write(prevId)
			# f1.write(" ")
			# f1.write(l1[rColPos+2:rColPos+3])
			f1.write("\n")
	#f2.write("nodedef>name\n")
	#for node in nodes:
		#f2.write(node)
		#f2.write("\n")
	#print (str(len(nodes)))
		
		# if "Id:" in l:
			# f1.write("\n")
			# if ctr>262111:
				# break
			# ctr = ctr + 1
			# colonPos = l.find(':')
			# f1.write(l[colonPos+4:])


parseCustomer("D:\\Courses\\Social Network Analysis\\project\\amazon-meta.txt.gz")
#print simplejson.dumps(e)