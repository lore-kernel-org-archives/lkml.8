Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF04C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91AD20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BbF9P9Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgFCOMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:12:49 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36208 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFCOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193565; x=1622729565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HdcrPuLgRalMd0xvT2Nk9yFYbm77J9Vp5ajfx1XxAKI=;
  b=BbF9P9NaetUd+WJ94PFmS125Axrb3fhxWouB8zeG5Lb06A2XwwWafrtZ
   R/7CzdRHu8VuKpnaLi2ITdtFOxkl9VHWle9hvfWz4J9s5JvW1TE6KqZ7M
   4hz+UioSvZmUk0AOlbCRj2vRqM63H80H7MK6Jzcb06IHrOcCcYNQpo83r
   8=;
IronPort-SDR: 9CalquzHuRYWE2RJ+k9p9Y8ZBwl9SEZFdnvMce1l17HjCYXClmVQDJpvSN1NJ9+kxG4VZEueQy
 N+Rx8naSOHtg==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="35572938"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 14:12:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 22480A1852;
        Wed,  3 Jun 2020 14:12:30 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:12:29 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:12:12 +0000
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
Subject: [RFC v2 1/9] mm/damon: Use vm-independent address range concept
Date:   Wed, 3 Jun 2020 16:11:27 +0200
Message-ID: <20200603141135.10575-2-sjpark@amazon.com>
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

DAMON's main idea is not limited to virtual address space.  To prepare
for further expansion of the support for other address spaces including
physical memory, this commit modifies one of its core struct, 'struct
damon_region' to use virtual memory independent address space concept.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 20 +++++++++++------
 mm/damon-test.h       | 42 ++++++++++++++++++------------------
 mm/damon.c            | 50 +++++++++++++++++++++----------------------
 3 files changed, 59 insertions(+), 53 deletions(-)

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
diff --git a/mm/damon-test.h b/mm/damon-test.h
index 5b18619efe72..9dd2061502cb 100644
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
@@ -267,7 +267,7 @@ static void damon_test_aggregate(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 3, it);
 
 	/* The aggregated information should be written in the buffer */
-	sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
+	sr = sizeof(r->ar.start) + sizeof(r->ar.end) + sizeof(r->nr_accesses);
 	sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
 	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
 	KUNIT_EXPECT_EQ(test, (unsigned int)sz, ctx->rbuf_offset);
@@ -350,8 +350,8 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
-		KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
-		KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
+		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
 	damon_cleanup_global_state();
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
index ea6a8b6886b8..a9676b804b0b 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -80,7 +80,7 @@ static struct damon_ctx damon_user_ctx = {
  * Returns the pointer to the new struct if success, or NULL otherwise
  */
 static struct damon_region *damon_new_region(struct damon_ctx *ctx,
-				unsigned long vm_start, unsigned long vm_end)
+				unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
@@ -88,8 +88,8 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	if (!region)
 		return NULL;
 
-	region->vm_start = vm_start;
-	region->vm_end = vm_end;
+	region->ar.start = start;
+	region->ar.end = end;
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
@@ -277,16 +277,16 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
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
@@ -296,7 +296,7 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
 	}
 	/* complement last region for possible rounding error */
 	if (n)
-		n->vm_end = orig_end;
+		n->ar.end = orig_end;
 
 	return 0;
 }
@@ -509,7 +509,7 @@ static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 static void damon_prepare_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
-	r->sampling_addr = damon_rand(r->vm_start, r->vm_end);
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
 	damon_mkold(mm, r->sampling_addr);
 }
@@ -709,12 +709,12 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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
@@ -742,8 +742,8 @@ static int damos_madvise(struct damon_task *task, struct damon_region *r,
 	if (!mm)
 		goto put_task_out;
 
-	ret = do_madvise(t, mm, PAGE_ALIGN(r->vm_start),
-			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
 	mmput(mm);
 put_task_out:
 	put_task_struct(t);
@@ -790,7 +790,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
 	unsigned long sz;
 
 	damon_for_each_scheme(s, c) {
-		sz = r->vm_end - r->vm_start;
+		sz = r->ar.end - r->ar.start;
 		if ((s->min_sz_region && sz < s->min_sz_region) ||
 				(s->max_sz_region && s->max_sz_region < sz))
 			continue;
@@ -821,7 +821,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
-#define sz_damon_region(r) (r->vm_end - r->vm_start)
+#define sz_damon_region(r) (r->ar.end - r->ar.start)
 
 /*
  * Merge two adjacent regions into one region
@@ -834,7 +834,7 @@ static void damon_merge_two_regions(struct damon_region *l,
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
-	l->vm_end = r->vm_end;
+	l->ar.end = r->ar.end;
 	damon_destroy_region(r);
 }
 
@@ -856,7 +856,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		else
 			r->age++;
 
-		if (prev && prev->vm_end == r->vm_start &&
+		if (prev && prev->ar.end == r->ar.start &&
 		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres)
 			damon_merge_two_regions(prev, r);
 		else
@@ -893,8 +893,8 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 {
 	struct damon_region *new;
 
-	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
-	r->vm_end = new->vm_start;
+	new = damon_new_region(ctx, r->ar.start + sz_r, r->ar.end);
+	r->ar.end = new->ar.start;
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
@@ -911,7 +911,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 	int i;
 
 	damon_for_each_region_safe(r, next, t) {
-		sz_region = r->vm_end - r->vm_start;
+		sz_region = r->ar.end - r->ar.start;
 
 		for (i = 0; i < nr_subs - 1 &&
 				sz_region > 2 * MIN_REGION; i++) {
@@ -985,7 +985,7 @@ static bool kdamond_need_update_regions(struct damon_ctx *ctx)
  */
 static bool damon_intersect(struct damon_region *r, struct region *re)
 {
-	return !(r->vm_end <= re->start || re->end <= r->vm_start);
+	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
 
 /*
@@ -1024,7 +1024,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 					first = r;
 				last = r;
 			}
-			if (r->vm_start >= br->end)
+			if (r->ar.start >= br->end)
 				break;
 		}
 		if (!first) {
@@ -1036,8 +1036,8 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
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
-- 
2.17.1

