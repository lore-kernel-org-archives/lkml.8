Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB7208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgEZGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:11:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:16985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgEZGLv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:11:51 -0400
IronPort-SDR: aBanoetVOtbelOZUDw74+BJoBfy4/ncosgmx0zJALRsDYRxEQroo6b8wcTXdhFr3i91IqqrJWS
 biQ03NlP7LdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:11:43 -0700
IronPort-SDR: aPPHUzEWMFVGMiSaNECIph3VxMnl4oBO2QKdglHsMy4XCovf2s483i4LKeO9rM5wU/oJA62lkA
 S4hzivUOumVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291068706"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 23:11:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 7/7] perf diff: Support hot streams comparison
Date:   Tue, 26 May 2020 14:09:20 +0800
Message-Id: <20200526060920.26490-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526060920.26490-1-yao.jin@linux.intel.com>
References: <20200526060920.26490-1-yao.jin@linux.intel.com>
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
 tools/perf/Documentation/perf-diff.txt |   4 +
 tools/perf/builtin-diff.c              | 133 ++++++++++++++++++++++---
 2 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index f50ca0fef0a4..be65bd55ab2a 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -182,6 +182,10 @@ OPTIONS
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
index f8c9bdd8269a..cfe26f0321f0 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -25,6 +25,7 @@
 #include "util/map.h"
 #include "util/spark.h"
 #include "util/block-info.h"
+#include "util/stream.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -42,6 +43,7 @@ struct perf_diff {
 	int				 range_size;
 	int				 range_num;
 	bool				 has_br_stack;
+	bool				 stream;
 };
 
 /* Diff command specific HPP columns. */
@@ -72,6 +74,8 @@ struct data__file {
 	struct perf_data	 data;
 	int			 idx;
 	struct hists		*hists;
+	struct evsel_streams	*evsel_streams;
+	int			 nr_evsel_streams;
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
 };
 
@@ -106,6 +110,7 @@ enum {
 	COMPUTE_DELTA_ABS,
 	COMPUTE_CYCLES,
 	COMPUTE_MAX,
+	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
 };
 
 const char *compute_names[COMPUTE_MAX] = {
@@ -393,6 +398,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
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
@@ -411,14 +421,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
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
@@ -428,6 +432,23 @@ static int diff__process_sample_event(struct perf_tool *tool,
 
 		hist__account_cycles(sample->branch_stack, &al, sample, false,
 				     NULL);
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
@@ -996,6 +1017,50 @@ static void data_process(void)
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
+		evsel_streams_report(es_base, es_pair, STREAM_CALLCHAIN);
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
@@ -1109,6 +1174,19 @@ static int check_file_brstack(void)
 	return 0;
 }
 
+static struct evsel_streams *create_evsel_streams(struct evlist *evlist,
+						  int nr_streams_max,
+						  int *nr_evsel_streams)
+{
+	struct evsel_streams *es;
+
+	es = perf_evlist__create_streams(evlist, nr_streams_max,
+					 STREAM_CALLCHAIN);
+	*nr_evsel_streams = evlist->core.nr_entries;
+
+	return es;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1153,9 +1231,21 @@ static int __cmd_diff(void)
 
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
@@ -1228,6 +1318,8 @@ static const struct option options[] = {
 		   "only consider symbols in these pids"),
 	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "only consider symbols in these tids"),
+	OPT_BOOLEAN(0, "stream", &pdiff.stream,
+		    "Enable hot streams comparison."),
 	OPT_END()
 };
 
@@ -1887,6 +1979,9 @@ int cmd_diff(int argc, const char **argv)
 	if (cycles_hist && (compute != COMPUTE_CYCLES))
 		usage_with_options(diff_usage, options);
 
+	if (pdiff.stream)
+		compute = COMPUTE_STREAM;
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
@@ -1898,13 +1993,25 @@ int cmd_diff(int argc, const char **argv)
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

