Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA87D20801
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="auRfI2d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgERKEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:05 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:45429 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589796243; x=1621332243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/3OXY5/GhgzxlIuGdzy8bwvKP9vS52mzYgTtW+mk1sc=;
  b=auRfI2d4SCpK6CDK2z9c4Z/kP4y7UVcfl3kZLLmolW+xcb0g+YWsO/zk
   04pPz60nRBPJeD1R9dJI9H8FIARQl2Sz+RdhRus/0IT7FcssKPheeULKU
   fN9lPeo/VssHPtZdl2M4+F6BOHRnNPeR90bVMzIPdbVSK5PdI8kzMZqTk
   M=;
IronPort-SDR: YKN58bXVwTAQyp+8J+arZirKU9cWz03JlU6kcCcFuUg2LmBGH3z1Jlvv9UvTaEIA5jw8/8I7hE
 CQU5QNgwnl1A==
X-IronPort-AV: E=Sophos;i="5.73,406,1583193600"; 
   d="scan'208";a="30883199"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 18 May 2020 10:04:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 18ED7A24EC;
        Mon, 18 May 2020 10:04:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:04:00 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:03:45 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 05/16] mm/damon: Adaptively adjust regions
Date:   Mon, 18 May 2020 12:00:07 +0200
Message-ID: <20200518100018.2293-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518100018.2293-1-sjpark@amazon.com>
References: <20200518100018.2293-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D04UWA003.ant.amazon.com (10.43.160.212) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

At the beginning of the monitoring, DAMON constructs the initial regions
by evenly splitting the memory mapped address space of the process into
the user-specified minimal number of regions.  In this initial state,
the assumption of the regions (pages in same region have similar access
frequencies) is normally not kept and thus the monitoring quality could
be low.  To keep the assumption as much as possible, DAMON adaptively
merges and splits each region.

For each ``aggregation interval``, it compares the access frequencies of
adjacent regions and merges those if the frequency difference is small.
Then, after it reports and clears the aggregated access frequency of
each region, it splits each region into two regions if the total number
of regions is smaller than the half of the user-specified maximum number
of regions.

In this way, DAMON provides its best-effort quality and minimal overhead
while keeping the bounds users set for their trade-off.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   6 +-
 mm/damon.c            | 158 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 558dd6ae0afa..f1c3f491fc50 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -42,6 +42,7 @@ struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
 
@@ -53,8 +54,9 @@ struct damon_ctx {
 };
 
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long min_nr_reg);
+int damon_set_attrs(struct damon_ctx *ctx,
+		unsigned long sample_int, unsigned long aggr_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_start(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx *ctx);
 
diff --git a/mm/damon.c b/mm/damon.c
index ca1eeb51c7d0..6c9581104caf 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -332,9 +332,12 @@ static int damon_three_regions_of(struct damon_task *t,
  * regions is wasteful.  That said, because we can deal with small noises,
  * tracking every mapping is not strictly required but could even incur a high
  * overhead if the mapping frequently changes or the number of mappings is
- * high.  Nonetheless, this may seems very weird.  DAMON's dynamic regions
- * adjustment mechanism, which will be implemented with following commit will
- * make this more sense.
+ * high.  The adaptive regions adjustment mechanism will further help to deal
+ * with the noise by simply identifying the unmapped areas as a region that
+ * has no access.  Moreover, applying the real mappings that would have many
+ * unmapped areas inside will make the adaptive mechanism quite complex.  That
+ * said, too huge unmapped areas inside the monitoring target should be removed
+ * to not take the time for the adaptive mechanism.
  *
  * For the reason, we convert the complex mappings to three distinct regions
  * that cover every mapped area of the address space.  Also the two gaps
@@ -508,20 +511,25 @@ static void damon_check_access(struct damon_ctx *ctx,
 	last_addr = r->sampling_addr;
 }
 
-static void kdamond_check_accesses(struct damon_ctx *ctx)
+static unsigned int kdamond_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	struct mm_struct *mm;
 	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
 
 	damon_for_each_task(t, ctx) {
 		mm = damon_get_mm(t);
 		if (!mm)
 			continue;
-		damon_for_each_region(r, t)
+		damon_for_each_region(r, t) {
 			damon_check_access(ctx, mm, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+
 		mmput(mm);
 	}
+	return max_nr_accesses;
 }
 
 /**
@@ -570,6 +578,125 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+#define sz_damon_region(r) (r->vm_end - r->vm_start)
+
+/*
+ * Merge two adjacent regions into one region
+ */
+static void damon_merge_two_regions(struct damon_region *l,
+				struct damon_region *r)
+{
+	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
+			r->nr_accesses * sz_damon_region(r)) /
+			(sz_damon_region(l) + sz_damon_region(r));
+	l->vm_end = r->vm_end;
+	damon_destroy_region(r);
+}
+
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * t		task affected by merge operation
+ * thres	'->nr_accesses' diff threshold for the merge
+ */
+static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (!prev || prev->vm_end != r->vm_start ||
+		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
+			prev = r;
+			continue;
+		}
+		damon_merge_two_regions(prev, r);
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	'->nr_accesses' diff threshold for the merge
+ *
+ * This function merges monitoring target regions which are adjacent and their
+ * access frequencies are similar.  This is for minimizing the monitoring
+ * overhead under the dynamically changeable access pattern.  If a merge was
+ * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ */
+static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold)
+{
+	struct damon_task *t;
+
+	damon_for_each_task(t, c)
+		damon_merge_regions_of(t, threshold);
+}
+
+/*
+ * Split a region in two
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_ctx *ctx,
+				  struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	r->vm_end = new->vm_start;
+
+	damon_insert_region(new, r, damon_next_region(r));
+}
+
+/* Split every region in the given task into two randomly-sized regions */
+static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_orig_region, sz_left_region;
+
+	damon_for_each_region_safe(r, next, t) {
+		sz_orig_region = r->vm_end - r->vm_start;
+
+		/*
+		 * Randomly select size of left sub-region to be at least
+		 * 10 percent and at most 90% of original region
+		 */
+		sz_left_region = ALIGN_DOWN(damon_rand(1, 10) * sz_orig_region
+					    / 10, MIN_REGION);
+		/* Do not allow blank region */
+		if (sz_left_region == 0 || sz_left_region >= sz_orig_region)
+			continue;
+
+		damon_split_region_at(ctx, r, sz_left_region);
+	}
+}
+
+/*
+ * splits every target region into two randomly-sized regions
+ *
+ * This function splits every target region into two random-sized regions if
+ * current total number of the regions is equal or smaller than half of the
+ * user-specified maximum number of regions.  This is for maximizing the
+ * monitoring accuracy under the dynamically changeable access patterns.  If a
+ * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
+ * it.
+ */
+static void kdamond_split_regions(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_task(t, ctx)
+		nr_regions += nr_damon_regions(t);
+	if (nr_regions > ctx->max_nr_regions / 2)
+		return;
+
+	damon_for_each_task(t, ctx)
+		damon_split_regions_of(ctx, t);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -609,6 +736,7 @@ static int kdamond_fn(void *data)
 	struct damon_ctx *ctx = (struct damon_ctx *)data;
 	struct damon_task *t;
 	struct damon_region *r, *next;
+	unsigned int max_nr_accesses = 0;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 	kdamond_init_regions(ctx);
@@ -617,11 +745,13 @@ static int kdamond_fn(void *data)
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
-		kdamond_check_accesses(ctx);
+		max_nr_accesses = kdamond_check_accesses(ctx);
 
-		if (kdamond_aggregate_interval_passed(ctx))
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_merge_regions(ctx, max_nr_accesses / 10);
 			kdamond_reset_aggregated(ctx);
-
+			kdamond_split_regions(ctx);
+		}
 	}
 	damon_for_each_task(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
@@ -731,24 +861,32 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
  * @sample_int:		time interval between samplings
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
+ * @max_nr_reg:		maximum number of regions
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long min_nr_reg)
+int damon_set_attrs(struct damon_ctx *ctx,
+		    unsigned long sample_int, unsigned long aggr_int,
+		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
 		pr_err("min_nr_regions (%lu) must be at least 3\n",
 				min_nr_reg);
 		return -EINVAL;
 	}
+	if (min_nr_reg > max_nr_reg) {
+		pr_err("invalid nr_regions.  min (%lu) > max (%lu)\n",
+				min_nr_reg, max_nr_reg);
+		return -EINVAL;
+	}
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
 	ctx->min_nr_regions = min_nr_reg;
+	ctx->max_nr_regions = max_nr_reg;
 
 	return 0;
 }
-- 
2.17.1

