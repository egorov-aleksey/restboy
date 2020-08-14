PROJECT = restboy
PROJECT_DESCRIPTION = REST API on Erlang Cowboy
PROJECT_VERSION = 0.1.0

DEPS = cowboy jsx
dep_cowboy_commit = 2.8.0
dep_jsx_commit = v3.0.0

DEP_PLUGINS = cowboy

include erlang.mk
