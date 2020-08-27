Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D8822CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNK6bt36";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rknZ0XAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgH0H7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH0HyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:21 -0400
Date:   Thu, 27 Aug 2020 07:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIuIakP8hdkH95dec5pD9ElRGvp+o1uR9AgqhEkUx6s=;
        b=lNK6bt36pba22g+RT4sj9vc9T/j8OaPYXUiGAUl7d44caZx9lQEcsnVaLzKvlJ9sg9HM2n
        ZlRIvQEOkvNNnzZ409+GeCOrVqYCqXF/0q7PC8eve46H9yC0i0UG1BQHd7iaLc0OAP2rc8
        8SGLO+bAZAzD6Fb6x0FvTwWmn3+NhLrWO83pm6VEuXPjRG3JmdiKfvT7tlGDTPDe/cEq2p
        w+TfXrOz4ry7S3pLgWTVFJfdM1KYRqbrkRtL/mVJPpJMdSiZCBbjm5oSXF48Zg6vYLDkwX
        JK9LEqOfDK4KjVnflTT+y0fVLtoRvKhpk+1X0m3PZcBslWqBd8zYyWG6HUoUmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIuIakP8hdkH95dec5pD9ElRGvp+o1uR9AgqhEkUx6s=;
        b=rknZ0XAaFeiZdOUHMJ74JzZYWvA0qtu0XY6LP3iOpZpLmBaBI04/CbyIIPIhdzu9jgwkfK
        aqgUhOJk6CPMEDAg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix recursive read lock related
 safe->unsafe detection
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-12-boqun.feng@gmail.com>
References: <20200807074238.1632519-12-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485798.20229.16391776348028955183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f08e3888574d490b31481eef6d84c61bedba7a47
Gitweb:        https://git.kernel.org/tip/f08e3888574d490b31481eef6d84c61bedba7a47
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:05 +02:00

lockdep: Fix recursive read lock related safe->unsafe detection

Currently, in safe->unsafe detection, lockdep misses the fact that a
LOCK_ENABLED_IRQ_*_READ usage and a LOCK_USED_IN_IRQ_*_READ usage may
cause deadlock too, for example:

	P1                          P2
	<irq disabled>
	write_lock(l1);             <irq enabled>
				    read_lock(l2);
	write_lock(l2);
				    <in irq>
				    read_lock(l1);

Actually, all of the following cases may cause deadlocks:

	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*
	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*
	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*_READ
	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*_READ

To fix this, we need to 1) change the calculation of exclusive_mask() so
that READ bits are not dropped and 2) always call usage() in
mark_lock_irq() to check usage deadlocks, even when the new usage of the
lock is READ.

Besides, adjust usage_match() and usage_acculumate() to recursive read
lock changes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-12-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 188 ++++++++++++++++++++++++++++----------
 1 file changed, 141 insertions(+), 47 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 42e2f1f..6644974 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2100,22 +2100,72 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+/*
+ * Forwards and backwards subgraph searching, for the purposes of
+ * proving that two subgraphs can be connected by a new dependency
+ * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ *
+ * A irq safe->unsafe deadlock happens with the following conditions:
+ *
+ * 1) We have a strong dependency path A -> ... -> B
+ *
+ * 2) and we have ENABLED_IRQ usage of B and USED_IN_IRQ usage of A, therefore
+ *    irq can create a new dependency B -> A (consider the case that a holder
+ *    of B gets interrupted by an irq whose handler will try to acquire A).
+ *
+ * 3) the dependency circle A -> ... -> B -> A we get from 1) and 2) is a
+ *    strong circle:
+ *
+ *      For the usage bits of B:
+ *        a) if A -> B is -(*N)->, then B -> A could be any type, so any
+ *           ENABLED_IRQ usage suffices.
+ *        b) if A -> B is -(*R)->, then B -> A must be -(E*)->, so only
+ *           ENABLED_IRQ_*_READ usage suffices.
+ *
+ *      For the usage bits of A:
+ *        c) if A -> B is -(E*)->, then B -> A could be any type, so any
+ *           USED_IN_IRQ usage suffices.
+ *        d) if A -> B is -(S*)->, then B -> A must be -(*N)->, so only
+ *           USED_IN_IRQ_*_READ usage suffices.
+ */
+
+/*
+ * There is a strong dependency path in the dependency graph: A -> B, and now
+ * we need to decide which usage bit of A should be accumulated to detect
+ * safe->unsafe bugs.
+ *
+ * Note that usage_accumulate() is used in backwards search, so ->only_xr
+ * stands for whether A -> B only has -(S*)-> (in this case ->only_xr is true).
+ *
+ * As above, if only_xr is false, which means A -> B has -(E*)-> dependency
+ * path, any usage of A should be considered. Otherwise, we should only
+ * consider _READ usage.
+ */
 static inline bool usage_accumulate(struct lock_list *entry, void *mask)
 {
-	*(unsigned long *)mask |= entry->class->usage_mask;
+	if (!entry->only_xr)
+		*(unsigned long *)mask |= entry->class->usage_mask;
+	else /* Mask out _READ usage bits */
+		*(unsigned long *)mask |= (entry->class->usage_mask & LOCKF_IRQ);
 
 	return false;
 }
 
 /*
- * Forwards and backwards subgraph searching, for the purposes of
- * proving that two subgraphs can be connected by a new dependency
- * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ * There is a strong dependency path in the dependency graph: A -> B, and now
+ * we need to decide which usage bit of B conflicts with the usage bits of A,
+ * i.e. which usage bit of B may introduce safe->unsafe deadlocks.
+ *
+ * As above, if only_xr is false, which means A -> B has -(*N)-> dependency
+ * path, any usage of B should be considered. Otherwise, we should only
+ * consider _READ usage.
  */
-
 static inline bool usage_match(struct lock_list *entry, void *mask)
 {
-	return !!(entry->class->usage_mask & *(unsigned long *)mask);
+	if (!entry->only_xr)
+		return !!(entry->class->usage_mask & *(unsigned long *)mask);
+	else /* Mask out _READ usage bits */
+		return !!((entry->class->usage_mask & LOCKF_IRQ) & *(unsigned long *)mask);
 }
 
 /*
@@ -2406,17 +2456,39 @@ static unsigned long invert_dir_mask(unsigned long mask)
 }
 
 /*
- * As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all
- * bits with bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*).
- * And then mask out all bitnr0.
+ * Note that a LOCK_ENABLED_IRQ_*_READ usage and a LOCK_USED_IN_IRQ_*_READ
+ * usage may cause deadlock too, for example:
+ *
+ * P1				P2
+ * <irq disabled>
+ * write_lock(l1);		<irq enabled>
+ *				read_lock(l2);
+ * write_lock(l2);
+ * 				<in irq>
+ * 				read_lock(l1);
+ *
+ * , in above case, l1 will be marked as LOCK_USED_IN_IRQ_HARDIRQ_READ and l2
+ * will marked as LOCK_ENABLE_IRQ_HARDIRQ_READ, and this is a possible
+ * deadlock.
+ *
+ * In fact, all of the following cases may cause deadlocks:
+ *
+ * 	 LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*
+ * 	 LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*
+ * 	 LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*_READ
+ * 	 LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*_READ
+ *
+ * As a result, to calculate the "exclusive mask", first we invert the
+ * direction (USED_IN/ENABLED) of the original mask, and 1) for all bits with
+ * bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*). 2) for all
+ * bits with bitnr0 cleared (LOCK_*_READ), add those with bitnr0 set (LOCK_*).
  */
 static unsigned long exclusive_mask(unsigned long mask)
 {
 	unsigned long excl = invert_dir_mask(mask);
 
-	/* Strip read */
 	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
-	excl &= ~LOCKF_IRQ_READ;
+	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
 
 	return excl;
 }
@@ -2433,6 +2505,7 @@ static unsigned long original_mask(unsigned long mask)
 	unsigned long excl = invert_dir_mask(mask);
 
 	/* Include read in existing usages */
+	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
 	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
 
 	return excl;
@@ -2447,14 +2520,24 @@ static int find_exclusive_match(unsigned long mask,
 				enum lock_usage_bit *bitp,
 				enum lock_usage_bit *excl_bitp)
 {
-	int bit, excl;
+	int bit, excl, excl_read;
 
 	for_each_set_bit(bit, &mask, LOCK_USED) {
+		/*
+		 * exclusive_bit() strips the read bit, however,
+		 * LOCK_ENABLED_IRQ_*_READ may cause deadlocks too, so we need
+		 * to search excl | LOCK_USAGE_READ_MASK as well.
+		 */
 		excl = exclusive_bit(bit);
+		excl_read = excl | LOCK_USAGE_READ_MASK;
 		if (excl_mask & lock_flag(excl)) {
 			*bitp = bit;
 			*excl_bitp = excl;
 			return 0;
+		} else if (excl_mask & lock_flag(excl_read)) {
+			*bitp = bit;
+			*excl_bitp = excl_read;
+			return 0;
 		}
 	}
 	return -1;
@@ -2480,8 +2563,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 1: gather all hard/soft IRQs usages backward in an
 	 * accumulated usage mask.
 	 */
-	this.parent = NULL;
-	this.class = hlock_class(prev);
+	bfs_init_rootb(&this, prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
 	if (bfs_error(ret)) {
@@ -2499,8 +2581,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 */
 	forward_mask = exclusive_mask(usage_mask);
 
-	that.parent = NULL;
-	that.class = hlock_class(next);
+	bfs_init_root(&that, next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
 	if (bfs_error(ret)) {
@@ -3695,14 +3776,16 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     enum lock_usage_bit bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
+	enum lock_usage_bit read_bit = bit + LOCK_USAGE_READ_MASK;
+	unsigned usage_mask = lock_flag(bit) | lock_flag(read_bit);
 
 	bfs_init_root(&root, this);
-	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
+	ret = find_usage_forwards(&root, usage_mask, &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -3710,8 +3793,15 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 1, irqclass);
+	/* Check whether write or read usage is the match */
+	if (target_entry->class->usage_mask & lock_flag(bit)) {
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 1, state_name(bit));
+	} else {
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 1, state_name(read_bit));
+	}
+
 	return 0;
 }
 
@@ -3721,14 +3811,16 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      enum lock_usage_bit bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
+	enum lock_usage_bit read_bit = bit + LOCK_USAGE_READ_MASK;
+	unsigned usage_mask = lock_flag(bit) | lock_flag(read_bit);
 
 	bfs_init_rootb(&root, this);
-	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
+	ret = find_usage_backwards(&root, usage_mask, &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -3736,8 +3828,15 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 0, irqclass);
+	/* Check whether write or read usage is the match */
+	if (target_entry->class->usage_mask & lock_flag(bit)) {
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 0, state_name(bit));
+	} else {
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 0, state_name(read_bit));
+	}
+
 	return 0;
 }
 
@@ -3776,8 +3875,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -3803,16 +3900,6 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
 	/*
-	 * mark USED_IN has to look forwards -- to ensure no dependency
-	 * has ENABLED state, which would allow recursion deadlocks.
-	 *
-	 * mark ENABLED has to look backwards -- to ensure no dependee
-	 * has USED_IN state, which, again, would allow  recursion deadlocks.
-	 */
-	check_usage_f usage = dir ?
-		check_usage_backwards : check_usage_forwards;
-
-	/*
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
@@ -3820,23 +3907,30 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 		return 0;
 
 	/*
-	 * Validate that the lock dependencies don't have conflicting usage
-	 * states.
+	 * Check for read in write conflicts
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	if (!read && !valid_state(curr, this, new_bit,
+				  excl_bit + LOCK_USAGE_READ_MASK))
 		return 0;
 
+
 	/*
-	 * Check for read in write conflicts
+	 * Validate that the lock dependencies don't have conflicting usage
+	 * states.
 	 */
-	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
+	if (dir) {
+		/*
+		 * mark ENABLED has to look backwards -- to ensure no dependee
+		 * has USED_IN state, which, again, would allow  recursion deadlocks.
+		 */
+		if (!check_usage_backwards(curr, this, excl_bit))
 			return 0;
-
-		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+	} else {
+		/*
+		 * mark USED_IN has to look forwards -- to ensure no dependency
+		 * has ENABLED state, which would allow recursion deadlocks.
+		 */
+		if (!check_usage_forwards(curr, this, excl_bit))
 			return 0;
 	}
 
