Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFFB20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tzE6JaHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFCON3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:13:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:53984 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFCON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193607; x=1622729607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Ej94uKSnn/iDFeYCmXsAkJtR13LdF4uCUpJrZqH1uaw=;
  b=tzE6JaHNwEzzFuB13no0y0rAHlKch8Chww8lYX4jcGHOQgeaWQPkMHJS
   HvpdXMmW8uXi/eEKdLQhV5NJKYF7U1f5WZ9ThvZJkAjCSWOTsAEdRyjKW
   ALKOhRThjx8LO6Y6N4mD8EpGGos6DrzMAteeIMkLo/St+JQB8+xZFPMIt
   U=;
IronPort-SDR: 0D3QqA6tyyY5NH9rf89c2wrk2SdQAsUVZNAlRumsVEepPYIhQP2amzPue9dzc3lJ2ZQu7+0o0o
 ZO+SfiAFKLdA==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="41264917"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Jun 2020 14:13:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 4E60EA1607;
        Wed,  3 Jun 2020 14:13:23 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:13:22 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:13:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 3/9] mm/damon: Make monitoring target regions init/update configurable
Date:   Wed, 3 Jun 2020 16:11:29 +0200
Message-ID: <20200603141135.10575-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603141135.10575-1-sjpark@amazon.com>
References: <20200603141135.10575-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D45UWB002.ant.amazon.com (10.43.161.78) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit allows DAMON users to configure their own monitoring target
regions initializer / updater.  Using this, users can confine the
monitoring address spaces as they want.  For example, users can track
only stack, heap, shared memory area, or specific file-backed area, as
they want.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 13 +++++++++++++
 mm/damon.c            | 17 ++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b4b06ca905a2..a1b6810ce0eb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -158,9 +158,16 @@ struct damos {
  * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
  * @schemes_list:	Head of schemes (&damos) list.
  *
+ * @init_target_regions:	Constructs initial monitoring target regions.
+ * @update_target_regions:	Updates monitoring target regions.
  * @sample_cb:			Called for each sampling interval.
  * @aggregate_cb:		Called for each aggregation interval.
  *
+ * The monitoring thread calls @init_target_regions before starting the
+ * monitoring, @update_target_regions for each @regions_update_interval.  By
+ * setting these callbacks to appropriate functions, therefore, users can
+ * monitor specific range of virtual address space.
+ *
  * @sample_cb and @aggregate_cb are called from @kdamond for each of the
  * sampling intervals and aggregation intervals, respectively.  Therefore,
  * users can safely access to the monitoring results via @tasks_list without
@@ -190,10 +197,16 @@ struct damon_ctx {
 	struct list_head schemes_list;	/* 'damos' objects */
 
 	/* callbacks */
+	void (*init_target_regions)(struct damon_ctx *context);
+	void (*update_target_regions)(struct damon_ctx *context);
 	void (*sample_cb)(struct damon_ctx *context);
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
+/* Reference callback implementations for virtual memory */
+void kdamond_init_vm_regions(struct damon_ctx *ctx);
+void kdamond_update_vm_regions(struct damon_ctx *ctx);
+
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
diff --git a/mm/damon.c b/mm/damon.c
index f6dd34425185..2a3c1abb9b47 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -72,6 +72,9 @@ static struct damon_ctx damon_user_ctx = {
 	.regions_update_interval = 1000 * 1000,
 	.min_nr_regions = 10,
 	.max_nr_regions = 1000,
+
+	.init_target_regions = kdamond_init_vm_regions,
+	.update_target_regions = kdamond_update_vm_regions,
 };
 
 /*
@@ -324,7 +327,7 @@ static void swap_ranges(struct damon_addr_range *r1,
  *
  * This function receives an address space and finds three regions in it which
  * separated by the two biggest unmapped regions in the space.  Please refer to
- * below comments of 'damon_init_regions_of()' function to know why this is
+ * below comments of 'damon_init_vm_regions_of()' function to know why this is
  * necessary.
  *
  * Returns 0 if success, or negative error code otherwise.
@@ -436,7 +439,7 @@ static int damon_three_regions_of(struct damon_task *t,
  *   <BIG UNMAPPED REGION 2>
  *   <stack>
  */
-static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
+static void damon_init_vm_regions_of(struct damon_ctx *c, struct damon_task *t)
 {
 	struct damon_region *r, *m = NULL;
 	struct damon_addr_range regions[3];
@@ -465,12 +468,12 @@ static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
 }
 
 /* Initialize '->regions_list' of every task */
-static void kdamond_init_regions(struct damon_ctx *ctx)
+void kdamond_init_vm_regions(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 
 	damon_for_each_task(t, ctx)
-		damon_init_regions_of(ctx, t);
+		damon_init_vm_regions_of(ctx, t);
 }
 
 static void damon_mkold(struct mm_struct *mm, unsigned long addr)
@@ -1039,7 +1042,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 /*
  * Update regions for current memory mappings
  */
-static void kdamond_update_regions(struct damon_ctx *ctx)
+void kdamond_update_vm_regions(struct damon_ctx *ctx)
 {
 	struct damon_addr_range three_regions[3];
 	struct damon_task *t;
@@ -1101,7 +1104,7 @@ static int kdamond_fn(void *data)
 	unsigned int max_nr_accesses = 0;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
-	kdamond_init_regions(ctx);
+	ctx->init_target_regions(ctx);
 
 	kdamond_write_record_header(ctx);
 
@@ -1124,7 +1127,7 @@ static int kdamond_fn(void *data)
 		}
 
 		if (kdamond_need_update_regions(ctx))
-			kdamond_update_regions(ctx);
+			ctx->update_target_regions(ctx);
 	}
 	damon_flush_rbuffer(ctx);
 	damon_for_each_task(t, ctx) {
-- 
2.17.1

