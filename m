Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA874C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB1220752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589230404;
	bh=VE4A4IcBgmeXk1J0dWBAiJZ4XR3tdCDYZ+YaBJG186E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOQrrEA7xXx97eVc/Y5SDXrSg7ZrGF6QNbwIzHzxNOviYtYg8XHKIVlmARDqpZ/cd
	 gPcMnW7xc/C5N7xGyIg45Sae9m3IlpATZ5O8qV+00I0OGIOG5YMW1vznTCytTbz8OL
	 INQvnQRi++Di/6Y1vuzQ5PLjWci058ldm+Cs7Bj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgEKUxY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:53:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729846AbgEKUxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:53:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-lycg6VWtMz-qTVrDzdVN8g-1; Mon, 11 May 2020 16:53:16 -0400
X-MC-Unique: lycg6VWtMz-qTVrDzdVN8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAC788005B7;
        Mon, 11 May 2020 20:53:14 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214306444B;
        Mon, 11 May 2020 20:53:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/4] perf expr: Add parsing support for multiple expressions
Date:   Mon, 11 May 2020 22:53:04 +0200
Message-Id: <20200511205307.3107775-2-jolsa@kernel.org>
In-Reply-To: <20200511205307.3107775-1-jolsa@kernel.org>
References: <20200511205307.3107775-1-jolsa@kernel.org>
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

Adding support to parse metric difinitions in following form:

  NAME = EXPRESSION ;
  NAME = EXPRESSION ;
  ...

The parsed NAME and EXPRESSION will be used in following
changes to feed the metric code with definitions from
custom file.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 tools/perf/util/expr.c  |  6 ++++++
 tools/perf/util/expr.h  | 19 +++++++++++++++++--
 tools/perf/util/expr.l  | 12 ++++++++++++
 tools/perf/util/expr.y  | 13 ++++++++++++-
 5 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index f9e8e5628836..c62e122fe719 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -71,5 +71,18 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 		zfree(&other[i]);
 	free((void *)other);
 
+	expr__ctx_init(&ctx);
+	ret = expr__parse_custom(&ctx, "IPC=INSTRUCTIONS / CYCLES; CPI=CYCLES / INSTRUCTIONS;");
+	TEST_ASSERT_VAL("parse custom failed", ret == 0);
+	TEST_ASSERT_VAL("parse custom count", ctx.num_custom == 2);
+	TEST_ASSERT_VAL("parse custom name", !strcmp(ctx.custom[0].name, "IPC"));
+	TEST_ASSERT_VAL("parse custom name", !strcmp(ctx.custom[1].name, "CPI"));
+	TEST_ASSERT_VAL("parse custom expr", !strcmp(ctx.custom[0].expr, "INSTRUCTIONS / CYCLES"));
+	TEST_ASSERT_VAL("parse custom expr", !strcmp(ctx.custom[1].expr, "CYCLES / INSTRUCTIONS"));
+
+	for (i = 0; i < ctx.num_custom; i++) {
+		zfree(&ctx.custom[i].name);
+		zfree(&ctx.custom[i].expr);
+	}
 	return 0;
 }
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 8b4ce704a68d..d744cb15c1d4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -23,6 +23,7 @@ void expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
 void expr__ctx_init(struct expr_parse_ctx *ctx)
 {
 	ctx->num_ids = 0;
+	ctx->num_custom = 0;
 }
 
 static int
@@ -61,6 +62,11 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr,
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
+int expr__parse_custom(struct expr_parse_ctx *ctx, const char *expr)
+{
+	return __expr__parse(NULL, ctx, expr, EXPR_CUSTOM, 0);
+}
+
 static bool
 already_seen(const char *val, const char *one, const char **other,
 	     int num_other)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 40fc452b0f2b..ef116b58a5d4 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -4,15 +4,29 @@
 
 #define EXPR_MAX_OTHER 64
 #define MAX_PARSE_ID EXPR_MAX_OTHER
+#define EXPR_MAX 20
 
 struct expr_parse_id {
 	const char *name;
 	double val;
 };
 
+struct expr_parse_custom {
+	const char *name;
+	const char *expr;
+};
+
 struct expr_parse_ctx {
-	int num_ids;
-	struct expr_parse_id ids[MAX_PARSE_ID];
+	union {
+		struct {
+			int			 num_ids;
+			struct expr_parse_id	 ids[MAX_PARSE_ID];
+		};
+		struct {
+			int			 num_custom;
+			struct expr_parse_custom custom[EXPR_MAX];
+		};
+	};
 };
 
 struct expr_scanner_ctx {
@@ -23,6 +37,7 @@ struct expr_scanner_ctx {
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime);
+int expr__parse_custom(struct expr_parse_ctx *ctx, const char *expr);
 int expr__find_other(const char *expr, const char *one, const char ***other,
 		int *num_other, int runtime);
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index ceab11bea6f9..c6a930ed22e6 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -81,12 +81,15 @@ static int str(yyscan_t scanner, int token, int runtime)
 }
 %}
 
+%x custom
+
 number		[0-9]*\.?[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@?]+
 symbol		({spec}|{sym})+
+all		[^;]+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
@@ -100,6 +103,12 @@ symbol		({spec}|{sym})+
 		}
 	}
 
+<custom>{
+
+{all}		{ BEGIN(INITIAL); return str(yyscanner, ALL, sctx->runtime); }
+
+}
+
 max		{ return MAX; }
 min		{ return MIN; }
 if		{ return IF; }
@@ -118,6 +127,9 @@ else		{ return ELSE; }
 "("		{ return '('; }
 ")"		{ return ')'; }
 ","		{ return ','; }
+";"		{ return ';'; }
+"="		{ BEGIN(custom); return '='; }
+\n		{ }
 .		{ }
 %%
 
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 21e82a1e11a2..0521e48fa5e3 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -24,9 +24,10 @@
 	char	*str;
 }
 
-%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
+%token EXPR_PARSE EXPR_OTHER EXPR_CUSTOM EXPR_ERROR
 %token <num> NUMBER
 %token <str> ID
+%token <str> ALL
 %token MIN MAX IF ELSE SMT_ON
 %left MIN MAX IF
 %left '|'
@@ -66,6 +67,16 @@ start:
 EXPR_PARSE all_expr
 |
 EXPR_OTHER all_other
+|
+EXPR_CUSTOM all_custom
+
+all_custom: all_custom ID '=' ALL ';'
+{
+	ctx->custom[ctx->num_custom].name = $2;
+	ctx->custom[ctx->num_custom].expr = $4;
+	ctx->num_custom++;
+}
+|
 
 all_other: all_other other
 |
-- 
2.25.4

