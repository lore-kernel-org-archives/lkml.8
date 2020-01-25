Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331A5246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgAYKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44202 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgAYKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItv-0008QZ-GZ; Sat, 25 Jan 2020 11:42:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CCC121C1A7C;
        Sat, 25 Jan 2020 11:42:45 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:45 -0000
From:   "tip-bot2 for Byungchul Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add basic support for kfree_rcu() batching
Cc:     kernel-team@android.com, kernel-team@lge.com,
        Byungchul Park <byungchul.park@lge.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896561.396.6093992627864808042.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a35d16905efc6ad5523d864a5c6efcb1e657e386
Gitweb:        https://git.kernel.org/tip/a35d16905efc6ad5523d864a5c6efcb1e657e386
Author:        Byungchul Park <byungchul.park@lge.com>
AuthorDate:    Mon, 05 Aug 2019 18:22:27 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:17:03 -08:00

rcu: Add basic support for kfree_rcu() batching

Recently a discussion about stability and performance of a system
involving a high rate of kfree_rcu() calls surfaced on the list [1]
which led to another discussion how to prepare for this situation.

This patch adds basic batching support for kfree_rcu(). It is "basic"
because we do none of the slab management, dynamic allocation, code
moving or any of the other things, some of which previous attempts did
[2]. These fancier improvements can be follow-up patches and there are
different ideas being discussed in those regards. This is an effort to
start simple, and build up from there. In the future, an extension to
use kfree_bulk and possibly per-slab batching could be done to further
improve performance due to cache-locality and slab-specific bulk free
optimizations. By using an array of pointers, the worker thread
processing the work would need to read lesser data since it does not
need to deal with large rcu_head(s) any longer.

Torture tests follow in the next patch and show improvements of around
5x reduction in number of  grace periods on a 16 CPU system. More
details and test data are in that patch.

There is an implication with rcu_barrier() with this patch. Since the
kfree_rcu() calls can be batched, and may not be handed yet to the RCU
machinery in fact, the monitor may not have even run yet to do the
queue_rcu_work(), there seems no easy way of implementing rcu_barrier()
to wait for those kfree_rcu()s that are already made. So this means a
kfree_rcu() followed by an rcu_barrier() does not imply that memory will
be freed once rcu_barrier() returns.

Another implication is higher active memory usage (although not
run-away..) until the kfree_rcu() flooding ends, in comparison to
without batching. More details about this are in the second patch which
adds an rcuperf test.

Finally, in the near future we will get rid of kfree_rcu() special casing
within RCU such as in rcu_do_batch and switch everything to just
batching. Currently we don't do that since timer subsystem is not yet up
and we cannot schedule the kfree_rcu() monitor as the timer subsystem's
lock are not initialized. That would also mean getting rid of
kfree_call_rcu_nobatch() entirely.

[1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
[2] https://lkml.org/lkml/2017/12/19/824

Cc: kernel-team@android.com
Cc: kernel-team@lge.com
Co-developed-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Applied 0day and Paul Walmsley feedback on ->monitor_todo. ]
[ paulmck: Make it work during early boot. ]
[ paulmck: Add a crude early boot self-test. ]
[ paulmck: Style adjustments and experimental docbook structure header. ]
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.9999.1908161931110.32497@viisi.sifive.com/T/#me9956f66cb611b95d26ae92700e1d901f46e8c59
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |   6 +-
 include/linux/rcutree.h |   2 +-
 kernel/rcu/tree.c       | 194 +++++++++++++++++++++++++++++++++++++--
 kernel/rcu/update.c     |  10 ++-
 4 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 37b6f0c..1bd166a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -39,6 +39,11 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	call_rcu(head, func);
 }
 
+static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
@@ -85,6 +90,7 @@ static inline void rcu_scheduler_starting(void) { }
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
+static inline void kfree_rcu_scheduler_running(void) { }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index c5147de..6a65d3a 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,10 +34,12 @@ static inline void rcu_virt_note_context_switch(int cpu)
 
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
+void kfree_rcu_scheduler_running(void);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..0af016f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2683,19 +2683,187 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+
+/* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES (HZ / 50)
+
+/**
+ * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
+ * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @head_free: List of kfree_rcu() objects already waiting for a grace period
+ * @lock: Synchronize access to this structure
+ * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
+ * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
+ * @initialized: The @lock and @rcu_work fields have been initialized
+ *
+ * This is a per-CPU structure.  The reason that it is not included in
+ * the rcu_data structure is to permit this code to be extracted from
+ * the RCU files.  Such extraction could allow further optimization of
+ * the interactions with the slab allocators.
+ */
+struct kfree_rcu_cpu {
+	struct rcu_work rcu_work;
+	struct rcu_head *head;
+	struct rcu_head *head_free;
+	spinlock_t lock;
+	struct delayed_work monitor_work;
+	int monitor_todo;
+	bool initialized;
+};
+
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+
 /*
- * Queue an RCU callback for lazy invocation after a grace period.
- * This will likely be later named something like "call_rcu_lazy()",
- * but this change will require some way of tagging the lazy RCU
- * callbacks in the list of pending callbacks. Until then, this
- * function may only be called from __kfree_rcu().
+ * This function is invoked in workqueue context after a grace period.
+ * It frees all the objects queued on ->head_free.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static void kfree_rcu_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct rcu_head *head, *next;
+	struct kfree_rcu_cpu *krcp;
+
+	krcp = container_of(to_rcu_work(work), struct kfree_rcu_cpu, rcu_work);
+	spin_lock_irqsave(&krcp->lock, flags);
+	head = krcp->head_free;
+	krcp->head_free = NULL;
+	spin_unlock_irqrestore(&krcp->lock, flags);
+
+	// List "head" is now private, so traverse locklessly.
+	for (; head; head = next) {
+		next = head->next;
+		// Potentially optimize with kfree_bulk in future.
+		__rcu_reclaim(rcu_state.name, head);
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
+/*
+ * Schedule the kfree batch RCU work to run in workqueue context after a GP.
+ *
+ * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
+ * timeout has been reached.
+ */
+static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
+{
+	lockdep_assert_held(&krcp->lock);
+
+	// If a previous RCU batch is in progress, we cannot immediately
+	// queue another one, so return false to tell caller to retry.
+	if (krcp->head_free)
+		return false;
+
+	krcp->head_free = krcp->head;
+	krcp->head = NULL;
+	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krcp->rcu_work);
+	return true;
+}
+
+static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
+					  unsigned long flags)
+{
+	// Attempt to start a new batch.
+	if (queue_kfree_rcu_work(krcp)) {
+		// Success! Our job is done here.
+		spin_unlock_irqrestore(&krcp->lock, flags);
+		return;
+	}
+
+	// Previous RCU batch still in progress, try again later.
+	if (!xchg(&krcp->monitor_todo, true))
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
+						 monitor_work.work);
+
+	spin_lock_irqsave(&krcp->lock, flags);
+	if (xchg(&krcp->monitor_todo, false))
+		kfree_rcu_drain_unlock(krcp, flags);
+	else
+		spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+/*
+ * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
+ * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
+ */
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
 {
 	__call_rcu(head, func, 1);
 }
+EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
+
+/*
+ * Queue a request for lazy invocation of kfree() after a grace period.
+ *
+ * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
+ * will be kfree'd in workqueue context. This allows us to:
+ *
+ * 1.	Batch requests together to reduce the number of grace periods during
+ *	heavy kfree_rcu() load.
+ *
+ * 2.	It makes it possible to use kfree_bulk() on a large number of
+ *	kfree_rcu() requests thus reducing cache misses and the per-object
+ *	overhead of kfree().
+ */
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp;
+
+	head->func = func;
+
+	local_irq_save(flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (krcp->initialized)
+		spin_lock(&krcp->lock);
+
+	// Queue the object but don't yet schedule the batch.
+	head->func = func;
+	head->next = krcp->head;
+	krcp->head = head;
+
+	// Set timer to drain after KFREE_DRAIN_JIFFIES.
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+	    !xchg(&krcp->monitor_todo, true))
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+
+	if (krcp->initialized)
+		spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
+void __init kfree_rcu_scheduler_running(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	for_each_online_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		spin_lock_irqsave(&krcp->lock, flags);
+		if (!krcp->head || xchg(&krcp->monitor_todo, true)) {
+			spin_unlock_irqrestore(&krcp->lock, flags);
+			continue;
+		}
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		spin_unlock_irqrestore(&krcp->lock, flags);
+	}
+}
+
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPT.
@@ -3557,12 +3725,26 @@ static void __init rcu_dump_rcu_node_tree(void)
 struct workqueue_struct *rcu_gp_wq;
 struct workqueue_struct *rcu_par_gp_wq;
 
+static void __init kfree_rcu_batch_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		spin_lock_init(&krcp->lock);
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		krcp->initialized = true;
+	}
+}
+
 void __init rcu_init(void)
 {
 	int cpu;
 
 	rcu_early_boot_tests();
 
+	kfree_rcu_batch_init();
 	rcu_bootup_announce();
 	rcu_init_geometry();
 	rcu_init_one();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103..1964877 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -40,6 +40,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
+#include <linux/slab.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -218,6 +219,7 @@ static int __init rcu_set_runtime_mode(void)
 {
 	rcu_test_sync_prims();
 	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
+	kfree_rcu_scheduler_running();
 	rcu_test_sync_prims();
 	return 0;
 }
@@ -853,14 +855,22 @@ static void test_callback(struct rcu_head *r)
 
 DEFINE_STATIC_SRCU(early_srcu);
 
+struct early_boot_kfree_rcu {
+	struct rcu_head rh;
+};
+
 static void early_boot_test_call_rcu(void)
 {
 	static struct rcu_head head;
 	static struct rcu_head shead;
+	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
 	if (IS_ENABLED(CONFIG_SRCU))
 		call_srcu(&early_srcu, &shead, test_callback);
+	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+	if (!WARN_ON_ONCE(!rhp))
+		kfree_rcu(rhp, rh);
 }
 
 void rcu_early_boot_tests(void)
