Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944724682
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCJHEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:04:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:5994 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCJHEE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:04:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524701"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:04:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 13/14] perf util: Filter out blocks by name of changed functions
Date:   Tue, 10 Mar 2020 15:02:44 +0800
Message-Id: <20200310070245.16314-14-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar as previous patch "perf util: Filter out streams
by name of changed functions", user provides a list of changed
functions, then perf-diff can know these functions are not
matched between old perf data and new perf data.

In this patch, the names of changed function names have been
stored in strlist, and we will check if the symbol name is in
strlist. If yes, that means this function is changed and the
related blocks are not matched.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    |  4 ++--
 tools/perf/util/block-info.c | 18 ++++++++++++------
 tools/perf/util/block-info.h |  4 +++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 2f891e8a5122..98e9ab8c69ce 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -703,7 +703,7 @@ static void hists__precompute(struct hists *hists)
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
 							  &pair_bh->block_hists,
-							  NULL,
+							  NULL, NULL,
 							  compute_cycles_diff);
 					hists__output_resort(&pair_bh->block_hists,
 							     NULL);
@@ -1043,7 +1043,7 @@ static int process_base_stream(struct data__file *data_base,
 		block_hists_addr2line(&rep_pair->hist.block_hists, pair_dir);
 
 		block_info__match_report(rep_base, rep_pair,
-					 pdiff.src_list, NULL);
+					 pdiff.src_list, NULL, NULL);
 
 		fprintf(stdout, "%s", title);
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 3aa564151d84..0e9aeb407455 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -93,7 +93,7 @@ struct block_info *block_info__new(void)
 }
 
 int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
-			  struct srclist *src_list)
+			  struct srclist *src_list, struct strlist *func_list)
 {
 	struct block_info *bi_l = left->block_info;
 	struct block_info *bi_r = right->block_info;
@@ -113,6 +113,9 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
 	if (cmp)
 		return cmp;
 
+	if (func_list && strlist__has_entry(func_list, bi_l->sym->name))
+		return -1;
+
 	if (src_list && bi_l->line && bi_r->line) {
 		if (block_same_srcfiles(bi_l->line, bi_r->line) &&
 		    bi_l->line->start_rel) {
@@ -143,7 +146,7 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right)
 {
-	return __block_info__cmp(left, right, NULL);
+	return __block_info__cmp(left, right, NULL, NULL);
 }
 
 static void init_block_info(struct block_info *bi, struct symbol *sym,
@@ -872,7 +875,8 @@ bool block_srclist_matched(struct srclist *slist, char *rel_path,
 
 static struct hist_entry *get_block_pair(struct hist_entry *he,
 					 struct hists *hists_pair,
-					 struct srclist *src_list)
+					 struct srclist *src_list,
+					 struct strlist *func_list)
 {
 	struct rb_root_cached *root = hists_pair->entries_in;
 	struct rb_node *next = rb_first_cached(root);
@@ -884,7 +888,7 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 
 		next = rb_next(&he_pair->rb_node_in);
 
-		cmp = __block_info__cmp(he_pair, he, src_list);
+		cmp = __block_info__cmp(he_pair, he, src_list, func_list);
 		if (!cmp)
 			return he_pair;
 	}
@@ -895,6 +899,7 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 void block_hists_match(struct hists *hists_base,
 		       struct hists *hists_pair,
 		       struct srclist *src_list,
+		       struct strlist *func_list,
 		       void (*func)(struct hist_entry *,
 				    struct hist_entry *))
 {
@@ -905,7 +910,7 @@ void block_hists_match(struct hists *hists_base,
 		struct hist_entry *he = rb_entry(next, struct hist_entry,
 						 rb_node_in);
 		struct hist_entry *pair = get_block_pair(he, hists_pair,
-							 src_list);
+							 src_list, func_list);
 
 		next = rb_next(&he->rb_node_in);
 
@@ -921,6 +926,7 @@ void block_hists_match(struct hists *hists_base,
 int block_info__match_report(struct block_report *rep_base,
 			     struct block_report *rep_pair,
 			     struct srclist *src_list,
+			     struct strlist *func_list,
 			     void (*func)(struct hist_entry *,
 					  struct hist_entry *))
 {
@@ -928,7 +934,7 @@ int block_info__match_report(struct block_report *rep_base,
 	struct block_hist *bh_pair = &rep_pair->hist;
 
 	block_hists_match(&bh_base->block_hists, &bh_pair->block_hists,
-			  src_list, func);
+			  src_list, func_list, func);
 
 	return 0;
 }
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index 4e22bce81731..2b440cef4ef7 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -70,7 +70,7 @@ static inline void __block_info__zput(struct block_info **bi)
 #define block_info__zput(bi) __block_info__zput(&bi)
 
 int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
-			  struct srclist *src_list __maybe_unused);
+			  struct srclist *src_list, struct strlist *func_list);
 
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right);
@@ -108,12 +108,14 @@ bool block_srclist_matched(struct srclist *slist, char *rel_path,
 void block_hists_match(struct hists *hists_base,
 		       struct hists *hists_pair,
 		       struct srclist *src_list,
+		       struct strlist *func_list,
 		       void (*func)(struct hist_entry *,
 				    struct hist_entry *));
 
 int block_info__match_report(struct block_report *rep_base,
 			     struct block_report *rep_pair,
 			     struct srclist *src_list,
+			     struct strlist *func_list,
 			     void (*func)(struct hist_entry *,
 					  struct hist_entry *));
 
-- 
2.17.1

