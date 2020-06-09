Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCEC206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fpBTw6jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgFIOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:20:55 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:26246 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591712450; x=1623248450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QfG5eKoD+sZ//7OiS8Fehvn0otmU61iX4KRNGPgG1BA=;
  b=fpBTw6jc3b4K04m+pIX4CKAl6XxqCm0yj0d9/LK73gdqLcocR2t0EOdT
   yAClgv88U8vJE0/5nu+VIi5HQLJS6yu+4aJO+0bCc54gnl1ocSkGwZszY
   BExCrJ+hnZLEuz+AizBIh4GCFJ8SAYwlgS7bZ/D37m+q7ZlTcJA0waewq
   0=;
IronPort-SDR: E42dogMr/dT/P/eMFkUcyxmW31bPAboJCxDhedHmjnCGWokaAT4DBH62rcQTO+MS7foDk6NUvn
 qnkjIWgQjU4g==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="36625790"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Jun 2020 14:20:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id E5708A2007;
        Tue,  9 Jun 2020 14:20:37 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:20:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:20:19 +0000
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
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v3 01/10] mm/damon: Use vm-independent address range concept
Date:   Tue, 9 Jun 2020 16:19:32 +0200
Message-ID: <20200609141941.19184-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609141941.19184-1-sjpark@amazon.com>
References: <20200609141941.19184-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON's main idea is not limited to virtual address space.  To prepare
for further expansion of the support for other address spaces including
physical memory, this commit modifies one of its core struct, 'struct
damon_region' to use virtual memory independent address space concept,
and cleans up the code using it.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h        | 20 +++++---
 include/trace/events/damon.h |  4 +-
 mm/damon-test.h              | 78 +++++++++++++++---------------
 mm/damon.c                   | 94 +++++++++++++++++-------------------
 4 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e77256cf30dd..b4b06ca905a2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -16,11 +16,18 @@
 #include <linux/types.h>
 
 /**
- * struct damon_region - Represents a monitoring target region of
- * [@vm_start, @vm_end).
- *
- * @vm_start:		Start address of the region (inclusive).
- * @vm_end:		End address of the region (exclusive).
+ * struct damon_addr_range - Represents an address region of [@start, @end).
+ * @start:	Start address of the region (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_addr_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+/**
+ * struct damon_region - Represents a monitoring target region.
+ * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
@@ -33,8 +40,7 @@
  * region are set as region size-weighted average of those of the two regions.
  */
 struct damon_region {
-	unsigned long vm_start;
-	unsigned long vm_end;
+	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index fd260463d5b8..471b6e49960f 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -27,8 +27,8 @@ TRACE_EVENT(damon_aggregated,
 	TP_fast_assign(
 		__entry->pid = t->pid;
 		__entry->nr_regions = nr_regions;
-		__entry->vm_start = r->vm_start;
-		__entry->vm_end = r->vm_end;
+		__entry->vm_start = r->ar.start;
+		__entry->vm_end = r->ar.end;
 		__entry->nr_accesses = r->nr_accesses;
 	),
 
diff --git a/mm/damon-test.h b/mm/damon-test.h
index 5b18619efe72..6d01f0e782d5 100644
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
@@ -177,7 +177,7 @@ static void damon_test_set_recording(struct kunit *test)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
-	struct region regions[3] = {0,};
+	struct damon_addr_range regions[3] = {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
@@ -267,7 +267,7 @@ static void damon_test_aggregate(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 3, it);
 
 	/* The aggregated information should be written in the buffer */
-	sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
+	sr = sizeof(r->ar.start) + sizeof(r->ar.end) + sizeof(r->nr_accesses);
 	sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
 	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
 	KUNIT_EXPECT_EQ(test, (unsigned int)sz, ctx->rbuf_offset);
@@ -331,7 +331,7 @@ static struct damon_region *__nth_region_of(struct damon_task *t, int idx)
  */
 static void damon_do_test_apply_three_regions(struct kunit *test,
 				unsigned long *regions, int nr_regions,
-				struct region *three_regions,
+				struct damon_addr_range *three_regions,
 				unsigned long *expected, int nr_expected)
 {
 	struct damon_task *t;
@@ -350,8 +350,8 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
-		KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
-		KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
 	damon_cleanup_global_state();
@@ -369,10 +369,10 @@ static void damon_test_apply_three_regions1(struct kunit *test)
 	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
 				70, 80, 80, 90, 90, 100};
 	/* 5-27, 45-55, 73-104 */
-	struct region new_three_regions[3] = {
-		(struct region){.start = 5, .end = 27},
-		(struct region){.start = 45, .end = 55},
-		(struct region){.start = 73, .end = 104} };
+	struct damon_addr_range new_three_regions[3] = {
+		(struct damon_addr_range){.start = 5, .end = 27},
+		(struct damon_addr_range){.start = 45, .end = 55},
+		(struct damon_addr_range){.start = 73, .end = 104} };
 	/* 5-20-27, 45-55, 73-80-90-104 */
 	unsigned long expected[] = {5, 20, 20, 27, 45, 55,
 				73, 80, 80, 90, 90, 104};
@@ -391,10 +391,10 @@ static void damon_test_apply_three_regions2(struct kunit *test)
 	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
 				70, 80, 80, 90, 90, 100};
 	/* 5-27, 56-57, 65-104 */
-	struct region new_three_regions[3] = {
-		(struct region){.start = 5, .end = 27},
-		(struct region){.start = 56, .end = 57},
-		(struct region){.start = 65, .end = 104} };
+	struct damon_addr_range new_three_regions[3] = {
+		(struct damon_addr_range){.start = 5, .end = 27},
+		(struct damon_addr_range){.start = 56, .end = 57},
+		(struct damon_addr_range){.start = 65, .end = 104} };
 	/* 5-20-27, 56-57, 65-80-90-104 */
 	unsigned long expected[] = {5, 20, 20, 27, 56, 57,
 				65, 80, 80, 90, 90, 104};
@@ -415,10 +415,10 @@ static void damon_test_apply_three_regions3(struct kunit *test)
 	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
 				70, 80, 80, 90, 90, 100};
 	/* 5-27, 61-63, 65-104 */
-	struct region new_three_regions[3] = {
-		(struct region){.start = 5, .end = 27},
-		(struct region){.start = 61, .end = 63},
-		(struct region){.start = 65, .end = 104} };
+	struct damon_addr_range new_three_regions[3] = {
+		(struct damon_addr_range){.start = 5, .end = 27},
+		(struct damon_addr_range){.start = 61, .end = 63},
+		(struct damon_addr_range){.start = 65, .end = 104} };
 	/* 5-20-27, 61-63, 65-80-90-104 */
 	unsigned long expected[] = {5, 20, 20, 27, 61, 63,
 				65, 80, 80, 90, 90, 104};
@@ -440,10 +440,10 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
 				70, 80, 80, 90, 90, 100};
 	/* 5-7, 30-32, 65-68 */
-	struct region new_three_regions[3] = {
-		(struct region){.start = 5, .end = 7},
-		(struct region){.start = 30, .end = 32},
-		(struct region){.start = 65, .end = 68} };
+	struct damon_addr_range new_three_regions[3] = {
+		(struct damon_addr_range){.start = 5, .end = 7},
+		(struct damon_addr_range){.start = 30, .end = 32},
+		(struct damon_addr_range){.start = 65, .end = 68} };
 	/* expect 5-7, 30-32, 65-68 */
 	unsigned long expected[] = {5, 7, 30, 32, 65, 68};
 
@@ -470,8 +470,8 @@ static void damon_test_split_evenly(struct kunit *test)
 
 	i = 0;
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->vm_start, i++ * 10);
-		KUNIT_EXPECT_EQ(test, r->vm_end, i * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.start, i++ * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.end, i * 10);
 	}
 	damon_free_task(t);
 
@@ -485,11 +485,11 @@ static void damon_test_split_evenly(struct kunit *test)
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
@@ -499,8 +499,8 @@ static void damon_test_split_evenly(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 1u);
 
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
-		KUNIT_EXPECT_EQ(test, r->vm_end, 6ul);
+		KUNIT_EXPECT_EQ(test, r->ar.start, 5ul);
+		KUNIT_EXPECT_EQ(test, r->ar.end, 6ul);
 	}
 	damon_free_task(t);
 }
@@ -514,12 +514,12 @@ static void damon_test_split_at(struct kunit *test)
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
@@ -539,8 +539,8 @@ static void damon_test_merge_two(struct kunit *test)
 	damon_add_region(r2, t);
 
 	damon_merge_two_regions(r, r2);
-	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
-	KUNIT_EXPECT_EQ(test, r->vm_end, 300ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
 
 	i = 0;
@@ -577,8 +577,8 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
 	for (i = 0; i < 5; i++) {
 		r = __nth_region_of(t, i);
-		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
-		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
 	damon_free_task(t);
 }
diff --git a/mm/damon.c b/mm/damon.c
index 98fd32ace6f7..fcd919e96754 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -95,7 +95,7 @@ static struct damon_ctx damon_user_ctx = {
  * Returns the pointer to the new struct if success, or NULL otherwise
  */
 static struct damon_region *damon_new_region(struct damon_ctx *ctx,
-				unsigned long vm_start, unsigned long vm_end)
+				unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
@@ -103,8 +103,8 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	if (!region)
 		return NULL;
 
-	region->vm_start = vm_start;
-	region->vm_end = vm_end;
+	region->ar.start = start;
+	region->ar.end = end;
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
@@ -296,16 +296,16 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
 	if (!r || !nr_pieces)
 		return -EINVAL;
 
-	orig_end = r->vm_end;
-	sz_orig = r->vm_end - r->vm_start;
+	orig_end = r->ar.end;
+	sz_orig = r->ar.end - r->ar.start;
 	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, MIN_REGION);
 
 	if (!sz_piece)
 		return -EINVAL;
 
-	r->vm_end = r->vm_start + sz_piece;
+	r->ar.end = r->ar.start + sz_piece;
 	next = damon_next_region(r);
-	for (start = r->vm_end; start + sz_piece <= orig_end;
+	for (start = r->ar.end; start + sz_piece <= orig_end;
 			start += sz_piece) {
 		n = damon_new_region(ctx, start, start + sz_piece);
 		if (!n)
@@ -315,24 +315,20 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
 	}
 	/* complement last region for possible rounding error */
 	if (n)
-		n->vm_end = orig_end;
+		n->ar.end = orig_end;
 
 	return 0;
 }
 
-struct region {
-	unsigned long start;
-	unsigned long end;
-};
-
-static unsigned long sz_region(struct region *r)
+static unsigned long sz_range(struct damon_addr_range *r)
 {
 	return r->end - r->start;
 }
 
-static void swap_regions(struct region *r1, struct region *r2)
+static void swap_ranges(struct damon_addr_range *r1,
+			struct damon_addr_range *r2)
 {
-	struct region tmp;
+	struct damon_addr_range tmp;
 
 	tmp = *r1;
 	*r1 = *r2;
@@ -343,7 +339,7 @@ static void swap_regions(struct region *r1, struct region *r2)
  * Find three regions separated by two biggest unmapped regions
  *
  * vma		the head vma of the target address space
- * regions	an array of three 'struct region's that results will be saved
+ * regions	an array of three address ranges that results will be saved
  *
  * This function receives an address space and finds three regions in it which
  * separated by the two biggest unmapped regions in the space.  Please refer to
@@ -353,9 +349,9 @@ static void swap_regions(struct region *r1, struct region *r2)
  * Returns 0 if success, or negative error code otherwise.
  */
 static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
-		struct region regions[3])
+		struct damon_addr_range regions[3])
 {
-	struct region gap = {0}, first_gap = {0}, second_gap = {0};
+	struct damon_addr_range gap = {0}, first_gap = {0}, second_gap = {0};
 	struct vm_area_struct *last_vma = NULL;
 	unsigned long start = 0;
 
@@ -368,20 +364,20 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
 		}
 		gap.start = last_vma->vm_end;
 		gap.end = vma->vm_start;
-		if (sz_region(&gap) > sz_region(&second_gap)) {
-			swap_regions(&gap, &second_gap);
-			if (sz_region(&second_gap) > sz_region(&first_gap))
-				swap_regions(&second_gap, &first_gap);
+		if (sz_range(&gap) > sz_range(&second_gap)) {
+			swap_ranges(&gap, &second_gap);
+			if (sz_range(&second_gap) > sz_range(&first_gap))
+				swap_ranges(&second_gap, &first_gap);
 		}
 		last_vma = vma;
 	}
 
-	if (!sz_region(&second_gap) || !sz_region(&first_gap))
+	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
-		swap_regions(&first_gap, &second_gap);
+		swap_ranges(&first_gap, &second_gap);
 
 	/* Store the result */
 	regions[0].start = ALIGN(start, MIN_REGION);
@@ -400,7 +396,7 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
  * Returns 0 on success, negative error code otherwise.
  */
 static int damon_three_regions_of(struct damon_task *t,
-				struct region regions[3])
+				struct damon_addr_range regions[3])
 {
 	struct mm_struct *mm;
 	int rc;
@@ -462,7 +458,7 @@ static int damon_three_regions_of(struct damon_task *t,
 static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
 {
 	struct damon_region *r, *m = NULL;
-	struct region regions[3];
+	struct damon_addr_range regions[3];
 	int i;
 
 	if (damon_three_regions_of(t, regions)) {
@@ -501,15 +497,13 @@ static void kdamond_init_regions(struct damon_ctx *ctx)
  */
 
 /*
- * Check whether regions are intersecting
- *
- * Note that this function checks 'struct damon_region' and 'struct region'.
+ * Check whether a region is intersecting an address range
  *
  * Returns true if it is.
  */
-static bool damon_intersect(struct damon_region *r, struct region *re)
+static bool damon_intersect(struct damon_region *r, struct damon_addr_range *re)
 {
-	return !(r->vm_end <= re->start || re->end <= r->vm_start);
+	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
 
 /*
@@ -519,7 +513,7 @@ static bool damon_intersect(struct damon_region *r, struct region *re)
  * bregions	the three big regions of the task
  */
 static void damon_apply_three_regions(struct damon_ctx *ctx,
-		struct damon_task *t, struct region bregions[3])
+		struct damon_task *t, struct damon_addr_range bregions[3])
 {
 	struct damon_region *r, *next;
 	unsigned int i = 0;
@@ -538,7 +532,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 	for (i = 0; i < 3; i++) {
 		struct damon_region *first = NULL, *last;
 		struct damon_region *newr;
-		struct region *br;
+		struct damon_addr_range *br;
 
 		br = &bregions[i];
 		/* Get the first and last regions which intersects with br */
@@ -548,7 +542,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 					first = r;
 				last = r;
 			}
-			if (r->vm_start >= br->end)
+			if (r->ar.start >= br->end)
 				break;
 		}
 		if (!first) {
@@ -560,8 +554,8 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 				continue;
 			damon_insert_region(newr, damon_prev_region(r), r);
 		} else {
-			first->vm_start = ALIGN_DOWN(br->start, MIN_REGION);
-			last->vm_end = ALIGN(br->end, MIN_REGION);
+			first->ar.start = ALIGN_DOWN(br->start, MIN_REGION);
+			last->ar.end = ALIGN(br->end, MIN_REGION);
 		}
 	}
 }
@@ -571,7 +565,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
  */
 static void kdamond_update_regions(struct damon_ctx *ctx)
 {
-	struct region three_regions[3];
+	struct damon_addr_range three_regions[3];
 	struct damon_task *t;
 
 	damon_for_each_task(t, ctx) {
@@ -617,7 +611,7 @@ static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 static void damon_prepare_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
-	r->sampling_addr = damon_rand(r->vm_start, r->vm_end);
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
 	damon_mkold(mm, r->sampling_addr);
 }
@@ -821,8 +815,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		nr = nr_damon_regions(t);
 		damon_write_rbuf(c, &nr, sizeof(nr));
 		damon_for_each_region(r, t) {
-			damon_write_rbuf(c, &r->vm_start, sizeof(r->vm_start));
-			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
+			damon_write_rbuf(c, &r->ar.start, sizeof(r->ar.start));
+			damon_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
 			trace_damon_aggregated(t, r, nr);
@@ -853,8 +847,8 @@ static int damos_madvise(struct damon_task *task, struct damon_region *r,
 	if (!mm)
 		goto put_task_out;
 
-	ret = do_madvise(t, mm, PAGE_ALIGN(r->vm_start),
-			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
 	mmput(mm);
 put_task_out:
 	put_task_struct(t);
@@ -901,7 +895,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
 	unsigned long sz;
 
 	damon_for_each_scheme(s, c) {
-		sz = r->vm_end - r->vm_start;
+		sz = r->ar.end - r->ar.start;
 		if ((s->min_sz_region && sz < s->min_sz_region) ||
 				(s->max_sz_region && s->max_sz_region < sz))
 			continue;
@@ -932,7 +926,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
-#define sz_damon_region(r) (r->vm_end - r->vm_start)
+#define sz_damon_region(r) (r->ar.end - r->ar.start)
 
 /*
  * Merge two adjacent regions into one region
@@ -945,7 +939,7 @@ static void damon_merge_two_regions(struct damon_region *l,
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
-	l->vm_end = r->vm_end;
+	l->ar.end = r->ar.end;
 	damon_destroy_region(r);
 }
 
@@ -967,7 +961,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		else
 			r->age++;
 
-		if (prev && prev->vm_end == r->vm_start &&
+		if (prev && prev->ar.end == r->ar.start &&
 		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres)
 			damon_merge_two_regions(prev, r);
 		else
@@ -1004,8 +998,8 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 {
 	struct damon_region *new;
 
-	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
-	r->vm_end = new->vm_start;
+	new = damon_new_region(ctx, r->ar.start + sz_r, r->ar.end);
+	r->ar.end = new->ar.start;
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
@@ -1022,7 +1016,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 	int i;
 
 	damon_for_each_region_safe(r, next, t) {
-		sz_region = r->vm_end - r->vm_start;
+		sz_region = r->ar.end - r->ar.start;
 
 		for (i = 0; i < nr_subs - 1 &&
 				sz_region > 2 * MIN_REGION; i++) {
-- 
2.17.1

