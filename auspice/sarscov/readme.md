tree.bat is the nextstrain/augur pipeline and metadata.tsv is the table I'm using to build https://nextstrain.org/community/babarlelephant/cov/sarscov

Be careful that not all collection dates are correct. For many sequences no metadata is provided in the litterature, for some others onset date is given,
often approximate and a bit obfusctated, so it is a bit a sudoku to assemble all these and obtain a meaningful timetree.

For the 3 lab leaks the date is left as ? then set to the correct value in set_lab_infections_dates.py, which is also setting the possible spillover branches.

In tree.bat I listed most useful pointers to re-generate this metadata.

In the alignement/tree I added a fake bat recombination sequence obtained by assembling the best match in each 500nt window, to improve confidence in the rooting of the SARS clade.