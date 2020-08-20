Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B636C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCAC208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgHTQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:49:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:14315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbgHTQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:48:27 -0400
IronPort-SDR: /0K1SpkkIcnIg96np9udQIa5QsKdaWtUV+KECp2iItNVnNgcPxzjQJiM6Q9+sgYYw/4xkiUr83
 nGTwXd3hR6GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="155325458"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="155325458"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 09:48:26 -0700
IronPort-SDR: QHFpUwRO4vzDFp3GLhHX4VW7siyiHAA54+hnpyk4qHSJR/5wWCAPwy81icrHyqMj1skZtJ85nc
 D1QxTqmsV7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="442049141"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2020 09:48:26 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf stat: Support new per thread TopDown metrics
Date:   Thu, 20 Aug 2020 09:45:31 -0700
Message-Id: <20200820164532.8011-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820164532.8011-1-kan.liang@linux.intel.com>
References: <20200820164532.8011-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Icelake has support for reporting per thread TopDown metrics.
These are reported differently than the previous TopDown support,
each metric is standalone, but scaled to pipeline "slots".
We don't need to do anything special for HyperThreading anymore.
Teach perf stat --topdown to handle these new metrics and
print them in the same way as the previous TopDown metrics.
The restrictions of only being able to report information per core is
gone.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  7 +-
 tools/perf/builtin-stat.c              | 30 ++++++++-
 tools/perf/util/stat-shadow.c          | 89 ++++++++++++++++++++++++++
 tools/perf/util/stat.c                 |  4 ++
 tools/perf/util/stat.h                 |  8 +++
 5 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index c9bfefc051fb..e803dbdc88a8 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -357,6 +357,11 @@ if the workload is actually bound by the CPU and not by something else.
 For best results it is usually a good idea to use it with interval
 mode like -I 1000, as the bottleneck of workloads can change often.
 
+This enables --metric-only, unless overridden with --no-metric-only.
+
+The following restrictions only apply to older Intel CPUs and Atom,
+on newer CPUs (IceLake and later) TopDown can be collected for any thread:
+
 The top down metrics are collected per core instead of per
 CPU thread. Per core mode is automatically enabled
 and -a (global monitoring) is needed, requiring root rights or
@@ -368,8 +373,6 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
 for best results. Otherwise the bottlenecks may be inconsistent
 on workload with changing phases.
 
-This enables --metric-only, unless overridden with --no-metric-only.
-
 To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
 taskset.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5583e22ca808..6290da5bd142 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -128,6 +128,15 @@ static const char * topdown_attrs[] = {
 	NULL,
 };
 
+static const char *topdown_metric_attrs[] = {
+	"slots",
+	"topdown-retiring",
+	"topdown-bad-spec",
+	"topdown-fe-bound",
+	"topdown-be-bound",
+	NULL,
+};
+
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1691,6 +1700,24 @@ static int add_default_attributes(void)
 		char *str = NULL;
 		bool warn = false;
 
+		if (!force_metric_only)
+			stat_config.metric_only = true;
+
+		if (topdown_filter_events(topdown_metric_attrs, &str, 1) < 0) {
+			pr_err("Out of memory\n");
+			return -1;
+		}
+		if (topdown_metric_attrs[0] && str) {
+			if (!stat_config.interval && !stat_config.metric_only) {
+				fprintf(stat_config.output,
+					"Topdown accuracy may decreases when measuring long period.\n"
+					"Please print the result regularly, e.g. -I1000\n");
+			}
+			goto setup_metrics;
+		}
+
+		str = NULL;
+
 		if (stat_config.aggr_mode != AGGR_GLOBAL &&
 		    stat_config.aggr_mode != AGGR_CORE) {
 			pr_err("top down event configuration requires --per-core mode\n");
@@ -1702,8 +1729,6 @@ static int add_default_attributes(void)
 			return -1;
 		}
 
-		if (!force_metric_only)
-			stat_config.metric_only = true;
 		if (topdown_filter_events(topdown_attrs, &str,
 				arch_topdown_check_group(&warn)) < 0) {
 			pr_err("Out of memory\n");
@@ -1712,6 +1737,7 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
+setup_metrics:
 			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e1ba6c1b916a..3204084161c9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -241,6 +241,18 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
 				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
+		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
+		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
+		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
+		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
+				    ctx, cpu, count);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    ctx, cpu, count);
@@ -705,6 +717,47 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 	return sanitize_val(1.0 - sum);
 }
 
+/*
+ * Kernel reports metrics multiplied with slots. To get back
+ * the ratios we need to recreate the sum.
+ */
+
+static double td_metric_ratio(int ctx, int cpu,
+			      enum stat_type type,
+			      struct runtime_stat *stat)
+{
+	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu);
+	double d = runtime_stat_avg(stat, type, ctx, cpu);
+
+	if (sum)
+		return d / sum;
+	return 0;
+}
+
+/*
+ * ... but only if most of the values are actually available.
+ * We allow two missing.
+ */
+
+static bool full_td(int ctx, int cpu,
+		    struct runtime_stat *stat)
+{
+	int c = 0;
+
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu) > 0)
+		c++;
+	return c >= 2;
+}
+
 static void print_smi_cost(struct perf_stat_config *config,
 			   int cpu, struct evsel *evsel,
 			   struct perf_stat_output_ctx *out,
@@ -1071,6 +1124,42 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
+			full_td(ctx, cpu, st)) {
+		double retiring = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_RETIRING, st);
+
+		if (retiring > 0.7)
+			color = PERF_COLOR_GREEN;
+		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
+				retiring * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
+			full_td(ctx, cpu, st)) {
+		double fe_bound = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_FE_BOUND, st);
+
+		if (fe_bound > 0.2)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
+				fe_bound * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
+			full_td(ctx, cpu, st)) {
+		double be_bound = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_BE_BOUND, st);
+
+		if (be_bound > 0.2)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
+				be_bound * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
+			full_td(ctx, cpu, st)) {
+		double bad_spec = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_BAD_SPEC, st);
+
+		if (bad_spec > 0.1)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
+				bad_spec * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index cdb154381a87..bd0decd6d753 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -95,6 +95,10 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(TOPDOWN_SLOTS_RETIRED, topdown-slots-retired),
 	ID(TOPDOWN_FETCH_BUBBLES, topdown-fetch-bubbles),
 	ID(TOPDOWN_RECOVERY_BUBBLES, topdown-recovery-bubbles),
+	ID(TOPDOWN_RETIRING, topdown-retiring),
+	ID(TOPDOWN_BAD_SPEC, topdown-bad-spec),
+	ID(TOPDOWN_FE_BOUND, topdown-fe-bound),
+	ID(TOPDOWN_BE_BOUND, topdown-be-bound),
 	ID(SMI_NUM, msr/smi/),
 	ID(APERF, msr/aperf/),
 };
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f8778cffd941..6c944d81d726 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -28,6 +28,10 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__TOPDOWN_SLOTS_RETIRED,
 	PERF_STAT_EVSEL_ID__TOPDOWN_FETCH_BUBBLES,
 	PERF_STAT_EVSEL_ID__TOPDOWN_RECOVERY_BUBBLES,
+	PERF_STAT_EVSEL_ID__TOPDOWN_RETIRING,
+	PERF_STAT_EVSEL_ID__TOPDOWN_BAD_SPEC,
+	PERF_STAT_EVSEL_ID__TOPDOWN_FE_BOUND,
+	PERF_STAT_EVSEL_ID__TOPDOWN_BE_BOUND,
 	PERF_STAT_EVSEL_ID__SMI_NUM,
 	PERF_STAT_EVSEL_ID__APERF,
 	PERF_STAT_EVSEL_ID__MAX,
@@ -82,6 +86,10 @@ enum stat_type {
 	STAT_TOPDOWN_SLOTS_RETIRED,
 	STAT_TOPDOWN_FETCH_BUBBLES,
 	STAT_TOPDOWN_RECOVERY_BUBBLES,
+	STAT_TOPDOWN_RETIRING,
+	STAT_TOPDOWN_BAD_SPEC,
+	STAT_TOPDOWN_FE_BOUND,
+	STAT_TOPDOWN_BE_BOUND,
 	STAT_SMI_NUM,
 	STAT_APERF,
 	STAT_MAX
-- 
2.17.1

