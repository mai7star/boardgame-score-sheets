dev:
	docker run -it --rm -v /Users/might/Documents/src/boardgame-score-sheets:/app -w /app -p 3333:3333 node:16-alpine yarn dev

install:
	docker run -it --rm -v /Users/might/Documents/src/boardgame-score-sheets:/app -w /app node:16-alpine yarn install
