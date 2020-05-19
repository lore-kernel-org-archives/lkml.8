Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387EE2065F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgESUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgEST7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8DC08C5C2;
        Tue, 19 May 2020 12:59:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OJ-0000FG-Gf; Tue, 19 May 2020 21:59:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1B4091C0853;
        Tue, 19 May 2020 21:58:48 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:47 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lockdep: Prepare for noinstr sections
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.484532537@linutronix.de>
References: <20200505134100.484532537@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832797.17951.6526047446168762670.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c86e9b987cea3dd0209203e714553a47f5d7c6dd
Gitweb:        https://git.kernel.org/tip/c86e9b987cea3dd0209203e714553a47f5d7c6dd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Mar 2020 14:22:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:21 +02:00

lockdep: Prepare for noinstr sections

Force inlining and prevent instrumentation of all sorts by marking the
functions which are invoked from low level entry code with 'noinstr'.

Split the irqflags tracking into two parts. One which does the heavy
lifting while RCU is watching and the final one which can be invoked after
RCU is turned off.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134100.484532537@linutronix.de


---
 include/linux/irqflags.h        |  2 +-
 include/linux/sched.h           |  1 +-
 kernel/locking/lockdep.c        | 86 ++++++++++++++++++++++++--------
 kernel/trace/trace_preemptirq.c |  2 +-
 lib/debug_locks.c               |  2 +-
 5 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index f150e69..d7f7e43 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -19,11 +19,13 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void lockdep_softirqs_on(unsigned long ip);
   extern void lockdep_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on_prepare(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_hardirqs_on_prepare(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5c..658de61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -983,6 +983,7 @@ struct task_struct {
 	unsigned int			hardirq_disable_event;
 	int				hardirqs_enabled;
 	int				hardirq_context;
+	u64				hardirq_chain_key;
 	unsigned long			softirq_disable_ip;
 	unsigned long			softirq_enable_ip;
 	unsigned int			softirq_disable_event;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac10db6..9ccd675 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3635,13 +3635,10 @@ mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 /*
  * Hardirqs will be enabled:
  */
-static void __trace_hardirqs_on_caller(unsigned long ip)
+static void __trace_hardirqs_on_caller(void)
 {
 	struct task_struct *curr = current;
 
-	/* we'll do an OFF -> ON transition: */
-	curr->hardirqs_enabled = 1;
-
 	/*
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
@@ -3654,15 +3651,19 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * this bit from being set before)
 	 */
 	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
-			return;
-
-	curr->hardirq_enable_ip = ip;
-	curr->hardirq_enable_event = ++curr->irq_events;
-	debug_atomic_inc(hardirqs_on_events);
+		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 }
 
-void lockdep_hardirqs_on(unsigned long ip)
+/**
+ * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
+ * @ip:		Caller address
+ *
+ * Invoked before a possible transition to RCU idle from exit to user or
+ * guest mode. This ensures that all RCU operations are done before RCU
+ * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
+ * invoked to set the final state.
+ */
+void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -3698,20 +3699,62 @@ void lockdep_hardirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
+	current->hardirq_chain_key = current->curr_chain_key;
+
 	current->lockdep_recursion++;
-	__trace_hardirqs_on_caller(ip);
+	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
-NOKPROBE_SYMBOL(lockdep_hardirqs_on);
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
+
+void noinstr lockdep_hardirqs_on(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks || curr->lockdep_recursion))
+		return;
+
+	if (curr->hardirqs_enabled) {
+		/*
+		 * Neither irq nor preemption are disabled here
+		 * so this is racy by nature but losing one hit
+		 * in a stat is not a big deal.
+		 */
+		__debug_atomic_inc(redundant_hardirqs_on);
+		return;
+	}
+
+	/*
+	 * We're enabling irqs and according to our state above irqs weren't
+	 * already enabled, yet we find the hardware thinks they are in fact
+	 * enabled.. someone messed up their IRQ state tracing.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	/*
+	 * Ensure the lock stack remained unchanged between
+	 * lockdep_hardirqs_on_prepare() and lockdep_hardirqs_on().
+	 */
+	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
+			    current->curr_chain_key);
+
+	/* we'll do an OFF -> ON transition: */
+	curr->hardirqs_enabled = 1;
+	curr->hardirq_enable_ip = ip;
+	curr->hardirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(hardirqs_on_events);
+}
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
  */
-void lockdep_hardirqs_off(unsigned long ip)
+void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks || curr->lockdep_recursion))
 		return;
 
 	/*
@@ -3729,10 +3772,11 @@ void lockdep_hardirqs_off(unsigned long ip)
 		curr->hardirq_disable_ip = ip;
 		curr->hardirq_disable_event = ++curr->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
-	} else
+	} else {
 		debug_atomic_inc(redundant_hardirqs_off);
+	}
 }
-NOKPROBE_SYMBOL(lockdep_hardirqs_off);
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -4408,8 +4452,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	dump_stack();
 }
 
-static int match_held_lock(const struct held_lock *hlock,
-					const struct lockdep_map *lock)
+static noinstr int match_held_lock(const struct held_lock *hlock,
+				   const struct lockdep_map *lock)
 {
 	if (hlock->instance == lock)
 		return 1;
@@ -4696,7 +4740,7 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	return 0;
 }
 
-static nokprobe_inline
+static __always_inline
 int __lock_is_held(const struct lockdep_map *lock, int read)
 {
 	struct task_struct *curr = current;
@@ -4956,7 +5000,7 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lock_release);
 
-int lock_is_held_type(const struct lockdep_map *lock, int read)
+noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 {
 	unsigned long flags;
 	int ret = 0;
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index c008801..fb0691b 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -46,6 +46,7 @@ void trace_hardirqs_on(void)
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
@@ -93,6 +94,7 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index a75ee30..06d3135 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
 /*
  * Generic 'turn off all lock debugging' function:
  */
-int debug_locks_off(void)
+noinstr int debug_locks_off(void)
 {
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
