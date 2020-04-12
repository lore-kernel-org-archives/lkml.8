Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C73F20705
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgDLOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:19:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDLOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:19:29 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jNdSI-0001W3-EA; Sun, 12 Apr 2020 16:19:26 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BF1E2100E35;
        Sun, 12 Apr 2020 16:19:25 +0200 (CEST)
Date:   Sun, 12 Apr 2020 14:18:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.7-rc1
Message-ID: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-04-12

up to:  9a019db0b6be: locking/lockdep: Improve 'invalid wait context' splat


Three small fixes/updates for the locking core code:

 - Plug a task struct reference leak in the percpu rswem implementation.

 - Document the refcount interaction with PID_MAX_LIMIT

 - Improve the 'invalid wait context' data dump in lockdep so it contains
   all information which is required to decode the problem


Thanks,

	tglx

------------------>
Jann Horn (1):
      locking/refcount: Document interaction with PID_MAX_LIMIT

Peter Zijlstra (1):
      locking/lockdep: Improve 'invalid wait context' splat

Qian Cai (1):
      locking/percpu-rwsem: Fix a task_struct refcount


 include/linux/refcount.h      | 23 ++++++++++++++-----
 kernel/locking/lockdep.c      | 51 ++++++++++++++++++++++++++-----------------
 kernel/locking/percpu-rwsem.c |  3 ++-
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0ac50cf62d06..0e3ee25eb156 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -38,11 +38,24 @@
  * atomic operations, then the count will continue to edge closer to 0. If it
  * reaches a value of 1 before /any/ of the threads reset it to the saturated
  * value, then a concurrent refcount_dec_and_test() may erroneously free the
- * underlying object. Given the precise timing details involved with the
- * round-robin scheduling of each thread manipulating the refcount and the need
- * to hit the race multiple times in succession, there doesn't appear to be a
- * practical avenue of attack even if using refcount_add() operations with
- * larger increments.
+ * underlying object.
+ * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
+ * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
+ * With the current PID limit, if no batched refcounting operations are used and
+ * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
+ * operations, this makes it impossible for a saturated refcount to leave the
+ * saturation range, even if it is possible for multiple uses of the same
+ * refcount to nest in the context of a single task:
+ *
+ *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
+ *     0x40000000 / 0x400000 = 0x100 = 256
+ *
+ * If hundreds of references are added/removed with a single refcounting
+ * operation, it may potentially be possible to leave the saturation range; but
+ * given the precise timing details involved with the round-robin scheduling of
+ * each thread manipulating the refcount and the need to hit the race multiple
+ * times in succession, there doesn't appear to be a practical avenue of attack
+ * even if using refcount_add() operations with larger increments.
  *
  * Memory ordering
  * ===============
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1511690e4de7..ac10db66cc63 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3952,10 +3952,36 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
+static inline short task_wait_context(struct task_struct *curr)
+{
+	/*
+	 * Set appropriate wait type for the context; for IRQs we have to take
+	 * into account force_irqthread as that is implied by PREEMPT_RT.
+	 */
+	if (curr->hardirq_context) {
+		/*
+		 * Check if force_irqthreads will run us threaded.
+		 */
+		if (curr->hardirq_threaded || curr->irq_config)
+			return LD_WAIT_CONFIG;
+
+		return LD_WAIT_SPIN;
+	} else if (curr->softirq_context) {
+		/*
+		 * Softirqs are always threaded.
+		 */
+		return LD_WAIT_CONFIG;
+	}
+
+	return LD_WAIT_MAX;
+}
+
 static int
 print_lock_invalid_wait_context(struct task_struct *curr,
 				struct held_lock *hlock)
 {
+	short curr_inner;
+
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -3971,6 +3997,10 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	print_lock(hlock);
 
 	pr_warn("other info that might help us debug this:\n");
+
+	curr_inner = task_wait_context(curr);
+	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
+
 	lockdep_print_held_locks(curr);
 
 	pr_warn("stack backtrace:\n");
@@ -4017,26 +4047,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	}
 	depth++;
 
-	/*
-	 * Set appropriate wait type for the context; for IRQs we have to take
-	 * into account force_irqthread as that is implied by PREEMPT_RT.
-	 */
-	if (curr->hardirq_context) {
-		/*
-		 * Check if force_irqthreads will run us threaded.
-		 */
-		if (curr->hardirq_threaded || curr->irq_config)
-			curr_inner = LD_WAIT_CONFIG;
-		else
-			curr_inner = LD_WAIT_SPIN;
-	} else if (curr->softirq_context) {
-		/*
-		 * Softirqs are always threaded.
-		 */
-		curr_inner = LD_WAIT_CONFIG;
-	} else {
-		curr_inner = LD_WAIT_MAX;
-	}
+	curr_inner = task_wait_context(curr);
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a008a1ba21a7..8bbafe3e5203 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -118,14 +118,15 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
 {
-	struct task_struct *p = get_task_struct(wq_entry->private);
 	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
 	struct percpu_rw_semaphore *sem = key;
+	struct task_struct *p;
 
 	/* concurrent against percpu_down_write(), can get stolen */
 	if (!__percpu_rwsem_trylock(sem, reader))
 		return 1;
 
+	p = get_task_struct(wq_entry->private);
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 

