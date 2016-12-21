# contrib/jsonb_extra/Makefile

MODULE_big = jsonb_extra

OBJS = jsonb_extra.o

EXTENSION = jsonb_extra
DATA = jsonb_extra--1.0.sql

REGRESS = jsonb_extra

SHLIB_LINK += -ljq

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/jsonb_extra
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif

# parser.o: parser.c
# parser.c: parser.y
# parser.y: bison -d -y parser.y
