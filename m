Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC0AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB0A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VzI4/XwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHQKy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:54:59 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:17241 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHQKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597661652; x=1629197652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LBkVD+Wxv/M9aVrPwb/7QYNuHeSGbLtCTunoYImZEDw=;
  b=VzI4/XwSedPOq3+pmKeLErOsF1WSFoRd+N41PM3fiiVXMhGg88ORUNDT
   xikAbLs128UUfzlIPQoHcQC+hJqTXatxIq1VGWXIJ8Ygj2Kv8/wEiyuxR
   SqdRNsaSJYiIkvMvPkqjMAJ+1JDfY7ENiXbo3o/YNC4lqOgvjsq0eIhSm
   M=;
X-IronPort-AV: E=Sophos;i="5.76,322,1592870400"; 
   d="scan'208";a="49617019"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Aug 2020 10:53:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id B6162A18C5;
        Mon, 17 Aug 2020 10:53:52 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:53:51 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:53:33 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 04/15] mm/damon: Track dynamic monitoring target regions update
Date:   Mon, 17 Aug 2020 12:51:26 +0200
Message-ID: <20200817105137.19296-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
References: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The monitoring target address range can be dynamically changed.  For
example, virtual memory could be dynamically mapped and unmapped.
Physical memory could be hot-plugged.

As the changes could be quite frequent in some cases, DAMON checks the
dynamic memory mapping changes and applies it to the abstracted target
area only for each of a user-specified time interval, ``regions update
interval``.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h | 20 +++++++++++++++-----
 mm/damon.c            | 23 +++++++++++++++++++++--
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 708775a36be3..65533be91735 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -64,13 +64,16 @@ struct damon_target {
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
+ * @regions_update_interval:	The time between monitor regions updates.
  * @min_nr_regions:		The minimum number of monitoring regions.
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
@@ -94,6 +97,7 @@ struct damon_target {
  * @targets_list:	Head of monitoring targets (&damon_target) list.
  *
  * @init_target_regions:	Constructs initial monitoring target regions.
+ * @update_target_regions:	Updates monitoring target regions.
  * @prepare_access_checks:	Prepares next access check of target regions.
  * @check_accesses:		Checks the access of target regions.
  * @target_valid:		Determine if the target is valid.
@@ -104,12 +108,15 @@ struct damon_target {
  * DAMON can be extended for various address spaces by users.  For this, users
  * can register the target address space dependent low level functions for
  * their usecases via the callback pointers of the context.  The monitoring
- * thread calls @init_target_regions before starting the monitoring, and
+ * thread calls @init_target_regions before starting the monitoring,
+ * @update_target_regions for each @regions_update_interval, and
  * @prepare_access_checks, @check_accesses, and @target_valid for each
  * @sample_interval.
  *
  * @init_target_regions should construct proper monitoring target regions and
  * link those to the DAMON context struct.
+ * @update_target_regions should update the monitoring target regions for
+ * current status.
  * @prepare_access_checks should manipulate the monitoring regions to be
  * prepare for the next access check.
  * @check_accesses should check the accesses to each region that made after the
@@ -128,10 +135,12 @@ struct damon_target {
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
@@ -141,6 +150,7 @@ struct damon_ctx {
 
 	/* callbacks */
 	void (*init_target_regions)(struct damon_ctx *context);
+	void (*update_target_regions)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	bool (*target_valid)(struct damon_target *target);
@@ -151,8 +161,8 @@ struct damon_ctx {
 
 int damon_set_targets(struct damon_ctx *ctx,
 		unsigned long *ids, ssize_t nr_ids);
-int damon_set_attrs(struct damon_ctx *ctx,
-		unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_start(struct damon_ctx *ctxs, int nr_ctxs);
 int damon_stop(struct damon_ctx *ctxs, int nr_ctxs);
diff --git a/mm/damon.c b/mm/damon.c
index 13b17074d411..59d0b59858ae 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -385,6 +385,17 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 	last_nr_regions = nr_regions;
 }
 
+/*
+ * Check whether it is time to check and apply the target monitoring regions
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_regions(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_regions_update,
+			ctx->regions_update_interval);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -450,6 +461,12 @@ static int kdamond_fn(void *data)
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
+
+		if (kdamond_need_update_regions(ctx)) {
+			if (ctx->update_target_regions)
+				ctx->update_target_regions(ctx);
+			sz_limit = damon_region_sz_limit(ctx);
+		}
 	}
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
@@ -624,6 +641,7 @@ int damon_set_targets(struct damon_ctx *ctx,
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between target regions update
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -633,8 +651,8 @@ int damon_set_targets(struct damon_ctx *ctx,
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
@@ -650,6 +668,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
-- 
2.17.1

