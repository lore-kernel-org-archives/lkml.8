Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47CC3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3B208C3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBBOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:17:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:6188 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgBBOR0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:17:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 06:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,394,1574150400"; 
   d="scan'208";a="253811061"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2020 06:17:24 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 2/4] perf util: Use __block_info__cmp to replace block_pair_cmp
Date:   Sun,  2 Feb 2020 22:16:53 +0800
Message-Id: <20200202141655.32053-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202141655.32053-1-yao.jin@linux.intel.com>
References: <20200202141655.32053-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf-diff uses block_pair_cmp to compare two blocks. The
block_info__cmp has the similar functionality and it's
a bit more complete.

This patch removes the block_pair_cmp and use __block_info__cmp
instead. The __block_info__cmp is wrapped by block_info__cmp
and it doesn't receive perf_hpp_fmt parameter.

 v6:
 ---
 New in this patch set.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    | 21 ++-------------------
 tools/perf/util/block-info.c |  9 +++++++--
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..dc151b3ae189 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -572,29 +572,12 @@ static void init_block_hist(struct block_hist *bh)
 	bh->valid = true;
 }
 
-static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
-{
-	struct block_info *bi_a = a->block_info;
-	struct block_info *bi_b = b->block_info;
-	int cmp;
-
-	if (!bi_a->sym || !bi_b->sym)
-		return -1;
-
-	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
-
-	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
-		return 0;
-
-	return -1;
-}
-
 static struct hist_entry *get_block_pair(struct hist_entry *he,
 					 struct hists *hists_pair)
 {
 	struct rb_root_cached *root = hists_pair->entries_in;
 	struct rb_node *next = rb_first_cached(root);
-	int cmp;
+	int64_t cmp;
 
 	while (next != NULL) {
 		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
@@ -602,7 +585,7 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 
 		next = rb_next(&he_pair->rb_node_in);
 
-		cmp = block_pair_cmp(he_pair, he);
+		cmp = __block_info__cmp(he_pair, he);
 		if (!cmp)
 			return he_pair;
 	}
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 4ed5bce945ad..c8833f1bbc3a 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -65,8 +65,7 @@ struct block_info *block_info__new(void)
 	return bi;
 }
 
-int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-			struct hist_entry *left, struct hist_entry *right)
+int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	struct block_info *bi_l = left->block_info;
 	struct block_info *bi_r = right->block_info;
@@ -91,6 +90,12 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return (int64_t)(bi_r->end - bi_l->end);
 }
 
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right)
+{
+	return __block_info__cmp(left, right);
+}
+
 static void init_block_info(struct block_info *bi, struct symbol *sym,
 			    struct cyc_hist *ch, int offset,
 			    u64 total_cycles)
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bef0d75e9819..a0fa9fefeaf0 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -61,6 +61,8 @@ static inline void __block_info__zput(struct block_info **bi)
 
 #define block_info__zput(bi) __block_info__zput(&bi)
 
+int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
+
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right);
 
-- 
2.17.1

