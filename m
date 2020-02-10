Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC22C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EB720873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oF5KRyO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBJOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:49:24 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:65097 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgBJOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346162; x=1612882162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ARgUxovNWkrqHL2839pISxPLYqfZfMmH4fIUd0VlNr4=;
  b=oF5KRyO7aIn2Ey24XWQxgp6WOnN0qcjhWL8hqHoTdo1PXyNYnBpzzJ+A
   nM1LVSfGh4U2YDL+8zmTuHtfQX73JHfa2ZF6BD+mNmdaZ+Ib83MIDJk2l
   mYIrR2v2VFxl+RYpxjJ6yFB7bL+yB4GBTFjSli4A90jhgnUGONizYmcqa
   I=;
IronPort-SDR: o5Po3Ey/OJilkzmiHptc94HfbY04X21DcxCj8v5yoIB8nrY7PWSTY7+f9shZ+XfxzXV7unlS3E
 O5uoCUSvaHHA==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="17014037"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Feb 2020 14:49:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id AB9D2A1E76;
        Mon, 10 Feb 2020 14:49:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:49:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:49:01 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/11] mm/damon: Adaptively adjust regions
Date:   Mon, 10 Feb 2020 15:48:04 +0100
Message-ID: <20200210144812.26845-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210144812.26845-1-sjpark@amazon.com>
References: <20200210144812.26845-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D35UWC004.ant.amazon.com (10.43.162.180) To
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
 mm/damon.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 5 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 03fd9b1b931b..0639064527a4 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -68,6 +68,7 @@ struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
 
@@ -397,9 +398,12 @@ static int damon_three_regions_of(struct damon_task *t,
  * regions is wasteful.  That said, because we can deal with small noises,
  * tracking every mapping is not strictly required but could even incur a high
  * overhead if the mapping frequently changes or the number of mappings is
- * high.  Nonetheless, this may seems very weird.  DAMON's dynamic regions
- * adjustment mechanism, which will be implemented with following commit will
- * make this more sense.
+ * high.  The adaptive regions adjustment mechanism will further help to deal
+ * with the noises by simply identifying the unmapped areas as a region that
+ * has no access.  Moreover, applying the real mappings that would have many
+ * unmapped areas inside will make the adaptive mechanism quite complex.  That
+ * said, too huge unmapped areas inside the monitoring target should be removed
+ * to not take the time for the adaptive mechanism.
  *
  * For the reason, we convert the complex mappings to three distinct regions
  * that cover every mapped areas of the address space.  Also the two gaps
@@ -623,6 +627,123 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
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
+ * t		task that merge operation will make change
+ * thres	merge regions having '->nr_accesses' diff smaller than this
+ */
+static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (!prev || prev->vm_end != r->vm_start)
+			goto next;
+		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres)
+			goto next;
+		damon_merge_two_regions(prev, r);
+		continue;
+next:
+		prev = r;
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	merge regions havind nr_accesses diff larger than this
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
+	damon_for_each_task(c, t)
+		damon_merge_regions_of(t, threshold);
+}
+
+/*
+ * Split a region into two small regions
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_ctx *ctx,
+		struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	r->vm_end = new->vm_start;
+
+	damon_add_region(new, r, damon_next_region(r));
+}
+
+static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_left_region;
+
+	damon_for_each_region_safe(r, next, t) {
+		/*
+		 * Randomly select size of left sub-region to be at least
+		 * 10 percent and at most 90% of original region
+		 */
+		sz_left_region = (prandom_u32_state(&ctx->rndseed) % 9 + 1) *
+			(r->vm_end - r->vm_start) / 10;
+		/* Do not allow blank region */
+		if (sz_left_region == 0)
+			continue;
+		damon_split_region_at(ctx, r, sz_left_region);
+	}
+}
+
+/*
+ * splits every target regions into two randomly-sized regions
+ *
+ * This function splits every target regions into two random-sized regions if
+ * current total number of the regions is smaller than the half of the
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
+	damon_for_each_task(ctx, t)
+		nr_regions += nr_damon_regions(t);
+	if (nr_regions > ctx->max_nr_regions / 2)
+		return;
+
+	damon_for_each_task(ctx, t)
+		damon_split_regions_of(ctx, t);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -663,21 +784,29 @@ static int kdamond_fn(void *data)
 	struct damon_task *t;
 	struct damon_region *r, *next;
 	struct mm_struct *mm;
+	unsigned long max_nr_accesses;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 	kdamond_init_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
+		max_nr_accesses = 0;
 		damon_for_each_task(ctx, t) {
 			mm = damon_get_mm(t);
 			if (!mm)
 				continue;
-			damon_for_each_region(r, t)
+			damon_for_each_region(r, t) {
 				kdamond_check_access(ctx, mm, r);
+				if (r->nr_accesses > max_nr_accesses)
+					max_nr_accesses = r->nr_accesses;
+			}
 			mmput(mm);
 		}
 
-		if (kdamond_aggregate_interval_passed(ctx))
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_merge_regions(ctx, max_nr_accesses / 10);
 			kdamond_flush_aggregated(ctx);
+			kdamond_split_regions(ctx);
+		}
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
@@ -827,6 +956,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
  * min_nr_reg		minimal number of regions
+ * max_nr_reg		maximum number of regions
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
@@ -841,10 +971,16 @@ static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 				min_nr_reg);
 		return -EINVAL;
 	}
+	if (min_nr_reg >= ctx->max_nr_regions) {
+		pr_err("invalid nr_regions.  min (%lu) >= max (%lu)\n",
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

