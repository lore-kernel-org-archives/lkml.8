Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6513DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3781124694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCJHDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgCJHDu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524642"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:46 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 07/14] perf diff: Support hot streams comparison
Date:   Tue, 10 Mar 2020 15:02:38 +0800
Message-Id: <20200310070245.16314-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables perf-diff with "--stream", "--before" and "--after"
options.

"--stream": Enable hot streams comparison
"--before": Source code directory corresponding to perf.data.old
"--after" : Source code directory corresponding to perf.data

Let's see two examples

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream

[ Matched hot chains between old perf data and new perf data ]

hot chain pair 1:
            cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
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
            cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
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

hot chain pair 4:
             cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot chains in old perf data but source line changed (*) in new perf data ]

[ Hot chains in old perf data only ]

hot chain 1:
             cycles: 2, hits: 4.08%
         --------------------------
                      main div.c:42
              compute_flag div.c:28

[ Hot chains in new perf data only ]

hot chain 1:
                                                    cycles: 36, hits: 3.36%
                                                 --------------------------
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
                                                              main div.c:40

If we enable the source line comparison, the output might be different.

perf diff --stream --before ./before --after ./after

[ Matched hot chains between old perf data and new perf data) ]

hot chain pair 1:
            cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
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

hot chain pair 2:
             cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot chains in old perf data but source line changed (*) in new perf data ]

hot chain pair 1:
            cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39*
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
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
                      main div.c:39                           main div.c:39*

[ Hot chains in old perf data only ]

hot chain 1:
             cycles: 2, hits: 4.08%
         --------------------------
                      main div.c:42
              compute_flag div.c:28

[ Hot chains in new perf data only ]

hot chain 1:
                                                    cycles: 36, hits: 3.36%
                                                 --------------------------
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
                                                              main div.c:40
                                                              main div.c:39

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt |  14 ++
 tools/perf/builtin-diff.c              | 170 +++++++++++++++++++++++--
 2 files changed, 171 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index f50ca0fef0a4..296fea98ac07 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -182,6 +182,20 @@ OPTIONS
 --tid=::
 	Only diff samples for given thread ID (comma separated list).
 
+--stream::
+	Enable hot streams comparison. Stream is a callchain which is
+	aggregated by the branch records from samples. The option can be
+	used with --before and --after if source line comparison is
+	required.
+
+--before::
+	Source code directory corresponding to perf.data.old. Should be
+	used with --stream and --after.
+
+--after::
+	Source code directory corresponding to perf.data. Should be
+	used with --stream and --before.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5e697cd2224a..9c801b9bc5bb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -25,6 +25,8 @@
 #include "util/map.h"
 #include "util/spark.h"
 #include "util/block-info.h"
+#include "util/srclist.h"
+#include "util/callchain.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -38,10 +40,15 @@
 struct perf_diff {
 	struct perf_tool		 tool;
 	const char			*time_str;
+	const char			*before_dir;
+	const char			*after_dir;
 	struct perf_time_interval	*ptime_range;
 	int				 range_size;
 	int				 range_num;
 	bool				 has_br_stack;
+	bool				 src_cmp;
+	bool				 stream;
+	struct srclist			*src_list;
 };
 
 /* Diff command specific HPP columns. */
@@ -72,6 +79,8 @@ struct data__file {
 	struct perf_data	 data;
 	int			 idx;
 	struct hists		*hists;
+	struct callchain_streams *evsel_streams;
+	int			 nr_evsel_streams;
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
 };
 
@@ -106,6 +115,7 @@ enum {
 	COMPUTE_DELTA_ABS,
 	COMPUTE_CYCLES,
 	COMPUTE_MAX,
+	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
 };
 
 const char *compute_names[COMPUTE_MAX] = {
@@ -393,6 +403,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
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
@@ -411,14 +426,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
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
@@ -428,6 +437,23 @@ static int diff__process_sample_event(struct perf_tool *tool,
 
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
@@ -995,6 +1021,53 @@ static void data_process(void)
 	}
 }
 
+static int process_base_stream(struct data__file *data_base,
+			       struct data__file *data_pair,
+			       const char *title __maybe_unused,
+			       const char *base_dir __maybe_unused,
+			       const char *pair_dir __maybe_unused)
+{
+	struct evlist *evlist_base = data_base->session->evlist;
+	struct evlist *evlist_pair = data_pair->session->evlist;
+	struct evsel *evsel_base, *evsel_pair;
+	struct callchain_streams *es_base, *es_pair;
+
+	evlist__for_each_entry(evlist_base, evsel_base) {
+		evsel_pair = evsel_match(evsel_base, evlist_pair);
+		if (!evsel_pair)
+			continue;
+
+		es_base = callchain_evsel_streams_get(data_base->evsel_streams,
+						      data_base->nr_evsel_streams,
+						      evsel_base->idx);
+		if (!es_base)
+			return -1;
+
+		es_pair = callchain_evsel_streams_get(data_pair->evsel_streams,
+						      data_pair->nr_evsel_streams,
+						      evsel_pair->idx);
+		if (!es_pair)
+			return -1;
+
+		callchain_match_streams(es_base, es_pair, pdiff.src_list);
+		callchain_stream_report(es_base, es_pair);
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
+			    "# Output based on old perf data:\n#\n",
+			    pdiff.before_dir, pdiff.after_dir);
+}
+
 static void data__free(struct data__file *d)
 {
 	int col;
@@ -1108,6 +1181,19 @@ static int check_file_brstack(void)
 	return 0;
 }
 
+static struct callchain_streams *create_evsel_streams(struct evlist *evlist,
+						      int nr_streams_max,
+						      int *nr_evsel_streams)
+{
+	struct callchain_streams *evsel_streams;
+
+	evsel_streams = callchain_evsel_streams_create(evlist,
+						       nr_streams_max,
+						       nr_evsel_streams);
+
+	return evsel_streams;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1121,6 +1207,14 @@ static int __cmd_diff(void)
 	abstime_tmp = abstime_ostr;
 	ret = -EINVAL;
 
+	if (pdiff.src_cmp) {
+		pdiff.src_list = srclist__new(pdiff.before_dir,
+					      pdiff.after_dir);
+
+		if (!pdiff.src_list)
+			goto out_free;
+	}
+
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &pdiff.tool);
 		if (IS_ERR(d->session)) {
@@ -1152,9 +1246,21 @@ static int __cmd_diff(void)
 
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
@@ -1162,6 +1268,7 @@ static int __cmd_diff(void)
 		data__free(d);
 	}
 
+ out_free:
 	free(data__files);
 
 	if (pdiff.ptime_range)
@@ -1170,6 +1277,9 @@ static int __cmd_diff(void)
 	if (abstime_ostr)
 		free(abstime_ostr);
 
+	if (pdiff.src_list)
+		srclist__delete(pdiff.src_list);
+
 	return ret;
 }
 
@@ -1227,6 +1337,15 @@ static const struct option options[] = {
 		   "only consider symbols in these pids"),
 	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "only consider symbols in these tids"),
+	OPT_BOOLEAN(0, "stream", &pdiff.stream,
+		    "Enable hot streams comparison. "
+		    "Can be used with --before and --after"),
+	OPT_STRING(0, "before", &pdiff.before_dir, "dir",
+		   "Source code directory corresponding to perf.data.old. "
+		   "WARNING: use with --after and --stream"),
+	OPT_STRING(0, "after", &pdiff.after_dir, "dir",
+		   "Source code directory corresponding to perf.data. "
+		   "WARNING: use with --before and --stream"),
 	OPT_END()
 };
 
@@ -1886,6 +2005,19 @@ int cmd_diff(int argc, const char **argv)
 	if (cycles_hist && (compute != COMPUTE_CYCLES))
 		usage_with_options(diff_usage, options);
 
+	if (pdiff.stream) {
+		compute = COMPUTE_STREAM;
+		if ((pdiff.before_dir && !pdiff.after_dir) ||
+		    (!pdiff.before_dir && pdiff.after_dir)) {
+			usage_with_options(diff_usage, options);
+		}
+
+		if (pdiff.before_dir && pdiff.after_dir)
+			pdiff.src_cmp = true;
+	} else if (pdiff.before_dir || pdiff.after_dir) {
+		usage_with_options(diff_usage, options);
+	}
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
@@ -1897,13 +2029,25 @@ int cmd_diff(int argc, const char **argv)
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

