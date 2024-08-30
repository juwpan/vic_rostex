drop:
	rails db:drop db:create db:migrate db:seed

back:
	rails db:rollback

b:
	yarn build --watch

w:
	yarn watch:css

sdrop:
	fuser -k 3000/tcp
