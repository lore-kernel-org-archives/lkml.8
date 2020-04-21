Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FCC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C0F20722
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587492849;
	bh=WdIFy6vrsum21qUjwMbqoMHjlL25lWqWkTxfnoSgYpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWjPmoNBePpB2Hxhngphw4I+60EcjG70zQkMhOQ+Fu/55vnVVMFTSVpF1aMwwP2M3
	 E38QqxHCOaE+/OaMEJ91J0/P0c6i9NmqlIXN5omRFRczymXJ5gZ50eZrPuAmq9M2JX
	 Wws5sHi0MDLx819PUWAM2iJ+7TK1TmC/n2EnN8cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgDUSOH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:14:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729083AbgDUSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:14:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-wmhDccJUPpqzac3h8w80Gg-1; Tue, 21 Apr 2020 14:13:58 -0400
X-MC-Unique: wmhDccJUPpqzac3h8w80Gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C92802568;
        Tue, 21 Apr 2020 18:13:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 861FDB3A64;
        Tue, 21 Apr 2020 18:13:53 +0000 (UTC)
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
Subject: [PATCH 3/3] perf stat: Add --metrics-file option
Date:   Tue, 21 Apr 2020 20:13:36 +0200
Message-Id: <20200421181337.988681-4-jolsa@kernel.org>
In-Reply-To: <20200421181337.988681-1-jolsa@kernel.org>
References: <20200421181337.988681-1-jolsa@kernel.org>
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

Adding --metrics-file option that allows to specify metrics
in the file.

It's now possible to define metrics in file and use them like:

  $ cat metrics
  # IPC
  mine1 = instructions / cycles;
  /* DECODED_ICACHE_UOPS% */
  mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));

  $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
  #           time       insn per cycle                mine1                mine2
       1.000536263                0.71                   0.7                 41.4
       2.002069025                0.31                   0.3                 14.1
       3.003427684                0.27                   0.3                 14.8
       4.004807132                0.25                   0.2                 12.1
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  3 ++
 tools/perf/builtin-stat.c              |  7 ++-
 tools/perf/util/metricgroup.c          | 66 +++++++++++++++++++++++---
 tools/perf/util/metricgroup.h          |  3 +-
 tools/perf/util/stat.h                 |  1 +
 5 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4d56586b2fb9..263b0d2bb835 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -264,6 +264,9 @@ For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
 See perf list output for the possble metrics and metricgroups.
 
+--metrics-file file::
+Read metrics definitions from file in addition to compiled in metrics.
+
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9207b6c45475..81c2b2f8ec53 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -841,7 +841,8 @@ static int parse_metric_groups(const struct option *opt,
 			       const char *str,
 			       int unset __maybe_unused)
 {
-	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
+	return metricgroup__parse_groups(opt, str, &stat_config.metric_events,
+					 stat_config.metrics_file);
 }
 
 static struct option stat_options[] = {
@@ -926,6 +927,8 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_STRING(0, "metrics-file", &stat_config.metrics_file, "file path",
+		   "file with metrics definitions"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
 			 "Configure all used events to run in kernel space.",
 			 PARSE_OPT_EXCLUSIVE),
@@ -1443,7 +1446,7 @@ static int add_default_attributes(void)
 			struct option opt = { .value = &evsel_list };
 
 			return metricgroup__parse_groups(&opt, "transaction",
-							 &stat_config.metric_events);
+							 &stat_config.metric_events, NULL);
 		}
 
 		if (pmu_have_event("cpu", "cycles-ct") &&
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7ad81c8177ea..99e0ef725a6f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -519,17 +519,17 @@ static int __metricgroup__add_metric(struct strbuf *events,
 }
 
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
-				   struct list_head *group_list)
+				   struct list_head *group_list,
+				   struct expr_parse_ctx *ctx)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-	struct pmu_event *pe;
 	int i, ret = -EINVAL;
 
 	if (!map)
 		return 0;
 
 	for (i = 0; ; i++) {
-		pe = &map->table[i];
+		struct pmu_event *pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
@@ -545,15 +545,56 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				break;
 		}
 	}
+
+	if (!ctx->num_custom || ret == -ENOMEM)
+		return ret;
+
+	for (i = 0; i < ctx->num_custom; i++) {
+		struct pmu_event pe = { 0 };
+
+		if (!match_metric(ctx->custom[i].name, metric))
+			continue;
+
+		pe.metric_name = strdup(ctx->custom[i].name);
+		pe.metric_expr = strdup(ctx->custom[i].expr);
+
+		if (!pe.metric_name && !pe.metric_expr)
+			return -ENOMEM;
+
+		ret = __metricgroup__add_metric(events, group_list, &pe);
+		if (ret) {
+			free((char *) pe.metric_name);
+			free((char *) pe.metric_expr);
+			break;
+		}
+	}
+
 	return ret;
 }
 
 static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
-				        struct list_head *group_list)
+					struct list_head *group_list,
+					const char *metrics_file)
 {
+	struct expr_parse_ctx ctx = { 0 };
 	char *llist, *nlist, *p;
 	int ret = -EINVAL;
 
+	if (metrics_file) {
+		size_t size;
+		char *buf;
+
+		if (filename__read_str(metrics_file, &buf, &size)) {
+			pr_err("failed to read metrics file: %s\n", metrics_file);
+			return -1;
+		}
+
+		expr__ctx_init(&ctx);
+		expr__parse_custom(&ctx, buf);
+
+		free(buf);
+	}
+
 	nlist = strdup(list);
 	if (!nlist)
 		return -ENOMEM;
@@ -563,7 +604,7 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 	strbuf_addf(events, "%s", "");
 
 	while ((p = strsep(&llist, ",")) != NULL) {
-		ret = metricgroup__add_metric(p, events, group_list);
+		ret = metricgroup__add_metric(p, events, group_list, &ctx);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -575,6 +616,15 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 	if (!ret)
 		metricgroup___watchdog_constraint_hint(NULL, true);
 
+	if (metrics_file) {
+		int i;
+
+		for (i = 0; i < ctx.num_custom; i++) {
+			zfree(&ctx.custom[i].name);
+			zfree(&ctx.custom[i].expr);
+		}
+	}
+
 	return ret;
 }
 
@@ -594,7 +644,8 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 
 int metricgroup__parse_groups(const struct option *opt,
 			   const char *str,
-			   struct rblist *metric_events)
+			   struct rblist *metric_events,
+			   const char *metrics_file)
 {
 	struct parse_events_error parse_error;
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
@@ -604,7 +655,8 @@ int metricgroup__parse_groups(const struct option *opt,
 
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
-	ret = metricgroup__add_metric_list(str, &extra_events, &group_list);
+	ret = metricgroup__add_metric_list(str, &extra_events, &group_list,
+					   metrics_file);
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 475c7f912864..bf6e4281915f 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -29,7 +29,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 bool create);
 int metricgroup__parse_groups(const struct option *opt,
 			const char *str,
-			struct rblist *metric_events);
+			struct rblist *metric_events,
+			const char *metrics_file);
 
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..57c4c7695aaf 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -123,6 +123,7 @@ struct perf_stat_config {
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
+	const char		*metrics_file;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
 	struct perf_cpu_map		*aggr_map;
-- 
2.25.3

