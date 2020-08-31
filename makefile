default:
	@echo "Specify what to make."

all: pages

pages:
	@./build-pages.sh

#clean: 
	# TODO: add line to remove html results of .org files, but not raw html files.
