Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413AAC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C7C21D42
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIGERT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:17:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:58725 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgIGERL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:17:11 -0400
IronPort-SDR: olt98iQ3RyrDDowMUOlzFI/obb5/S6FayNZpDgLQi7IUpv58zcdXqpsRpHgrKjaJYI8fFVw54e
 aVIQtSQapXTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215569"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:17:00 -0700
IronPort-SDR: kgI09PEcDwStJRntDxvBgdS1gzpGi048kVc8pV9wmxG6r3AOkYqOV2DWQfv26+mNXPTWOdGLb3
 PNUcpBDtGDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709955"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 7/7] perf diff: Support hot streams comparison
Date:   Mon,  7 Sep 2020 12:16:06 +0800
Message-Id: <20200907041606.14500-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables perf-diff with "--stream" option.

"--stream": Enable hot streams comparison

Now let's see examples.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream

[ Matched hot streams ]

hot chain pair 1:
            cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40
                      main div.c:40                           main div.c:40
                      main div.c:39                           main div.c:39

hot chain pair 3:
             cycles: 9, hits: 4.48%                  cycles: 6, hits: 4.51%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot streams in old perf data only ]

hot chain 1:
            cycles: 18, hits: 6.75%
         --------------------------
          __random_r random_r.c:360
          __random_r random_r.c:388
          __random_r random_r.c:388
          __random_r random_r.c:380
          __random_r random_r.c:357
              __random random.c:293
              __random random.c:293
              __random random.c:291
              __random random.c:291
              __random random.c:291
              __random random.c:288
                     rand rand.c:27
                     rand rand.c:26
                           rand@plt
                           rand@plt
              compute_flag div.c:25
              compute_flag div.c:22
                      main div.c:40

hot chain 2:
            cycles: 29, hits: 2.78%
         --------------------------
              compute_flag div.c:22
                      main div.c:40
                      main div.c:40
                      main div.c:39

[ Hot streams in new perf data only ]

hot chain 1:
                                                     cycles: 4, hits: 4.54%
                                                 --------------------------
                                                              main div.c:42
                                                      compute_flag div.c:28

hot chain 2:
                                                     cycles: 5, hits: 3.51%
                                                 --------------------------
                                                              main div.c:39
                                                              main div.c:44
                                                              main div.c:42
                                                      compute_flag div.c:28

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v5:
   - Remove enum stream_type
   - Rebase to perf/core

 v4:
   - Remove the "--before" and "--after" options since they are for
     source line based comparison. In this patchset, we will not
     support source line based comparison.

 tools/perf/Documentation/perf-diff.txt |   4 +
 tools/perf/builtin-diff.c              | 133 ++++++++++++++++++++++---
 2 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index d5cc15e651cf..5e2e4b7d62ec 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -177,6 +177,10 @@ OPTIONS
 --tid=::
 	Only diff samples for given thread ID (comma separated list).
 
+--stream::
+	Enable hot streams comparison. Stream can be a callchain which is
+	aggregated by the branch records from samples.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c37a78677955..6a6b52a0a49b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -23,6 +23,7 @@
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include "util/stream.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -40,6 +41,7 @@ struct perf_diff {
 	int				 range_size;
 	int				 range_num;
 	bool				 has_br_stack;
+	bool				 stream;
 };
 
 /* Diff command specific HPP columns. */
@@ -69,6 +71,8 @@ struct data__file {
 	struct perf_data	 data;
 	int			 idx;
 	struct hists		*hists;
+	struct evsel_streams	*evsel_streams;
+	int			 nr_evsel_streams;
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
 };
 
@@ -104,6 +108,7 @@ enum {
 	COMPUTE_DELTA_ABS,
 	COMPUTE_CYCLES,
 	COMPUTE_MAX,
+	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
 };
 
 const char *compute_names[COMPUTE_MAX] = {
@@ -387,6 +392,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
 	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
 	struct addr_location al;
 	struct hists *hists = evsel__hists(evsel);
+	struct hist_entry_iter iter = {
+		.evsel	= evsel,
+		.sample	= sample,
+		.ops	= &hist_iter_normal,
+	};
 	int ret = -1;
 
 	if (perf_time__ranges_skip_sample(pdiff->ptime_range, pdiff->range_num,
@@ -405,14 +415,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (compute != COMPUTE_CYCLES) {
-		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
-				      true)) {
-			pr_warning("problem incrementing symbol period, "
-				   "skipping event\n");
-			goto out_put;
-		}
-	} else {
+	switch (compute) {
+	case COMPUTE_CYCLES:
 		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
 					  NULL, NULL, sample, true)) {
 			pr_warning("problem incrementing symbol period, "
@@ -421,6 +425,23 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		}
 
 		hist__account_cycles(sample->branch_stack, &al, sample, false);
+		break;
+
+	case COMPUTE_STREAM:
+		if (hist_entry_iter__add(&iter, &al, PERF_MAX_STACK_DEPTH,
+					 NULL)) {
+			pr_debug("problem adding hist entry, skipping event\n");
+			goto out_put;
+		}
+		break;
+
+	default:
+		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
+				      true)) {
+			pr_warning("problem incrementing symbol period, "
+				   "skipping event\n");
+			goto out_put;
+		}
 	}
 
 	/*
@@ -1058,6 +1079,50 @@ static void data_process(void)
 	}
 }
 
+static int process_base_stream(struct data__file *data_base,
+			       struct data__file *data_pair,
+			       const char *title __maybe_unused)
+{
+	struct evlist *evlist_base = data_base->session->evlist;
+	struct evlist *evlist_pair = data_pair->session->evlist;
+	struct evsel *evsel_base, *evsel_pair;
+	struct evsel_streams *es_base, *es_pair;
+
+	evlist__for_each_entry(evlist_base, evsel_base) {
+		evsel_pair = evsel_match(evsel_base, evlist_pair);
+		if (!evsel_pair)
+			continue;
+
+		es_base = evsel_streams_get(data_base->evsel_streams,
+					    data_base->nr_evsel_streams,
+					    evsel_base->idx);
+		if (!es_base)
+			return -1;
+
+		es_pair = evsel_streams_get(data_pair->evsel_streams,
+					    data_pair->nr_evsel_streams,
+					    evsel_pair->idx);
+		if (!es_pair)
+			return -1;
+
+		match_evsel_streams(es_base, es_pair);
+		evsel_streams_report(es_base, es_pair);
+	}
+
+	return 0;
+}
+
+static void stream_process(void)
+{
+	/*
+	 * Stream comparison only supports two data files.
+	 * perf.data.old and perf.data. data__files[0] is perf.data.old,
+	 * data__files[1] is perf.data.
+	 */
+	process_base_stream(&data__files[0], &data__files[1],
+			    "# Output based on old perf data:\n#\n");
+}
+
 static void data__free(struct data__file *d)
 {
 	int col;
@@ -1171,6 +1236,18 @@ static int check_file_brstack(void)
 	return 0;
 }
 
+static struct evsel_streams *create_evsel_streams(struct evlist *evlist,
+						  int nr_streams_max,
+						  int *nr_evsel_streams)
+{
+	struct evsel_streams *es;
+
+	es = perf_evlist__create_streams(evlist, nr_streams_max);
+	*nr_evsel_streams = evlist->core.nr_entries;
+
+	return es;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1215,9 +1292,21 @@ static int __cmd_diff(void)
 
 		if (pdiff.ptime_range)
 			zfree(&pdiff.ptime_range);
+
+		if (compute == COMPUTE_STREAM) {
+			d->evsel_streams = create_evsel_streams(
+						d->session->evlist,
+						5,
+						&d->nr_evsel_streams);
+			if (!d->evsel_streams)
+				goto out_delete;
+		}
 	}
 
-	data_process();
+	if (compute == COMPUTE_STREAM)
+		stream_process();
+	else
+		data_process();
 
  out_delete:
 	data__for_each_file(i, d) {
@@ -1287,6 +1376,8 @@ static const struct option options[] = {
 		   "only consider symbols in these pids"),
 	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "only consider symbols in these tids"),
+	OPT_BOOLEAN(0, "stream", &pdiff.stream,
+		    "Enable hot streams comparison."),
 	OPT_END()
 };
 
@@ -1850,6 +1941,9 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (pdiff.stream)
+		compute = COMPUTE_STREAM;
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
@@ -1861,13 +1955,26 @@ int cmd_diff(int argc, const char **argv)
 	if (check_file_brstack() < 0)
 		return -1;
 
-	if (compute == COMPUTE_CYCLES && !pdiff.has_br_stack)
+	if ((compute == COMPUTE_CYCLES || compute == COMPUTE_STREAM)
+	    && !pdiff.has_br_stack) {
 		return -1;
+	}
 
-	if (ui_init() < 0)
-		return -1;
+	if (compute == COMPUTE_STREAM) {
+		symbol_conf.show_branchflag_count = true;
+		symbol_conf.disable_add2line_warn = true;
+		callchain_param.mode = CHAIN_FLAT;
+		callchain_param.key = CCKEY_SRCLINE;
+		callchain_param.branch_callstack = 1;
+		symbol_conf.use_callchain = true;
+		callchain_register_param(&callchain_param);
+		sort_order = "srcline,symbol,dso";
+	} else {
+		if (ui_init() < 0)
+			return -1;
 
-	sort__mode = SORT_MODE__DIFF;
+		sort__mode = SORT_MODE__DIFF;
+	}
 
 	if (setup_sorting(NULL) < 0)
 		usage_with_options(diff_usage, options);
-- 
2.17.1

