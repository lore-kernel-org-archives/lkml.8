Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E0C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4337E22522
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCFOmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAs-0006Fy-Dp; Fri, 06 Mar 2020 15:42:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 100551C21D4;
        Fri,  6 Mar 2020 15:42:02 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:01 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] lib: Introduce generic min-heap
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214075133.181299-3-irogers@google.com>
References: <20200214075133.181299-3-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572180.28353.514553346921628090.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6e24628d78e4785385876125cba62315ca3b04b9
Gitweb:        https://git.kernel.org/tip/6e24628d78e4785385876125cba62315ca3b04b9
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 13 Feb 2020 23:51:29 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:56:59 +01:00

lib: Introduce generic min-heap

Supports push, pop and converting an array into a heap. If the sense of
the compare function is inverted then it can provide a max-heap.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200214075133.181299-3-irogers@google.com
---
 include/linux/min_heap.h | 134 ++++++++++++++++++++++++++-
 lib/Kconfig.debug        |  10 ++-
 lib/Makefile             |   1 +-
 lib/test_min_heap.c      | 194 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 339 insertions(+)
 create mode 100644 include/linux/min_heap.h
 create mode 100644 lib/test_min_heap.c

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
new file mode 100644
index 0000000..4407783
--- /dev/null
+++ b/include/linux/min_heap.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MIN_HEAP_H
+#define _LINUX_MIN_HEAP_H
+
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/**
+ * struct min_heap - Data structure to hold a min-heap.
+ * @data: Start of array holding the heap elements.
+ * @nr: Number of elements currently in the heap.
+ * @size: Maximum number of elements that can be held in current storage.
+ */
+struct min_heap {
+	void *data;
+	int nr;
+	int size;
+};
+
+/**
+ * struct min_heap_callbacks - Data/functions to customise the min_heap.
+ * @elem_size: The nr of each element in bytes.
+ * @less: Partial order function for this heap.
+ * @swp: Swap elements function.
+ */
+struct min_heap_callbacks {
+	int elem_size;
+	bool (*less)(const void *lhs, const void *rhs);
+	void (*swp)(void *lhs, void *rhs);
+};
+
+/* Sift the element at pos down the heap. */
+static __always_inline
+void min_heapify(struct min_heap *heap, int pos,
+		const struct min_heap_callbacks *func)
+{
+	void *left, *right, *parent, *smallest;
+	void *data = heap->data;
+
+	for (;;) {
+		if (pos * 2 + 1 >= heap->nr)
+			break;
+
+		left = data + ((pos * 2 + 1) * func->elem_size);
+		parent = data + (pos * func->elem_size);
+		smallest = parent;
+		if (func->less(left, smallest))
+			smallest = left;
+
+		if (pos * 2 + 2 < heap->nr) {
+			right = data + ((pos * 2 + 2) * func->elem_size);
+			if (func->less(right, smallest))
+				smallest = right;
+		}
+		if (smallest == parent)
+			break;
+		func->swp(smallest, parent);
+		if (smallest == left)
+			pos = (pos * 2) + 1;
+		else
+			pos = (pos * 2) + 2;
+	}
+}
+
+/* Floyd's approach to heapification that is O(nr). */
+static __always_inline
+void min_heapify_all(struct min_heap *heap,
+		const struct min_heap_callbacks *func)
+{
+	int i;
+
+	for (i = heap->nr / 2; i >= 0; i--)
+		min_heapify(heap, i, func);
+}
+
+/* Remove minimum element from the heap, O(log2(nr)). */
+static __always_inline
+void min_heap_pop(struct min_heap *heap,
+		const struct min_heap_callbacks *func)
+{
+	void *data = heap->data;
+
+	if (WARN_ONCE(heap->nr <= 0, "Popping an empty heap"))
+		return;
+
+	/* Place last element at the root (position 0) and then sift down. */
+	heap->nr--;
+	memcpy(data, data + (heap->nr * func->elem_size), func->elem_size);
+	min_heapify(heap, 0, func);
+}
+
+/*
+ * Remove the minimum element and then push the given element. The
+ * implementation performs 1 sift (O(log2(nr))) and is therefore more
+ * efficient than a pop followed by a push that does 2.
+ */
+static __always_inline
+void min_heap_pop_push(struct min_heap *heap,
+		const void *element,
+		const struct min_heap_callbacks *func)
+{
+	memcpy(heap->data, element, func->elem_size);
+	min_heapify(heap, 0, func);
+}
+
+/* Push an element on to the heap, O(log2(nr)). */
+static __always_inline
+void min_heap_push(struct min_heap *heap, const void *element,
+		const struct min_heap_callbacks *func)
+{
+	void *data = heap->data;
+	void *child, *parent;
+	int pos;
+
+	if (WARN_ONCE(heap->nr >= heap->size, "Pushing on a full heap"))
+		return;
+
+	/* Place at the end of data. */
+	pos = heap->nr;
+	memcpy(data + (pos * func->elem_size), element, func->elem_size);
+	heap->nr++;
+
+	/* Sift child at pos up. */
+	for (; pos > 0; pos = (pos - 1) / 2) {
+		child = data + (pos * func->elem_size);
+		parent = data + ((pos - 1) / 2) * func->elem_size;
+		if (func->less(parent, child))
+			break;
+		func->swp(parent, child);
+	}
+}
+
+#endif /* _LINUX_MIN_HEAP_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a..f04b61c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1769,6 +1769,16 @@ config TEST_LIST_SORT
 
 	  If unsure, say N.
 
+config TEST_MIN_HEAP
+	tristate "Min heap test"
+	depends on DEBUG_KERNEL || m
+	help
+	  Enable this to turn on min heap function tests. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
+
+	  If unsure, say N.
+
 config TEST_SORT
 	tristate "Array-based sort test"
 	depends on DEBUG_KERNEL || m
diff --git a/lib/Makefile b/lib/Makefile
index 611872c..09a8acb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,6 +67,7 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
+obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
new file mode 100644
index 0000000..d19c808
--- /dev/null
+++ b/lib/test_min_heap.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "min_heap_test: " fmt
+
+/*
+ * Test cases for the min max heap.
+ */
+
+#include <linux/log2.h>
+#include <linux/min_heap.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+
+static __init bool less_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs < *(int *)rhs;
+}
+
+static __init bool greater_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs > *(int *)rhs;
+}
+
+static __init void swap_ints(void *lhs, void *rhs)
+{
+	int temp = *(int *)lhs;
+
+	*(int *)lhs = *(int *)rhs;
+	*(int *)rhs = temp;
+}
+
+static __init int pop_verify_heap(bool min_heap,
+				struct min_heap *heap,
+				const struct min_heap_callbacks *funcs)
+{
+	int *values = heap->data;
+	int err = 0;
+	int last;
+
+	last = values[0];
+	min_heap_pop(heap, funcs);
+	while (heap->nr > 0) {
+		if (min_heap) {
+			if (last > values[0]) {
+				pr_err("error: expected %d <= %d\n", last,
+					values[0]);
+				err++;
+			}
+		} else {
+			if (last < values[0]) {
+				pr_err("error: expected %d >= %d\n", last,
+					values[0]);
+				err++;
+			}
+		}
+		last = values[0];
+		min_heap_pop(heap, funcs);
+	}
+	return err;
+}
+
+static __init int test_heapify_all(bool min_heap)
+{
+	int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
+			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
+	struct min_heap heap = {
+		.data = values,
+		.nr = ARRAY_SIZE(values),
+		.size =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.less = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, err;
+
+	/* Test with known set of values. */
+	min_heapify_all(&heap, &funcs);
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+
+	/* Test with randomly generated values. */
+	heap.nr = ARRAY_SIZE(values);
+	for (i = 0; i < heap.nr; i++)
+		values[i] = get_random_int();
+
+	min_heapify_all(&heap, &funcs);
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_heap heap = {
+		.data = values,
+		.nr = 0,
+		.size =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.less = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	/* Test with randomly generated values. */
+	while (heap.nr < heap.size) {
+		temp = get_random_int();
+		min_heap_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_pop_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_heap heap = {
+		.data = values,
+		.nr = 0,
+		.size =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.less = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Fill values with data to pop and replace. */
+	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &temp, &funcs);
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_pop_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	heap.nr = 0;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &temp, &funcs);
+
+	/* Test with randomly generated values. */
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
+		temp = get_random_int();
+		min_heap_pop_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static int __init test_min_heap_init(void)
+{
+	int err = 0;
+
+	err += test_heapify_all(true);
+	err += test_heapify_all(false);
+	err += test_heap_push(true);
+	err += test_heap_push(false);
+	err += test_heap_pop_push(true);
+	err += test_heap_pop_push(false);
+	if (err) {
+		pr_err("test failed with %d errors\n", err);
+		return -EINVAL;
+	}
+	pr_info("test passed\n");
+	return 0;
+}
+module_init(test_min_heap_init);
+
+static void __exit test_min_heap_exit(void)
+{
+	/* do nothing */
+}
+module_exit(test_min_heap_exit);
+
+MODULE_LICENSE("GPL");
