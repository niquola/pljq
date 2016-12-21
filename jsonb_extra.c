#include "postgres.h"
#include <string.h>
#include "fmgr.h"
#include "funcapi.h"
#include "utils/array.h"
#include "catalog/pg_type.h"

#include "Jq.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

#include "utils/jsonb.h"
#include "utils/builtins.h"

PG_FUNCTION_INFO_V1(jq);

Datum
jq(PG_FUNCTION_ARGS) {

	text *arg1 = PG_GETARG_TEXT_P(0);
	text *arg2 = PG_GETARG_TEXT_P(1);

	const char* program = text_to_cstring(arg1);

	jq_state *jq = jq_init();
	if (jq == NULL) {
		elog(DEBUG1, "Error while jq_init");
		PG_RETURN_NULL();
	}

	int compiled = jq_compile(jq, program);
	if(compiled){
		/* char buf[500]; */
		//char *input_str = "{\"a\":{\"b\": {\"c\": true}}}";
		char *input_str = text_to_cstring(arg2); //"{\"a\":{\"b\": {\"c\": true}}}";
		/* strcpy(buf, input_str); */
		elog(INFO, "inp size %d", sizeof(input_str));
		jv input = jv_parse(input_str);

		if (!jv_is_valid(input)) {
			elog(INFO, "JQ input is invalide %s", input_str);
			PG_RETURN_NULL();
		}

		jq_start(jq, input, 0);
		jv result;

		if (jv_is_valid(result = jq_next(jq))) {
			jv dumped = jv_dump_string(result, 0);
			const char *res_str = jv_string_value(dumped);
			jq_teardown(&jq);
			PG_RETURN_TEXT_P(cstring_to_text(res_str));
		}
	} else {
		elog(INFO, "not compiled %s", program);
		PG_RETURN_NULL();
	}
}
