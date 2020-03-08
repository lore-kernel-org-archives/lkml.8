Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF0AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FA206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgC1Qpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:43 -0400
Received: from mx.sdf.org ([205.166.94.20]:50074 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbgC1Qnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:33 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhJqQ014207
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:20 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhJ0C010012;
        Sat, 28 Mar 2020 16:43:19 GMT
Message-Id: <202003281643.02SGhJ0C010012@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sun, 8 Mar 2020 06:09:17 -0400
Subject: [RFC PATCH v1 33/50] lib/test_vmalloc.c: Use pseudorandom numbers
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test code doesn't need crypto-grade randomness.

Also:
* Simplify shuffle_array using the initialize-while-shuffling
  Fisher-Yates variant.
* Shrink the data type to u8; it's currently shuffling 8 items and
  exceeding 256 will not happen soon.
* Implement the sequential_test_order flag inside shuffle_array
  rather than testing it at each call site.  (This is implemented the
  compact way using an invariant conditional branch inside the loop.
  Modern branch predictors handle such things very efficiently.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org
---
 lib/test_vmalloc.c | 58 ++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 8bbefcaddfe84..27b06c97a2a08 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -74,22 +74,20 @@ test_report_one_done(void)
 
 static int random_size_align_alloc_test(void)
 {
-	unsigned long size, align, rnd;
+	unsigned long size, align;
 	void *ptr;
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		get_random_bytes(&rnd, sizeof(rnd));
-
 		/*
 		 * Maximum 1024 pages, if PAGE_SIZE is 4096.
 		 */
-		align = 1 << (rnd % 23);
+		align = prandom_u32_max(23);
 
 		/*
 		 * Maximum 10 pages.
 		 */
-		size = ((rnd % 10) + 1) * PAGE_SIZE;
+		size = (prandom_u32_max(10) + 1) * PAGE_SIZE;
 
 		ptr = __vmalloc_node_range(size, align,
 		   VMALLOC_START, VMALLOC_END,
@@ -157,20 +155,16 @@ static int fix_align_alloc_test(void)
 
 static int random_size_alloc_test(void)
 {
-	unsigned int n;
 	void *p;
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		get_random_bytes(&n, sizeof(i));
-		n = (n % 100) + 1;
-
-		p = vmalloc(n * PAGE_SIZE);
+		p = vmalloc((prandom_u32_max(100) + 1) * PAGE_SIZE);
 
 		if (!p)
 			return -1;
 
-		*((__u8 *)p) = 1;
+		*(__u8 *)p = 1;
 		vfree(p);
 	}
 
@@ -304,16 +298,12 @@ pcpu_alloc_test(void)
 		return -1;
 
 	for (i = 0; i < 35000; i++) {
-		unsigned int r;
-
-		get_random_bytes(&r, sizeof(i));
-		size = (r % (PAGE_SIZE / 4)) + 1;
+		size = prandom_u32_max(PAGE_SIZE / 4) + 1;
 
 		/*
 		 * Maximum PAGE_SIZE
 		 */
-		get_random_bytes(&r, sizeof(i));
-		align = 1 << ((i % 11) + 1);
+		align = 1 << (prandom_u32_max(PAGE_SHIFT-1) + 1);
 
 		pcpu[i] = __alloc_percpu(size, align);
 		if (!pcpu[i])
@@ -362,28 +352,30 @@ static struct test_driver {
 	int cpu;
 } per_cpu_test_driver[NR_CPUS];
 
-static void shuffle_array(int *arr, int n)
+/*
+ * Generate a permutation array.  Shuffled by default, or
+ * the identity mapping if sequential_test_order is set.
+ */
+static void shuffle_array(u8 *arr, int n)
 {
-	unsigned int rnd;
-	int i, j, x;
+	int i;
 
-	for (i = n - 1; i > 0; i--)  {
-		get_random_bytes(&rnd, sizeof(rnd));
+	arr[0] = 0;
 
-		/* Cut the range. */
-		j = rnd % i;
-
-		/* Swap indexes. */
-		x = arr[i];
-		arr[i] = arr[j];
-		arr[j] = x;
+	for (i = 1; i < n; i++) {
+		int j = i;
+		if  (!sequential_test_order) {
+			j = prandom_u32_max(i+1);
+			arr[i] = arr[j];
+		}
+		arr[j] = i;
 	}
 }
 
 static int test_func(void *private)
 {
 	struct test_driver *t = private;
-	int random_array[ARRAY_SIZE(test_case_array)];
+	u8 random_array[ARRAY_SIZE(test_case_array)];
 	int index, i, j;
 	ktime_t kt;
 	u64 delta;
@@ -391,11 +383,7 @@ static int test_func(void *private)
 	if (set_cpus_allowed_ptr(current, cpumask_of(t->cpu)) < 0)
 		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
 
-	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
-		random_array[i] = i;
-
-	if (!sequential_test_order)
-		shuffle_array(random_array, ARRAY_SIZE(test_case_array));
+	shuffle_array(random_array, ARRAY_SIZE(test_case_array));
 
 	/*
 	 * Block until initialization is done.
-- 
2.26.0

