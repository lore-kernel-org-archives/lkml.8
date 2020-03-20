Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014EC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5020754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCTM6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgCTM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHEP-0003qD-9f; Fri, 20 Mar 2020 13:58:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DE3481C22BF;
        Fri, 20 Mar 2020 13:58:32 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Rework lockdep_lock
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313102107.GX12561@hirez.programming.kicks-ass.net>
References: <20200313102107.GX12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158470911262.28353.5260029684693301810.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     248efb2158f1e23750728e92ad9db3ab60c14485
Gitweb:        https://git.kernel.org/tip/248efb2158f1e23750728e92ad9db3ab60c14485
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 13 Mar 2020 11:09:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:25 +01:00

locking/lockdep: Rework lockdep_lock

A few sites want to assert we own the graph_lock/lockdep_lock, provide
a more conventional lock interface for it with a number of trivial
debug checks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313102107.GX12561@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 89 +++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 64ea69f..47e3acb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,12 +84,39 @@ module_param(lock_stat, int, 0644);
  * to use a raw spinlock - we really dont want the spinlock
  * code to recurse back into the lockdep code...
  */
-static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t __lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static struct task_struct *__owner;
+
+static inline void lockdep_lock(void)
+{
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
+	arch_spin_lock(&__lock);
+	__owner = current;
+	current->lockdep_recursion++;
+}
+
+static inline void lockdep_unlock(void)
+{
+	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
+		return;
+
+	current->lockdep_recursion--;
+	__owner = NULL;
+	arch_spin_unlock(&__lock);
+}
+
+static inline bool lockdep_assert_locked(void)
+{
+	return DEBUG_LOCKS_WARN_ON(__owner != current);
+}
+
 static struct task_struct *lockdep_selftest_task_struct;
 
+
 static int graph_lock(void)
 {
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -97,27 +124,15 @@ static int graph_lock(void)
 	 * dropped already)
 	 */
 	if (!debug_locks) {
-		arch_spin_unlock(&lockdep_lock);
+		lockdep_unlock();
 		return 0;
 	}
-	/* prevent any recursions within lockdep from causing deadlocks */
-	current->lockdep_recursion++;
 	return 1;
 }
 
-static inline int graph_unlock(void)
+static inline void graph_unlock(void)
 {
-	if (debug_locks && !arch_spin_is_locked(&lockdep_lock)) {
-		/*
-		 * The lockdep graph lock isn't locked while we expect it to
-		 * be, we're confused now, bye!
-		 */
-		return DEBUG_LOCKS_WARN_ON(1);
-	}
-
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
-	return 0;
+	lockdep_unlock();
 }
 
 /*
@@ -128,7 +143,7 @@ static inline int debug_locks_off_graph_unlock(void)
 {
 	int ret = debug_locks_off();
 
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 
 	return ret;
 }
@@ -1479,6 +1494,8 @@ static int __bfs(struct lock_list *source_entry,
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
+	lockdep_assert_locked();
+
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
 		ret = 0;
@@ -1501,8 +1518,6 @@ static int __bfs(struct lock_list *source_entry,
 
 		head = get_dep_list(lock, offset);
 
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
-
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
@@ -1729,11 +1744,9 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_forward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1758,11 +1771,9 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_backward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -3046,7 +3057,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
 	 * lockdep won't complain about its own locking errors.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (lockdep_assert_locked())
 		return 0;
 
 	chain = alloc_lock_chain();
@@ -5181,8 +5192,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -5194,8 +5204,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5240,13 +5249,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
@@ -5268,10 +5275,10 @@ static void lockdep_free_key_range_imm(void *start, unsigned long size)
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_free_key_range(pf, start, size);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5367,10 +5374,10 @@ static void lockdep_reset_lock_imm(struct lockdep_map *lock)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_reset_lock(pf, lock);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
