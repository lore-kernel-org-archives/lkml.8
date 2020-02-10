Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4217EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B1C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NggovpKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBJOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:54:43 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59327 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgBJOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346477; x=1612882477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GGDnF9UT4B4GJxH4K228rZTLKyJugI4ru7aV1x+6y7s=;
  b=NggovpKicF10e2CqH5UQn5DLAYi9/gqwB/ttjzD3t1twBqYvH8o9Aj3n
   pi6kavrxr05ZxFCA8zm1OqcfkFbdArSwAIPmgFX8z8AguLclQtazbgU+G
   Fic1aFxsSFGh8hLE46xC2WvpHqs+GEmiLShBSsVTLaG1z5VwVKDPu7T0m
   A=;
IronPort-SDR: 6Kpjio8JxL1oi9P5tmD41KWbw7Tq6bMFbJ2jrgPmHyHhEpVakvJ3lvwBZ41LwsPNm7krfoqHmW
 fDKX2yfwgt2Q==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="15700529"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Feb 2020 14:54:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 84FF0A183D;
        Mon, 10 Feb 2020 14:54:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:54:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:54:04 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/11] mm/damon: Add kunit tests
Date:   Mon, 10 Feb 2020 15:53:50 +0100
Message-ID: <20200210145350.28289-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210144812.26845-1-sjpark@amazon.com>
References: <20200210144812.26845-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D30UWC002.ant.amazon.com (10.43.162.235) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds kunit based unit tests for DAMON.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/Kconfig      |  11 +
 mm/damon-test.h | 604 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/damon.c      |   2 +
 3 files changed, 617 insertions(+)
 create mode 100644 mm/damon-test.h

diff --git a/mm/Kconfig b/mm/Kconfig
index 387d469f40ec..b279ab9c78d0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -751,4 +751,15 @@ config DAMON
 	  be 1) accurate enough to be useful for performance-centric domains,
 	  and 2) sufficiently light-weight so that it can be applied online.
 
+config DAMON_KUNIT_TEST
+	bool "Test for damon"
+	depends on DAMON && KUNIT
+	help
+	  This builds the DAMON Kunit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/mm/damon-test.h b/mm/damon-test.h
new file mode 100644
index 000000000000..c7dc21325c77
--- /dev/null
+++ b/mm/damon-test.h
@@ -0,0 +1,604 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Access Monitor Unit Tests
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifdef CONFIG_DAMON_KUNIT_TEST
+
+#ifndef _DAMON_TEST_H
+#define _DAMON_TEST_H
+
+#include <kunit/test.h>
+
+static void damon_test_str_to_pids(struct kunit *test)
+{
+	char *question;
+	unsigned long *answers;
+	unsigned long expected[] = {12, 35, 46};
+	ssize_t nr_integers = 0, i;
+
+	question = "123";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
+	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	kfree(answers);
+
+	question = "123abc";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
+	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	kfree(answers);
+
+	question = "a123";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, answers, (unsigned long *)NULL);
+
+	question = "12 35";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
+	for (i = 0; i < nr_integers; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "12 35 46";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)3, nr_integers);
+	for (i = 0; i < nr_integers; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "12 35 abc 46";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
+	for (i = 0; i < 2; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
+	kfree(answers);
+
+	question = "\n";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
+	kfree(answers);
+}
+
+static void damon_test_regions(struct kunit *test)
+{
+	struct damon_region *r;
+	struct damon_task *t;
+
+	r = damon_new_region(&damon_user_ctx, 1, 2);
+	KUNIT_EXPECT_EQ(test, 1ul, r->vm_start);
+	KUNIT_EXPECT_EQ(test, 2ul, r->vm_end);
+	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
+	KUNIT_EXPECT_TRUE(test, r->sampling_addr >= r->vm_start);
+	KUNIT_EXPECT_TRUE(test, r->sampling_addr < r->vm_end);
+
+	t = damon_new_task(42);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
+
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_regions(t));
+
+	damon_del_region(r);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
+
+	damon_free_task(t);
+}
+
+static void damon_test_tasks(struct kunit *test)
+{
+	struct damon_ctx *c = &damon_user_ctx;
+	struct damon_task *t;
+
+	t = damon_new_task(42);
+	KUNIT_EXPECT_EQ(test, 42ul, t->pid);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks(c));
+
+	damon_add_task_tail(&damon_user_ctx, t);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_tasks(c));
+
+	damon_destroy_task(t);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks(c));
+}
+
+static void damon_test_set_pids(struct kunit *test)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	unsigned long pids[] = {1, 2, 3};
+	char buf[64];
+
+	damon_set_pids(ctx, pids, 3);
+	damon_sprint_pids(ctx, buf, 64);
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2 3\n");
+
+	damon_set_pids(ctx, NULL, 0);
+	damon_sprint_pids(ctx, buf, 64);
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
+
+	damon_set_pids(ctx, (unsigned long []){1, 2}, 2);
+	damon_sprint_pids(ctx, buf, 64);
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2\n");
+
+	damon_set_pids(ctx, (unsigned long []){2}, 1);
+	damon_sprint_pids(ctx, buf, 64);
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "2\n");
+
+	damon_set_pids(ctx, NULL, 0);
+	damon_sprint_pids(ctx, buf, 64);
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
+}
+
+/*
+ * Test damon_three_regions_in_vmas() function
+ *
+ * DAMON converts the complex and dynamic memory mappings of each target task
+ * to three discontiguous regions which cover every mapped areas.  However, the
+ * three regions should not include the two biggest unmapped areas in the
+ * original mapping, because the two biggest areas are normally the areas
+ * between 1) heap and the mmap()-ed regions, and 2) the mmap()-ed regions and
+ * stack.  Because these two unmapped areas are very huge but obviously never
+ * accessed, covering the region is just a waste.
+ *
+ * 'damon_three_regions_in_vmas() receives an address space of a process.  It
+ * first identifies the start of mappings, end of mappings, and the two biggest
+ * unmapped areas.  After that, based on the information, it constructs the
+ * three regions and returns.  For more detail, refer to the comment of
+ * 'damon_init_regions_of()' function definition in 'mm/damon.c' file.
+ *
+ * For example, suppose virtual address ranges of 10-20, 20-25, 200-210,
+ * 210-220, 300-305, and 307-330 (Other comments represent this mappings in
+ * more short form: 10-20-25, 200-210-220, 300-305, 307-330) of a process are
+ * mapped.  To cover every mappings, the three regions should start with 10,
+ * and end with 305.  The process also has three unmapped areas, 25-200,
+ * 220-300, and 305-307.  Among those, 25-200 and 220-300 are the biggest two
+ * unmapped areas, and thus it should be converted to three regions of 10-25,
+ * 200-220, and 300-330.
+ */
+static void damon_test_three_regions_in_vmas(struct kunit *test)
+{
+	struct region regions[3] = {0,};
+	/* 10-20-25, 200-210-220, 300-305, 307-330 */
+	struct vm_area_struct vmas[] = {
+		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
+		(struct vm_area_struct) {.vm_start = 20, .vm_end = 25},
+		(struct vm_area_struct) {.vm_start = 200, .vm_end = 210},
+		(struct vm_area_struct) {.vm_start = 210, .vm_end = 220},
+		(struct vm_area_struct) {.vm_start = 300, .vm_end = 305},
+		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
+	};
+	vmas[0].vm_next = &vmas[1];
+	vmas[1].vm_next = &vmas[2];
+	vmas[2].vm_next = &vmas[3];
+	vmas[3].vm_next = &vmas[4];
+	vmas[4].vm_next = &vmas[5];
+	vmas[5].vm_next = NULL;
+
+	damon_three_regions_in_vmas(&vmas[0], regions);
+
+	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
+	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
+	KUNIT_EXPECT_EQ(test, 200ul, regions[1].start);
+	KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
+	KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
+	KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
+}
+
+/* Clean up global state of damon */
+static void damon_cleanup_global_state(void)
+{
+	struct damon_task *t, *next;
+
+	damon_for_each_task_safe(&damon_user_ctx, t, next)
+		damon_destroy_task(t);
+
+	damon_user_ctx.rbuf_offset = 0;
+}
+
+/*
+ * Test kdamond_flush_aggregated()
+ *
+ * DAMON checks access to each region and aggregates this information as the
+ * access frequency of each region.  In detail, it increases '->nr_accesses' of
+ * regions that an access has confirmed.  'kdamond_flush_aggregated()' flushes
+ * the aggregated information ('->nr_accesses' of each regions) to the result
+ * buffer.  As a result of the flushing, the '->nr_accesses' of regions are
+ * initialized to zero.
+ */
+static void damon_test_aggregate(struct kunit *test)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	unsigned long pids[] = {1, 2, 3};
+	unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
+	unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
+	unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
+	struct damon_task *t;
+	struct damon_region *r;
+	int it, ir;
+	ssize_t sz, sr, sp;
+
+	damon_set_recording(ctx, 256, "damon.data");
+	damon_set_pids(ctx, pids, 3);
+
+	it = 0;
+	damon_for_each_task(ctx, t) {
+		for (ir = 0; ir < 3; ir++) {
+			r = damon_new_region(ctx,
+					saddr[it][ir], eaddr[it][ir]);
+			r->nr_accesses = accesses[it][ir];
+			damon_add_region_tail(r, t);
+		}
+		it++;
+	}
+	kdamond_flush_aggregated(ctx);
+	it = 0;
+	damon_for_each_task(ctx, t) {
+		ir = 0;
+		/* '->nr_accesses' should be zeroed */
+		damon_for_each_region(r, t) {
+			KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
+			ir++;
+		}
+		/* regions should be preserved */
+		KUNIT_EXPECT_EQ(test, 3, ir);
+		it++;
+	}
+	/* tasks also should be preserved */
+	KUNIT_EXPECT_EQ(test, 3, it);
+
+	/* The aggregated information should be written in the buffer */
+	sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
+	sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
+	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
+	KUNIT_EXPECT_EQ(test, (unsigned int)sz, ctx->rbuf_offset);
+
+	damon_set_recording(ctx, 0, "damon.data");
+	damon_cleanup_global_state();
+}
+
+static void damon_test_write_rbuf(struct kunit *test)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *data;
+
+	damon_set_recording(&damon_user_ctx, 256, "damon.data");
+
+	data = "hello";
+	damon_write_rbuf(ctx, data, strnlen(data, 256));
+	KUNIT_EXPECT_EQ(test, ctx->rbuf_offset, 5u);
+
+	damon_write_rbuf(ctx, data, 0);
+	KUNIT_EXPECT_EQ(test, ctx->rbuf_offset, 5u);
+
+	KUNIT_EXPECT_STREQ(test, (char *)ctx->rbuf, data);
+	damon_set_recording(&damon_user_ctx, 0, "damon.data");
+}
+
+/*
+ * Test 'damon_apply_three_regions()'
+ *
+ * test			kunit object
+ * regions		an array containing start/end addresses of current
+ *			monitoring target regions
+ * nr_regions		the number of the addresses in 'regions'
+ * three_regions	The three regions that need to be applied now
+ * expected		start/end addresses of monitoring target regions that
+ *			'three_regions' are applied
+ * nr_expected		the number of addresses in 'expected'
+ *
+ * The memory mapping of the target processes changes dynamically.  To follow
+ * the change, DAMON periodically reads the mappings, simplifies it to the
+ * three regions, and updates the monitoring target regions to fit in the three
+ * regions.  The update of current target regions is the role of
+ * 'damon_apply_three_regions()'.
+ *
+ * This test passes the given target regions and the new three regions that
+ * need to be applied to the function and check whether it updates the regions
+ * as expected.
+ */
+static void damon_do_test_apply_three_regions(struct kunit *test,
+				unsigned long *regions, int nr_regions,
+				struct region *three_regions,
+				unsigned long *expected, int nr_expected)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < nr_regions / 2; i++) {
+		r = damon_new_region(&damon_user_ctx,
+				regions[i * 2], regions[i * 2 + 1]);
+		damon_add_region_tail(r, t);
+	}
+	damon_add_task_tail(&damon_user_ctx, t);
+
+	damon_apply_three_regions(&damon_user_ctx, t, three_regions);
+
+	for (i = 0; i < nr_expected / 2; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
+	}
+
+	damon_cleanup_global_state();
+}
+
+/*
+ * This function test most common case where the three big regions are only
+ * slightly changed.  Target regions should adjust their boundary (10-20-30,
+ * 50-55, 70-80, 90-100) to fit with the new big regions or remove target
+ * regions (57-79) that now out of the three regions.
+ */
+static void damon_test_apply_three_regions1(struct kunit *test)
+{
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
+				70, 80, 80, 90, 90, 100};
+	/* 5-27, 45-55, 73-104 */
+	struct region new_three_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 45, .end = 55},
+		(struct region){.start = 73, .end = 104} };
+	/* 5-20-27, 45-55, 73-80-90-104 */
+	unsigned long expected[] = {5, 20, 20, 27, 45, 55,
+				73, 80, 80, 90, 90, 104};
+
+	damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
+			new_three_regions, expected, ARRAY_SIZE(expected));
+}
+
+/*
+ * Test slightly bigger change.  Similar to above, but the second big region
+ * now require two target regions (50-55, 57-59) to be removed.
+ */
+static void damon_test_apply_three_regions2(struct kunit *test)
+{
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
+				70, 80, 80, 90, 90, 100};
+	/* 5-27, 56-57, 65-104 */
+	struct region new_three_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 56, .end = 57},
+		(struct region){.start = 65, .end = 104} };
+	/* 5-20-27, 56-57, 65-80-90-104 */
+	unsigned long expected[] = {5, 20, 20, 27, 56, 57,
+				65, 80, 80, 90, 90, 104};
+
+	damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
+			new_three_regions, expected, ARRAY_SIZE(expected));
+}
+
+/*
+ * Test a big change.  The second big region has totally freed and mapped to
+ * different area (50-59 -> 61-63).  The target regions which were in the old
+ * second big region (50-55-57-59) should be removed and new target region
+ * covering the second big region (61-63) should be created.
+ */
+static void damon_test_apply_three_regions3(struct kunit *test)
+{
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
+				70, 80, 80, 90, 90, 100};
+	/* 5-27, 61-63, 65-104 */
+	struct region new_three_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 61, .end = 63},
+		(struct region){.start = 65, .end = 104} };
+	/* 5-20-27, 61-63, 65-80-90-104 */
+	unsigned long expected[] = {5, 20, 20, 27, 61, 63,
+				65, 80, 80, 90, 90, 104};
+
+	damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
+			new_three_regions, expected, ARRAY_SIZE(expected));
+}
+
+/*
+ * Test another big change.  Both of the second and third big regions (50-59
+ * and 70-100) has totally freed and mapped to different area (30-32 and
+ * 65-68).  The target regions which were in the old second and third big
+ * regions should now be removed and new target regions covering the new second
+ * and third big regions should be crated.
+ */
+static void damon_test_apply_three_regions4(struct kunit *test)
+{
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
+				70, 80, 80, 90, 90, 100};
+	/* 5-7, 30-32, 65-68 */
+	struct region new_three_regions[3] = {
+		(struct region){.start = 5, .end = 7},
+		(struct region){.start = 30, .end = 32},
+		(struct region){.start = 65, .end = 68} };
+	/* expect 5-7, 30-32, 65-68 */
+	unsigned long expected[] = {5, 7, 30, 32, 65, 68};
+
+	damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
+			new_three_regions, expected, ARRAY_SIZE(expected));
+}
+
+static void damon_test_split_evenly(struct kunit *test)
+{
+	struct damon_ctx *c = &damon_user_ctx;
+	struct damon_task *t;
+	struct damon_region *r;
+	unsigned long i;
+
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(c, NULL, 5), -EINVAL);
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 0, 100);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(c, r, 0), -EINVAL);
+
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(c, r, 10), 0);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 10u);
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_EQ(test, r->vm_start, i++ * 10);
+		KUNIT_EXPECT_EQ(test, r->vm_end, i * 10);
+	}
+	damon_free_task(t);
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 5, 59);
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(c, r, 5), 0);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		if (i == 4)
+			break;
+		KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i++);
+		KUNIT_EXPECT_EQ(test, r->vm_end, 5 + 10 * i);
+	}
+	KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 59ul);
+	damon_free_task(t);
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 5, 6);
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(c, r, 2), -EINVAL);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 1u);
+
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
+		KUNIT_EXPECT_EQ(test, r->vm_end, 6ul);
+	}
+	damon_free_task(t);
+}
+
+static void damon_test_split_at(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 0, 100);
+	damon_add_region_tail(r, t);
+	damon_split_region_at(&damon_user_ctx, r, 25);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 25ul);
+
+	r = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 25ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 100ul);
+
+	damon_free_task(t);
+}
+
+static void damon_test_merge_two(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r, *r2, *r3;
+	int i;
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 0, 100);
+	r->nr_accesses = 10;
+	damon_add_region_tail(r, t);
+	r2 = damon_new_region(&damon_user_ctx, 100, 300);
+	r2->nr_accesses = 20;
+	damon_add_region_tail(r2, t);
+
+	damon_merge_two_regions(r, r2);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 300ul);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+
+	i = 0;
+	damon_for_each_region(r3, t) {
+		KUNIT_EXPECT_PTR_EQ(test, r, r3);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	damon_free_task(t);
+}
+
+static void damon_test_merge_regions_of(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
+	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
+	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
+
+	unsigned long saddrs[] = {0, 114, 130, 156, 170};
+	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(sa); i++) {
+		r = damon_new_region(&damon_user_ctx, sa[i], ea[i]);
+		r->nr_accesses = nrs[i];
+		damon_add_region_tail(r, t);
+	}
+
+	damon_merge_regions_of(t, 9);
+	/* 0-112, 114-130, 130-156, 156-170 */
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
+	for (i = 0; i < 5; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
+	}
+	damon_free_task(t);
+}
+
+static void damon_test_split_regions_of(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	t = damon_new_task(42);
+	r = damon_new_region(&damon_user_ctx, 0, 22);
+	damon_add_region_tail(r, t);
+	damon_split_regions_of(&damon_user_ctx, t);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 2u);
+	damon_free_task(t);
+}
+
+static struct kunit_case damon_test_cases[] = {
+	KUNIT_CASE(damon_test_str_to_pids),
+	KUNIT_CASE(damon_test_tasks),
+	KUNIT_CASE(damon_test_regions),
+	KUNIT_CASE(damon_test_set_pids),
+	KUNIT_CASE(damon_test_three_regions_in_vmas),
+	KUNIT_CASE(damon_test_aggregate),
+	KUNIT_CASE(damon_test_write_rbuf),
+	KUNIT_CASE(damon_test_apply_three_regions1),
+	KUNIT_CASE(damon_test_apply_three_regions2),
+	KUNIT_CASE(damon_test_apply_three_regions3),
+	KUNIT_CASE(damon_test_apply_three_regions4),
+	KUNIT_CASE(damon_test_split_evenly),
+	KUNIT_CASE(damon_test_split_at),
+	KUNIT_CASE(damon_test_merge_two),
+	KUNIT_CASE(damon_test_merge_regions_of),
+	KUNIT_CASE(damon_test_split_regions_of),
+	{},
+};
+
+static struct kunit_suite damon_test_suite = {
+	.name = "damon",
+	.test_cases = damon_test_cases,
+};
+kunit_test_suite(damon_test_suite);
+
+#endif /* _DAMON_TEST_H */
+
+#endif	/* CONFIG_DAMON_KUNIT_TEST */
diff --git a/mm/damon.c b/mm/damon.c
index 02bfa12940ea..bb8eb88edaf3 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1409,3 +1409,5 @@ module_exit(damon_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
 MODULE_DESCRIPTION("DAMON: Data Access MONitor");
+
+#include "damon-test.h"
-- 
2.17.1

