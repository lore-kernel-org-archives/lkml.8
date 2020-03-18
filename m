Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9B6C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53D20771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PMVNaiSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgCRLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:32:34 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21400 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgCRLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584531153; x=1616067153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9JLpSR/hpH6Y1WsOsdGzWbBnkGtgStWv6JmQH3em5Xc=;
  b=PMVNaiSxcrtbXOrRCqUK5kkdIKM8gNIlTOkMVS6fxKjEHnUzi2xwtbsE
   OzTE2w6IZ1LFKVnor3aQM+m9lZwJ4I+eKFju5I3uKKXMAWBKJ2k3X+OKZ
   2X5ArK6pS5PiOSZtooo2lk3InfTQHT+5HY/kGrD1ynaLLL0YBhQF/bAl6
   g=;
IronPort-SDR: v4ArqjtWhnIt+YxBgPW2aJGAvBO5f+0hGzDqNbGEBDbAfFLPG0h2RLQpzjySIWgf6IBh1cisp5
 J3b6c+smyZ+A==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="22002491"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 18 Mar 2020 11:32:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 82C74A18E6;
        Wed, 18 Mar 2020 11:32:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:32:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:32:04 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 06/15] mm/damon: Apply dynamic memory mapping changes
Date:   Wed, 18 Mar 2020 12:27:13 +0100
Message-ID: <20200318112722.30143-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com>
References: <20200318112722.30143-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
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
 include/linux/damon.h | 10 +++--
 mm/damon.c            | 92 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7562b85b1ec0..64e327400749 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -34,17 +34,21 @@ struct damon_task {
 /*
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for each 'aggr_interval' time.
+ * each region) for 'aggr_interval' time.  DAMON also checks whether the memory
+ * mapping of the target tasks has changed (e.g., by mmap() calls from the
+ * application) and applies the changes. for each 'regions_update_interval'.
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
 	struct mutex kdamond_lock;
@@ -55,8 +59,8 @@ struct damon_ctx {
 };
 
 int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids);
-int damon_set_attrs(struct damon_ctx *ctx,
-		unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_start(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx *ctx);
diff --git a/mm/damon.c b/mm/damon.c
index 23c0de3b502e..535337529d20 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -651,6 +651,87 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
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
+	/* Remove regions which isn't in the three big regions now */
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
+			newr = damon_new_region(ctx, br->start, br->end);
+			damon_insert_region(newr, damon_prev_region(r), r);
+		} else {
+			first->vm_start = br->start;
+			last->vm_end = br->end;
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
@@ -713,6 +794,9 @@ static int kdamond_fn(void *data)
 			kdamond_split_regions(ctx);
 		}
 
+		if (kdamond_need_update_regions(ctx))
+			kdamond_update_regions(ctx);
+
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
 	damon_for_each_task(ctx, t) {
@@ -826,6 +910,7 @@ int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids)
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between vma update checks
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -835,9 +920,9 @@ int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids)
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx,
-			unsigned long sample_int, unsigned long aggr_int,
-			unsigned long min_nr_reg, unsigned long max_nr_reg)
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
 		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
@@ -852,6 +937,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
-- 
2.17.1

