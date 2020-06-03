Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD820772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vbUCOu/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFCOOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:14:42 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:54367 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193680; x=1622729680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SRYgykF0yAohy2O2/4bBvbIs8aFrlPW/NT2qDFyZwWE=;
  b=vbUCOu/74qRdQK4VKPBpFZRcImn4bkwLASUcIkQDCHaJnJYUDbAf1fqm
   0J58ZcUJ7gGOBTpjM/zoefjnAAm8TiDGHkAdS7YfroduhJsRCW3GvI06y
   Bv6HgjEyUE6UbyHOV86jvm5Q61qe1qisTGPmxcHtWk/agyJ2sWLiqMRRF
   g=;
IronPort-SDR: 1kL31in7XtdjkETvtVd2fzBeZmIrdTWw1WeU3Rr7AK11SdSlFGC1OsaKPzcRq//dMRCiZ9uBym
 zSbFg8kH0BAQ==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="41265283"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Jun 2020 14:14:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id C67E51A18E6;
        Wed,  3 Jun 2020 14:14:37 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:14:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:14:21 +0000
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
Subject: [RFC v2 6/9] mm/damon: Make access check primitive configurable
Date:   Wed, 3 Jun 2020 16:11:32 +0200
Message-ID: <20200603141135.10575-7-sjpark@amazon.com>
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

DAMON assumes the target region is in virtual address space and
therefore uses PTE Accessed bit checking for access checking.  However,
as some CPU provides H/W based memory access check features that usually
more accurate and light-weight than PTE Accessed bit checking, some
users would want to use those in special use cases.  Also, some users
might want to use DAMON for different address spaces such as physical
memory space, which needs different ways to check the access.

This commit therefore allows DAMON users to configure the low level
access check primitives as they want.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 13 +++++++++++--
 mm/damon.c            | 20 +++++++++++---------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a1b6810ce0eb..1a788bfd1b4e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -160,13 +160,18 @@ struct damos {
  *
  * @init_target_regions:	Constructs initial monitoring target regions.
  * @update_target_regions:	Updates monitoring target regions.
+ * @prepare_access_checks:	Prepares next access check of target regions.
+ * @check_accesses:		Checks the access of target regions.
  * @sample_cb:			Called for each sampling interval.
  * @aggregate_cb:		Called for each aggregation interval.
  *
  * The monitoring thread calls @init_target_regions before starting the
- * monitoring, @update_target_regions for each @regions_update_interval.  By
+ * monitoring, @update_target_regions for each @regions_update_interval, and
+ * @prepare_access_checks and @check_accesses for each @sample_interval.  By
  * setting these callbacks to appropriate functions, therefore, users can
- * monitor specific range of virtual address space.
+ * monitor any address space with special handling.  If these are not
+ * explicitly configured, the functions for virtual memory address space
+ * monitoring are used.
  *
  * @sample_cb and @aggregate_cb are called from @kdamond for each of the
  * sampling intervals and aggregation intervals, respectively.  Therefore,
@@ -199,6 +204,8 @@ struct damon_ctx {
 	/* callbacks */
 	void (*init_target_regions)(struct damon_ctx *context);
 	void (*update_target_regions)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*sample_cb)(struct damon_ctx *context);
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
@@ -206,6 +213,8 @@ struct damon_ctx {
 /* Reference callback implementations for virtual memory */
 void kdamond_init_vm_regions(struct damon_ctx *ctx);
 void kdamond_update_vm_regions(struct damon_ctx *ctx);
+void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
+unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
 
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
diff --git a/mm/damon.c b/mm/damon.c
index c7806e81248a..f5cbc97a3bbc 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -75,6 +75,8 @@ static struct damon_ctx damon_user_ctx = {
 
 	.init_target_regions = kdamond_init_vm_regions,
 	.update_target_regions = kdamond_update_vm_regions,
+	.prepare_access_checks = kdamond_prepare_vm_access_checks,
+	.check_accesses = kdamond_check_vm_accesses,
 };
 
 /*
@@ -507,7 +509,7 @@ static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
-static void damon_prepare_access_check(struct damon_ctx *ctx,
+static void damon_prepare_vm_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
@@ -515,7 +517,7 @@ static void damon_prepare_access_check(struct damon_ctx *ctx,
 	damon_mkold(mm, r->sampling_addr);
 }
 
-static void kdamond_prepare_access_checks(struct damon_ctx *ctx)
+void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	struct mm_struct *mm;
@@ -526,7 +528,7 @@ static void kdamond_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			damon_prepare_access_check(ctx, mm, r);
+			damon_prepare_vm_access_check(ctx, mm, r);
 		mmput(mm);
 	}
 }
@@ -564,7 +566,7 @@ static bool damon_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void damon_check_access(struct damon_ctx *ctx,
+static void damon_check_vm_access(struct damon_ctx *ctx,
 			       struct mm_struct *mm, struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
@@ -588,7 +590,7 @@ static void damon_check_access(struct damon_ctx *ctx,
 	last_addr = r->sampling_addr;
 }
 
-static unsigned int kdamond_check_accesses(struct damon_ctx *ctx)
+unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	struct mm_struct *mm;
@@ -600,12 +602,12 @@ static unsigned int kdamond_check_accesses(struct damon_ctx *ctx)
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
 
@@ -1111,13 +1113,13 @@ static int kdamond_fn(void *data)
 	kdamond_write_record_header(ctx);
 
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

