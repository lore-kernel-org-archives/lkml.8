Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DFC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F822206
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Aac8a9tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDIJnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:43:25 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:49843 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDIJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586425405; x=1617961405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eJdgkB1g/K1jRRQidYcVaQejEdoFAC1wMAfV1Ww6yws=;
  b=Aac8a9tAHMZ6ANO59GfBH0deTgvYCSmXtr+pdYA6uBm6dVY1xWF32K3u
   /qKaMW4BO3ZcM2EXS++loOURiPMbLdAlfDTadKtPGOsvJs/brJdWh+VQm
   1wLJhCBHForfAjIU2qLMIi6+SWzo7Hy2XjB/us+fBvtBTSPJk9jqVrfd6
   o=;
IronPort-SDR: orQxzxSS55iQqc+T3T5nm8Firl3XqpSHalhZo0Sx5WzDek4vQG5VqHCzHSNYPjhc0nmSin4O8D
 SNWlYOlGS74Q==
X-IronPort-AV: E=Sophos;i="5.72,362,1580774400"; 
   d="scan'208";a="37581156"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Apr 2020 09:43:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 572E9A181A;
        Thu,  9 Apr 2020 09:43:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:05 +0000
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
Subject: [RFC PATCH 1/4] mm/damon: Use vm-independent address range concept
Date:   Thu, 9 Apr 2020 11:42:29 +0200
Message-ID: <20200409094232.29680-2-sjpark@amazon.com>
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

DAMON's main idea is not limited to virtual address space.  To prepare
for further expansion of the support for other address spaces including
physical memory, this commit modifies one of its core struct, 'struct
damon_region' to use virtual memory independent address space concept.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 11 ++++---
 mm/damon-test.h       | 46 +++++++++++++-------------
 mm/damon.c            | 76 +++++++++++++++++++++----------------------
 3 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b0fa898ed6d8..d72dd524924f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -15,17 +15,20 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 
+struct damon_addr_range {
+	unsigned long start;
+	unsigned long end;
+};
+
 /* Represents a monitoring target region on the virtual address space */
 struct damon_region {
-	unsigned long vm_start;
-	unsigned long vm_end;
+	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
 
 	unsigned int age;
-	unsigned long last_vm_start;
-	unsigned long last_vm_end;
+	struct damon_addr_range last_ar;
 	unsigned int last_nr_accesses;
 };
 
diff --git a/mm/damon-test.h b/mm/damon-test.h
index af6a1e84b8eb..7fd66df1e493 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -78,8 +78,8 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_task *t;
 
 	r = damon_new_region(&damon_user_ctx, 1, 2);
-	KUNIT_EXPECT_EQ(test, 1ul, r->vm_start);
-	KUNIT_EXPECT_EQ(test, 2ul, r->vm_end);
+	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
+	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_task(42);
@@ -255,7 +255,7 @@ static void damon_test_aggregate(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 3, it);
 
 	/* The aggregated information should be written in the buffer */
-	sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
+	sr = sizeof(r->ar.start) + sizeof(r->ar.end) + sizeof(r->nr_accesses);
 	sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
 	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
 	KUNIT_EXPECT_EQ(test, (unsigned int)sz, ctx->rbuf_offset);
@@ -325,8 +325,8 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = damon_nth_region_of(t, i);
-		KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
-		KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
 	damon_cleanup_global_state();
@@ -445,8 +445,8 @@ static void damon_test_split_evenly(struct kunit *test)
 
 	i = 0;
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->vm_start, i++ * 10);
-		KUNIT_EXPECT_EQ(test, r->vm_end, i * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.start, i++ * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.end, i * 10);
 	}
 	damon_free_task(t);
 
@@ -460,11 +460,11 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_for_each_region(r, t) {
 		if (i == 4)
 			break;
-		KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i++);
-		KUNIT_EXPECT_EQ(test, r->vm_end, 5 + 10 * i);
+		KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i++);
+		KUNIT_EXPECT_EQ(test, r->ar.end, 5 + 10 * i);
 	}
-	KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i);
-	KUNIT_EXPECT_EQ(test, r->vm_end, 59ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 59ul);
 	damon_free_task(t);
 
 	t = damon_new_task(42);
@@ -474,8 +474,8 @@ static void damon_test_split_evenly(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 1u);
 
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
-		KUNIT_EXPECT_EQ(test, r->vm_end, 6ul);
+		KUNIT_EXPECT_EQ(test, r->ar.start, 5ul);
+		KUNIT_EXPECT_EQ(test, r->ar.end, 6ul);
 	}
 	damon_free_task(t);
 }
@@ -489,12 +489,12 @@ static void damon_test_split_at(struct kunit *test)
 	r = damon_new_region(&damon_user_ctx, 0, 100);
 	damon_add_region(r, t);
 	damon_split_region_at(&damon_user_ctx, r, 25);
-	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
-	KUNIT_EXPECT_EQ(test, r->vm_end, 25ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
 	r = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r->vm_start, 25ul);
-	KUNIT_EXPECT_EQ(test, r->vm_end, 100ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
 
 	damon_free_task(t);
 }
@@ -514,8 +514,8 @@ static void damon_test_merge_two(struct kunit *test)
 	damon_add_region(r2, t);
 
 	damon_merge_two_regions(r, r2);
-	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
-	KUNIT_EXPECT_EQ(test, r->vm_end, 300ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
 
 	i = 0;
@@ -554,10 +554,10 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
 	for (i = 0; i < 5; i++) {
 		r = damon_nth_region_of(t, i);
-		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
-		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
-		KUNIT_EXPECT_EQ(test, r->last_vm_start, lsa[i]);
-		KUNIT_EXPECT_EQ(test, r->last_vm_end, lea[i]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->last_ar.start, lsa[i]);
+		KUNIT_EXPECT_EQ(test, r->last_ar.end, lea[i]);
 
 	}
 	damon_free_task(t);
diff --git a/mm/damon.c b/mm/damon.c
index 3f93da898d72..f9958952d09e 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -72,7 +72,7 @@ static struct damon_ctx damon_user_ctx = {
  * Returns the pointer to the new struct if success, or NULL otherwise
  */
 static struct damon_region *damon_new_region(struct damon_ctx *ctx,
-				unsigned long vm_start, unsigned long vm_end)
+				unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
@@ -80,14 +80,14 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	if (!region)
 		return NULL;
 
-	region->vm_start = vm_start;
-	region->vm_end = vm_end;
+	region->ar.start = start;
+	region->ar.end = end;
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
-	region->last_vm_start = vm_start;
-	region->last_vm_end = vm_end;
+	region->last_ar.start = start;
+	region->last_ar.end = end;
 
 	return region;
 }
@@ -282,16 +282,16 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
 	if (!r || !nr_pieces)
 		return -EINVAL;
 
-	orig_end = r->vm_end;
-	sz_orig = r->vm_end - r->vm_start;
+	orig_end = r->ar.end;
+	sz_orig = r->ar.end - r->ar.start;
 	sz_piece = sz_orig / nr_pieces;
 
 	if (!sz_piece)
 		return -EINVAL;
 
-	r->vm_end = r->vm_start + sz_piece;
+	r->ar.end = r->ar.start + sz_piece;
 	next = damon_next_region(r);
-	for (start = r->vm_end; start + sz_piece <= orig_end;
+	for (start = r->ar.end; start + sz_piece <= orig_end;
 			start += sz_piece) {
 		n = damon_new_region(ctx, start, start + sz_piece);
 		damon_insert_region(n, r, next);
@@ -299,7 +299,7 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
 	}
 	/* complement last region for possible rounding error */
 	if (n)
-		n->vm_end = orig_end;
+		n->ar.end = orig_end;
 
 	return 0;
 }
@@ -507,7 +507,7 @@ static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 static void damon_prepare_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
-	r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);
+	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
 
 	damon_mkold(mm, r->sampling_addr);
 }
@@ -708,12 +708,12 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		nr = nr_damon_regions(t);
 		damon_write_rbuf(c, &nr, sizeof(nr));
 		damon_for_each_region(r, t) {
-			damon_write_rbuf(c, &r->vm_start, sizeof(r->vm_start));
-			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
+			damon_write_rbuf(c, &r->ar.start, sizeof(r->ar.start));
+			damon_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
 			trace_damon_aggregated(t->pid, nr,
-					r->vm_start, r->vm_end, r->nr_accesses);
+					r->ar.start, r->ar.end, r->nr_accesses);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
@@ -730,10 +730,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
  */
 static void damon_do_count_age(struct damon_region *r, unsigned int threshold)
 {
-	unsigned long sz_threshold = (r->vm_end - r->vm_start) / 5;
+	unsigned long sz_threshold = (r->ar.end - r->ar.start) / 5;
 
-	if (diff_of(r->vm_start, r->last_vm_start) +
-			diff_of(r->vm_end, r->last_vm_end) > sz_threshold)
+	if (diff_of(r->ar.start, r->last_ar.start) +
+			diff_of(r->ar.end, r->last_ar.end) > sz_threshold)
 		r->age = 0;
 	else if (diff_of(r->nr_accesses, r->last_nr_accesses) > threshold)
 		r->age = 0;
@@ -773,8 +773,8 @@ static int damos_madvise(struct damon_task *task, struct damon_region *r,
 	if (!mm)
 		goto put_task_out;
 
-	ret = do_madvise(t, mm, PAGE_ALIGN(r->vm_start),
-			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
 	mmput(mm);
 put_task_out:
 	put_task_struct(t);
@@ -819,7 +819,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
 	unsigned long sz;
 
 	damon_for_each_schemes(c, s) {
-		sz = r->vm_end - r->vm_start;
+		sz = r->ar.end - r->ar.start;
 		if ((s->min_sz_region && sz < s->min_sz_region) ||
 				(s->max_sz_region && s->max_sz_region < sz))
 			continue;
@@ -847,7 +847,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
-#define sz_damon_region(r) (r->vm_end - r->vm_start)
+#define sz_damon_region(r) (r->ar.end - r->ar.start)
 
 /*
  * Merge two adjacent regions into one region
@@ -860,20 +860,20 @@ static void damon_merge_two_regions(struct damon_region *l,
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
-	l->vm_end = r->vm_end;
+	l->ar.end = r->ar.end;
 	damon_destroy_region(r);
 }
 
 static inline void set_last_area(struct damon_region *r, struct region *last)
 {
-	r->last_vm_start = last->start;
-	r->last_vm_end = last->end;
+	r->last_ar.start = last->start;
+	r->last_ar.end = last->end;
 }
 
 static inline void get_last_area(struct damon_region *r, struct region *last)
 {
-	last->start = r->last_vm_start;
-	last->end = r->last_vm_end;
+	last->start = r->last_ar.start;
+	last->end = r->last_ar.end;
 }
 
 /*
@@ -905,7 +905,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 	unsigned long sz_mergee = 0;	/* size of current mergee */
 
 	damon_for_each_region_safe(r, next, t) {
-		if (!prev || prev->vm_end != r->vm_start ||
+		if (!prev || prev->ar.end != r->ar.start ||
 		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
 			if (sz_biggest)
 				set_last_area(prev, &biggest_mergee);
@@ -928,7 +928,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		 * If next region and current region is not originated from
 		 * same region, initialize the size of mergee.
 		 */
-		if (r->last_vm_start != next->last_vm_start)
+		if (r->last_ar.start != next->last_ar.start)
 			sz_mergee = 0;
 
 		damon_merge_two_regions(prev, r);
@@ -966,14 +966,14 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 {
 	struct damon_region *new;
 
-	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	new = damon_new_region(ctx, r->ar.start + sz_r, r->ar.end);
 	new->age = r->age;
-	new->last_vm_start = r->vm_start;
+	new->last_ar.start = r->ar.start;
 	new->last_nr_accesses = r->last_nr_accesses;
 
-	r->last_vm_start = r->vm_start;
-	r->last_vm_end = r->vm_end;
-	r->vm_end = new->vm_start;
+	r->last_ar.start = r->ar.start;
+	r->last_ar.end = r->ar.end;
+	r->ar.end = new->ar.start;
 
 	damon_insert_region(new, r, damon_next_region(r));
 }
@@ -989,7 +989,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
 		 * 10 percent and at most 90% of original region
 		 */
 		sz_left_region = (prandom_u32_state(&ctx->rndseed) % 9 + 1) *
-			(r->vm_end - r->vm_start) / 10;
+			(r->ar.end - r->ar.start) / 10;
 		/* Do not allow blank region */
 		if (sz_left_region == 0)
 			continue;
@@ -1034,7 +1034,7 @@ static bool kdamond_need_update_regions(struct damon_ctx *ctx)
 
 static bool damon_intersect(struct damon_region *r, struct region *re)
 {
-	return !(r->vm_end <= re->start || re->end <= r->vm_start);
+	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
 
 /*
@@ -1073,7 +1073,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 					first = r;
 				last = r;
 			}
-			if (r->vm_start >= br->end)
+			if (r->ar.start >= br->end)
 				break;
 		}
 		if (!first) {
@@ -1081,8 +1081,8 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 			newr = damon_new_region(ctx, br->start, br->end);
 			damon_insert_region(newr, damon_prev_region(r), r);
 		} else {
-			first->vm_start = br->start;
-			last->vm_end = br->end;
+			first->ar.start = br->start;
+			last->ar.end = br->end;
 		}
 	}
 }
-- 
2.17.1

