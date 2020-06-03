Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD5920772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SDzcABIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCONR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:13:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:41565 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFCONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193594; x=1622729594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RSeCraCWvQ2SO2B882JJ9QFVdUoepG0Yn3yCcaEeubE=;
  b=SDzcABInoP5yGDG1J9ZUfOmKkiMkC4KqMsw1hXaQG5VBImXUt75zuxFj
   boOKK9s2eUXu/xfK+vu0kh/WH5PQn1I9gIZ5WPH/Wptrw4QjYsXpMkHaj
   VXRRdEWHueub5eWqt+jrWCnj/GfIDhsIw1eWg6/2kmfhD+Hq21AwrtC3S
   c=;
IronPort-SDR: lbCK1x6wFLNRjmzwSvqq5e+tt5rawN8U5ina3oNFDCOa80uKD5HnO/IEUkkG4ueE+oQ2VNQ7j0
 UoSoZmc49sAQ==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="34278974"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Jun 2020 14:12:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 0ECCAA2370;
        Wed,  3 Jun 2020 14:12:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:12:55 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:12:39 +0000
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
Subject: [RFC v2 2/9] mm/damon: Clean up code using 'struct damon_addr_range'
Date:   Wed, 3 Jun 2020 16:11:28 +0200
Message-ID: <20200603141135.10575-3-sjpark@amazon.com>
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

There are unnecessarily duplicated code in DAMON, that can be eliminated
by using the new struct, 'damon_addr_range'.  This commit cleans up the
DAMON code in the way.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon-test.h | 36 ++++++++++++++++++------------------
 mm/damon.c      | 46 ++++++++++++++++++++--------------------------
 2 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index 9dd2061502cb..6d01f0e782d5 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -177,7 +177,7 @@ static void damon_test_set_recording(struct kunit *test)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
-	struct region regions[3] = {0,};
+	struct damon_addr_range regions[3] = {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
@@ -331,7 +331,7 @@ static struct damon_region *__nth_region_of(struct damon_task *t, int idx)
  */
 static void damon_do_test_apply_three_regions(struct kunit *test,
 				unsigned long *regions, int nr_regions,
-				struct region *three_regions,
+				struct damon_addr_range *three_regions,
 				unsigned long *expected, int nr_expected)
 {
 	struct damon_task *t;
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
 
diff --git a/mm/damon.c b/mm/damon.c
index a9676b804b0b..f6dd34425185 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -301,19 +301,15 @@ static int damon_split_region_evenly(struct damon_ctx *ctx,
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
@@ -324,7 +320,7 @@ static void swap_regions(struct region *r1, struct region *r2)
  * Find three regions separated by two biggest unmapped regions
  *
  * vma		the head vma of the target address space
- * regions	an array of three 'struct region's that results will be saved
+ * regions	an array of three address ranges that results will be saved
  *
  * This function receives an address space and finds three regions in it which
  * separated by the two biggest unmapped regions in the space.  Please refer to
@@ -334,9 +330,9 @@ static void swap_regions(struct region *r1, struct region *r2)
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
 
@@ -349,20 +345,20 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
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
@@ -381,7 +377,7 @@ static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
  * Returns 0 on success, negative error code otherwise.
  */
 static int damon_three_regions_of(struct damon_task *t,
-				struct region regions[3])
+				struct damon_addr_range regions[3])
 {
 	struct mm_struct *mm;
 	int rc;
@@ -443,7 +439,7 @@ static int damon_three_regions_of(struct damon_task *t,
 static void damon_init_regions_of(struct damon_ctx *c, struct damon_task *t)
 {
 	struct damon_region *r, *m = NULL;
-	struct region regions[3];
+	struct damon_addr_range regions[3];
 	int i;
 
 	if (damon_three_regions_of(t, regions)) {
@@ -977,13 +973,11 @@ static bool kdamond_need_update_regions(struct damon_ctx *ctx)
 }
 
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
 	return !(r->ar.end <= re->start || re->end <= r->ar.start);
 }
@@ -995,7 +989,7 @@ static bool damon_intersect(struct damon_region *r, struct region *re)
  * bregions	the three big regions of the task
  */
 static void damon_apply_three_regions(struct damon_ctx *ctx,
-		struct damon_task *t, struct region bregions[3])
+		struct damon_task *t, struct damon_addr_range bregions[3])
 {
 	struct damon_region *r, *next;
 	unsigned int i = 0;
@@ -1014,7 +1008,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
 	for (i = 0; i < 3; i++) {
 		struct damon_region *first = NULL, *last;
 		struct damon_region *newr;
-		struct region *br;
+		struct damon_addr_range *br;
 
 		br = &bregions[i];
 		/* Get the first and last regions which intersects with br */
@@ -1047,7 +1041,7 @@ static void damon_apply_three_regions(struct damon_ctx *ctx,
  */
 static void kdamond_update_regions(struct damon_ctx *ctx)
 {
-	struct region three_regions[3];
+	struct damon_addr_range three_regions[3];
 	struct damon_task *t;
 
 	damon_for_each_task(t, ctx) {
-- 
2.17.1

