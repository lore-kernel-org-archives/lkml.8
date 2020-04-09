Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9687C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E7522245
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VONU9WBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDIJoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:44:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1456 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgDIJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586425447; x=1617961447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DQOaqgUeRZ7W8RMsPCocm8k0cuRNjH4lt231zETKFlg=;
  b=VONU9WBn4TcvsIX98Ab0ccbFopZjlZtZsr7HlFkhKFNB4LnFwZ2FRbo1
   iNkIFW2shF5yI1F5J6M8tpoSja9WyyIIyiCgwDchlA7X4pqx7YX8WTpPo
   /d8Y49UqBaxBo0jzn3IDATs0V1I1syPvBreX3a0u2LxJ/4FGOYMDEPfJW
   0=;
IronPort-SDR: H6WmciwMKvPvXMRrZo6To41lLKCMJ4ne5p/aVW5SfQm9/LK71jyq0F2lToYeWqvoo4Db5m5F0g
 hwN0S292SDYg==
X-IronPort-AV: E=Sophos;i="5.72,362,1580774400"; 
   d="scan'208";a="36177728"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 09 Apr 2020 09:44:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id A6DFDA1CA8;
        Thu,  9 Apr 2020 09:44:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:44:02 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/4] mm/damon: Make monitoring target regions init/update configurable
Date:   Thu, 9 Apr 2020 11:42:31 +0200
Message-ID: <20200409094232.29680-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409094232.29680-1-sjpark@amazon.com>
References: <20200409094232.29680-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D15UWB003.ant.amazon.com (10.43.161.138) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit allows DAMON users to configure their own monitoring target
regions initializer / updater.  Using this, users can confine the
monitoring address spaces as they want.  For example, users can track
only stack, heap, or shared memory area, as they want.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  2 ++
 mm/damon.c            | 20 +++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d72dd524924f..a051b5d966ed 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -93,6 +93,8 @@ struct damon_ctx {
 	struct list_head schemes_list;	/* 'damos' objects */
 
 	/* callbacks */
+	void (*init_target_regions)(struct damon_ctx *context);
+	void (*update_target_regions)(struct damon_ctx *context);
 	void (*sample_cb)(struct damon_ctx *context);
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
diff --git a/mm/damon.c b/mm/damon.c
index 80fa3cab7720..da0e7efdf1e1 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -57,6 +57,9 @@
 /* Get a random number in [l, r) */
 #define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
 
+static void kdamond_init_vm_regions(struct damon_ctx *ctx);
+static void kdamond_update_vm_regions(struct damon_ctx *ctx);
+
 /* A monitoring context for debugfs interface users. */
 static struct damon_ctx damon_user_ctx = {
 	.sample_interval = 5 * 1000,
@@ -64,6 +67,9 @@ static struct damon_ctx damon_user_ctx = {
 	.regions_update_interval = 1000 * 1000,
 	.min_nr_regions = 10,
 	.max_nr_regions = 1000,
+
+	.init_target_regions = kdamond_init_vm_regions,
+	.update_target_regions = kdamond_update_vm_regions,
 };
 
 /*
@@ -327,7 +333,7 @@ static void swap_ranges(struct damon_addr_range *r1,
  *
  * This function receives an address space and finds three regions in it which
  * separated by the two biggest unmapped regions in the space.  Please refer to
- * below comments of 'damon_init_regions_of()' function to know why this is
+ * below comments of 'damon_init_vm_regions_of()' function to know why this is
  * necessary.
  *
  * Returns 0 if success, or negative error code otherwise.
@@ -439,7 +445,7 @@ static int damon_three_regions_of(struct damon_task *t,
  *   <BIG UNMAPPED REGION 2>
  *   <stack>
  */
-static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
+static void damon_init_vm_regions_of(struct damon_ctx *c, struct damon_task *t)
 {
 	struct damon_region *r;
 	struct damon_addr_range regions[3];
@@ -463,12 +469,12 @@ static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
 }
 
 /* Initialize '->regions_list' of every task */
-static void kdamond_init_regions(struct damon_ctx *ctx)
+static void kdamond_init_vm_regions(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 
 	damon_for_each_task(ctx, t)
-		damon_init_regions_of(ctx, t);
+		damon_init_vm_regions_of(ctx, t);
 }
 
 static void damon_mkold(struct mm_struct *mm, unsigned long addr)
@@ -1074,7 +1080,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 /*
  * Update regions for current memory mappings
  */
-static void kdamond_update_regions(struct damon_ctx *ctx)
+static void kdamond_update_vm_regions(struct damon_ctx *ctx)
 {
 	struct damon_addr_range three_regions[3];
 	struct damon_task *t;
@@ -1126,7 +1132,7 @@ static int kdamond_fn(void *data)
 	unsigned int max_nr_accesses = 0;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
-	kdamond_init_regions(ctx);
+	ctx->init_target_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_prepare_access_checks(ctx);
 		if (ctx->sample_cb)
@@ -1147,7 +1153,7 @@ static int kdamond_fn(void *data)
 		}
 
 		if (kdamond_need_update_regions(ctx))
-			kdamond_update_regions(ctx);
+			ctx->update_target_regions(ctx);
 	}
 	damon_flush_rbuffer(ctx);
 	damon_for_each_task(ctx, t) {
-- 
2.17.1

