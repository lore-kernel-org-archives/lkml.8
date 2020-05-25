Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D90C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AF32071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r/hBjsbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbgEYJVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:21:48 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34801 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389227AbgEYJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590398508; x=1621934508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=71sXcREmLOnztKv+Ut+G5eckrRCJCQNw3WmMn9+X+HA=;
  b=r/hBjsbrQnfuOPYI+WkS9v8jwgUH+sOKBNAnjHKmGfZK2NMo6S8IXA6O
   adzAOu9ld8OFD5dl54sxYi8nJduiQ9HKOSZti6LIoxvt7HxDRQ0BqoaOZ
   5I2Wx0k6+z0lwseYVsn63j/OZKiXu9hNUzh31Gm348LeVT15uwltZJeOJ
   k=;
IronPort-SDR: vNvhL1I1oMaIzHF+JNrdsIGNrGi8h++N3FA2OdkBKXH0UAaZh5Hsn7eLv2aLFF8Tlu20StL/Gp
 Emd36JsgLgHQ==
X-IronPort-AV: E=Sophos;i="5.73,432,1583193600"; 
   d="scan'208";a="32064261"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 May 2020 09:21:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id D3596A219C;
        Mon, 25 May 2020 09:21:36 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:21:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:21:21 +0000
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
Subject: [PATCH v13 06/15] mm/damon: Apply dynamic memory mapping changes
Date:   Mon, 25 May 2020 11:15:03 +0200
Message-ID: <20200525091512.30391-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525091512.30391-1-sjpark@amazon.com>
References: <20200525091512.30391-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
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
 include/linux/damon.h |  13 ++++--
 mm/damon.c            | 101 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4294640036d8..7d59f57028ca 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -55,13 +55,16 @@ struct damon_task {
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
+ * @regions_update_interval:	The time between monitor regions updates.
  * @min_nr_regions:		The number of initial monitoring regions.
  * @max_nr_regions:		The maximum number of monitoring regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for @aggr_interval time.  All time intervals are in
- * micro-seconds.
+ * each region) for @aggr_interval time.  DAMON also checks whether the target
+ * memory regions need update (e.g., by ``mmap()`` calls from the application,
+ * in case of virtual memory monitoring) and applies the changes for each
+ * @regions_update_interval.  All time intervals are in micro-seconds.
  *
  * @kdamond:		Kernel thread who does the monitoring.
  * @kdamond_stop:	Notifies whether kdamond should stop.
@@ -81,10 +84,12 @@ struct damon_task {
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
@@ -94,8 +99,8 @@ struct damon_ctx {
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
index 68f95b1d75aa..a2be399ab0ab 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -714,6 +714,98 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		last_nr_regions = nr_regions;
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
+	damon_for_each_task(t, ctx) {
+		if (damon_three_regions_of(t, three_regions))
+			continue;
+		damon_apply_three_regions(ctx, t, three_regions);
+	}
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -769,6 +861,9 @@ static int kdamond_fn(void *data)
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
+
+		if (kdamond_need_update_regions(ctx))
+			kdamond_update_regions(ctx);
 	}
 	damon_for_each_task(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
@@ -876,6 +971,7 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between vma update checks
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -885,8 +981,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
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
@@ -902,6 +998,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
-- 
2.17.1

