Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5AFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126D420725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560452;
	bh=2+ohYgozHWL/cC5j+D8gf2ckE87ajlNCG7ijma+QwDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEiC5AaC3W88s7JUYKGJJDiE7EXnbdwidd4IjZ7bfwxQ4nERyhPeOAHMC0tjlZibA
	 3Ex0EJ0N//1Wbjj0prWYdFcxtN8QpFWzvb3F/J/5vNdmx9WgeBClIvAoW+H3My/ClH
	 2++WkG+8IAdxeZWtdMcV4B/Hs1IQABcgLetGB5fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgGLN1a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58867 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728987AbgGLN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-ZovG8pRXOBChv8rH7BBKQQ-1; Sun, 12 Jul 2020 09:27:17 -0400
X-MC-Unique: ZovG8pRXOBChv8rH7BBKQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CF08005B0;
        Sun, 12 Jul 2020 13:27:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1421944D;
        Sun, 12 Jul 2020 13:27:12 +0000 (UTC)
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
Subject: [PATCH 11/18] perf metric: Add referenced metrics to hash data
Date:   Sun, 12 Jul 2020 15:26:27 +0200
Message-Id: <20200712132634.138901-12-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding referenced metrics to the parsing context so they
can be resolved during the metric processing.

Adding expr__add_ref function to store referenced metrics
into parse context.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c        | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        | 13 ++++++++++++-
 tools/perf/util/stat-shadow.c | 20 ++++++++++++++------
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 91142d4c3419..6bf8a21f5c53 100644
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
@@ -61,6 +63,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	if (!data_ptr)
 		return -ENOMEM;
 	data_ptr->val = val;
+	data_ptr->is_ref = false;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -69,6 +72,38 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	return ret;
 }
 
+int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
+{
+	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	char *name;
+	int ret;
+
+	data_ptr = zalloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+
+	name = strdup(ref->metric_name);
+	if (!name) {
+		free(data_ptr);
+		return -ENOMEM;
+	}
+
+	data_ptr->ref.metric_name = ref->metric_name;
+	data_ptr->ref.metric_expr = ref->metric_expr;
+	data_ptr->is_ref = true;
+
+	ret = hashmap__set(&ctx->ids, name, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+
+	pr_debug2("adding ref metric %s: %s\n",
+		  ref->metric_name, ref->metric_expr);
+
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data)
 {
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 2462abd0ac65..d19e66915228 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -11,12 +11,22 @@
 #include "util/hashmap.h"
 //#endif
 
+struct metric_ref;
+
 struct expr_parse_ctx {
 	struct hashmap ids;
 };
 
 struct expr_id_data {
-	double	val;
+	bool	is_ref;
+
+	union {
+		double	val;
+		struct {
+			const char *metric_name;
+			const char *metric_expr;
+		} ref;
+	};
 };
 
 struct expr_scanner_ctx {
@@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
+int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index fc9ac4b4218e..e1ba6c1b916a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
 }
 
 static int prepare_metric(struct evsel **metric_events,
+			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
 			  int cpu,
 			  struct runtime_stat *st)
 {
 	double scale;
 	char *n, *pn;
-	int i;
+	int i, j, ret;
 
 	expr__ctx_init(pctx);
 	for (i = 0; metric_events[i]; i++) {
@@ -778,12 +779,19 @@ static int prepare_metric(struct evsel **metric_events,
 			expr__add_id_val(pctx, n, avg_stats(stats)*scale);
 	}
 
+	for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
+		ret = expr__add_ref(pctx, &metric_refs[j]);
+		if (ret)
+			return ret;
+	}
+
 	return i;
 }
 
 static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_expr,
 			   struct evsel **metric_events,
+			   struct metric_ref *metric_refs,
 			   char *name,
 			   const char *metric_name,
 			   const char *metric_unit,
@@ -798,7 +806,7 @@ static void generic_metric(struct perf_stat_config *config,
 	int i;
 	void *ctxp = out->ctx;
 
-	i = prepare_metric(metric_events, &pctx, cpu, st);
+	i = prepare_metric(metric_events, metric_refs, &pctx, cpu, st);
 	if (i < 0)
 		return;
 
@@ -847,7 +855,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	struct expr_parse_ctx pctx;
 	double ratio;
 
-	if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
+	if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
 		return 0.;
 
 	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
@@ -1064,8 +1072,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
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
@@ -1093,7 +1101,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			if (num++ > 0)
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
-					evsel->name, mexp->metric_name,
+					mexp->metric_refs, evsel->name, mexp->metric_name,
 					mexp->metric_unit, mexp->runtime, cpu, out, st);
 		}
 	}
-- 
2.25.4

