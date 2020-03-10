Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2B4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72AD2469E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCJHED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:04:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:5989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCJHD7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524670"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:56 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 11/14] perf diff: support hot blocks comparison
Date:   Tue, 10 Mar 2020 15:02:42 +0800
Message-Id: <20200310070245.16314-12-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reports the results of hot blocks comparison.

For example, following outputs are added to the end of
hot streams reports.

  # Output based on old stream (perf.data.old):
  #
  # Sampled Cycles%  Avg Cycles  New Stream Diff(cycles%,cycles)  New Stream Sampled Cycles%  New Stream Avg Cycles
  # ...............  ..........  ...............................  ..........................  .....................
  #
             24.76%          17                     -4.54%,   -7                           -                      -
             14.72%           7                      0.13%,   -1                           -                      -
              5.28%           2        [block not in new stream]                           -                      -
              5.09%           2                      0.52%,    0                           -                      -
              5.05%           2                     -0.15%,   -1                           -                      -
              4.18%           1                      0.12%,    0                           -                      -
              3.16%           1                      0.28%,    0                           -                      -

If we enable the source line comparison, the output might be different.

  # Output based on old stream (perf.data.old):
  #
  # Sampled Cycles%  Avg Cycles  New Stream Diff(cycles%,cycles)  New Stream Sampled Cycles%  New Stream Avg Cycles
  # ...............  ..........  ...............................  ..........................  .....................
  #
             24.76%          17    [block changed in new stream]                      20.22%                     10
             14.72%           7                      0.13%,   -1                           -                      -
              5.28%           2        [block not in new stream]                           -                      -
              5.09%           2                      0.52%,    0                           -                      -
              5.05%           2                     -0.15%,   -1                           -                      -
              4.18%           1    [block changed in new stream]                       4.31%                      1
              3.16%           1                      0.28%,    0                           -                      -

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 85 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index dcbc9bba4e61..566e811054b1 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -49,6 +49,8 @@ struct perf_diff {
 	bool				 src_cmp;
 	bool				 stream;
 	struct srclist			*src_list;
+	u64				 total_cycles;
+	float				 min_percent;
 };
 
 /* Diff command specific HPP columns. */
@@ -76,8 +78,10 @@ struct diff_hpp_fmt {
 
 struct data__file {
 	struct perf_session	*session;
+	struct block_report	*block_reports;
 	struct perf_data	 data;
 	int			 idx;
+	int			 nr_block_reports;
 	struct hists		*hists;
 	struct callchain_streams *evsel_streams;
 	int			 nr_evsel_streams;
@@ -445,8 +449,10 @@ static int diff__process_sample_event(struct perf_tool *tool,
 			pr_debug("problem adding hist entry, skipping event\n");
 			goto out_put;
 		}
-		break;
 
+		hist__account_cycles(sample->branch_stack, &al, sample, false,
+				     &pdiff->total_cycles);
+		break;
 	default:
 		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
 				      true)) {
@@ -992,6 +998,7 @@ static int process_base_stream(struct data__file *data_base,
 	struct evlist *evlist_pair = data_pair->session->evlist;
 	struct evsel *evsel_base, *evsel_pair;
 	struct callchain_streams *es_base, *es_pair;
+	struct block_report *rep_base, *rep_pair;
 
 	evlist__for_each_entry(evlist_base, evsel_base) {
 		evsel_pair = evsel_match(evsel_base, evlist_pair);
@@ -1014,6 +1021,37 @@ static int process_base_stream(struct data__file *data_base,
 		callchain_stream_report(es_base, es_pair);
 	}
 
+	evlist__for_each_entry(evlist_base, evsel_base) {
+		rep_base = block_info__get_report(data_base->block_reports,
+						  data_base->nr_block_reports,
+						  evsel_base->idx);
+
+		if (!rep_base)
+			return -1;
+
+		block_hists_addr2line(&rep_base->hist.block_hists, base_dir);
+
+		evlist_pair = data_pair->session->evlist;
+		evsel_pair = evsel_match(evsel_base, evlist_pair);
+		if (!evsel_pair)
+			continue;
+
+		rep_pair = block_info__get_report(data_pair->block_reports,
+						  data_pair->nr_block_reports,
+						  evsel_pair->idx);
+
+		block_hists_addr2line(&rep_pair->hist.block_hists, pair_dir);
+
+		block_info__match_report(rep_base, rep_pair,
+					 pdiff.src_list, NULL);
+
+		fprintf(stdout, "%s", title);
+
+		use_browser = 0;
+		report__browse_block_hists(&rep_base->hist, pdiff.min_percent,
+					   evsel_base, NULL, NULL);
+	}
+
 	return 0;
 }
 
@@ -1142,6 +1180,26 @@ static int check_file_brstack(void)
 	return 0;
 }
 
+static struct block_report *create_block_reports(struct evlist *evlist,
+						 u64 total_cycles,
+						 int *nr_block_reports)
+{
+	struct block_report *reps;
+	int block_hpps[7] = {
+		PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
+		PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
+		PERF_HPP__BLOCK_NEW_STREAM_DIFF,
+		PERF_HPP__BLOCK_NEW_STREAM_TOTAL_CYCLES_PCT,
+		PERF_HPP__BLOCK_NEW_STREAM_AVG_CYCLES,
+		PERF_HPP_REPORT__BLOCK_RANGE,
+		PERF_HPP_REPORT__BLOCK_DSO,
+	};
+
+	reps = block_info__create_report(evlist, total_cycles, block_hpps, 7,
+					 nr_block_reports);
+	return reps;
+}
+
 static struct callchain_streams *create_evsel_streams(struct evlist *evlist,
 						      int nr_streams_max,
 						      int *nr_evsel_streams)
@@ -1197,6 +1255,8 @@ static int __cmd_diff(void)
 				goto out_delete;
 		}
 
+		pdiff.total_cycles = 0;
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.path);
@@ -1215,6 +1275,12 @@ static int __cmd_diff(void)
 						&d->nr_evsel_streams);
 			if (!d->evsel_streams)
 				goto out_delete;
+
+			d->block_reports = create_block_reports(d->session->evlist,
+								pdiff.total_cycles,
+								&d->nr_block_reports);
+			if (!d->block_reports)
+				goto out_delete;
 		}
 	}
 
@@ -1225,6 +1291,11 @@ static int __cmd_diff(void)
 
  out_delete:
 	data__for_each_file(i, d) {
+		if (d->block_reports) {
+			block_info__free_report(d->block_reports,
+						d->nr_block_reports);
+		}
+
 		perf_session__delete(d->session);
 		data__free(d);
 	}
@@ -1244,6 +1315,15 @@ static int __cmd_diff(void)
 	return ret;
 }
 
+static int parse_percent_limit(const struct option *opt, const char *arg,
+			       int unset __maybe_unused)
+{
+	struct perf_diff *d = opt->value;
+
+	d->min_percent = strtof(arg, NULL);
+	return 0;
+}
+
 static const char * const diff_usage[] = {
 	"perf diff [<options>] [old_file] [new_file]",
 	NULL,
@@ -1307,6 +1387,9 @@ static const struct option options[] = {
 	OPT_STRING(0, "after", &pdiff.after_dir, "dir",
 		   "Source code directory corresponding to perf.data. "
 		   "WARNING: use with --before and --stream"),
+	OPT_CALLBACK(0, "percent-limit", &pdiff, "percent",
+		     "Don't show entries under that percent",
+		     parse_percent_limit),
 	OPT_END()
 };
 
-- 
2.17.1

