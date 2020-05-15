Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F4BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B722070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="Vg1uCEM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEOVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:01:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC548C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:01:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d191so3429206oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HnZbklJatilSXN9Hk3X5olTGdbCsTt443t/FiqEu9hA=;
        b=Vg1uCEM+Sqb8PyJ3PLdP4gaBbTGPHEajUSyZTq3+fEIYaNBnx/TCqtCEUD4gbJVYOh
         N68aRfpoAnS3AU2dKJTUOfddm/nAvWcYsuwxrHn25wpR8OYqnPh7QJQ94+oPPOzio/1/
         7yPLWCQa3YtdMWBf8neSv6VGYanvsxHSFEomuZZyp0CPPy/1+8W7gjw2ySl6vNcaG5aO
         bki+ZXUKn48t3w/7HNHSCxeyRYuYHsOyjKIoAmie1DxdiG04A62DP+/2R5u9kvLO7PPC
         3TYDfidcURLnr3IVps4kl986xatFWjwyHaCSqS8InQmBppvJrZIXW8J227jZhmRwadCl
         zcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HnZbklJatilSXN9Hk3X5olTGdbCsTt443t/FiqEu9hA=;
        b=k67qo+wyW6t+Deq8n1uIyIJy1IyS4s1pDISSOUCV8xq2Kn/ZFmY/AR0L670WpQOU8B
         nj0WdPHZLEXFZsq/BcHTI/lg/lCmD+1DhSR3exO3HpVq0eXEbSYjwnOThacBlIrdsFQ1
         4boYI+TiEfmxPXN1cTkFJRvGe4Ft3BzkAdrvrAmsFJv8BJyy6Ag36oDn6P7xMoIAuzO7
         STak8lVSe9BeVBunxAA2E7jqeg7tCxLEapLF1JGirDWIINRf4MAyy35h+1t/JUAdW432
         l0aiAdMZKTdTolwnroZn3+jp5WNdcPpVDIEXH2lhcXr9Zt0PTGOyIFAqNwB4UGb/1dSO
         ureg==
X-Gm-Message-State: AOAM530duzfm86oRiB+htsXA7AAQZMmaluAx9JW780ITLnVYHfB6llra
        4XB9jvEK9HMx15cShnOQLDNwBQ==
X-Google-Smtp-Source: ABdhPJxBCA6cktUDc2OFL55lmWlKk95tX/VeEWhdhSEuPD4pyaq5OQPjvg2jDQdaibbjPBvm3qwgaQ==
X-Received: by 2002:aca:ba88:: with SMTP id k130mr3420511oif.24.1589576517833;
        Fri, 15 May 2020 14:01:57 -0700 (PDT)
Received: from localhost (05462bf6.skybroadband.com. [5.70.43.246])
        by smtp.gmail.com with ESMTPSA id x17sm882076ool.38.2020.05.15.14.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 14:01:57 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH] perf ordered_events: Optimise event object reuse
Date:   Fri, 15 May 2020 22:01:51 +0100
Message-Id: <20200515210151.2058-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ordered_event objects can be placed on the free object cache list in any
order which means future allocations may not return objects at
sequential locations in memory. Getting non-contiguous objects from the
free cache has bad consequences when later iterating over those objects
in ordered_events__queue().

For example, large perf.data files can contain trillions of events and
since objects that are next to each other in the free cache linked list
can point to pretty much anywhere in the object address space, lots of
cycles in ordered_events__queue() are spent servicing DTLB misses.

Implement the free object cache using the in-kernel implementation of
interval trees so that objects can always be allocated from the free
object cache in sequential order, improving spatial locality and
reducing DTLB misses.

Here are some numbers showing the speed up (reducing in execution time)
when running perf sched latency on sched events data and perf report on
HW_CPU_CYCLES.

 $ perf stat --null -r 10 -- bash -c \
	"export PAGER=cat ; perf sched latency -i $file --stdio &>/dev/null"

  Nr events     File Size   Before    After    Speed up
--------------  ---------  --------  -------  ----------
  123318457470     29MB     0.2149    0.2440    -13.5%
 1651500885357    260MB     3.1205    1.9855    +36.4%
 3470519751785    506MB     6.1821    3.8941    +37.0%
 8213765551679   1100MB    13.4875    8.5079    +36.9%
15900515973759   1946MB    23.4069   15.0960    +35.5%

and HW_CPU_CYCLES events:

 $ perf stat --null -r 10 -- bash -c \
	"export PAGER=cat ; perf report -i $file --stdio &>/dev/null"

  Nr events     File Size   Before    After    Speed up
--------------  ---------  --------  -------  ----------
  328805166262     29MB      1.637     1.587    +3.0%
 3280413919096    253MB     13.381    12.349    +7.7%
 6475305954370    500MB     25.648    23.753    +7.4%
14218430569416   1000MB     52.800    49.036    +7.1%
26760562279427   2000MB     97.169    90.129    +7.2%

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
---
 tools/include/linux/interval_tree.h         |  30 +++
 tools/include/linux/interval_tree_generic.h | 187 ++++++++++++++++++
 tools/lib/interval_tree.c                   |  12 ++
 tools/perf/MANIFEST                         |   1 +
 tools/perf/tests/Build                      |   1 +
 tools/perf/tests/builtin-test.c             |   4 +
 tools/perf/tests/free-object-cache.c        | 200 ++++++++++++++++++++
 tools/perf/tests/tests.h                    |   2 +
 tools/perf/util/Build                       |   6 +
 tools/perf/util/ordered-events.c            | 130 ++++++++++++-
 tools/perf/util/ordered-events.h            |   8 +-
 11 files changed, 573 insertions(+), 8 deletions(-)
 create mode 100644 tools/include/linux/interval_tree.h
 create mode 100644 tools/include/linux/interval_tree_generic.h
 create mode 100644 tools/lib/interval_tree.c
 create mode 100644 tools/perf/tests/free-object-cache.c

diff --git a/tools/include/linux/interval_tree.h b/tools/include/linux/interval_tree.h
new file mode 100644
index 000000000000..288c26f50732
--- /dev/null
+++ b/tools/include/linux/interval_tree.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_INTERVAL_TREE_H
+#define _LINUX_INTERVAL_TREE_H
+
+#include <linux/rbtree.h>
+
+struct interval_tree_node {
+	struct rb_node rb;
+	unsigned long start;	/* Start of interval */
+	unsigned long last;	/* Last location _in_ interval */
+	unsigned long __subtree_last;
+};
+
+extern void
+interval_tree_insert(struct interval_tree_node *node,
+		     struct rb_root_cached *root);
+
+extern void
+interval_tree_remove(struct interval_tree_node *node,
+		     struct rb_root_cached *root);
+
+extern struct interval_tree_node *
+interval_tree_iter_first(struct rb_root_cached *root,
+			 unsigned long start, unsigned long last);
+
+extern struct interval_tree_node *
+interval_tree_iter_next(struct interval_tree_node *node,
+			unsigned long start, unsigned long last);
+
+#endif	/* _LINUX_INTERVAL_TREE_H */
diff --git a/tools/include/linux/interval_tree_generic.h b/tools/include/linux/interval_tree_generic.h
new file mode 100644
index 000000000000..aaa8a0767aa3
--- /dev/null
+++ b/tools/include/linux/interval_tree_generic.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+  Interval Trees
+  (C) 2012  Michel Lespinasse <walken@google.com>
+
+
+  include/linux/interval_tree_generic.h
+*/
+
+#include <linux/rbtree_augmented.h>
+
+/*
+ * Template for implementing interval trees
+ *
+ * ITSTRUCT:   struct type of the interval tree nodes
+ * ITRB:       name of struct rb_node field within ITSTRUCT
+ * ITTYPE:     type of the interval endpoints
+ * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
+ * ITSTART(n): start endpoint of ITSTRUCT node n
+ * ITLAST(n):  last endpoint of ITSTRUCT node n
+ * ITSTATIC:   'static' or empty
+ * ITPREFIX:   prefix to use for the inline tree definitions
+ *
+ * Note - before using this, please consider if generic version
+ * (interval_tree.h) would work for you...
+ */
+
+#define INTERVAL_TREE_DEFINE(ITSTRUCT, ITRB, ITTYPE, ITSUBTREE,		      \
+			     ITSTART, ITLAST, ITSTATIC, ITPREFIX)	      \
+									      \
+/* Callbacks for augmented rbtree insert and remove */			      \
+									      \
+RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
+			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
+									      \
+/* Insert / remove interval nodes from the tree */			      \
+									      \
+ITSTATIC void ITPREFIX ## _insert(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)	 	      \
+{									      \
+	struct rb_node **link = &root->rb_root.rb_node, *rb_parent = NULL;    \
+	ITTYPE start = ITSTART(node), last = ITLAST(node);		      \
+	ITSTRUCT *parent;						      \
+	bool leftmost = true;						      \
+									      \
+	while (*link) {							      \
+		rb_parent = *link;					      \
+		parent = rb_entry(rb_parent, ITSTRUCT, ITRB);		      \
+		if (parent->ITSUBTREE < last)				      \
+			parent->ITSUBTREE = last;			      \
+		if (start < ITSTART(parent))				      \
+			link = &parent->ITRB.rb_left;			      \
+		else {							      \
+			link = &parent->ITRB.rb_right;			      \
+			leftmost = false;				      \
+		}							      \
+	}								      \
+									      \
+	node->ITSUBTREE = last;						      \
+	rb_link_node(&node->ITRB, rb_parent, link);			      \
+	rb_insert_augmented_cached(&node->ITRB, root,			      \
+				   leftmost, &ITPREFIX ## _augment);	      \
+}									      \
+									      \
+ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)		      \
+{									      \
+	rb_erase_augmented_cached(&node->ITRB, root, &ITPREFIX ## _augment);  \
+}									      \
+									      \
+/*									      \
+ * Iterate over intervals intersecting [start;last]			      \
+ *									      \
+ * Note that a node's interval intersects [start;last] iff:		      \
+ *   Cond1: ITSTART(node) <= last					      \
+ * and									      \
+ *   Cond2: start <= ITLAST(node)					      \
+ */									      \
+									      \
+static ITSTRUCT *							      \
+ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariant: start <= node->ITSUBTREE		      \
+		 * (Cond2 is satisfied by one of the subtree nodes)	      \
+		 */							      \
+		if (node->ITRB.rb_left) {				      \
+			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
+						  ITSTRUCT, ITRB);	      \
+			if (start <= left->ITSUBTREE) {			      \
+				/*					      \
+				 * Some nodes in left subtree satisfy Cond2.  \
+				 * Iterate to find the leftmost such node N.  \
+				 * If it also satisfies Cond1, that's the     \
+				 * match we are looking for. Otherwise, there \
+				 * is no matching interval as nodes to the    \
+				 * right of N can't satisfy Cond1 either.     \
+				 */					      \
+				node = left;				      \
+				continue;				      \
+			}						      \
+		}							      \
+		if (ITSTART(node) <= last) {		/* Cond1 */	      \
+			if (start <= ITLAST(node))	/* Cond2 */	      \
+				return node;	/* node is leftmost match */  \
+			if (node->ITRB.rb_right) {			      \
+				node = rb_entry(node->ITRB.rb_right,	      \
+						ITSTRUCT, ITRB);	      \
+				if (start <= node->ITSUBTREE)		      \
+					continue;			      \
+			}						      \
+		}							      \
+		return NULL;	/* No match */				      \
+	}								      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_first(struct rb_root_cached *root,			      \
+			ITTYPE start, ITTYPE last)			      \
+{									      \
+	ITSTRUCT *node, *leftmost;					      \
+									      \
+	if (!root->rb_root.rb_node)					      \
+		return NULL;						      \
+									      \
+	/*								      \
+	 * Fastpath range intersection/overlap between A: [a0, a1] and	      \
+	 * B: [b0, b1] is given by:					      \
+	 *								      \
+	 *         a0 <= b1 && b0 <= a1					      \
+	 *								      \
+	 *  ... where A holds the lock range and B holds the smallest	      \
+	 * 'start' and largest 'last' in the tree. For the later, we	      \
+	 * rely on the root node, which by augmented interval tree	      \
+	 * property, holds the largest value in its last-in-subtree.	      \
+	 * This allows mitigating some of the tree walk overhead for	      \
+	 * for non-intersecting ranges, maintained and consulted in O(1).     \
+	 */								      \
+	node = rb_entry(root->rb_root.rb_node, ITSTRUCT, ITRB);		      \
+	if (node->ITSUBTREE < start)					      \
+		return NULL;						      \
+									      \
+	leftmost = rb_entry(root->rb_leftmost, ITSTRUCT, ITRB);		      \
+	if (ITSTART(leftmost) > last)					      \
+		return NULL;						      \
+									      \
+	return ITPREFIX ## _subtree_search(node, start, last);		      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	struct rb_node *rb = node->ITRB.rb_right, *prev;		      \
+									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariants:					      \
+		 *   Cond1: ITSTART(node) <= last			      \
+		 *   rb == node->ITRB.rb_right				      \
+		 *							      \
+		 * First, search right subtree if suitable		      \
+		 */							      \
+		if (rb) {						      \
+			ITSTRUCT *right = rb_entry(rb, ITSTRUCT, ITRB);	      \
+			if (start <= right->ITSUBTREE)			      \
+				return ITPREFIX ## _subtree_search(right,     \
+								start, last); \
+		}							      \
+									      \
+		/* Move up the tree until we come from a node's left child */ \
+		do {							      \
+			rb = rb_parent(&node->ITRB);			      \
+			if (!rb)					      \
+				return NULL;				      \
+			prev = &node->ITRB;				      \
+			node = rb_entry(rb, ITSTRUCT, ITRB);		      \
+			rb = node->ITRB.rb_right;			      \
+		} while (prev == rb);					      \
+									      \
+		/* Check if the node intersects [start;last] */		      \
+		if (last < ITSTART(node))		/* !Cond1 */	      \
+			return NULL;					      \
+		else if (start <= ITLAST(node))		/* Cond2 */	      \
+			return node;					      \
+	}								      \
+}
diff --git a/tools/lib/interval_tree.c b/tools/lib/interval_tree.c
new file mode 100644
index 000000000000..4775c291edd6
--- /dev/null
+++ b/tools/lib/interval_tree.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/interval_tree.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/compiler.h>
+#include <linux/export.h>
+
+#define START(node) ((node)->start)
+#define LAST(node)  ((node)->last)
+
+INTERVAL_TREE_DEFINE(struct interval_tree_node, rb,
+		     unsigned long, __subtree_last,
+		     START, LAST,, interval_tree)
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 5d7b947320fb..01fe06660a77 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -20,4 +20,5 @@ tools/lib/bitmap.c
 tools/lib/str_error_r.c
 tools/lib/vsprintf.c
 tools/lib/zalloc.c
+tools/lib/interval_tree.c
 scripts/bpf_helpers_doc.py
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index b3d1bf13ca07..c4e65ce96e2e 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -56,6 +56,7 @@ perf-y += mem2node.o
 perf-y += maps.o
 perf-y += time-utils-test.o
 perf-y += genelf.o
+perf-y += free-object-cache.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b6322eb0f423..efb9bf7b9056 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -313,6 +313,10 @@ static struct test generic_tests[] = {
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
 	},
+	{
+		.desc = "Free object cache",
+		.func = test__free_object_cache,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/free-object-cache.c b/tools/perf/tests/free-object-cache.c
new file mode 100644
index 000000000000..e4395ece7d2b
--- /dev/null
+++ b/tools/perf/tests/free-object-cache.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include <linux/kernel.h>
+
+#define ordered_events__flush_time __test_ordered_events__flush_time
+#define ordered_events__first_time __test_ordered_events__first_time
+#define ordered_events__delete __test_ordered_events__delete
+#define ordered_events__init __test_ordered_events__init
+#define ordered_events__free __test_ordered_events__free
+#define ordered_events__queue __test_ordered_events__queue
+#define ordered_events__reinit __test_ordered_events__reinit
+#define ordered_events__flush __test_ordered_events__flush
+
+#include "../util/ordered-events.c"
+
+static void *alloc_cache(unsigned int num_objs)
+{
+	void *ptr = calloc(sizeof(struct ordered_event), num_objs);
+	return ptr;
+}
+
+static inline struct ordered_event *
+cache_obj_entry(void *ptr, unsigned int index)
+{
+	struct ordered_event *objs = ptr;
+	return &objs[index];
+}
+
+static int test_cache_get_put(void)
+{
+	struct ordered_events oe;
+	struct ordered_event *e;
+	int num_objs, i;
+	void *ptr;
+
+	__test_ordered_events__init(&oe, NULL, NULL);
+
+	num_objs = 8;
+	ptr = alloc_cache(num_objs);
+
+	e = free_cache_get(&oe);
+	TEST_ASSERT_VAL("got object from empty cache", e == NULL);
+
+	for (i = 0; i < num_objs; i++) {
+		e = cache_obj_entry(ptr, i);
+		free_cache_put(&oe, e);
+	}
+
+	for (i = 0; i < num_objs; i++) {
+		e = free_cache_get(&oe);
+		TEST_ASSERT_VAL("ran out of objects", e != NULL);
+	}
+
+	e = free_cache_get(&oe);
+	TEST_ASSERT_VAL("got object from empty cache after put", e == NULL);
+
+	free(ptr);
+
+	return 0;
+}
+
+#define CHECK_EVENTS_IN_ORDER(o, addr) \
+	for (i = 0; i < num_objs; i++) { \
+		struct ordered_event *__e = free_cache_get(o); \
+		TEST_ASSERT_VAL("out-of-order event object", __e ==  cache_obj_entry(addr, i)); \
+	}
+
+/*
+ * The reason that the free object cache switched to using interval
+ * trees is that accessing event objects in-order (with contiguous
+ * addresses) is much faster than accessing them out-of-order when
+ * working with a large numbers of events.
+ *
+ * Check that objects are always allocated in-order no matter which
+ * ordered they're added to the cache.
+ */
+static int test_cache_get_put_in_order(void)
+{
+	struct ordered_events oe;
+	struct ordered_event *e;
+	unsigned long *obj_map;
+	int num_objs, i;
+	void *ptr;
+
+	__test_ordered_events__init(&oe, NULL, NULL);
+
+	num_objs = 8192;
+	ptr = alloc_cache(num_objs);
+
+	for (i = 0; i < num_objs; i++) {
+		e = cache_obj_entry(ptr, i);
+		free_cache_put(&oe, e);
+	}
+	CHECK_EVENTS_IN_ORDER(&oe, ptr);
+
+	/*
+	 * Reverse the put order and check we still see ascending
+	 * addresses on get.
+	 */
+	for (i = num_objs-1; i >= 0; i--) {
+		e = cache_obj_entry(ptr, i);
+		free_cache_put(&oe, e);
+	}
+	CHECK_EVENTS_IN_ORDER(&oe, ptr);
+
+	/*
+	 * Insert objects randomly and check we still see ascending
+	 * addresses on get.
+	 */
+	obj_map = bitmap_alloc(num_objs);
+	srand(0);
+
+	while (!bitmap_full(obj_map, num_objs)) {
+		i = rand() % num_objs;
+
+		/* Not already inserted? */
+		if (!test_and_set_bit(i, obj_map)) {
+			e = cache_obj_entry(ptr, i);
+			free_cache_put(&oe, e);
+		}
+	}
+	CHECK_EVENTS_IN_ORDER(&oe, ptr);
+
+	bitmap_free(obj_map);
+	free(ptr);
+
+	return 0;
+}
+
+/*
+ * Punch holes in the object address space and make sure that we can
+ * later fill them without corrupting objects.
+ */
+static int test_cache_hole_punch(void)
+{
+	struct ordered_events oe;
+	struct ordered_event *e;
+	int num_objs, i;
+	int holes[3] = { 2046, 4097, 7084 };
+	void *ptr;
+
+	__test_ordered_events__init(&oe, NULL, NULL);
+
+	num_objs = 8192;
+	ptr = alloc_cache(num_objs);
+
+	for (i = 0; i < num_objs; i++) {
+		switch (i) {
+		case 2046:
+		case 4097:
+		case 7084:
+			continue;
+		default:
+			break;
+		}
+
+		e = cache_obj_entry(ptr, i);
+		memset(e, i, sizeof(*e));
+		free_cache_put(&oe, e);
+	}
+
+	for (i = 0; i < 3; i++) {
+		e = cache_obj_entry(ptr, holes[i]);
+		memset(e, holes[i], sizeof(*e));
+		free_cache_put(&oe, e);
+	}
+
+	for (i = 0; i < num_objs; i++) {
+		struct ordered_event tmp;
+
+		memset(&tmp, i, sizeof(tmp));
+		e = free_cache_get(&oe);
+
+		TEST_ASSERT_VAL("out-of-order event object", e ==  cache_obj_entry(ptr, i));
+		TEST_ASSERT_VAL("corrupt event object", !memcmp(e, &tmp, sizeof(*e)));
+	}
+
+	free(ptr);
+
+	return 0;
+}
+
+int test__free_object_cache(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = test_cache_get_put();
+	if (ret)
+		return ret;
+
+	ret = test_cache_get_put_in_order();
+	if (ret)
+		return ret;
+
+	ret = test_cache_hole_punch();
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab032080..f790da4357c9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -117,6 +117,8 @@ bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 
+int test__free_object_cache(struct test *test, int subtest);
+
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c0cf8dff694e..3bfb4ab1bd7f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -28,6 +28,7 @@ perf-y += print_binary.o
 perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
+perf-y += interval_tree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
@@ -223,6 +224,7 @@ CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
+CFLAGS_interval_tree.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_parse-events.o  += -Wno-redundant-decls
 CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
@@ -251,6 +253,10 @@ $(OUTPUT)util/rbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)util/interval_tree.o: ../lib/interval_tree.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 $(OUTPUT)util/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 359db2b1fcef..809bdeb42cb0 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
+#include <linux/interval_tree.h>
 #include "ordered-events.h"
 #include "session.h"
 #include "asm/bug.h"
@@ -95,11 +96,116 @@ static void free_dup_event(struct ordered_events *oe, union perf_event *event)
 		__free_dup_event(oe, event);
 }
 
+static inline unsigned long cache_region_size(struct interval_tree_node *it)
+{
+	return it->last - it->start + 1;
+}
+
+/*
+ * Allocate a new event object from the free object cache.
+ *
+ * Find the first address range in the cache and carve out enough bytes
+ * for an ordered_event objects. The object with the lowest address is
+ * always returned so that subsequent allocations benefit from
+ * contiguous memory accesses (spatial locality).
+ */
+static struct ordered_event *free_cache_get(struct ordered_events *oe)
+{
+	struct interval_tree_node *it;
+	struct ordered_event *new;
+	size_t bytes = sizeof(*new);
+
+	it = interval_tree_iter_first(&oe->cache, 0, ULONG_MAX);
+	if (!it)
+		return NULL;
+
+	/* Has the cache memory been exhausted? */
+	assert(cache_region_size(it) >= bytes);
+
+	new = (void *)it->start;
+	interval_tree_remove(it, &oe->cache);
+
+	it->start += bytes;
+	if (cache_region_size(it))
+		interval_tree_insert(it, &oe->cache);
+	else
+		free(it);
+
+	return new;
+}
+
+static int free_cache_put(struct ordered_events *oe, struct ordered_event *event)
+{
+	struct interval_tree_node *it;
+	unsigned long start, end;
+
+	/*
+	 * We're inserting a new region of free memory. Check to see if
+	 * this region can be merged with an existing one. The three cases
+	 * to consider are:
+	 *
+	 *     +----------+-------+
+	 * 1)  | it->last | event |
+	 *     +----------+-------+
+	 *
+	 *                +-------+-----------+
+	 * 2)             | event | it->start |
+	 *                +-------+-----------+
+	 *
+	 *     +----------+-------+-------------+
+	 * 3)  | it->last | event | next->start |
+	 *     +----------+-------+-------------+
+	 *
+	 * Add a byte to either side of 'event' to see if there's an
+	 * existing free region(s) to merge with.
+	 */
+	start = (unsigned long)event;
+	end = (unsigned long)event + sizeof(*event) - 1;
+
+	it = interval_tree_iter_first(&oe->cache, start - 1, end + 1);
+	if (it) {
+		struct interval_tree_node *next;
+
+		next = interval_tree_iter_next(it, start - 1, end);
+		interval_tree_remove(it, &oe->cache);
+
+		if (next) {
+			/* Case 3: Merge two regions */
+			assert((next->start - (it->last + 1)) == sizeof(*event));
+
+			interval_tree_remove(next, &oe->cache);
+
+			it->start = start;
+			it->last = next->last;
+			free(next);
+		} else if (it->last < start) {
+			/* Case 1: Extend end of region */
+			it->last = end;
+		} else if (it->start > end) {
+			/* Case 2: Extend start of region */
+			it->start = start;
+		}
+
+		interval_tree_insert(it, &oe->cache);
+		return 0;
+	}
+
+	it = malloc(sizeof(*it));
+	if (!it)
+		return -ENOMEM;
+
+	it->start = start;
+	it->last = end;
+
+	interval_tree_insert(it, &oe->cache);
+
+	return 0;
+}
+
 #define MAX_SAMPLE_BUFFER	(64 * 1024 / sizeof(struct ordered_event))
 static struct ordered_event *alloc_event(struct ordered_events *oe,
 					 union perf_event *event)
 {
-	struct list_head *cache = &oe->cache;
 	struct ordered_event *new = NULL;
 	union perf_event *new_event;
 	size_t size;
@@ -134,13 +240,21 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	 *
 	 * Removal of ordered event object moves it from events to
 	 * the cache list.
+	 *
+	 * The order of entries on the cache list is crucial for
+	 * performance with large numbers of events. Events can be freed
+	 * in essentially any order which means that free entries must
+	 * be kept sorted on insertion to the cache so that subsequent
+	 * allocation in alloc_event() returns contiguous addresses.
+	 * This improves spatial locality.
 	 */
 	size = sizeof(*oe->buffer) + MAX_SAMPLE_BUFFER * sizeof(*new);
 
-	if (!list_empty(cache)) {
-		new = list_entry(cache->next, struct ordered_event, list);
-		list_del_init(&new->list);
-	} else if (oe->buffer) {
+	new = free_cache_get(oe);
+	if (new)
+		goto out;
+
+	if (oe->buffer) {
 		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
 			oe->buffer = NULL;
@@ -164,6 +278,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		return NULL;
 	}
 
+out:
 	new->event = new_event;
 	return new;
 }
@@ -185,7 +300,8 @@ ordered_events__new_event(struct ordered_events *oe, u64 timestamp,
 
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event)
 {
-	list_move(&event->list, &oe->cache);
+	list_del_init(&event->list);
+	free_cache_put(oe, event);
 	oe->nr_events--;
 	free_dup_event(oe, event->event);
 	event->event = NULL;
@@ -361,8 +477,8 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 			  void *data)
 {
 	INIT_LIST_HEAD(&oe->events);
-	INIT_LIST_HEAD(&oe->cache);
 	INIT_LIST_HEAD(&oe->to_free);
+	oe->cache = RB_ROOT_CACHED;
 	oe->max_alloc_size = (u64) -1;
 	oe->cur_alloc_size = 0;
 	oe->deliver	   = deliver;
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0920fb0ec6cc..20d108baa572 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -3,9 +3,15 @@
 #define __ORDERED_EVENTS_H
 
 #include <linux/types.h>
+#include <linux/interval_tree.h>
 
 struct perf_sample;
 
+struct cache_region {
+	struct interval_tree_node node;
+	size_t len;
+};
+
 struct ordered_event {
 	u64			timestamp;
 	u64			file_offset;
@@ -39,7 +45,7 @@ struct ordered_events {
 	u64				 max_alloc_size;
 	u64				 cur_alloc_size;
 	struct list_head		 events;
-	struct list_head		 cache;
+	struct rb_root_cached		 cache;
 	struct list_head		 to_free;
 	struct ordered_events_buffer	*buffer;
 	struct ordered_event		*last;
-- 
2.17.1

