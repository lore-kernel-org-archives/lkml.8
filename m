Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04BC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B042A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LhQ/0NGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgBJOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:49:34 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:30991 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgBJOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346172; x=1612882172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2wC1R3anMNTqtOwoKo1A1zvWJSTEzJ+dwR/23NCUC4Y=;
  b=LhQ/0NGz/MV3VIOAbc9tjG1MhX5O9gx9wMZJolrUCTS4q/mu79lzamPa
   lxF16139jI29XJUQ8NI4YAmUMhRmXDllz0myDUYi6E9zSMFTXLVC1mTHC
   W3bKtmpAT3ckWygXKauUhDeb/b8EVBT4Y01rMi2QahXm79zlLWrlnWig3
   U=;
IronPort-SDR: N+YUsr5679y3iuqOKcF4vx8V4GZxvhEGXnTpxYkz1KEXlxlKHjxI+MlIvXt3WqdCuBgF6r2H7Y
 QYc6BMtEtpPw==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="16392363"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Feb 2020 14:49:31 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 54FC2A1FFE;
        Mon, 10 Feb 2020 14:49:24 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:49:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:49:12 +0000
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
Subject: [PATCH v4 04/11] mm/damon: Apply dynamic memory mapping changes
Date:   Mon, 10 Feb 2020 15:48:05 +0100
Message-ID: <20200210144812.26845-5-sjpark@amazon.com>
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

Only a number of parts in the virtual address space of the processes is
mapped to physical memory and accessed.  Thus, tracking the unmapped
address regions is just wasteful.  However, tracking every memory
mapping change might incur an overhead.  For the reason, DAMON applies
the dynamic memory mapping changes to the tracking regions only for each
of a user-specified time interval (``regions update interval``).

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 0639064527a4..c2c40e003580 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -60,13 +60,16 @@ struct damon_task {
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
  * each region) for 'aggr_interval' and then flushes it to the result buffer if
- * an 'aggr_interval' surpassed.
+ * an 'aggr_interval' surpassed.  And for each 'regions_update_interval', damon
+ * checks whether the memory mapping of the target tasks has changed (e.g., by
+ * mmap() calls from the applications) and applies the changes.
  *
  * All time intervals are in micro-seconds.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
+	unsigned long regions_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 
@@ -744,6 +747,87 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
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
+	/* Adjust intersecting regions to fit with the threee big regions */
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
+			damon_add_region(newr, damon_prev_region(r), r);
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
@@ -808,6 +892,9 @@ static int kdamond_fn(void *data)
 			kdamond_split_regions(ctx);
 		}
 
+		if (kdamond_need_update_regions(ctx))
+			kdamond_update_regions(ctx);
+
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
 	damon_flush_rbuffer(ctx);
@@ -955,6 +1042,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
  *
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
+ * regions_update_int	time interval between vma update checks
  * min_nr_reg		minimal number of regions
  * max_nr_reg		maximum number of regions
  *
@@ -964,7 +1052,8 @@ static int damon_set_recording(struct damon_ctx *ctx,
  * Returns 0 on success, negative error code otherwise.
  */
 static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long min_nr_reg)
+		unsigned long aggr_int, unsigned long regions_update_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
 		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
@@ -979,6 +1068,7 @@ static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 	return 0;
-- 
2.17.1

