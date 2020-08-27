Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C668CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4A20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOEiMz58";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMRsOCOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgH0H7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgH0HyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58FC061233;
        Thu, 27 Aug 2020 00:54:21 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IAsJwXAtxR10SvvujO/TxVsBMgI4VZEygzqUTq7TQo=;
        b=uOEiMz58S1FclAQlcIavK2/6L7cuQy6zWq2M70yxH1ICaqqHnOMeQ5dQmjIS2EEs7wC+NZ
        LVC2XdOt8T1jerRv4MNDEbO39wuVOW9QZMYqPaKLl1HH4RgVt/CChR3x534Brs4U+5Jmvt
        N0Z6gQoKuWYZC71+wf+K8yfbWTBVvCSt7C6QpUUwn/KcYKQU6pOpEpyYejWhr//UcJ6PWS
        V8bwf3ogZS81rz1DIy3SkV+NEGzdQXwhuYLwo/LMxBIQwEVXs0KARUg0GzWoQmw2latmcv
        PUmRQKjkawwsbYwW9uaSfrbzbdADO1ayigt+/DXWPXFHgmdYp1ttcXbugZ4RLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IAsJwXAtxR10SvvujO/TxVsBMgI4VZEygzqUTq7TQo=;
        b=BMRsOCOwTDOeixaGAOBQZVuhQF9nHnSkeC+Ih+K6EmZoXwWQTY56eYBV6sMBo2Bn289A9f
        5iFi1Y4geT/ed4CA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Extend __bfs() to work with multiple
 types of dependencies
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-8-boqun.feng@gmail.com>
References: <20200807074238.1632519-8-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485971.20229.16683302872240308936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6971c0f345620aae5e6172207a57b7524603a34e
Gitweb:        https://git.kernel.org/tip/6971c0f345620aae5e6172207a57b7524603a34e
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:04 +02:00

lockdep: Extend __bfs() to work with multiple types of dependencies

Now we have four types of dependencies in the dependency graph, and not
all the pathes carry real dependencies (the dependencies that may cause
a deadlock), for example:

	Given lock A and B, if we have:

	CPU1			CPU2
	=============		==============
	write_lock(A);		read_lock(B);
	read_lock(B);		write_lock(A);

	(assuming read_lock(B) is a recursive reader)

	then we have dependencies A -(ER)-> B, and B -(SN)-> A, and a
	dependency path A -(ER)-> B -(SN)-> A.

	In lockdep w/o recursive locks, a dependency path from A to A
	means a deadlock. However, the above case is obviously not a
	deadlock, because no one holds B exclusively, therefore no one
	waits for the other to release B, so who get A first in CPU1 and
	CPU2 will run non-blockingly.

	As a result, dependency path A -(ER)-> B -(SN)-> A is not a
	real/strong dependency that could cause a deadlock.

>From the observation above, we know that for a dependency path to be
real/strong, no two adjacent dependencies can be as -(*R)-> -(S*)->.

Now our mission is to make __bfs() traverse only the strong dependency
paths, which is simple: we record whether we only have -(*R)-> for the
previous lock_list of the path in lock_list::only_xr, and when we pick a
dependency in the traverse, we 1) filter out -(S*)-> dependency if the
previous lock_list only has -(*R)-> dependency (i.e. ->only_xr is true)
and 2) set the next lock_list::only_xr to true if we only have -(*R)->
left after we filter out dependencies based on 1), otherwise, set it to
false.

With this extension for __bfs(), we now need to initialize the root of
__bfs() properly (with a correct ->only_xr), to do so, we introduce some
helper functions, which also cleans up a little bit for the __bfs() root
initialization code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-8-boqun.feng@gmail.com
---
 include/linux/lockdep.h  |   2 +-
 kernel/locking/lockdep.c | 113 +++++++++++++++++++++++++++++++-------
 2 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 35c8bb0..57d642d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -57,6 +57,8 @@ struct lock_list {
 	u16				distance;
 	/* bitmap of different dependencies from head to this */
 	u8				dep;
+	/* used by BFS to record whether "prev -> this" only has -(*R)-> */
+	u8				only_xr;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 16ad1b7..5abc227 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1551,8 +1551,72 @@ static inline u8 calc_depb(struct held_lock *prev, struct held_lock *next)
 }
 
 /*
- * Forward- or backward-dependency search, used for both circular dependency
- * checking and hardirq-unsafe/softirq-unsafe checking.
+ * Initialize a lock_list entry @lock belonging to @class as the root for a BFS
+ * search.
+ */
+static inline void __bfs_init_root(struct lock_list *lock,
+				   struct lock_class *class)
+{
+	lock->class = class;
+	lock->parent = NULL;
+	lock->only_xr = 0;
+}
+
+/*
+ * Initialize a lock_list entry @lock based on a lock acquisition @hlock as the
+ * root for a BFS search.
+ *
+ * ->only_xr of the initial lock node is set to @hlock->read == 2, to make sure
+ * that <prev> -> @hlock and @hlock -> <whatever __bfs() found> is not -(*R)->
+ * and -(S*)->.
+ */
+static inline void bfs_init_root(struct lock_list *lock,
+				 struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->only_xr = (hlock->read == 2);
+}
+
+/*
+ * Similar to bfs_init_root() but initialize the root for backwards BFS.
+ *
+ * ->only_xr of the initial lock node is set to @hlock->read != 0, to make sure
+ * that <next> -> @hlock and @hlock -> <whatever backwards BFS found> is not
+ * -(*S)-> and -(R*)-> (reverse order of -(*R)-> and -(S*)->).
+ */
+static inline void bfs_init_rootb(struct lock_list *lock,
+				  struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->only_xr = (hlock->read != 0);
+}
+
+/*
+ * Breadth-First Search to find a strong path in the dependency graph.
+ *
+ * @source_entry: the source of the path we are searching for.
+ * @data: data used for the second parameter of @match function
+ * @match: match function for the search
+ * @target_entry: pointer to the target of a matched path
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ *
+ * We may have multiple edges (considering different kinds of dependencies,
+ * e.g. ER and SN) between two nodes in the dependency graph. But
+ * only the strong dependency path in the graph is relevant to deadlocks. A
+ * strong dependency path is a dependency path that doesn't have two adjacent
+ * dependencies as -(*R)-> -(S*)->, please see:
+ *
+ *         Documentation/locking/lockdep-design.rst
+ *
+ * for more explanation of the definition of strong dependency paths
+ *
+ * In __bfs(), we only traverse in the strong dependency path:
+ *
+ *     In lock_list::only_xr, we record whether the previous dependency only
+ *     has -(*R)-> in the search, and if it does (prev only has -(*R)->), we
+ *     filter out any -(S*)-> in the current dependency and after that, the
+ *     ->only_xr is set according to whether we only have -(*R)-> left.
  */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
@@ -1582,6 +1646,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 	__cq_enqueue(cq, source_entry);
 
 	while ((lock = __cq_dequeue(cq))) {
+		bool prev_only_xr;
 
 		if (!lock->class) {
 			ret = BFS_EINVALIDNODE;
@@ -1602,10 +1667,26 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 
 		head = get_dep_list(lock, offset);
 
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+		prev_only_xr = lock->only_xr;
 
 		list_for_each_entry_rcu(entry, head, entry) {
 			unsigned int cq_depth;
+			u8 dep = entry->dep;
+
+			/*
+			 * Mask out all -(S*)-> if we only have *R in previous
+			 * step, because -(*R)-> -(S*)-> don't make up a strong
+			 * dependency.
+			 */
+			if (prev_only_xr)
+				dep &= ~(DEP_SR_MASK | DEP_SN_MASK);
+
+			/* If nothing left, we skip */
+			if (!dep)
+				continue;
+
+			/* If there are only -(*R)-> left, set that for the next step */
+			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
 
 			visit_lock_entry(entry, lock);
 			if (match(entry, data)) {
@@ -1827,8 +1908,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
@@ -1854,8 +1934,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
@@ -1898,10 +1977,9 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 {
 	enum bfs_result ret;
 	struct lock_list *target_entry;
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
 
 	debug_atomic_inc(nr_cyclic_checks);
 
@@ -1937,10 +2015,9 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 {
 	enum bfs_result ret;
 	struct lock_list *target_entry;
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
 
 	debug_atomic_inc(nr_redundant_checks);
 
@@ -3556,8 +3633,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *target_entry;
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
@@ -3583,8 +3659,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *target_entry;
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_rootb(&root, this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
