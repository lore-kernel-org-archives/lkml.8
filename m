Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ECAC5519C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84D220656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BFAOid1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgD0MIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:08:06 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:63232 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0MIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587989284; x=1619525284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OQUgA8kOK1ocRJ28Qlwg7SHOY79wKF5uOIVur2enNgU=;
  b=BFAOid1PfU96SfglfiGQbxK+rgfks90UbrOMHezdpIPEbbqLHU9qz40s
   dro3TOXDH2Uehk/0I85HiKbq/dzkdT91Eg8OYFiQlJXqDSu4fXIArLaPA
   D3Ys2u4bNiJf8YI8Ta5BNeZTqMFYqhSlZlmquCbU5s8EuzhRYvgb6NxlO
   8=;
IronPort-SDR: uf34SgUxt+GV9/0vlSYUUrVB4coYGsAaevhcHxUlJbqhWHX8u1/0fvBPL3dOBvNqwBvlz89Ntu
 dI75HpFxxOCg==
X-IronPort-AV: E=Sophos;i="5.73,324,1583193600"; 
   d="scan'208";a="39684050"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Apr 2020 12:08:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 0BB5AA11C5;
        Mon, 27 Apr 2020 12:08:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 12:08:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 12:07:45 +0000
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
Subject: [PATCH v9 06/15] mm/damon: Apply dynamic memory mapping changes
Date:   Mon, 27 Apr 2020 14:04:33 +0200
Message-ID: <20200427120442.24179-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427120442.24179-1-sjpark@amazon.com>
References: <20200427120442.24179-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D34UWC004.ant.amazon.com (10.43.162.155) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Only a number of parts in the virtual address space of the processes is
mapped to physical memory and accessed.  Thus, tracking the unmapped
address regions is just wasteful.  However, tracking every memory
mapping change might incur an overhead.  For the reason, DAMON applies
the dynamic memory mapping changes to the tracking regions only for each
of a user-specified time interval (``regions update interval``).

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  10 +++--
 mm/damon.c            | 101 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f1c3f491fc50..62b9f90ed87b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -34,17 +34,21 @@ struct damon_task {
 /*
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for each 'aggr_interval' time.
+ * each region) for 'aggr_interval' time.  DAMON also checks whether the memory
+ * mapping of the target tasks has changed (e.g., by mmap() calls from the
+ * application) and applies the changes for each 'regions_update_interval'.
  *
  * All time intervals are in micro-seconds.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
+	unsigned long regions_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
+	struct timespec64 last_regions_update;
 
 	struct task_struct *kdamond;
 	bool kdamond_stop;
@@ -54,8 +58,8 @@ struct damon_ctx {
 };
 
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
-int damon_set_attrs(struct damon_ctx *ctx,
-		unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_start(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx *ctx);
diff --git a/mm/damon.c b/mm/damon.c
index cec946197e13..2ee93014628b 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -697,6 +697,98 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		damon_split_regions_of(ctx, t);
 }
 
+/*
+ * Check whether it is time to check and apply the dynamic mmap changes
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_regions(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_regions_update,
+			ctx->regions_update_interval);
+}
+
+/*
+ * Check whether regions are intersecting
+ *
+ * Note that this function checks 'struct damon_region' and 'struct region'.
+ *
+ * Returns true if it is.
+ */
+static bool damon_intersect(struct damon_region *r, struct region *re)
+{
+	return !(r->vm_end <= re->start || re->end <= r->vm_start);
+}
+
+/*
+ * Update damon regions for the three big regions of the given task
+ *
+ * t		the given task
+ * bregions	the three big regions of the task
+ */
+static void damon_apply_three_regions(struct damon_ctx *ctx,
+		struct damon_task *t, struct region bregions[3])
+{
+	struct damon_region *r, *next;
+	unsigned int i = 0;
+
+	/* Remove regions which are not in the three big regions now */
+	damon_for_each_region_safe(r, next, t) {
+		for (i = 0; i < 3; i++) {
+			if (damon_intersect(r, &bregions[i]))
+				break;
+		}
+		if (i == 3)
+			damon_destroy_region(r);
+	}
+
+	/* Adjust intersecting regions to fit with the three big regions */
+	for (i = 0; i < 3; i++) {
+		struct damon_region *first = NULL, *last;
+		struct damon_region *newr;
+		struct region *br;
+
+		br = &bregions[i];
+		/* Get the first and last regions which intersects with br */
+		damon_for_each_region(r, t) {
+			if (damon_intersect(r, br)) {
+				if (!first)
+					first = r;
+				last = r;
+			}
+			if (r->vm_start >= br->end)
+				break;
+		}
+		if (!first) {
+			/* no damon_region intersects with this big region */
+			newr = damon_new_region(ctx,
+					ALIGN_DOWN(br->start, MIN_REGION),
+					ALIGN(br->end, MIN_REGION));
+			if (!newr)
+				continue;
+			damon_insert_region(newr, damon_prev_region(r), r);
+		} else {
+			first->vm_start = ALIGN_DOWN(br->start, MIN_REGION);
+			last->vm_end = ALIGN(br->end, MIN_REGION);
+		}
+	}
+}
+
+/*
+ * Update regions for current memory mappings
+ */
+static void kdamond_update_regions(struct damon_ctx *ctx)
+{
+	struct region three_regions[3];
+	struct damon_task *t;
+
+	damon_for_each_task(ctx, t) {
+		if (damon_three_regions_of(t, three_regions))
+			continue;
+		damon_apply_three_regions(ctx, t, three_regions);
+	}
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -752,6 +844,9 @@ static int kdamond_fn(void *data)
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
+
+		if (kdamond_need_update_regions(ctx))
+			kdamond_update_regions(ctx);
 	}
 	damon_for_each_task(ctx, t) {
 		damon_for_each_region_safe(r, next, t)
@@ -859,6 +954,7 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between vma update checks
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -868,8 +964,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx,
-		    unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		    unsigned long aggr_int, unsigned long regions_update_int,
 		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
@@ -885,6 +981,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
-- 
2.17.1

