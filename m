Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EDC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E682073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582327202;
	bh=MvEZKc67MFlfzq/oFzvceI7i1SBysJz2LHxhUnt9e+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1avyeLRlygryNY9Q6L5xuUseoJ3gMJQ9tO3S6U+HDV4jkZZR8MXJ6iF+EtjjUfLv7
	 ozvva7Pl5Wj4mhsJ4yPaNn4qJKhL36tRZIFOlwnJHZP5lsIHoe3V0mwJskxynpNof1
	 xurqXGdOA6lwUa9KMy+u7kSqyDfSgaN/qFOnLp6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgBUXUA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:20:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgBUXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:20:00 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ZeRKiasUNFG_zyIbqN5ofg-1; Fri, 21 Feb 2020 18:19:51 -0500
X-MC-Unique: ZeRKiasUNFG_zyIbqN5ofg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC0413F5;
        Fri, 21 Feb 2020 23:19:49 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1938B57E;
        Fri, 21 Feb 2020 23:19:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/4] perf expr: Move expr lexer to flex
Date:   Sat, 22 Feb 2020 00:19:33 +0100
Message-Id: <20200221231935.735145-3-jolsa@kernel.org>
In-Reply-To: <20200221231935.735145-1-jolsa@kernel.org>
References: <20200221231935.735145-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding expr flex code instead of the manual parser
code. So it's easily extensible in upcoming changes.

The new flex code is in flex.l object and gets compiled
like all the other flexers we use.  It's defined as flex
reentrant parser.

It's used by both expr__parse and expr__find_other
interfaces by separating the starting point.

There's no intended change of functionality ;-) the
test expr is passing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/Build  |  10 ++-
 tools/perf/util/expr.c |  91 ++++++++++++++++++++++
 tools/perf/util/expr.h |   2 -
 tools/perf/util/expr.l |  83 ++++++++++++++++++++
 tools/perf/util/expr.y | 169 ++++++++---------------------------------
 5 files changed, 214 insertions(+), 141 deletions(-)
 create mode 100644 tools/perf/util/expr.l

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 6fdf073093a6..c0cf8dff694e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -121,6 +121,7 @@ perf-y += mem-events.o
 perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
+perf-y += expr-flex.o
 perf-y += expr-bison.o
 perf-y += expr.o
 perf-y += branch.o
@@ -190,9 +191,13 @@ $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
 
+$(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
+
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr__
+	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
@@ -204,12 +209,14 @@ $(OUTPUT)util/pmu-bison.c: util/pmu.y
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
+CFLAGS_expr-flex.o          += -w
 CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
 CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
+$(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
@@ -217,6 +224,7 @@ CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_parse-events.o  += -Wno-redundant-decls
+CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 
 $(OUTPUT)util/kallsyms.o: ../lib/symbol/kallsyms.c FORCE
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4a82ff3bdbcc..b15cfa7ba694 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <assert.h>
 #include "expr.h"
+#include "expr-bison.h"
+#define YY_EXTRA_TYPE int
+#include "expr-flex.h"
+
+#ifdef PARSER_DEBUG
+extern int expr_debug;
+#endif
 
 /* Caller must make sure id is allocated */
 void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
@@ -18,3 +26,86 @@ void expr__ctx_init(struct parse_ctx *ctx)
 	ctx->num_ids = 0;
 }
 
+static int
+__expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
+	      int start)
+{
+	YY_BUFFER_STATE buffer;
+	void *scanner;
+	int ret;
+
+	ret = expr_lex_init_extra(start, &scanner);
+	if (ret)
+		return ret;
+
+	buffer = expr__scan_string(expr, scanner);
+
+#ifdef PARSER_DEBUG
+	expr_debug = 1;
+#endif
+
+	ret = expr_parse(val, ctx, scanner);
+
+	expr__flush_buffer(buffer, scanner);
+	expr__delete_buffer(buffer, scanner);
+	expr_lex_destroy(scanner);
+	return ret;
+}
+
+int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp)
+{
+	return __expr__parse(final_val, ctx, *pp, EXPR_PARSE);
+}
+
+static bool
+already_seen(const char *val, const char *one, const char **other,
+	     int num_other)
+{
+	int i;
+
+	if (one && !strcasecmp(one, val))
+		return true;
+	for (i = 0; i < num_other; i++)
+		if (!strcasecmp(other[i], val))
+			return true;
+	return false;
+}
+
+int expr__find_other(const char *p, const char *one, const char ***other,
+		     int *num_other)
+{
+	int err, i = 0, j = 0;
+	struct parse_ctx ctx;
+
+	expr__ctx_init(&ctx);
+	err = __expr__parse(NULL, &ctx, p, EXPR_OTHER);
+	if (err)
+		return err;
+
+	*other = malloc((ctx.num_ids + 1) * sizeof(char *));
+	if (!*other)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < ctx.num_ids; i++) {
+		const char *str = ctx.ids[i].name;
+
+		if (already_seen(str, one, *other, j))
+			continue;
+
+		str = strdup(str);
+		if (!str)
+			goto out;
+		(*other)[j++] = str;
+	}
+	(*other)[j] = NULL;
+
+out:
+	if (i != ctx.num_ids) {
+		while (--j)
+			free((char *) (*other)[i]);
+		free(*other);
+	}
+
+	*num_other = j;
+	return err;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 046160831f90..9332796e6649 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -17,9 +17,7 @@ struct parse_ctx {
 
 void expr__ctx_init(struct parse_ctx *ctx);
 void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
-#ifndef IN_EXPR_Y
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char **pp);
-#endif
 int expr__find_other(const char *p, const char *one, const char ***other,
 		int *num_other);
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
new file mode 100644
index 000000000000..fd50116c9277
--- /dev/null
+++ b/tools/perf/util/expr.l
@@ -0,0 +1,83 @@
+%option prefix="expr_"
+%option reentrant
+%option bison-bridge
+
+%{
+#include <linux/compiler.h>
+#include "expr.h"
+#include "expr-bison.h"
+
+char *expr_get_text(yyscan_t yyscanner);
+YYSTYPE *expr_get_lval(yyscan_t yyscanner);
+
+static int __value(YYSTYPE *yylval, char *str, int base, int token)
+{
+	u64 num;
+
+	errno = 0;
+	num = strtoull(str, NULL, base);
+	if (errno)
+		return EXPR_ERROR;
+
+	yylval->num = num;
+	return token;
+}
+
+static int value(yyscan_t scanner, int base)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+	char *text = expr_get_text(scanner);
+
+	return __value(yylval, text, base, NUMBER);
+}
+
+static int str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = expr_get_lval(scanner);
+	char *text = expr_get_text(scanner);
+
+	yylval->str = strdup(text);
+	return token;
+}
+%}
+
+number		[0-9]+
+symbol		[0-9a-zA-Z_\.:@\\]+
+
+%%
+	{
+		int start_token;
+
+		start_token = parse_events_get_extra(yyscanner);
+
+		if (start_token) {
+			parse_events_set_extra(NULL, yyscanner);
+			return start_token;
+		}
+	}
+
+max		{ return MAX; }
+min		{ return MIN; }
+if		{ return IF; }
+else		{ return ELSE; }
+#smt_on		{ return SMT_ON; }
+{number}	{ return value(yyscanner, 10); }
+{symbol}	{ return str(yyscanner, ID); }
+"|"		{ return '|'; }
+"^"		{ return '^'; }
+"&"		{ return '&'; }
+"-"		{ return '-'; }
+"+"		{ return '+'; }
+"*"		{ return '*'; }
+"/"		{ return '/'; }
+"%"		{ return '%'; }
+"("		{ return '('; }
+")"		{ return ')'; }
+","		{ return ','; }
+.		{ }
+%%
+
+int expr_wrap(void *scanner __maybe_unused)
+{
+	return 1;
+}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7cea8b7c3a5c..35c3e9b318f0 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,5 +1,7 @@
 /* Simple expression parser */
 %{
+#define YYDEBUG 1
+
 #include "util.h"
 #include "util/debug.h"
 #include <stdlib.h> // strtod()
@@ -8,23 +10,23 @@
 #include "smt.h"
 #include <string.h>
 
-#define MAXIDLEN 256
 %}
 
 %define api.pure full
 
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
-%parse-param { const char **pp }
-%lex-param { const char **pp }
+%parse-param {void *scanner}
+%lex-param {void* scanner}
 
 %union {
-	double num;
-	char id[MAXIDLEN+1];
+	double	 num;
+	char	*str;
 }
 
+%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
 %token <num> NUMBER
-%token <id> ID
+%token <str> ID
 %token MIN MAX IF ELSE SMT_ON
 %left MIN MAX IF
 %left '|'
@@ -36,11 +38,9 @@
 %type <num> expr if_expr
 
 %{
-static int expr__lex(YYSTYPE *res, const char **pp);
-
-static void expr__error(double *final_val __maybe_unused,
+static void expr_error(double *final_val __maybe_unused,
 		       struct parse_ctx *ctx __maybe_unused,
-		       const char **pp __maybe_unused,
+		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
@@ -62,6 +62,27 @@ static int lookup_id(struct parse_ctx *ctx, char *id, double *val)
 %}
 %%
 
+start:
+EXPR_PARSE all_expr
+|
+EXPR_OTHER all_other
+
+all_other: all_other other
+|
+
+other: ID
+{
+	if (ctx->num_ids + 1 >= EXPR_MAX_OTHER) {
+		pr_err("failed: way too many variables");
+		YYABORT;
+	}
+
+	ctx->ids[ctx->num_ids++].name = $1;
+}
+|
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+
+
 all_expr: if_expr			{ *final_val = $1; }
 	;
 
@@ -92,131 +113,3 @@ expr:	  NUMBER
 	;
 
 %%
-
-static int expr__symbol(YYSTYPE *res, const char *p, const char **pp)
-{
-	char *dst = res->id;
-	const char *s = p;
-
-	if (*p == '#')
-		*dst++ = *p++;
-
-	while (isalnum(*p) || *p == '_' || *p == '.' || *p == ':' || *p == '@' || *p == '\\') {
-		if (p - s >= MAXIDLEN)
-			return -1;
-		/*
-		 * Allow @ instead of / to be able to specify pmu/event/ without
-		 * conflicts with normal division.
-		 */
-		if (*p == '@')
-			*dst++ = '/';
-		else if (*p == '\\')
-			*dst++ = *++p;
-		else
-			*dst++ = *p;
-		p++;
-	}
-	*dst = 0;
-	*pp = p;
-	dst = res->id;
-	switch (dst[0]) {
-	case 'm':
-		if (!strcmp(dst, "min"))
-			return MIN;
-		if (!strcmp(dst, "max"))
-			return MAX;
-		break;
-	case 'i':
-		if (!strcmp(dst, "if"))
-			return IF;
-		break;
-	case 'e':
-		if (!strcmp(dst, "else"))
-			return ELSE;
-		break;
-	case '#':
-		if (!strcasecmp(dst, "#smt_on"))
-			return SMT_ON;
-		break;
-	}
-	return ID;
-}
-
-static int expr__lex(YYSTYPE *res, const char **pp)
-{
-	int tok;
-	const char *s;
-	const char *p = *pp;
-
-	while (isspace(*p))
-		p++;
-	s = p;
-	switch (*p++) {
-	case '#':
-	case 'a' ... 'z':
-	case 'A' ... 'Z':
-		return expr__symbol(res, p - 1, pp);
-	case '0' ... '9': case '.':
-		res->num = strtod(s, (char **)&p);
-		tok = NUMBER;
-		break;
-	default:
-		tok = *s;
-		break;
-	}
-	*pp = p;
-	return tok;
-}
-
-static bool already_seen(const char *val, const char *one, const char **other,
-			 int num_other)
-{
-	int i;
-
-	if (one && !strcasecmp(one, val))
-		return true;
-	for (i = 0; i < num_other; i++)
-		if (!strcasecmp(other[i], val))
-			return true;
-	return false;
-}
-
-int expr__find_other(const char *p, const char *one, const char ***other,
-		     int *num_otherp)
-{
-	const char *orig = p;
-	int err = -1;
-	int num_other;
-
-	*other = malloc((EXPR_MAX_OTHER + 1) * sizeof(char *));
-	if (!*other)
-		return -1;
-
-	num_other = 0;
-	for (;;) {
-		YYSTYPE val;
-		int tok = expr__lex(&val, &p);
-		if (tok == 0) {
-			err = 0;
-			break;
-		}
-		if (tok == ID && !already_seen(val.id, one, *other, num_other)) {
-			if (num_other >= EXPR_MAX_OTHER - 1) {
-				pr_debug("Too many extra events in %s\n", orig);
-				break;
-			}
-			(*other)[num_other] = strdup(val.id);
-			if (!(*other)[num_other])
-				return -1;
-			num_other++;
-		}
-	}
-	(*other)[num_other] = NULL;
-	*num_otherp = num_other;
-	if (err) {
-		*num_otherp = 0;
-		free(*other);
-		*other = NULL;
-	}
-	return err;
-}
-- 
2.24.1

