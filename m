Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6EC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69FE22242
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WedRGohC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDIJoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:44:06 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:39008 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586425445; x=1617961445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XiS2374fsSGZdv9aLyHrmIE5A3AGAHwWAZGOPgqN40k=;
  b=WedRGohClJKwPmX2HjE5eU5hjFLNExPwqlanxUfNU06ynMDm0J8qdi21
   GmwlTkgzOouZT7p2CYXEm+cXmWhXfFA3rAB5X4MYdojNDBlBLbqt+ITiu
   DgO6Y+eXYcjbC0Rq0AABSrpxdNv8w9CtSUcLFpmmhQHSUhPNlchlbWx8y
   s=;
IronPort-SDR: 4VNG/GfQsZb9N8ApXp55nFYqLKxTuj3WyQxVZ7Om1kpBsWHCJtJ4CSwQXAsAKQunI1uPOzN/Le
 TUpCm1Euos+w==
X-IronPort-AV: E=Sophos;i="5.72,362,1580774400"; 
   d="scan'208";a="24812650"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Apr 2020 09:43:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 50F64A1FEE;
        Thu,  9 Apr 2020 09:43:47 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Apr 2020 09:43:32 +0000
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
Subject: [RFC PATCH 2/4] mm/damon: Clean up code using 'struct damon_addr_range'
Date:   Thu, 9 Apr 2020 11:42:30 +0200
Message-ID: <20200409094232.29680-3-sjpark@amazon.com>
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

There are unnecessarily duplicated code in DAMON, that can be eliminated
by using the new struct, 'damon_addr_range'.  This commit cleans up the
DAMON code in the way.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon-test.h | 36 ++++++++++++++--------------
 mm/damon.c      | 64 +++++++++++++++++++------------------------------
 2 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index 7fd66df1e493..7b2c903f1357 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -165,7 +165,7 @@ static void damon_test_set_pids(struct kunit *test)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
-	struct region regions[3] = {0,};
+	struct damon_addr_range regions[3] = {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
@@ -306,7 +306,7 @@ static void damon_test_write_rbuf(struct kunit *test)
  */
 static void damon_do_test_apply_three_regions(struct kunit *test,
 				unsigned long *regions, int nr_regions,
-				struct region *three_regions,
+				struct damon_addr_range *three_regions,
 				unsigned long *expected, int nr_expected)
 {
 	struct damon_task *t;
@@ -344,10 +344,10 @@ static void damon_test_apply_three_regions1(struct kunit *test)
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
@@ -366,10 +366,10 @@ static void damon_test_apply_three_regions2(struct kunit *test)
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
@@ -390,10 +390,10 @@ static void damon_test_apply_three_regions3(struct kunit *test)
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
@@ -415,10 +415,10 @@ static void damon_test_apply_three_regions4(struct kunit *test)
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
 
diff --git a/mm/damon.c b/mm/damon.c
index f9958952d09e..80fa3cab7720 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -304,19 +304,15 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
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
@@ -327,7 +323,7 @@ static void swap_regions(struct region *r1, struct region *r2)
  * Find the three regions in an address space
  *
  * vma		the head vma of the target address space
- * regions	an array of three 'struct region's that results will be saved
+ * regions	an array of three address ranges that results will be saved
  *
  * This function receives an address space and finds three regions in it which
  * separated by the two biggest unmapped regions in the space.  Please refer to
@@ -337,9 +333,9 @@ static void swap_regions(struct region *r1, struct region *r2)
  * Returns 0 if success, or negative error code otherwise.
  */
 static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
-		struct region regions[3])
+		struct damon_addr_range regions[3])
 {
-	struct region gap = {0,}, first_gap = {0,}, second_gap = {0,};
+	struct damon_addr_range gap = {0,}, first_gap = {0,}, second_gap = {0,};
 	struct vm_area_struct *last_vma = NULL;
 	unsigned long start = 0;
 
@@ -352,20 +348,20 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
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
 	regions[0].start = start;
@@ -384,7 +380,7 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
  * Returns 0 on success, negative error code otherwise.
  */
 static int damon_three_regions_of(struct damon_task *t,
-				struct region regions[3])
+				struct damon_addr_range regions[3])
 {
 	struct mm_struct *mm;
 	int rc;
@@ -446,7 +442,7 @@ static int damon_three_regions_of(struct damon_task *t,
 static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
 {
 	struct damon_region *r;
-	struct region regions[3];
+	struct damon_addr_range regions[3];
 	int i;
 
 	if (damon_three_regions_of(t, regions)) {
@@ -864,18 +860,6 @@ static void damon_merge_two_regions(struct damon_region *l,
 	damon_destroy_region(r);
 }
 
-static inline void set_last_area(struct damon_region *r, struct region *last)
-{
-	r->last_ar.start = last->start;
-	r->last_ar.end = last->end;
-}
-
-static inline void get_last_area(struct damon_region *r, struct region *last)
-{
-	last->start = r->last_ar.start;
-	last->end = r->last_ar.end;
-}
-
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -900,7 +884,7 @@ static inline void get_last_area(struct damon_region *r, struct region *last)
 static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 {
 	struct damon_region *r, *prev = NULL, *next;
-	struct region biggest_mergee;	/* the biggest region being merged */
+	struct damon_addr_range biggest_mergee;
 	unsigned long sz_biggest = 0;	/* size of the biggest_mergee */
 	unsigned long sz_mergee = 0;	/* size of current mergee */
 
@@ -908,11 +892,11 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		if (!prev || prev->ar.end != r->ar.start ||
 		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
 			if (sz_biggest)
-				set_last_area(prev, &biggest_mergee);
+				prev->last_ar = biggest_mergee;
 
 			prev = r;
 			sz_biggest = sz_damon_region(prev);
-			get_last_area(prev, &biggest_mergee);
+			biggest_mergee = prev->ar;
 			continue;
 		}
 
@@ -921,7 +905,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		sz_mergee += sz_damon_region(r);
 		if (sz_mergee > sz_biggest) {
 			sz_biggest = sz_mergee;
-			get_last_area(r, &biggest_mergee);
+			biggest_mergee = r->ar;
 		}
 
 		/*
@@ -934,7 +918,7 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 		damon_merge_two_regions(prev, r);
 	}
 	if (sz_biggest)
-		set_last_area(prev, &biggest_mergee);
+		prev->last_ar = biggest_mergee;
 }
 
 /*
@@ -1032,7 +1016,7 @@ static bool kdamond_need_update_regions(struct damon_ctx *ctx)
 			ctx->regions_update_interval);
 }
 
-static bool damon_intersect(struct damon_region *r, struct region *re)
+static bool damon_intersect(struct damon_region *r, struct damon_addr_range *re)
 {
 	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
@@ -1044,7 +1028,7 @@ static bool damon_intersect(struct damon_region *r, struct region *re)
  * bregions	the three big regions of the task
  */
 static void damon_apply_three_regions(struct damon_ctx *ctx,
-		struct damon_task *t, struct region bregions[3])
+		struct damon_task *t, struct damon_addr_range bregions[3])
 {
 	struct damon_region *r, *next;
 	unsigned int i = 0;
@@ -1063,7 +1047,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 	for (i = 0; i < 3; i++) {
 		struct damon_region *first = NULL, *last;
 		struct damon_region *newr;
-		struct region *br;
+		struct damon_addr_range *br;
 
 		br = &bregions[i];
 		/* Get the first and last regions which intersects with br */
@@ -1092,7 +1076,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
  */
 static void kdamond_update_regions(struct damon_ctx *ctx)
 {
-	struct region three_regions[3];
+	struct damon_addr_range three_regions[3];
 	struct damon_task *t;
 
 	damon_for_each_task(ctx, t) {
-- 
2.17.1

