Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC9C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16642065D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mrI3bL0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGMIoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:44:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37761 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594629856; x=1626165856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=t79B8CLOUXxQIlSe8XShj08LMlOD6yCBLIEG62roapU=;
  b=mrI3bL0ASTpGZSt6C0jTpHOVzM5zYvOjtVZA4oF0N6zjZDT9zLMWY1/u
   kqfqtIxvaIvmu5gZIKt/RNh6+MnoVIr7EcHlPasYCfpNppc9BijQViWRu
   IRWf1dNYU47BdsVW7H7ILvedWbpV5ppFqtcS+x66H4/Dg93pS7LtgfkkS
   4=;
IronPort-SDR: N6/WW3pXl/rJlj/n8GXqRDtK01gTJipYCfSm53cbDc085Lqq2m/XhwWqS3rzL6h7IjEw84K5cm
 VYJspBitB8IA==
X-IronPort-AV: E=Sophos;i="5.75,346,1589241600"; 
   d="scan'208";a="59283127"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Jul 2020 08:44:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 8D91BC070B;
        Mon, 13 Jul 2020 08:44:07 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 08:44:07 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 08:43:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 05/14] mm/damon: Track dynamic monitoring target regions update
Date:   Mon, 13 Jul 2020 10:41:35 +0200
Message-ID: <20200713084144.4430-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713084144.4430-1-sjpark@amazon.com>
References: <20200713084144.4430-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
index 97ddc74e207f..3c0b92a679e8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -61,13 +61,16 @@ struct damon_task {
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
@@ -88,6 +91,7 @@ struct damon_task {
  * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
  *
  * @init_target_regions:	Constructs initial monitoring target regions.
+ * @update_target_regions:	Updates monitoring target regions.
  * @prepare_access_checks:	Prepares next access check of target regions.
  * @check_accesses:		Checks the access of target regions.
  * @sample_cb:			Called for each sampling interval.
@@ -96,11 +100,14 @@ struct damon_task {
  * DAMON can be extended for various address spaces by users.  For this, users
  * can register the target address space dependent low level functions for
  * their usecases via the callback pointers of the context.  The monitoring
- * thread calls @init_target_regions before starting the monitoring, and
+ * thread calls @init_target_regions before starting the monitoring,
+ * @update_target_regions for each @regions_update_interval, and
  * @prepare_access_checks and @check_accesses for each @sample_interval.
  *
  * @init_target_regions should construct proper monitoring target regions and
  * link those to the DAMON context struct.
+ * @update_target_regions should update the monitoring target regions for
+ * current status.
  * @prepare_access_checks should manipulate the monitoring regions to be
  * prepare for the next access check.
  * @check_accesses should check the accesses to each region that made after the
@@ -115,10 +122,12 @@ struct damon_task {
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
@@ -128,6 +137,7 @@ struct damon_ctx {
 
 	/* callbacks */
 	void (*init_target_regions)(struct damon_ctx *context);
+	void (*update_target_regions)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*sample_cb)(struct damon_ctx *context);
@@ -135,8 +145,8 @@ struct damon_ctx {
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
index 02bc7542a76f..b844924b9fdb 100644
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
@@ -455,6 +466,12 @@ static int kdamond_fn(void *data)
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
 	damon_for_each_task(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
@@ -564,6 +581,7 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between target regions update
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -573,8 +591,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
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
@@ -590,6 +608,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
-- 
2.17.1

