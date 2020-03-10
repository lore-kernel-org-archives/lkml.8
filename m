Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40837C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B5F246A7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839031;
	bh=ZK0hYRl26G9IkdBk/6JZRFcKKi7Uddno4RC5syOvQX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmUzO3pZFJomKtgFZDXWCj8Pi0XPwCNRsCpcQcIjLXoblBSVpSDGrDzhu1FGA75z/
	 ltTPCIhvwjErJov0RDZDM1veOXgjwCXRwuIbUAPHZGzz/4ymoS7qWNBDRPdRpiS4Yr
	 9gqEluKCszxmuTVFDqXvIB/8c/h5DZqab/7j+EdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCJLRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgCJLRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2995205F4;
        Tue, 10 Mar 2020 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839027;
        bh=ZK0hYRl26G9IkdBk/6JZRFcKKi7Uddno4RC5syOvQX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qF+lAL119oRIaZaSi3OGgWEyeZmXeq/NLtJ4AKOX5incTrxwF6hpGwOGEcwObtLEN
         3QXlbXYNaCkNHURnzbz1SC/y0TL/kfmhqWu49/D8Z/B/SZ7JBozfrNlcOUkSiyyXu6
         +CyknwkUJmwif3bwfBNIfK1ZNkrYAhZN8u14iamI=
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
Subject: [PATCH 17/19] perf diff: Use __block_info__cmp() to replace block_pair_cmp()
Date:   Tue, 10 Mar 2020 08:15:49 -0300
Message-Id: <20200310111551.25160-18-acme@kernel.org>
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

'perf diff' uses block_pair_cmp() to compare two blocks. But
block_info__cmp() has the similar functionality and it's a bit more
complete.

This patch removes block_pair_cmp() and uses __block_info__cmp()
instead. __block_info__cmp() is wrapped by block_info__cmp() and it
doesn't receives a perf_hpp_fmt parameter.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-3-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c    | 21 ++-------------------
 tools/perf/util/block-info.c |  9 +++++++--
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c03c36fde7e2..5e697cd2224a 100644
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
index 5b4214656e29..25f6422c548b 100644
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
2.21.1

