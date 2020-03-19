Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A1521473
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgCSOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:12:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgCSOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsx-0002CU-7q; Thu, 19 Mar 2020 15:10:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D0C301C22A3;
        Thu, 19 Mar 2020 15:10:49 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:49 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf diff: Use __block_info__cmp() to replace
 block_pair_cmp()
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200202141655.32053-3-yao.jin@linux.intel.com>
References: <20200202141655.32053-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704952.28353.1015195743996021982.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a8a9f6dc0dbfc0f4f225987abec7eb688f4b2d7e
Gitweb:        https://git.kernel.org/tip/a8a9f6dc0dbfc0f4f225987abec7eb688f4b2d7e
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Sun, 02 Feb 2020 22:16:53 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:25 -03:00

perf diff: Use __block_info__cmp() to replace block_pair_cmp()

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
index c03c36f..5e697cd 100644
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
index 5b42146..25f6422 100644
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
index bef0d75..a0fa9fe 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -61,6 +61,8 @@ static inline void __block_info__zput(struct block_info **bi)
 
 #define block_info__zput(bi) __block_info__zput(&bi)
 
+int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
+
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right);
 
