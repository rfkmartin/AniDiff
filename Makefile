# Builds all the projects in the solution...
.PHONY: all_projects
all_projects: segmenter

# Builds project 'segmenter'...
.PHONY: segmenter
segmenter:
	make --directory="AniDiff/" --file=anidiff.makefile

# Cleans all projects...
.PHONY: clean
clean:
	make --directory="AniDiff/" --file=anidiff.makefile clean

