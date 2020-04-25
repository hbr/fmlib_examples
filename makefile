.PHONY: gh-pages        \
	counter         \
	counter_release \
	text_reverse \
	text_reverse_release \
	simple_todo \
	simple_todo_release  \
	http_request \
	http_request_release





all_release: counter_release text_reverse_release simple_todo_release http_request_release


all: counter text_reverse simple_todo http_request

counter:
	dune build web/counter.js

counter_release:
	dune build --profile=release web/counter.js

text_reverse:
	dune build web/text_reverse.js

text_reverse_release:
	dune build --profile=release web/text_reverse.js

simple_todo:
	dune build web/simple_todo.js

simple_todo_release:
	dune build --profile=release web/simple_todo.js

http_request:
	dune build web/http_request.js

http_request_release:
	dune build --profile=release web/http_request.js

gh-pages: all_release
	cp web/*.js gh-pages/web/; cp web/*.html gh-pages/web; cp web/*.css gh-pages/web
