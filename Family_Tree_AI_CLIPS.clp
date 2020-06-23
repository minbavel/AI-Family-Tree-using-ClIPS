(deftemplate father-of (slot father) (slot child))
(deftemplate mother-of (slot mother) (slot child))
(deftemplate wife-of (slot wife) (slot husband))
(deftemplate husband-of (slot husband) (slot wife))
(deftemplate grandparent-of (slot grandparent) (slot grandchild))
(deftemplate parent-of (slot parent) (slot child))
(deftemplate sibling-of (slot sibling1) (slot sibling2))
(deftemplate uncle-of (slot uncle) (slot child))
(deftemplate aunt-of (slot aunt) (slot child))
(deftemplate greataunt-of (slot greataunt) (slot greatchild))
(deftemplate greatuncle-of (slot greatuncle) (slot greatchild))
(deftemplate cousin-of (slot cousin1) (slot cousin2))
(deftemplate grandmother-of (slot grandmother) (slot grandchild))
(deftemplate grandfather-of (slot grandfather) (slot grandchild))
(deftemplate nephew-of (slot nephew) (slot uncle))
(deftemplate niece-of (slot niece) (slot uncle))
(deftemplate halfsibling-of (slot halfsibling1) (slot halfsibling2))
(deftemplate stepparent-of (slot stepparent) (slot stepchild))
(deftemplate greatgrandparent-of (slot greatgrandparent) (slot greatgrandchild))
(deftemplate marriage-relation (slot husband) (slot wife))
(deftemplate child-relation (slot father) (slot mother) (slot child))
(deftemplate grand-child-relation (slot parent) (slot child))
(deftemplate brother-relation (slot brother) (slot sibling))
(deftemplate sister-relation (slot sister) (slot sibling))
(deftemplate daughter-relation (slot parent) (slot daughter))
(deftemplate son-relation (slot parent) (slot son))
(deftemplate uncle-relation (slot uncle) (slot nephew))
(deftemplate aunt-relation (slot aunt) (slot nephew))
(deftemplate sister-in-law-relation (slot sister) (slot sibling))
(deftemplate brother-in-law-relation (slot brother) (slot sibling))
(deftemplate first-cousin-relation (slot cousin) (slot sibling))
(deftemplate person (slot name) (slot gender))



(deffacts family-tree
           
		   (father-of (father joe) (child boruto))
		   (father-of (father joe) (child himawari))
		   (father-of (father joe) (child menma))
		   (father-of (father minato) (child joe))
		   (father-of (father minato) (child naruto))
		   (mother-of (mother kushina) (child joe))
		   (mother-of (mother kushina) (child naruto))
		   (mother-of (mother naruto) (child sarada))
		   (mother-of (mother naruto) (child uchiha))
		   (father-of (father minato) (child tsunade))
		   (mother-of (mother jiraiya) (child tsunade))
		   (mother-of (mother indra) (child itachi))
		   (mother-of (mother indra) (child sakura))
		   (mother-of (mother kishi) (child indra))
		   (mother-of (mother kishi) (child asura))
		   (mother-of (mother kishi) (child kushina))
		   (father-of (father hagoromo) (child indra))
		   (father-of (father hagoromo) (child asura))
		   (father-of (father hagoromo) (child kushina))
		   (father-of (father tenji) (child hagoromo))
		   (father-of (father tenji) (child otsutsuki))
		   (father-of (father tenji) (child hamura))
		   (mother-of (mother kaguya) (child hagoromo))
		   (mother-of (mother kaguya) (child otsutsuki))
		   (mother-of (mother kaguya) (child hamura))
		   (person (name joe) (gender male))
		   (person (name tenji) (gender male))
		   (person (name hagoromo) (gender male))
		   (person (name hamura) (gender male))
		   (person (name asura) (gender male))
		   (person (name minato) (gender male))
		   (person (name tsunade) (gender female))
		   (person (name sakura) (gender female))
		   (person (name itachi) (gender male))
		   (person (name uchiha) (gender male))
		   (person (name boruto) (gender male))
		   (person (name himawari) (gender male))
		   (person (name menma) (gender male))
		   (person (name kaguya) (gender female))
		   (person (name jiraiya) (gender female))
		   (person (name kishi) (gender female))
		   (person (name indra) (gender female))
		   (person (name kushina) (gender female))
		   (person (name naruto) (gender male))
		   (person (name sarada) (gender female))
		   (person (name otsutsuki) (gender female))
		   (marriage-relation (husband minato) (wife kushina))
		   (marriage-relation (husband hagoromo) (wife kishi))
		   (marriage-relation (husband tenji) (wife kaguya))
		   
)


(defglobal
			?*value1* = "nil"
			?*value2* = "nil")


(defrule value
	(declare(salience 1))
	=>
	(printout t "Enter Name 1:")
	(bind ?*value1*  (read t))
	
	(printout t "Enter Name 2:")
	(bind ?*value2*  (read t))
	
)


(defrule brother
	(and
		(father-of (father ?father) (child ?siblingone))
		(mother-of (mother ?mother) (child ?siblingone))
		(father-of (father ?father) (child ?siblingtwo&~?siblingone))
		(mother-of (mother ?mother) (child ?siblingtwo&~?siblingone)))
	(person (name ?siblingone) (gender male))
	=>
	(assert (brother-relation (brother ?siblingone) (sibling ?siblingtwo)))
	(if (and (or (eq ?siblingone ?*value1*)
				 (eq ?siblingone ?*value2*))	
			 (or (eq ?siblingtwo ?*value1*)
				 (eq ?siblingtwo ?*value2*)))
	then

	(printout t ?siblingone " is " ?siblingtwo "'s brother and the Genetic Similarity is 50%" crlf)
))


(defrule sister
	(and
		(father-of (father ?father) (child ?siblingone))
		(mother-of (mother ?mother) (child ?siblingone))
		(father-of (father ?father) (child ?siblingtwo&~?siblingone))
		(mother-of (mother ?mother) (child ?siblingtwo&~?siblingone)))
	(person (name ?siblingone) (gender female))
	=>
	(assert (brother-relation (brother ?siblingone) (sibling ?siblingtwo)))
	(if (and (or (eq ?siblingone ?*value1*)
				 (eq ?siblingone ?*value2*))	
			 (or (eq ?siblingtwo ?*value1*)
				 (eq ?siblingtwo ?*value2*)))
	then

	(printout t ?siblingone " is " ?siblingtwo "'s sister and the Genetic Similarity is 50%" crlf)
))


(defrule daughter
	(or
		(father-of (father ?f) (child ?sibling))
		(mother-of (mother ?f) (child ?sibling)))
	(person (name ?sibling) (gender female))
	=>
	(assert (daughter-relation (parent ?f) (daughter ?sibling) ))
	(if (and (or (eq ?f ?*value1*)
				 (eq ?f ?*value2*))	
			 (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*)))
	then
	
))

(defrule son
	(or
		(father-of (father ?f) (child ?sibling))
		(mother-of (mother ?f) (child ?sibling)))
	(person (name ?sibling) (gender male))
	=>
	(assert (son-relation (parent ?f) (son ?sibling) ))
	(if (and (or (eq ?f ?*value1*)
				 (eq ?f ?*value2*))	
			 (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*)))
	then
	
))


(defrule aunt
	(and
	(and
		(father-of (father ?father) (child ?child))
		(mother-of (mother ?mother) (child ?child)))
	(and
		(or (father-of (father ?grandfather) (child ?father))
			(father-of (father ?grandfather) (child ?mother)))
		(or (mother-of (mother ?grandmother) (child ?father))
			(mother-of (mother ?grandmother) (child ?mother))))
	(and
		(or (father-of (father ?grandfather) (child ?sibling&~?father&~?mother))
			(mother-of (mother ?grandfather) (child ?sibling&~?father&~?mother)))))

	(person (name ?sibling) (gender female))
	=>
	(assert (aunt-relation (aunt ?sibling) (nephew ?child)))
	(if (and (or (eq ?child ?*value1*)
				 (eq ?child ?*value2*))	
			 (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*)))
	then
	(printout t ?sibling " is " ?child "'s aunt and the Genetic Similarity is 25%" crlf)
))


(defrule uncle
	(and
	(and
		(father-of (father ?father) (child ?child))
		(mother-of (mother ?mother) (child ?child)))
	(and
		(or (father-of (father ?grandfather) (child ?father))
			(father-of (father ?grandfather) (child ?mother)))
		(or (mother-of (mother ?grandmother) (child ?father))
			(mother-of (mother ?grandmother) (child ?mother))))
	(and
		(or (father-of (father ?grandfather) (child ?sibling&~?father&~?mother))
			(mother-of (mother ?grandfather) (child ?sibling&~?father&~?mother)))))

	(person (name ?sibling) (gender male))
	=>
	(assert (uncle-relation (uncle ?sibling) (nephew ?child)))
	(if (and (or (eq ?child ?*value1*)
				 (eq ?child ?*value2*))	
			 (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*)))
	then
	(printout t ?sibling " is " ?child "'s uncle and the Genetic Similarity is 25%" crlf)
))


(defrule brother-in-law
	(and
		(father-of (father ?father) (child ?child))
		(mother-of (mother ?mother) (child ?child)))
	(person (name ?partner))
	(marriage-relation (husband ?child|?partner) (wife ?child|?partner))
	(and
		(father-of (father ?father) (child ?sibling&~?child))
		(mother-of (mother ?mother) (child ?sibling&~?child)))
	(person (name ?sibling) (gender male))
	=>
	(assert (brother-in-law-relation (brother ?sibling) (sibling ?partner)))
	(if (and (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*))	
			 (or (eq ?partner ?*value1*)
				 (eq ?partner ?*value2*)))
	then
	(printout t ?sibling " is " ?partner "'s brother in law and the Genetic Similarity is 12.5%" crlf)
))


(defrule sister-in-law
	(and
		(father-of (father ?father) (child ?child))
		(mother-of (mother ?mother) (child ?child)))
	(person (name ?partner))
	(marriage-relation (husband ?child|?partner) (wife ?child|?partner))
	(and
		(father-of (father ?father) (child ?sibling&~?child))
		(mother-of (mother ?mother) (child ?sibling&~?child)))
	(person (name ?sibling) (gender female))
	=>
	(assert (sister-in-law-relation (sister ?sibling) (sibling ?partner)))
	(if (and (or (eq ?sibling ?*value1*)
				 (eq ?sibling ?*value2*))	
			 (or (eq ?partner ?*value1*)
				 (eq ?partner ?*value2*)))
	then
	(printout t ?sibling " is " ?partner "'s sister in law and the Genetic Similarity is 12.5%" crlf)
))



(defrule is-parent-of
	(or	(father-of (father ?f) (child ?c))
		(mother-of (mother ?f) (child ?c)))
	=>
	(assert (parent-of (parent ?f) (child ?c)))
	(if (and (or (eq ?f ?*value1*)
				 (eq ?f ?*value2*))	
			 (or (eq ?c ?*value1*)
				 (eq ?c ?*value2*)))
	then
	(printout t ?f " is " ?c "'s Parent and the Genetic Similarity is 50%" crlf))
)


(defrule is-grandmother-of
(and (mother-of (mother ?m) (child ?c1)) 
	 (parent-of (parent ?c1) (child ?c2)) 
	 (person (name ?m) (gender female)))
	=>
	(assert (grandmother-of (grandmother ?m) (grandchild ?c2) ))
	(if (and (or (eq ?m ?*value1*)
				 (eq ?m ?*value2*))	
			 (or (eq ?c2 ?*value1*)
				 (eq ?c2 ?*value2*)))
	then
	(printout t ?m " is " ?c2 "'s Grand mother and the Genetic Similarity is 25%" crlf)))


(defrule is-grandfather-of
(and (father-of (father ?f) (child ?c1)) 
	 (parent-of (parent ?c1) (child ?c2)) 
	 (person (name ?f) (gender male)))
	=>
	(assert (grandfather-of (grandfather ?f) (grandchild ?c2) ))
	(if (and (or (eq ?f ?*value1*)
				 (eq ?f ?*value2*))	
			 (or (eq ?c2 ?*value1*)
				 (eq ?c2 ?*value2*)))
	then
	(printout t ?f " is " ?c2 "'s Grand Father and the Genetic Similarity is 25%" crlf)))
	

(defrule is-greatgrandparent-of 
	( and 
		(or (grandfather-of (grandfather ?gp) (grandchild ?gc)) 
			(grandmother-of (grandmother ?gp) (grandchild ?gc)))
		(parent-of (parent ?p) (child ?gp)))
	=> 
	(assert (greatgrandparent-of (greatgrandparent ?p) (greatgrandchild ?gc) ))
	(if (and (or (eq ?p ?*value1*)
				 (eq ?p ?*value2*))	
			 (or (eq ?gc ?*value1*)
				 (eq ?gc ?*value2*)))
	then
	(printout t ?p " is " ?gc "'s Great Grand Father and the Genetic Similarity is 12.5%" crlf)))


(defrule is-sibling-of
	(parent-of (parent ?p) (child ?c1))
	(parent-of (parent ?p) (child ?c2 & ~?c1))
	=>
	(assert (sibling-of (sibling1 ?c1) (sibling2 ?c2))))


(defrule is-greatuncle-of
		(or (grandfather-of (grandfather ?gp1) (grandchild ?gc)) 
			(grandmother-of (grandmother ?gp1) (grandchild ?gc)))
		(sibling-of (sibling1 ?gp1) (sibling2 ?gp2))
		(person (name ?gp2) (gender male))
	=> 
	(assert (greatuncle-of (greatuncle ?gp2) (greatchild ?gc) ))
	(if (and (or (eq ?gp2 ?*value1*)
				 (eq ?gp2 ?*value2*))	
			 (or (eq ?gc ?*value1*)
				 (eq ?gc ?*value2*)))
	then
	(printout t ?gp2" is " ?gc"'s Great Uncle and the Genetic Similarity is 12.5%" crlf)
))


(defrule is-greataunt-of
		(or (grandfather-of (grandfather ?gp1) (grandchild ?gc)) 
			(grandmother-of (grandmother ?gp1) (grandchild ?gc)))
		(sibling-of (sibling1 ?gp1) (sibling2 ?gp2))
		(person (name ?gp2) (gender female))
	=> 
	(assert (greataunt-of (greataunt ?gp2) (greatchild ?gc) ))
	(if (and (or (eq ?gp2 ?*value1*)
				 (eq ?gp2 ?*value2*))	
			 (or (eq ?gc ?*value1*)
				 (eq ?gc ?*value2*)))
	then
	(printout t ?gp2" is " ?gc"'s Great Aunt and the Genetic Similarity is 12.5%" crlf)
))


(defrule is-niece-of
  (father-of (father ?f) (child ?c1))
  (father-of (father ?f) (child ?c2))
  (mother-of (mother ?m) (child ?c1))
  (mother-of (mother ?m) (child ?c2))
  (person (name ?c1) (gender female))
  (person (name ?c2) (gender male))
  (mother-of (mother ?c1) (child ?c3))
  (person (name ?c3) (gender female))
  =>
 (assert (niece-of (niece ?c3) (uncle ?c2)))
 (if (and (or (eq ?c3 ?*value1*)
				 (eq ?c3 ?*value2*))	
			 (or (eq ?c2 ?*value1*)
				 (eq ?c2 ?*value2*)))
	then
	(printout t ?c3" is " ?c2"'s Niece and the Genetic Similarity is 25%" crlf)
))


(defrule is-nephew-of
  (father-of (father ?f) (child ?c1))
  (father-of (father ?f) (child ?c2))
  (mother-of (mother ?m) (child ?c1))
  (mother-of (mother ?m) (child ?c2))
  (person (name ?c1) (gender female))
  (person (name ?c2) (gender male))
  (mother-of (mother ?c1) (child ?c3))
  (person (name ?c3) (gender male))
  =>
 (assert (nephew-of (nephew ?c3) (uncle ?c2)))
 (if (and (or (eq ?c3 ?*value1*)
				 (eq ?c3 ?*value2*))	
			 (or (eq ?c2 ?*value1*)
				 (eq ?c2 ?*value2*)))
	then
	(printout t ?c3" is " ?c2"'s Nephew and the Genetic Similarity is 25%" crlf)
)
)


(defrule is-cousin-of 
	(and 
		(aunt-relation (aunt ?a) (nephew ?c1)) 
		(parent-of (parent ?a) (child ?c2)) )
	=> 
	(assert (cousin-of (cousin1 ?c1) (cousin2 ?c2) ))
	(if (and (or (eq ?c1 ?*value1*)
				 (eq ?c1 ?*value2*))	
			 (or (eq ?c2 ?*value1*)
				 (eq ?c2 ?*value2*)))
	then
	(printout t ?c1 " is " ?c2 "'s Cousin and the Genetic Similarity is 12.5%" crlf)))


(defrule is-husband-of
	(father-of (father ?f) (child ?c))
	(mother-of (mother ?m) (child ?c))
	=>
	(assert (husband-of (husband ?f) (wife ?m)))
	(if (and (eq ?f ?*value1*)
		   (eq ?m ?*value2*))
	then
	(printout t ?f " is " ?m "'s Husband" crlf))
)


(defrule is-wife-of
	(mother-of (mother ?m) (child ?c))
	(father-of (father ?f) (child ?c))
	=>
  (assert (wife-of (wife ?m) (husband ?f)))
  (if (and (eq ?m ?*value1*)
		   (eq ?f ?*value2*))
	then
  (printout t ?m " is " ?f "'s Wife" crlf))
)


(defrule  is-stepparent-of 
	(husband-of (husband ?h) (wife ?w))
	(father-of (father ?h) (child ?c1))
	(not (mother-of (mother ?w) (child ?c1)))
	=>
	(assert (stepparent-of (stepparent ?w) (stepchild ?c1)))
	(if (and (or (eq ?w ?*value1*)
				 (eq ?w ?*value2*))	
			 (or (eq ?c1 ?*value1*)
				 (eq ?c1 ?*value2*)))
	then
	(printout t ?w " is " ?c1 "'s Step Parent" crlf)
))

(defrule is-halfsibling-of
	(and 
		(wife-of (wife ?x) (husband ?y)) 
		(parent-of (parent ?x) (child ?z)) 
		(wife-of (wife ?a & ~?x) (husband ?y)) 
		(parent-of (parent ?a) (child ?b)))
	=>
	(assert (halfsibling-of (halfsibling1 ?z) (halfsibling2 ?b) ))
	(if (and (or (eq ?z ?*value1*)
				 (eq ?z ?*value2*))
			 (or (eq ?b ?*value1*)
				 (eq ?b ?*value2*)))
	then
	(printout t ?z " is " ?b "'s Half Sibling" crlf)
))

