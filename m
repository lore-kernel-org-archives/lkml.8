Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B884C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02724696
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839035;
	bh=d3eaJuIjb+5j7md3waJYX0JNx+JJ9dPkgVjssOqvwdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gI50liGACe7f6Krw4nEbNCeFPSthv1wRadFf7IXmyP/63HvIwg3V4VHNa6Ax938yd
	 Fl9kGeLF9DlLSLPvqFwrg9RPB/QuchXIM/6z+pxwvQKwEzUwqpm0xBNUoh1svDY9wp
	 5hWdc2b5H1kJ45WnXDYpbXKBKhfw2f4lgCygY0fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCJLRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgCJLRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4BEF2468D;
        Tue, 10 Mar 2020 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839030;
        bh=d3eaJuIjb+5j7md3waJYX0JNx+JJ9dPkgVjssOqvwdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wfrkso2mvm+BS91UZ3lXkrD39wfybWYRatYwS7hDSm5dVzSnzJqb0qQzB/bL/CTkB
         F8pf6tTjpVB3O5FQFNGWtRRYRvn/1n8lsNh173lPeY9kAVTx3lxEa7Lbz5q2jTjyLD
         YEz7DzV3yIyu7nNeX+61rdtzEQ2qcobegx/Vq+Uo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/19] perf block-info: Allow selecting which columns to report and its order
Date:   Tue, 10 Mar 2020 08:15:50 -0300
Message-Id: <20200310111551.25160-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Currently we use a predefined array to set the block info output
formats, it's fixed and inflexible.

This patch adds two parameters "block_hpps" and "nr_hpps" in
block_info__create_report and other static functions, in order to let
user decide which columns to report and with specified report ordering.
It should be more flexible.

Buffers will be allocated to contain the new fmts, of course, we need to
release them before perf exits.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c  | 21 ++++++++++++---
 tools/perf/util/block-info.c | 51 +++++++++++++++++++++++++-----------
 tools/perf/util/block-info.h |  7 ++++-
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 72a12b69f120..d7c905f7520f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -104,6 +104,7 @@ struct report {
 	bool			symbol_ipc;
 	bool			total_cycles_mode;
 	struct block_report	*block_reports;
+	int			nr_block_reports;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -966,8 +967,19 @@ static int __cmd_report(struct report *rep)
 	report__output_resort(rep);
 
 	if (rep->total_cycles_mode) {
+		int block_hpps[6] = {
+			PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
+			PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
+			PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
+			PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
+			PERF_HPP_REPORT__BLOCK_RANGE,
+			PERF_HPP_REPORT__BLOCK_DSO,
+		};
+
 		rep->block_reports = block_info__create_report(session->evlist,
-							       rep->total_cycles);
+							       rep->total_cycles,
+							       block_hpps, 6,
+							       &rep->nr_block_reports);
 		if (!rep->block_reports)
 			return -1;
 	}
@@ -1551,8 +1563,11 @@ int cmd_report(int argc, const char **argv)
 		zfree(&report.ptime_range);
 	}
 
-	if (report.block_reports)
-		zfree(&report.block_reports);
+	if (report.block_reports) {
+		block_info__free_report(report.block_reports,
+					report.nr_block_reports);
+		report.block_reports = NULL;
+	}
 
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 25f6422c548b..debb8b12cf51 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -373,33 +373,41 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 }
 
 static void register_block_columns(struct perf_hpp_list *hpp_list,
-				   struct block_fmt *block_fmts)
+				   struct block_fmt *block_fmts,
+				   int *block_hpps, int nr_hpps)
 {
-	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
-		hpp_register(&block_fmts[i], i, hpp_list);
+	for (int i = 0; i < nr_hpps; i++)
+		hpp_register(&block_fmts[i], block_hpps[i], hpp_list);
 }
 
-static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts)
+static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts,
+			    int *block_hpps, int nr_hpps)
 {
 	__hists__init(&bh->block_hists, &bh->block_list);
 	perf_hpp_list__init(&bh->block_list);
 	bh->block_list.nr_header_lines = 1;
 
-	register_block_columns(&bh->block_list, block_fmts);
+	register_block_columns(&bh->block_list, block_fmts,
+			       block_hpps, nr_hpps);
 
-	perf_hpp_list__register_sort_field(&bh->block_list,
-		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
+	/* Sort by the first fmt */
+	perf_hpp_list__register_sort_field(&bh->block_list, &block_fmts[0].fmt);
 }
 
-static void process_block_report(struct hists *hists,
-				 struct block_report *block_report,
-				 u64 total_cycles)
+static int process_block_report(struct hists *hists,
+				struct block_report *block_report,
+				u64 total_cycles, int *block_hpps,
+				int nr_hpps)
 {
 	struct rb_node *next = rb_first_cached(&hists->entries);
 	struct block_hist *bh = &block_report->hist;
 	struct hist_entry *he;
 
-	init_block_hist(bh, block_report->fmts);
+	if (nr_hpps > PERF_HPP_REPORT__BLOCK_MAX_INDEX)
+		return -1;
+
+	block_report->nr_fmts = nr_hpps;
+	init_block_hist(bh, block_report->fmts, block_hpps, nr_hpps);
 
 	while (next) {
 		he = rb_entry(next, struct hist_entry, rb_node);
@@ -408,16 +416,19 @@ static void process_block_report(struct hists *hists,
 		next = rb_next(&he->rb_node);
 	}
 
-	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
+	for (int i = 0; i < nr_hpps; i++) {
 		block_report->fmts[i].total_cycles = total_cycles;
 		block_report->fmts[i].block_cycles = block_report->cycles;
 	}
 
 	hists__output_resort(&bh->block_hists, NULL);
+	return 0;
 }
 
 struct block_report *block_info__create_report(struct evlist *evlist,
-					       u64 total_cycles)
+					       u64 total_cycles,
+					       int *block_hpps, int nr_hpps,
+					       int *nr_reps)
 {
 	struct block_report *block_reports;
 	int nr_hists = evlist->core.nr_entries, i = 0;
@@ -430,13 +441,23 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		process_block_report(hists, &block_reports[i], total_cycles);
+		process_block_report(hists, &block_reports[i], total_cycles,
+				     block_hpps, nr_hpps);
 		i++;
 	}
 
+	*nr_reps = nr_hists;
 	return block_reports;
 }
 
+void block_info__free_report(struct block_report *reps, int nr_reps)
+{
+	for (int i = 0; i < nr_reps; i++)
+		hists__delete_entries(&reps[i].hist.block_hists);
+
+	free(reps);
+}
+
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel, struct perf_env *env,
 			       struct annotation_options *annotation_opts)
@@ -448,13 +469,11 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 		symbol_conf.report_individual_block = true;
 		hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
 			       stdout, true);
-		hists__delete_entries(&bh->block_hists);
 		return 0;
 	case 1:
 		symbol_conf.report_individual_block = true;
 		ret = block_hists_tui_browse(bh, evsel, min_percent,
 					     env, annotation_opts);
-		hists__delete_entries(&bh->block_hists);
 		return ret;
 	default:
 		return -1;
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index a0fa9fefeaf0..42e9dcc4cf0a 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -45,6 +45,7 @@ struct block_report {
 	struct block_hist	hist;
 	u64			cycles;
 	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
+	int			nr_fmts;
 };
 
 struct block_hist;
@@ -70,7 +71,11 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 			    u64 *block_cycles_aggr, u64 total_cycles);
 
 struct block_report *block_info__create_report(struct evlist *evlist,
-					       u64 total_cycles);
+					       u64 total_cycles,
+					       int *block_hpps, int nr_hpps,
+					       int *nr_reps);
+
+void block_info__free_report(struct block_report *reps, int nr_reps);
 
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel, struct perf_env *env,
-- 
2.21.1

