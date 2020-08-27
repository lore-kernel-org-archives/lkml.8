Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3023C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9978A20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtlN490f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G81WDPBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgH0H5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgH0HyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A8C061232;
        Thu, 27 Aug 2020 00:54:23 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lPVRcN+5N84AigHgyoDwZ9Yp99WeUYG5wZVeYttW9Y=;
        b=MtlN490fdcsX55sWrAkVcbmF+aWAoomir0QUfT6u1zfNxHNzMGnOETvfYXxwDg/VfL+MNq
        bqfwpsiTAi9KFBMQMmuqLAmprVhzi5HflahI1xIXfLeuwYIqjYAbDRmkqhxODrxaljE7ak
        Jdyc2hVyGTyMTnynu4AztSWHiDWLEVEhRHBS6aEysCBJOQ0sPmEpd6w4uIgLqBaVUSp7PX
        p6C5lbZ+SmW5Njef9dTXOk6eee8qgdSon+Da4SB/illAJ6i7qoqbwLU8jd6z64RRWYcGDK
        P/YEQ9IsQsGWg7VCvpuBOsUcoya6/ixeZvuRXfEt+vMWuhkIgqMk46yvonQAJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lPVRcN+5N84AigHgyoDwZ9Yp99WeUYG5wZVeYttW9Y=;
        b=G81WDPBBqp4A9hpmZyRe7HvVp7ady7jWu7eyGkOt1Zlm6/by/gTxL1W1WLAUDKVLrTc+9n
        yXPBnl2JPZfMaLCA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Demagic the return value of BFS
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-4-boqun.feng@gmail.com>
References: <20200807074238.1632519-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486148.20229.16260642445080351596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b11be024de164213f6338973d76ab9ab139120cd
Gitweb:        https://git.kernel.org/tip/b11be024de164213f6338973d76ab9ab139120cd
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:22 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:03 +02:00

lockdep: Demagic the return value of BFS

__bfs() could return four magic numbers:

	1: search succeeds, but none match.
	0: search succeeds, find one match.
	-1: search fails because of the cq is full.
	-2: search fails because a invalid node is found.

This patch cleans things up by using a enum type for the return value
of __bfs() and its friends, this improves the code readability of the
code, and further, could help if we want to extend the BFS.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-4-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 155 +++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 77cd9e6..462c68c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1471,28 +1471,58 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 
 	return lock_class + offset;
 }
+/*
+ * Return values of a bfs search:
+ *
+ * BFS_E* indicates an error
+ * BFS_R* indicates a result (match or not)
+ *
+ * BFS_EINVALIDNODE: Find a invalid node in the graph.
+ *
+ * BFS_EQUEUEFULL: The queue is full while doing the bfs.
+ *
+ * BFS_RMATCH: Find the matched node in the graph, and put that node into
+ *             *@target_entry.
+ *
+ * BFS_RNOMATCH: Haven't found the matched node and keep *@target_entry
+ *               _unchanged_.
+ */
+enum bfs_result {
+	BFS_EINVALIDNODE = -2,
+	BFS_EQUEUEFULL = -1,
+	BFS_RMATCH = 0,
+	BFS_RNOMATCH = 1,
+};
+
+/*
+ * bfs_result < 0 means error
+ */
+static inline bool bfs_error(enum bfs_result res)
+{
+	return res < 0;
+}
 
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
-static int __bfs(struct lock_list *source_entry,
-		 void *data,
-		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
+static enum bfs_result __bfs(struct lock_list *source_entry,
+			     void *data,
+			     int (*match)(struct lock_list *entry, void *data),
+			     struct lock_list **target_entry,
+			     int offset)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
-	int ret = 1;
+	enum bfs_result ret = BFS_RNOMATCH;
 
 	lockdep_assert_locked();
 
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
-		ret = 0;
+		ret = BFS_RMATCH;
 		goto exit;
 	}
 
@@ -1506,7 +1536,7 @@ static int __bfs(struct lock_list *source_entry,
 	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
-			ret = -2;
+			ret = BFS_EINVALIDNODE;
 			goto exit;
 		}
 
@@ -1518,12 +1548,12 @@ static int __bfs(struct lock_list *source_entry,
 				mark_lock_accessed(entry, lock);
 				if (match(entry, data)) {
 					*target_entry = entry;
-					ret = 0;
+					ret = BFS_RMATCH;
 					goto exit;
 				}
 
 				if (__cq_enqueue(cq, entry)) {
-					ret = -1;
+					ret = BFS_EQUEUEFULL;
 					goto exit;
 				}
 				cq_depth = __cq_get_elem_count(cq);
@@ -1536,20 +1566,22 @@ exit:
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_forwards(struct lock_list *src_entry,
+	       void *data,
+	       int (*match)(struct lock_list *entry, void *data),
+	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
 		     offsetof(struct lock_class, locks_after));
 
 }
 
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_backwards(struct lock_list *src_entry,
+		void *data,
+		int (*match)(struct lock_list *entry, void *data),
+		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
 		     offsetof(struct lock_class, locks_before));
@@ -1775,18 +1807,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 /*
  * Check that the dependency graph starting at <src> can lead to
- * <target> or not. Print an error and return 0 if it does.
+ * <target> or not.
  */
-static noinline int
+static noinline enum bfs_result
 check_path(struct lock_class *target, struct lock_list *src_entry,
 	   struct lock_list **target_entry)
 {
-	int ret;
+	enum bfs_result ret;
 
 	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
 			     target_entry);
 
-	if (unlikely(ret < 0))
+	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
 
 	return ret;
@@ -1797,13 +1829,13 @@ check_path(struct lock_class *target, struct lock_list *src_entry,
  * lead to <target>. If it can, there is a circle when adding
  * <target> -> <src> dependency.
  *
- * Print an error and return 0 if it does.
+ * Print an error and return BFS_RMATCH if it does.
  */
-static noinline int
+static noinline enum bfs_result
 check_noncircular(struct held_lock *src, struct held_lock *target,
 		  struct lock_trace **const trace)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list *target_entry;
 	struct lock_list src_entry = {
 		.class = hlock_class(src),
@@ -1814,7 +1846,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	if (unlikely(!ret)) {
+	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
 			/*
 			 * If save_trace fails here, the printing might
@@ -1836,12 +1868,13 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
  * <target> or not. If it can, <src> -> <target> dependency is already
  * in the graph.
  *
- * Print an error and return 2 if it does or 1 if it does not.
+ * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * any error appears in the bfs search.
  */
-static noinline int
+static noinline enum bfs_result
 check_redundant(struct held_lock *src, struct held_lock *target)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list *target_entry;
 	struct lock_list src_entry = {
 		.class = hlock_class(src),
@@ -1852,11 +1885,8 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	if (!ret) {
+	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
-		ret = 2;
-	} else if (ret < 0)
-		ret = 0;
 
 	return ret;
 }
@@ -1886,17 +1916,14 @@ static inline int usage_match(struct lock_list *entry, void *mask)
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
  *
- * Return 0 if such a node exists in the subgraph, and put that node
+ * Return BFS_MATCH if such a node exists in the subgraph, and put that node
  * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
@@ -1908,18 +1935,12 @@ find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 /*
  * Find a node in the backwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
@@ -2247,7 +2268,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list *target_entry1;
 	struct lock_list *target_entry;
 	struct lock_list this, that;
-	int ret;
+	enum bfs_result ret;
 
 	/*
 	 * Step 1: gather all hard/soft IRQs usages backward in an
@@ -2257,7 +2278,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	this.class = hlock_class(prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2276,12 +2297,12 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	that.class = hlock_class(next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	/*
 	 * Step 3: we found a bad match! Now retrieve a lock from the backward
@@ -2291,11 +2312,11 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	backward_mask = original_mask(target_entry1->class->usage_mask);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (DEBUG_LOCKS_WARN_ON(ret == 1))
+	if (DEBUG_LOCKS_WARN_ON(ret == BFS_RNOMATCH))
 		return 1;
 
 	/*
@@ -2463,7 +2484,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct lock_trace **const trace)
 {
 	struct lock_list *entry;
-	int ret;
+	enum bfs_result ret;
 
 	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
 		/*
@@ -2494,7 +2515,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * in the graph whose neighbours are to be checked.
 	 */
 	ret = check_noncircular(next, prev, trace);
-	if (unlikely(ret <= 0))
+	if (unlikely(bfs_error(ret) || ret == BFS_RMATCH))
 		return 0;
 
 	if (!check_irq_usage(curr, prev, next))
@@ -2531,8 +2552,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	ret = check_redundant(prev, next);
-	if (ret != 1)
-		return ret;
+	if (bfs_error(ret))
+		return 0;
+	else if (ret == BFS_RMATCH)
+		return 2;
 #endif
 
 	if (!*trace) {
@@ -3436,19 +3459,19 @@ static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
 				this, 1, irqclass);
@@ -3463,19 +3486,19 @@ static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 		      enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
 				this, 0, irqclass);
