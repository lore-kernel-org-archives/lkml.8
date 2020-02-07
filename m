Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3828C217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBGSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:14:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbgBGSOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:14:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E5C5AD21;
        Fri,  7 Feb 2020 18:14:15 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        peterz@infradead.org, mingo@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/5] uprobes: optimize build_probe_list()
Date:   Fri,  7 Feb 2020 10:03:05 -0800
Message-Id: <20200207180305.11092-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200207180305.11092-1-dave@stgolabs.net>
References: <20200207180305.11092-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can optimize the uprobes_tree iterators when calling
build_probe_list() by using llrbtrees, having the previous
and next nodes from the given range available in branchless
O(1). The runtime overhead to maintain this data is minimal
for tree modifications, however the cost comes from enlarging
mostly the struct uprobe by two pointers and therefore we
sacrifice memory footprint.

Cc: peterz@infradead.org
Cc: mingo@redhat.com
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/events/uprobes.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..0a7b593578d1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,18 +27,19 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/ll_rbtree.h>
 
 #include <linux/uprobes.h>
 
 #define UINSNS_PER_PAGE			(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
 #define MAX_UPROBE_XOL_SLOTS		UINSNS_PER_PAGE
 
-static struct rb_root uprobes_tree = RB_ROOT;
+static struct llrb_root uprobes_tree = LLRB_ROOT;
 /*
  * allows us to skip the uprobe_mmap if there are no uprobe events active
  * at this time.  Probably a fine grained per inode count is better?
  */
-#define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
+#define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree.rb_root)
 
 static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
 
@@ -53,7 +54,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 #define UPROBE_COPY_INSN	0
 
 struct uprobe {
-	struct rb_node		rb_node;	/* node in the rb tree */
+	struct llrb_node	rb_node;	/* node in the llrb tree */
 	refcount_t		ref;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
@@ -639,12 +640,12 @@ static int match_uprobe(struct uprobe *l, struct uprobe *r)
 static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe u = { .inode = inode, .offset = offset };
-	struct rb_node *n = uprobes_tree.rb_node;
+	struct rb_node *n = uprobes_tree.rb_root.rb_node;
 	struct uprobe *uprobe;
 	int match;
 
 	while (n) {
-		uprobe = rb_entry(n, struct uprobe, rb_node);
+		uprobe = llrb_entry(n, struct uprobe, rb_node);
 		match = match_uprobe(&u, uprobe);
 		if (!match)
 			return get_uprobe(uprobe);
@@ -674,28 +675,30 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
-	struct rb_node **p = &uprobes_tree.rb_node;
+	struct rb_node **p = &uprobes_tree.rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct llrb_node *prev = NULL;
 	struct uprobe *u;
 	int match;
 
 	while (*p) {
 		parent = *p;
-		u = rb_entry(parent, struct uprobe, rb_node);
+		u = llrb_entry(parent, struct uprobe, rb_node);
 		match = match_uprobe(uprobe, u);
 		if (!match)
 			return get_uprobe(u);
 
 		if (match < 0)
 			p = &parent->rb_left;
-		else
+		else {
 			p = &parent->rb_right;
-
+			prev = llrb_from_rb(parent);
+		}
 	}
 
 	u = NULL;
-	rb_link_node(&uprobe->rb_node, parent, p);
-	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
+	rb_link_node(&uprobe->rb_node.rb_node, parent, p);
+	llrb_insert(&uprobes_tree, &uprobe->rb_node, prev);
 	/* get access + creation ref */
 	refcount_set(&uprobe->ref, 2);
 
@@ -940,7 +943,7 @@ remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vad
 
 static inline bool uprobe_is_active(struct uprobe *uprobe)
 {
-	return !RB_EMPTY_NODE(&uprobe->rb_node);
+	return !RB_EMPTY_NODE(&uprobe->rb_node.rb_node);
 }
 /*
  * There could be threads that have already hit the breakpoint. They
@@ -953,9 +956,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 		return;
 
 	spin_lock(&uprobes_treelock);
-	rb_erase(&uprobe->rb_node, &uprobes_tree);
+	llrb_erase(&uprobe->rb_node, &uprobes_tree);
 	spin_unlock(&uprobes_treelock);
-	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
+	RB_CLEAR_NODE(&uprobe->rb_node.rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);
 }
 
@@ -1263,13 +1266,13 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	return err;
 }
 
-static struct rb_node *
+static struct llrb_node *
 find_node_in_range(struct inode *inode, loff_t min, loff_t max)
 {
-	struct rb_node *n = uprobes_tree.rb_node;
+	struct rb_node *n = uprobes_tree.rb_root.rb_node;
 
 	while (n) {
-		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
+		struct uprobe *u = llrb_entry(n, struct uprobe, rb_node);
 
 		if (inode < u->inode) {
 			n = n->rb_left;
@@ -1285,7 +1288,7 @@ find_node_in_range(struct inode *inode, loff_t min, loff_t max)
 		}
 	}
 
-	return n;
+	return llrb_from_rb(n);
 }
 
 /*
@@ -1297,7 +1300,7 @@ static void build_probe_list(struct inode *inode,
 				struct list_head *head)
 {
 	loff_t min, max;
-	struct rb_node *n, *t;
+	struct llrb_node *n, *t;
 	struct uprobe *u;
 
 	INIT_LIST_HEAD(head);
@@ -1307,14 +1310,14 @@ static void build_probe_list(struct inode *inode,
 	spin_lock(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
-		for (t = n; t; t = rb_prev(t)) {
+		for (t = n; t; t = llrb_prev(t)) {
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset < min)
 				break;
 			list_add(&u->pending_list, head);
 			get_uprobe(u);
 		}
-		for (t = n; (t = rb_next(t)); ) {
+		for (t = n; (t = llrb_next(t)); ) {
 			u = rb_entry(t, struct uprobe, rb_node);
 			if (u->inode != inode || u->offset > max)
 				break;
@@ -1406,7 +1409,7 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 {
 	loff_t min, max;
 	struct inode *inode;
-	struct rb_node *n;
+	struct llrb_node *n;
 
 	inode = file_inode(vma->vm_file);
 
-- 
2.16.4

