all: release

APP="ex_aliyun_fc"
ERL_VERSION="23"
ERTS_VERSION="11.1.3"

.PHONY: release deploy

rel/erlang:
	docker pull erlang:$(ERL_VERSION)-slim && \
	CONTAINER_ID=`docker run -d erlang:$(ERL_VERSION)-slim /bin/sh -c "while true; do echo hello world; sleep 1; done"` && \
	cd rel && \
	docker cp $$CONTAINER_ID:/usr/local/lib/erlang/ . && \
	docker cp $$CONTAINER_ID:/lib/x86_64-linux-gnu/libtinfo.so.6.1 libtinfo.so.6 && \
	docker kill $$CONTAINER_ID && \
	docker rm $$CONTAINER_ID

release: rel/erlang rel/libtinfo.so.6
	MIX_ENV=prod mix release --overwrite --force
	cp rel/bootstrap _build/prod/rel/$(APP)/
	cp rel/libtinfo.so.6 _build/prod/rel/$(APP)/
	cd _build/prod/rel/$(APP)/ && \
	chmod a+x releases/0.1.0/env.sh && \
	chmod a+x releases/0.1.0/elixir && \
	chmod a+x releases/0.1.0/iex && \
	chmod a+x erts-$(ERTS_VERSION)/bin/epmd && \
	chmod a+x erts-$(ERTS_VERSION)/bin/erl && \
	chmod a+x bin/$(APP)

deploy: release
	fun deploy -y
