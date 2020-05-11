Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E2C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA22205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589230414;
	bh=M/ILeG/HmhzMCW72Q1OboT4lNgd2RjH7GdMjyI/X1Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5f3s4RnpKSvmzTpHY3ftsZgI+muXXpb0829tkTlTF48fpRm9nvBolMCFxZ+f92T/
	 DtDlK07nz+GfuiKfH1ebaHTpdp8sW/GB1uAIzDMLoMWKaFzh6ep5YBViolg0MMAj+z
	 OubTdtlzn5q/6rmWtH/ofVTCWHf6bD2rM16ADEuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbgEKUxe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:53:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731712AbgEKUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:53:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-nFGSSzEuOJGXV8jNBTS-7Q-1; Mon, 11 May 2020 16:53:26 -0400
X-MC-Unique: nFGSSzEuOJGXV8jNBTS-7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B76DC835B46;
        Mon, 11 May 2020 20:53:24 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B256444B;
        Mon, 11 May 2020 20:53:21 +0000 (UTC)
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
Subject: [PATCH 4/4] perf expr: Report line number with error
Date:   Mon, 11 May 2020 22:53:07 +0200
Message-Id: <20200511205307.3107775-5-jolsa@kernel.org>
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

Display line number on when parsing custom metrics file, like:

  $ cat metrics
  // IPC
  mine1 = inst_retired.any / cpu_clk_unhalted.thread;

  krava
  $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
  failed to parse metrics file: ./metrics:4

Please note that because the grammar is flexible on new lines,
the syntax could be broken on the next 'not fitting' item and
not the first wrong word, like:

  $ cat metrics
  // IPC
  krava
  mine1 = inst_retired.any / cpu_clk_unhalted.thread;
  $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
  failed to parse metrics file: ./metrics:3

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/expr.c       |  5 +++++
 tools/perf/util/expr.h        |  2 ++
 tools/perf/util/expr.l        | 10 ++++++++++
 tools/perf/util/expr.y        |  8 +++++---
 tools/perf/util/metricgroup.c |  3 ++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index c62e122fe719..3bffcd9f8397 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -84,5 +84,10 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 		zfree(&ctx.custom[i].name);
 		zfree(&ctx.custom[i].expr);
 	}
+
+	expr__ctx_init(&ctx);
+	ret = expr__parse_custom(&ctx, "IPC=INSTRUCTIONS / CYCLES;\n error");
+	TEST_ASSERT_VAL("parse custom failed", ret != 0);
+	TEST_ASSERT_VAL("parse custom count", ctx.lineno == 2);
 	return 0;
 }
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index ef116b58a5d4..ce95dfd2ad5a 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -27,6 +27,8 @@ struct expr_parse_ctx {
 			struct expr_parse_custom custom[EXPR_MAX];
 		};
 	};
+	/* Set on error for custom metrics. */
+	int lineno;
 };
 
 struct expr_scanner_ctx {
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index e9b294ba09fc..718aac4316d7 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -1,6 +1,8 @@
 %option prefix="expr_"
 %option reentrant
 %option bison-bridge
+%option bison-locations
+%option yylineno
 
 %{
 #include <linux/compiler.h>
@@ -79,6 +81,13 @@ static int str(yyscan_t scanner, int token, int runtime)
 	yylval->str = normalize(yylval->str, runtime);
 	return token;
 }
+
+#define YY_USER_ACTION				\
+do {						\
+	yylloc->last_line = yylloc->first_line;	\
+	yylloc->first_line = yylineno;		\
+} while (0);
+
 %}
 
 %x custom
@@ -101,6 +110,7 @@ all		[^;]+
 
 		if (sctx->start_token) {
 			sctx->start_token = 0;
+			yylineno = 1;
 			return start_token;
 		}
 	}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 0521e48fa5e3..812d893bcd31 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -18,6 +18,7 @@
 %parse-param { struct expr_parse_ctx *ctx }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
+%locations
 
 %union {
 	double	 num;
@@ -39,12 +40,13 @@
 %type <num> expr if_expr
 
 %{
-static void expr_error(double *final_val __maybe_unused,
-		       struct expr_parse_ctx *ctx __maybe_unused,
+static void expr_error(YYLTYPE *loc, double *final_val __maybe_unused,
+		       struct expr_parse_ctx *ctx,
 		       void *scanner,
 		       const char *s)
 {
-	pr_debug("%s\n", s);
+	pr_debug("%s, line %d\n", s, loc->last_line);
+	ctx->lineno = loc->last_line;
 }
 
 static int lookup_id(struct expr_parse_ctx *ctx, char *id, double *val)
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 3b4d5bdb5ac6..36df43546e84 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -615,7 +615,8 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 		ret = expr__parse_custom(&ctx, buf);
 		free(buf);
 		if (ret) {
-			pr_err("failed to parse metrics file: %s\n", metrics_file);
+			pr_err("failed to parse metrics file: %s:%d\n",
+				metrics_file, ctx.lineno);
 			return -1;
 		}
 	}
-- 
2.25.4

