f = open("cov_sarscov.json","r")
import json
j = json.load(f)
f.close()
def rec(n):
	if "vaccine" in n["node_attrs"]:
		n["node_attrs"].pop("vaccine")
	if "children" in n:
		for c in n["children"]:
			rec(c)
	if n["name"] == "LLJ-2004":
		n["node_attrs"]["num_date"]["value"]=2004.4
		n["node_attrs"]["num_date"]["confidence"]=[2004.25,2004.4]
		n["node_attrs"]["clade_membership"]["value"]="Lab leaks"
	if n["name"] == "Sin0409":
		n["node_attrs"]["num_date"]["value"]=2003.675
		n["node_attrs"]["num_date"]["confidence"]=[2003.675,2003.675]
		n["node_attrs"]["clade_membership"]["value"]="Lab leaks"
	if n["name"] == "SCVJ":
		n["node_attrs"]["num_date"]["value"]=2003.94109
		n["node_attrs"]["num_date"]["confidence"]=[2003.94109,2003.94109]
		n["node_attrs"]["clade_membership"]["value"]="Lab leaks"
		

rec(j["tree"])

def annotateSpillovers(n,tab):
	co = 0
	if "children" in n:
		for c in n["children"]:
			a = annotateSpillovers(c,tab)
			co += a
	else:
		if n["name"] in tab:
			co=1
	if co == len(tab):
		#n["node_attrs"].update({"vaccine": {"selection_date" : "2019-03-21"}})
		n["node_attrs"]["clade_membership"]["value"] = "A spillover branch?"
		return 0
	return co

annotateSpillovers(j["tree"],["GZ0401","GZ0402"])
annotateSpillovers(j["tree"],["ZS-A","ZS-B","ZS-C"])
annotateSpillovers(j["tree"],["GD01","GZ02"])
annotateSpillovers(j["tree"],["HGZ8L1-A"])
annotateSpillovers(j["tree"],["HSZ-Bc","Tor2","JMD"])






f = open("cov_sarscov.json","w")

json.dump(j,f)
