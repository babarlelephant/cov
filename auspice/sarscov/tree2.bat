
REM augur parse --sequences sequences.fasta --output-sequences sequences.fasta --output-metadata metadata.tsv --fields "strain date"


REM --exclude exclude.txt
augur filter --sequences genbank_sequences.mafft.ungapped.named.fasta --metadata metadata_with_acc.tsv  --output sequencesfiltered.fasta 

REM augur tree --alignment sequencesfiltered.fasta --output tree_raw.nwk
REM augur refine --tree tree_raw.nwk --alignment sequencesfiltered.fasta --output-tree tree.nwk --keep-polytomies --divergence-units "mutations" --metadata metadata.tsv --timetree --clock-rate 0.0012 --output-node-data branchlengths.json --coalescent "skyline" --date-inference "marginal" --date-confidence

iqtree2 -s sequencesfiltered.fasta -m GTR+G -ninit 10 -n 10 -redo
augur refine --tree sequencesfiltered.fasta.treefile --alignment sequencesfiltered.fasta --output-tree tree.nwk --keep-polytomies --divergence-units "mutations" --metadata metadata_with_acc.tsv --timetree --clock-rate 0.0012 --output-node-data branchlengths.json --coalescent "skyline" --date-inference "marginal" --date-confidence

REM --divergence-units "mutations" 

REM --clock-filter-iqd 8 --clock-std-dev 0.0015 

REM augur refine --tree tree_raw.nwk --alignment sequencesfiltered.fasta --output-tree tree.nwk --keep-polytomies --divergence-units "mutations" --metadata metadata.tsv --timetree --clock-rate 0.0012 --clock-std-dev 0.0005 --output-node-data branchlengths.json --coalescent "skyline" --date-inference "marginal" --date-confidence




augur ancestral --tree tree.nwk --alignment sequencesfiltered.fasta --output-node-data ntmuts.json

augur translate --tree tree.nwk --ancestral-sequences ntmuts.json --reference-sequence reference.gb --output-node-data aa_muts.json

REM Guangzhou HSZ hospital	nuc	3362	T
augur clades  --tree tree.nwk --mutations ntmuts.json aa_muts.json --clades clades.tsv --output clades.json
 
augur export v2 --tree tree.nwk --node-data branchlengths.json ntmuts.json aa_muts.json clades.json --auspice-config auspice_config.json --include-root-sequence --output cov_sarscov.json --metadata metadata_with_acc.tsv


python set_lab_infections_dates.py

exit /b

bonne chronologie WHO: SARS, how a global epidemic was stopped (on libgen)
file:///C:/code/nextstrain_ncov/sarscov1/World%20Health%20Organization,%20SARS%20-%20How%20a%20Global%20Epidemic%20Was%20Stopped%20(2006).pdf

Article du time sur Yi Guan le chercheur de HKU qui a séquencé des civettes en mai et fin 2003 http://content.time.com/time/subscriber/article/0,33009,993101-4,00.html
et https://web.archive.org/web/20210528015045if_/https://xw.qq.com/cmsid/20200121A0JRQH00?f=newdc


email de Yi Guan auteur de "an averted sars outbreak" seule référence sur les HC/SZ/DM1/03 https://hub.hku.hk/handle/10722/123639

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC548959/bin/pnas_102_7_2430__1.pdf collection date de SZ3, PC4, GZ0402, CUHK-AG01

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7114516/ ZL Shi dit que PC4-13 vient du restaurant et les autres PC4 du marché.
Big review of intermediate hosts investigations, although she seems to have missed Guan Yi's Chinese ferret badger market sequence CFB/SZ/94/03

https://core.ac.uk/download/pdf/8693258.pdf TJF naturally infected pig

https://github.com/blab/sars-like-cov/issues/7 a few collection dates (Raghwani2012 Revealing the Evolutionary History and Epidemiological Dynamics of Emerging RNA viral pathogens)
file:///C:\code\nextstrain_ncov\sarscov1/Raghwani2012.pdf
http://covdb.popgenetics.net/v2/index/searchlist

quelque metadata, pas terrible https://www.researchgate.net/publication/295039853_Additional_file_1

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5172409/ BJ01-BJ04

REM copy pangolinTree.json ../auspice/data/pangolinTreeAndOutliers.json


http://news.sina.com.cn/o/2006-01-13/08577971943s.shtml SARS index case (Foshan, Bitang https://www.mychinaroots.com/villages/16408/bitang ) chercher SARS 黄杏初
https://www.boundary2.org/2020/08/belinda-kong-recovering-first-patients/ d'autres détails. Mais celon la référence qu'ils citent 
traduite ici file:///C:/code/nextstrain_ncov/sarscov1/sars%20molecular%20epidemiology%20a%20chinese%20fairy%20tale%20of%20controlling%20emerging%20diease%2020209913.pdf
 c'est Yunnan, Vietnam et Myanmar, pas Guangxi.

https://science.sciencemag.org/content/303/5664/1666 Molecular Evolution of the SARS Coronavirus During the Course of the SARS Epidemic in China (ZS-A et HSZ-A)
https://science.sciencemag.org/content/sci/suppl/2004/03/10/1092002.DC1/Wang.SOM.pdf  sampling date of GZ02
J'ai mis HSZ-Bc	en janvier, pas sûr du tout 2003-01-XX
Dans l'article ils sont classés dans "early phase"

emma timetree  https://nextstrain.org/community/nextstrain/CoV/SARS?m=num_date
exclude https://github.com/nextstrain/cov/blob/master/SARS/config/exclude_SARS.txt
metadata https://github.com/nextstrain/cov/blob/master/data/CoV-SARS-23Jan20.tsv

Taiwan et amoy gardens
https://link.springer.com/content/pdf/10.1007%2F978-0-387-75722-3_7.pdf
https://www.nejm.org/doi/full/10.1056/NEJM200311063491923
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7199491/ mentionne SCVJ lab leak en décembre 2003 à taiwan. Séquence obtenue par leur liste de SNP comparé à TWC.

LC1-LC5 appelés CUHK-LCn dans https://science.sciencemag.org/content/303/5664/1666

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7112497/ GZ50

https://patents.google.com/patent/US20050112554A1/en?oq=US20050112554+ HZS2-Fc


https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7095783/ PUMC = Beijing hospital
https://www.sciencedirect.com/science/article/abs/pii/S0166093404001624 ideam plus d'autres locations

civets
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1212604/ SZ3, A022 (markets), pas mal de collection dates (month)
https://science.sciencemag.org/content/302/5643/276.long SZ3
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3367621/ Civet007 (restaurant)

http://news.sina.com.cn/w/2003-05-23/1701149902s.shtml conférence 23 mai 2003 par Yi Guan et Kwoc Yuen
https://news.sina.com.cn/c/2004-07-09/11163655901.shtml détails sur le lab leak de Beijing

https://www.nejm.org/doi/10.1056/NEJMoa030634?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200www.ncbi.nlm.nih.gov
Tor2

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC356986/ TW* cases, dans la figure il y a la correspondence TWn -> Pt x 
https://link.springer.com/content/pdf/10.1007%2F978-0-387-75722-3_7.pdf d'autres ici

REM TW1 problematic cluster: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC356986/
    ,
REM DES DATES http://covdb.popgenetics.net/v2/index/searchlist       https://era.ed.ac.uk/bitstream/handle/1842/5859/Raghwani2012.pdf?sequence=3&isAllowed=y http://www.leanmbb.net/fhw123/vip_doc/16293098.html

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3323155/ Epidemiologic Clues to SARS Origin in China,   index cases et timeline

http://babarlelephant.free-hoster.net/2004%E5%B9%B4SARS-CoV%E6%AF%92%E6%A0%AAS%E5%9F%BA%E5%9B%A0%E5%88%86%E5%AD%90%E8%BF%9B%E5%8C%96%E7%89%B9%E5%BE%81%20en.pdf
GZ0401,GZ0401 et LLJ-2004 (lab infection)

http://news.sina.com.cn/c/2004-01-05/13071509929s.shtml mention probable des HZ/SZ (shenzhen market)

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7131822/pdf/main.pdf BJ202 collected 23 May, onset 23 April

Late march Beijing superspreader file:///C:/Downloads/%E4%B8%80%E8%B5%B7%E4%BC%A0%E6%9F%93%E6%80%A7%E9%9D%9E%E5%85%B8%E5%9E%8B%E8%82%BA%E7%82%8E%E7%88%86%E5%8F%91%E7%9A%84%E2%80%9C%E8%B6%85%E7%BA%A7%E4%BC%A0%E6%92%AD%E8%80%85%E2%80%9D%E5%92%8C%E4%BC%A0%E6%92%AD%E9%93%BE%E5%88%86%E6%9E%90%20en.pdf
je ne sais pas à quelles séquences ça correspond !

Singapore lineages https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.0020043

https://www.nejm.org/doi/full/10.1056/NEJMoa032565
Sin0409 singapore lab infection

BJ182, ZJ01, ZJ02, BJ162-BJ202 file:///C:/code/nextstrain_ncov/sarscov1/SARS%E5%86%A0%E7%8A%B6%E7%97%85%E6%AF%92%E7%9A%84%E5%9F%BA%E5%9B%A0%E7%BB%84%E5%8F%98%E5%BC%82%E4%B8%8E%E8%BF%9B%E5%8C%96%E7%A0%94%E7%A9%B6%20(2)-20-22%20(2)%20en.docx
Translation from Chinese thesis SARS冠状病毒的基因组变异与进化研究 http://eng.oversea.cnki.net/kcms/detail/detail.aspx?recid=&FileName=2005128083.nh&DbName=CMFD0506&DbCode=CMFD
downloaded from https://cdmd.cnki.com.cn/Article/CDMD-10335-2005128083.htm

http://www.leanmbb.net/fhw123/vip_doc/16293098.html
	   'AY278489''DEC-16-2002''GZ 12/16/02'      
       'AY394997''DEC-26-2002''ZS 12/26/02'      ZS-A
       'AY395004''JAN-04-2003''ZS 01/04/03'       HZS2-Bb
       'AY394978''JAN-24-2003''GZ 01/24/03'      GZ-B
       'AY394983''JAN-31-2003''GZ Hospital'      
       'AY304495''FEB-18-2002''GZ 02/18/03'      
       'AY278554''FEB-21-2003''Metropole 02/21/03'
       'AY278741''FEB-26-2003''Hanoi 02/26/03'   
       'AY274119''FEB-27-2003''Toronto 02/27/03' 
       'AY283794''MAR-01-2003''Singapore 03/01/03'
       'AY291451''MAR-08-2003''Taiwan 03/08/03'  
       'AY345986''MAR-19-2003''Hong Kong 03/19/03'
       'AY394999''MAY-15-2003''Hong Kong 05/15/03'
       'AY627048' '''Palm civet'
	   
	   
	   https://bmcinfectdis.biomedcentral.com/articles/10.1186/1471-2334-4-3/tables/1
	   
	   Dates of hosts' death
		From: Date of origin of the SARS coronavirus strains
		ID	Strain	Date of host death	Date form Feb. 22
		1	BJ01	03-08-2003	13
		2	BJ02	03-08-2003	13
		3	GZ01	02-10-2003	-13
		4	SIN2500	03-14-2003	19
		5	TOR2	03-05-2003	10
		6	US	03-29-2003





http://www.doc88.com/p-1455044098095.html page 45  voir SZ-A.png
La date donnée pour Urbani ne colle pas avec wikipedia...

