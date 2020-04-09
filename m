Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7055C38A30
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A020BED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ORcpdwju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDIJof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:44:35 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:19563 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDIJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586425475; x=1617961475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JM5sUrNXKRJcdMGMKqju9wpkLsnMHLh8mrvocthSOiA=;
  b=ORcpdwju5i36mdlhScsr5feYqn7wswQiF7gNifwq4GdzTs6EOeQnPWL5
   WHkNtin8tXavIu8lkDEwZ+XOqOuYhc3h9ESvpgUhHLhR3kcJ4uEnW+nN1
   1scQ8HPCA/MH/YOczarcCztNrE4FJ+Lei7vSOIOqi8KvOAO9Va0BT6TP3
   Q=;
IronPort-SDR: GznbAMVH7ewBpKdtsJ3sQUEMtalWl/P2BFIN4vgfkQARSVI5kXIJ4bsAcXOgyKormsKvROOcNu
 Dt2pMSgWnnSw==
X-IronPort-AV: E=Sophos;i="5.72,362,1580774400"; 
   d="scan'208";a="24913339"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Apr 2020 09:44:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id E2548A2391;
        Thu,  9 Apr 2020 09:44:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:44:17 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:44:03 +0000
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
Subject: [RFC PATCH 4/4] mm/damon: Make access check configurable
Date:   Thu, 9 Apr 2020 11:42:32 +0200
Message-ID: <20200409094232.29680-5-sjpark@amazon.com>
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

DAMON assumes the target region is in virtual address space and
therefore uses PTE Accessed bit checking for access checking.  However,
some users might want to use architecture-specific, more accurate and
light-weight access checking features.  Also, some users might want to
use DAMON for different address spaces such as physical memory space,
which needs different ways to check the access.

This commit allows DAMON users to configure the access check function to
their own version.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  2 ++
 mm/damon.c            | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a051b5d966ed..188d5b89b303 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -95,6 +95,8 @@ struct damon_ctx {
 	/* callbacks */
 	void (*init_target_regions)(struct damon_ctx *context);
 	void (*update_target_regions)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*sample_cb)(struct damon_ctx *context);
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
diff --git a/mm/damon.c b/mm/damon.c
index da0e7efdf1e1..20a66a6307d1 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -59,6 +59,8 @@
 
 static void kdamond_init_vm_regions(struct damon_ctx *ctx);
 static void kdamond_update_vm_regions(struct damon_ctx *ctx);
+static void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
+static unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
 
 /* A monitoring context for debugfs interface users. */
 static struct damon_ctx damon_user_ctx = {
@@ -70,6 +72,8 @@ static struct damon_ctx damon_user_ctx = {
 
 	.init_target_regions = kdamond_init_vm_regions,
 	.update_target_regions = kdamond_update_vm_regions,
+	.prepare_access_checks = kdamond_prepare_vm_access_checks,
+	.check_accesses = kdamond_check_vm_accesses,
 };
 
 /*
@@ -506,7 +510,7 @@ static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
-static void damon_prepare_access_check(struct damon_ctx *ctx,
+static void damon_prepare_vm_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
@@ -514,7 +518,7 @@ static void damon_prepare_access_check(struct damon_ctx *ctx,
 	damon_mkold(mm, r->sampling_addr);
 }
 
-static void kdamond_prepare_access_checks(struct damon_ctx *ctx)
+static void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	struct mm_struct *mm;
@@ -525,7 +529,7 @@ static void kdamond_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			damon_prepare_access_check(ctx, mm, r);
+			damon_prepare_vm_access_check(ctx, mm, r);
 		mmput(mm);
 	}
 }
@@ -563,7 +567,7 @@ static bool damon_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void damon_check_access(struct damon_ctx *ctx,
+static void damon_check_vm_access(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
@@ -587,7 +591,7 @@ static void damon_check_access(struct damon_ctx *ctx,
 	last_addr = r->sampling_addr;
 }
 
-static unsigned int kdamond_check_accesses(struct damon_ctx *ctx)
+static unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	struct mm_struct *mm;
@@ -599,12 +603,12 @@ static unsigned int kdamond_check_accesses(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t) {
-			damon_check_access(ctx, mm, r);
+			damon_check_vm_access(ctx, mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
-
 		mmput(mm);
 	}
+
 	return max_nr_accesses;
 }
 
@@ -1134,13 +1138,13 @@ static int kdamond_fn(void *data)
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 	ctx->init_target_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
-		kdamond_prepare_access_checks(ctx);
+		ctx->prepare_access_checks(ctx);
 		if (ctx->sample_cb)
 			ctx->sample_cb(ctx);
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
-		max_nr_accesses = kdamond_check_accesses(ctx);
+		max_nr_accesses = ctx->check_accesses(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
-- 
2.17.1

