Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55811206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200890;
	bh=tlCGKoAIPqmmXpauQddxDdZmu/rhSciYyZdDifiRQK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivZlnzZjj4scvjxEE24zaaJSOdizty7cQKMclnamSiClVo9LzcIpcPN/+M5+40lyW
	 W92OoWSx6Wa91T6Iitqf9adcGHsPtJIVelYuPzxmIMuX9huTHtfkHm2WEFKIVqge2h
	 I5Xki/zo39AjSSQyX6hx9TV+ramy7DIa9ULjeWdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgFZTsJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:48:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbgFZTsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:48:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-c0lJVL7mPhWGGrvTk4UyZA-1; Fri, 26 Jun 2020 15:47:57 -0400
X-MC-Unique: c0lJVL7mPhWGGrvTk4UyZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DE1107BEF6;
        Fri, 26 Jun 2020 19:47:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B103C5BAD2;
        Fri, 26 Jun 2020 19:47:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 08/10] perf tools: Add other metrics to hash data
Date:   Fri, 26 Jun 2020 21:47:18 +0200
Message-Id: <20200626194720.2915044-9-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding other metrics to the parsing context so they
can be resolved during the metric processing.

Adding expr__add_other function to store 'other' metrics
into parse context.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c        | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        | 13 ++++++++++++-
 tools/perf/util/stat-shadow.c | 19 +++++++++++++------
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index cd73dae4588c..32f7acac7c19 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -4,6 +4,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include "metricgroup.h"
+#include "debug.h"
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
@@ -61,6 +63,7 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
 	if (!data_ptr)
 		return -ENOMEM;
 	data_ptr->val = val;
+	data_ptr->is_other = false;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -69,6 +72,38 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
 	return ret;
 }
 
+int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other)
+{
+	struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	char *name;
+	int ret;
+
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+
+	name = strdup(other->metric_name);
+	if (!name) {
+		free(data_ptr);
+		return -ENOMEM;
+	}
+
+	data_ptr->other.metric_name = other->metric_name;
+	data_ptr->other.metric_expr = other->metric_expr;
+	data_ptr->is_other = true;
+
+	ret = hashmap__set(&ctx->ids, name, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+
+	pr_debug2("adding other metric %s: %s\n",
+		  other->metric_name, other->metric_expr);
+
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_parse_data **data)
 {
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index fd924bb4e5cd..ed60f9227b43 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -11,12 +11,22 @@
 #include "util/hashmap.h"
 //#endif
 
+struct metric_other;
+
 struct expr_parse_ctx {
 	struct hashmap ids;
 };
 
 struct expr_parse_data {
-	double	val;
+	bool	is_other;
+
+	union {
+		double	val;
+		struct {
+			const char *metric_name;
+			const char *metric_expr;
+		} other;
+	};
 };
 
 struct expr_scanner_ctx {
@@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
 int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
+int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_parse_data **data);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0a991016f848..434382410170 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
 }
 
 static int prepare_metric(struct evsel **metric_events,
+			  struct metric_other *metric_other,
 			  struct expr_parse_ctx *pctx,
 			  int cpu,
 			  struct runtime_stat *st)
 {
 	double scale;
 	char *n, *pn;
-	int i;
+	int i, j;
 
 	expr__ctx_init(pctx);
 	for (i = 0; metric_events[i]; i++) {
@@ -778,12 +779,18 @@ static int prepare_metric(struct evsel **metric_events,
 			expr__add_val(pctx, n, avg_stats(stats)*scale);
 	}
 
+	for (j = 0; metric_other && metric_other[j].metric_name; j++) {
+		if (expr__add_other(pctx, &metric_other[j]))
+			return -ENOMEM;
+	}
+
 	return i;
 }
 
 static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_expr,
 			   struct evsel **metric_events,
+			   struct metric_other *metric_other,
 			   char *name,
 			   const char *metric_name,
 			   const char *metric_unit,
@@ -798,7 +805,7 @@ static void generic_metric(struct perf_stat_config *config,
 	int i;
 	void *ctxp = out->ctx;
 
-	i = prepare_metric(metric_events, &pctx, cpu, st);
+	i = prepare_metric(metric_events, metric_other, &pctx, cpu, st);
 	if (i < 0)
 		return;
 
@@ -847,7 +854,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	struct expr_parse_ctx pctx;
 	double ratio;
 
-	if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
+	if (prepare_metric(mexp->metric_events, mexp->metric_other, &pctx, cpu, st) < 0)
 		return 0.;
 
 	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
@@ -1064,8 +1071,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
-		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
-				evsel->metric_name, NULL, 1, cpu, out, st);
+		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
+				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
@@ -1093,7 +1100,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			if (num++ > 0)
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
-					evsel->name, mexp->metric_name,
+					mexp->metric_other, evsel->name, mexp->metric_name,
 					mexp->metric_unit, mexp->runtime, cpu, out, st);
 		}
 	}
-- 
2.25.4

