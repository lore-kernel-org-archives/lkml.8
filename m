Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096320726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGSOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:14:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGSOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDF1BAE0D;
        Fri,  7 Feb 2020 18:14:02 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/5] lib/rbtree: introduce linked-list rbtree interface
Date:   Fri,  7 Feb 2020 10:03:01 -0800
Message-Id: <20200207180305.11092-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200207180305.11092-1-dave@stgolabs.net>
References: <20200207180305.11092-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing in-order tree traversals, the rb_next() and rb_prev() helpers can
be sub-optimal as plain node representations incur in extra pointer chasing
up the tree to compute the corresponding node. This can impact negatively
in performance when traversals are a common thing. This, for example, is what
we do in our vm already to efficiently manage VMAs.

This interface provides branchless O(1) access to the first node as well as
both its in-order successor and predecessor. This is done at the cost of higher
memory footprint: mainly additional prev and next pointers for each node. Such
benefits can be seen in this table showing the amount of cycles it takes to
do a full tree traversal:

   +--------+--------------+-----------+
   | #nodes | plain rbtree | ll-rbtree |
   +--------+--------------+-----------+
   |     10 |          138 |        24 |
   |    100 |        7,200 |       425 |
   |   1000 |       17,000 |     8,000 |
   |  10000 |      501,090 |   222,500 |
   +--------+--------------+-----------+

While there are other node representations that optimize getting such pointers
without bloating the nodes as much, such as keeping a parent pointer or threaded
trees where the nil prev/next pointers are recycled; both incurring in higher
runtime penalization for common modification operations as well as any rotations.
The overhead of tree modifications can be seen in the following table, comparing
cycles to insert+delete:

   +--------+--------------+------------------+-----------+
   | #nodes | plain rbtree | augmented rbtree | ll-rbtree |
   +--------+--------------+------------------+-----------+
   |     10 |          530 |              840 |       600 |
   |    100 |        7,100 |           14,200 |     7,800 |
   |   1000 |      265,000 |          370,000 |   205,200 |
   |  10000 |    4,400,000 |        5,500,000 | 4,200,000 |
   +--------+--------------+------------------+-----------+

This shows that we gain fast iterators at pretty much a negligible runtime overhead,
where both regular and llrb trees are rather similar, but unsurprisingly there is
really a noticible cost when augmenting the rbtree (wich is not important for this
series perse).

Note that all data shown here is based on randomly populated rbtrees (albeit same
seed) running a hacked version of lib/rbtree_test.c on a x86-64 2.6 Ghz IvyBridge
system.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 Documentation/rbtree.txt  |  74 +++++++++++++++++++++++++++++++++
 include/linux/ll_rbtree.h | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 include/linux/ll_rbtree.h

diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index 523d54b60087..fe38fb257931 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -5,6 +5,7 @@ Red-black Trees (rbtree) in Linux
 
 :Date: January 18, 2007
 :Author: Rob Landley <rob@landley.net>
+         Davidlohr Bueso <dave@stgolabs.net>
 
 What are red-black trees, and what are they for?
 ------------------------------------------------
@@ -226,6 +227,79 @@ trees::
 				 struct rb_augment_callbacks *);
 
 
+Linked-list rbtrees
+-------------------
+
+When doing in-order tree traversals, the rb_next() and rb_prev() helpers can
+be sub-optimal as plain node representations incur in extra pointer chasing
+up the tree to compute the corresponding node. This can have a negative impact
+in latencies in scenarios where tree traversals are not rare. This interface
+provides branchless O(1) access to the first node as well as both its in-order
+successor and predecessor. This is done at the cost of higher memory footprint:
+mainly additional prev and next pointers for each node, essentially duplicating
+the tree data structure. While there are other node representations that optimize
+getting such pointers without bloating the nodes as much, such as keeping a
+parent pointer or threaded trees where the nil prev/next pointers are recycled;
+both incurring in higher runtime penalization for common modification operations
+as well as any rotations.
+
+As with regular rb_root structure, linked-list rbtrees are initialized to be
+empty via::
+
+  struct llrb_root mytree = LLRB_ROOT;
+
+Insertion and deletion are defined by:
+
+  void llrb_insert(struct llrb_root *, struct llrb_node *, struct llrb_node *);
+  void llrb_erase(struct llrb_node *, struct llrb_root *);
+
+The corresponding helpers needed to iterate through a tree are the following,
+equivalent to an optimized version of the regular rbtree version:
+
+  struct llrb_node *llrb_first(struct llrb_root *tree);
+  struct llrb_node *llrb_next(struct rb_node *node);
+  struct llrb_node *llrb_prev(struct rb_node *node);
+
+
+Inserting data into a Linked-list rbtree
+----------------------------------------
+
+Because llrb trees can exist anywhere regular rbtrees, the steps are similar.
+The search for insertion differs from the regular search in two ways. First
+the caller must keep track of the previous node, and secondly the caller must
+combine both regular nodes for the actual iteration down and convert from rb_node
+to llrb_node.
+
+Example::
+
+  int my_insert(struct llrb_root *root, struct mytype *data)
+  {
+	struct rb_node **new = &(root->rb_node.rb_node), *parent = NULL;
+	struct llrb_node *prev = NULL;
+
+	/* Figure out where to put new node */
+	while (*new) {
+		struct mytype *this = llrb_entry(*new, struct mytype, node);
+		int result = strcmp(data->keystring, this->keystring);
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0) {
+			prev = llrb_from_rb(*parent);
+			new = &((*new)->rb_right);
+		} else
+			return FALSE;
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&data->node.rb_node, parent, new);
+	llrb_insert(root, &data->node, prev);
+
+	return TRUE;
+  }
+
+
 Support for Augmented rbtrees
 -----------------------------
 
diff --git a/include/linux/ll_rbtree.h b/include/linux/ll_rbtree.h
new file mode 100644
index 000000000000..34ffbb935008
--- /dev/null
+++ b/include/linux/ll_rbtree.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linked-list RB-trees
+ *
+ * Copyright (C) 2020 Davidlohr Bueso.
+ *
+ * Use only when rbtree traversals are common and per-node extra
+ * mempory footprint is not an issue.
+ */
+
+#ifndef LLRB_TREE_H
+#define LLRB_TREE_H
+
+#include <linux/rbtree.h>
+
+struct llrb_node {
+	struct llrb_node *prev, *next;
+	struct rb_node rb_node;
+};
+
+struct llrb_root {
+	struct rb_root rb_root;
+	struct llrb_node *first;
+};
+
+#define LLRB_ROOT (struct llrb_root) { { NULL }, NULL }
+
+/**
+ * llrb_from_rb - get an llrb_node from an rb_node
+ * @node: the node in question.
+ *
+ * This is useful when iterating down the tree, for example
+ * during node insertion.
+ */
+static __always_inline struct llrb_node *llrb_from_rb(struct rb_node *node)
+{
+	return container_of(node, struct llrb_node, rb_node);
+}
+
+/**
+ * llrb_entry - get the struct for this entry
+ * @ptr:	the &struct rb_node pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the llrb_node within the struct.
+ */
+#define	llrb_entry(ptr, type, member) \
+	container_of(llrb_from_rb(ptr), type, member)
+
+static __always_inline struct llrb_node *llrb_first(struct llrb_root *root)
+{
+	return root->first;
+}
+
+static __always_inline struct llrb_node *llrb_next(struct llrb_node *node)
+{
+	return node->next;
+}
+
+static __always_inline struct llrb_node *llrb_prev(struct llrb_node *node)
+{
+	return node->prev;
+}
+
+static __always_inline
+void llrb_insert(struct llrb_root *root, struct llrb_node *node,
+		 struct llrb_node *prev)
+{
+	struct llrb_node *next;
+
+	rb_insert_color(&node->rb_node, &root->rb_root);
+
+	node->prev = prev;
+	if (prev) {
+		next = prev->next;
+		prev->next = node;
+	} else {
+		next = root->first;
+		root->first = node;
+	}
+	node->next = next;
+	if (next)
+		next->prev = node;
+}
+
+static __always_inline
+void llrb_erase(struct llrb_node *node, struct llrb_root *root)
+{
+	struct llrb_node *prev, *next;
+
+	rb_erase(&node->rb_node, &root->rb_root);
+
+	next = node->next;
+	prev = node->prev;
+
+	if (prev)
+		prev->next = next;
+	else
+		root->first = next;
+	if (next)
+		next->prev = prev;
+}
+
+#endif
-- 
2.16.4

