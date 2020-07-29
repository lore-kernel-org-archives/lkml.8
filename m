Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC720838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014405;
	bh=5r90F8JZfGpdF2bkCF7czpr1bpYuEIIOZXTUjQJWem0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Osp6hydjqeglrGDvBqI8xqabU3mdNRH8lhTV+qCJjEFsnyCAc/nxK4blaaGSHTQ9E
	 IknjkiRxLTh3mz3MHsfIN5BBCKtfP5gk8ktugqhgY+45jtcmBG3CvJIz0xOY4hXfYc
	 G5qwuvGjGaIC5psBoq+kL5/Kry2is68WMNKNMGmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgG2JUD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728195AbgG2JUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-xvuXeaEeOY-viX09FWe1qg-1; Wed, 29 Jul 2020 05:19:54 -0400
X-MC-Unique: xvuXeaEeOY-viX09FWe1qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 396898017FB;
        Wed, 29 Jul 2020 09:19:52 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A060B6931E;
        Wed, 29 Jul 2020 09:19:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/19] perf metric: Add referenced metrics to hash data
Date:   Wed, 29 Jul 2020 11:18:59 +0200
Message-Id: <20200729091908.1378911-11-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding referenced metrics to the parsing context so they can be resolved
during the metric processing.

Adding expr__add_ref function to store referenced metrics into parse
context.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c        | 54 +++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        | 13 ++++++++-
 tools/perf/util/stat-shadow.c | 20 +++++++++----
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index f726211f49d4..d3997c2b4a90 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -4,10 +4,14 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include "metricgroup.h"
+#include "debug.h"
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <ctype.h>
 
 #ifdef PARSER_DEBUG
 extern int expr_debug;
@@ -63,6 +67,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	if (!data_ptr)
 		return -ENOMEM;
 	data_ptr->val = val;
+	data_ptr->is_ref = false;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -73,6 +78,55 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	return ret;
 }
 
+int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
+{
+	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	char *name, *p;
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
+	/*
+	 * The jevents tool converts all metric expressions
+	 * to lowercase, including metric references, hence
+	 * we need to add lowercase name for metric, so it's
+	 * properly found.
+	 */
+	for (p = name; *p; p++)
+		*p = tolower(*p);
+
+	/*
+	 * Intentionally passing just const char pointers,
+	 * originally from 'struct pmu_event' object.
+	 * We don't need to change them, so there's no
+	 * need to create our own copy.
+	 */
+	data_ptr->ref.metric_name = ref->metric_name;
+	data_ptr->ref.metric_expr = ref->metric_expr;
+	data_ptr->is_ref = true;
+
+	ret = hashmap__set(&ctx->ids, name, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+	if (ret)
+		free(data_ptr);
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
index 2462abd0ac65..81d04ff7f857 100644
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
+	union {
+		double val;
+		struct {
+			const char *metric_name;
+			const char *metric_expr;
+		} ref;
+	};
+
+	bool is_ref;
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

