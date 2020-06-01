Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F84BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D9E20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFAJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C88C061A0E;
        Mon,  1 Jun 2020 02:52:22 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7D-0003eG-4e; Mon, 01 Jun 2020 11:52:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B3AA31C0481;
        Mon,  1 Jun 2020 11:52:18 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Replace rq::wake_list
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526161908.129371594@infradead.org>
References: <20200526161908.129371594@infradead.org>
MIME-Version: 1.0
Message-ID: <159100513859.17951.5366888281495604529.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a148866489fbe243c936fe43e4525d8dbfa0318f
Gitweb:        https://git.kernel.org/tip/a148866489fbe243c936fe43e4525d8dbfa0318f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 May 2020 18:11:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:54:16 +02:00

sched: Replace rq::wake_list

The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
got smp_call_function_single_async() subtly wrong. Even though it will
return -EBUSY when trying to re-use a csd, that condition is not
atomic and still requires external serialization.

The change in ttwu_queue_remote() got this wrong.

While on first reading ttwu_queue_remote() has an atomic test-and-set
that appears to serialize the use, the matching 'release' is not in
the right place to actually guarantee this serialization.

The actual race is vs the sched_ttwu_pending() call in the idle loop;
that can run the wakeup-list without consuming the CSD.

Instead of trying to chain the lists, merge them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200526161908.129371594@infradead.org
---
 include/linux/sched.h |  1 +-
 include/linux/smp.h   |  1 +-
 kernel/sched/core.c   | 25 ++++++----------------
 kernel/sched/idle.c   |  1 +-
 kernel/sched/sched.h  |  8 +-------
 kernel/smp.c          | 47 +++++++++++++++++++++++++++++++++++-------
 6 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ebc6870..e0f5f41 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -654,6 +654,7 @@ struct task_struct {
 
 #ifdef CONFIG_SMP
 	struct llist_node		wake_entry;
+	unsigned int			wake_entry_type;
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 45ad6e3..84f90e2 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -25,6 +25,7 @@ enum {
 	CSD_TYPE_ASYNC		= 0x00,
 	CSD_TYPE_SYNC		= 0x10,
 	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
 	CSD_FLAG_TYPE_MASK	= 0xF0,
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b71ed5e..b3c64c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1538,7 +1538,7 @@ static int migration_cpu_stop(void *data)
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
-	sched_ttwu_pending();
+	flush_smp_call_function_from_idle();
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
@@ -2272,14 +2272,13 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 }
 
 #ifdef CONFIG_SMP
-void sched_ttwu_pending(void)
+void sched_ttwu_pending(void *arg)
 {
+	struct llist_node *llist = arg;
 	struct rq *rq = this_rq();
-	struct llist_node *llist;
 	struct task_struct *p, *t;
 	struct rq_flags rf;
 
-	llist = llist_del_all(&rq->wake_list);
 	if (!llist)
 		return;
 
@@ -2299,11 +2298,6 @@ void sched_ttwu_pending(void)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-static void wake_csd_func(void *info)
-{
-	sched_ttwu_pending();
-}
-
 void send_call_function_single_ipi(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -2327,12 +2321,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	if (llist_add(&p->wake_entry, &rq->wake_list)) {
-		if (!set_nr_if_polling(rq->idle))
-			smp_call_function_single_async(cpu, &rq->wake_csd);
-		else
-			trace_sched_wake_idle_without_ipi(cpu);
-	}
+	__smp_call_single_queue(cpu, &p->wake_entry);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2772,6 +2761,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->capture_control = NULL;
 #endif
 	init_numa_balancing(clone_flags, p);
+#ifdef CONFIG_SMP
+	p->wake_entry_type = CSD_TYPE_TTWU;
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6564,7 +6556,6 @@ int sched_cpu_dying(unsigned int cpu)
 	struct rq_flags rf;
 
 	/* Handle pending wakeups and then migrate everything off */
-	sched_ttwu_pending();
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
@@ -6763,8 +6754,6 @@ void __init sched_init(void)
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
-		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
-
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 387fd75..05deb81 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -294,7 +294,6 @@ static void do_idle(void)
 	 * critical section.
 	 */
 	flush_smp_call_function_from_idle();
-	sched_ttwu_pending();
 	schedule_idle();
 
 	if (unlikely(klp_patch_pending(current)))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c86fc94..1d4e94c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1023,11 +1023,6 @@ struct rq {
 	unsigned int		ttwu_local;
 #endif
 
-#ifdef CONFIG_SMP
-	call_single_data_t	wake_csd;
-	struct llist_head	wake_list;
-#endif
-
 #ifdef CONFIG_CPU_IDLE
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
@@ -1371,8 +1366,6 @@ queue_balance_callback(struct rq *rq,
 	rq->balance_callback = head;
 }
 
-extern void sched_ttwu_pending(void);
-
 #define rcu_dereference_check_sched_domain(p) \
 	rcu_dereference_check((p), \
 			      lockdep_is_held(&sched_domains_mutex))
@@ -1512,7 +1505,6 @@ extern void flush_smp_call_function_from_idle(void);
 
 #else /* !CONFIG_SMP: */
 static inline void flush_smp_call_function_from_idle(void) { }
-static inline void sched_ttwu_pending(void) { }
 #endif
 
 #include "stats.h"
diff --git a/kernel/smp.c b/kernel/smp.c
index 856562b..0d61dc0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -196,6 +196,7 @@ void generic_smp_call_function_single_interrupt(void)
 	flush_smp_call_function_queue(true);
 }
 
+extern void sched_ttwu_pending(void *);
 extern void irq_work_single(void *);
 
 /**
@@ -244,6 +245,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 					csd->func);
 				break;
 
+			case CSD_TYPE_TTWU:
+				pr_warn("IPI task-wakeup sent to offline CPU\n");
+				break;
+
 			default:
 				pr_warn("IPI callback, unknown type %d, sent to offline CPU\n",
 					CSD_TYPE(csd));
@@ -275,22 +280,43 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 		}
 	}
 
+	if (!entry)
+		return;
+
 	/*
 	 * Second; run all !SYNC callbacks.
 	 */
+	prev = NULL;
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
 		int type = CSD_TYPE(csd);
 
-		if (type == CSD_TYPE_ASYNC) {
-			smp_call_func_t func = csd->func;
-			void *info = csd->info;
+		if (type != CSD_TYPE_TTWU) {
+			if (prev) {
+				prev->next = &csd_next->llist;
+			} else {
+				entry = &csd_next->llist;
+			}
 
-			csd_unlock(csd);
-			func(info);
-		} else if (type == CSD_TYPE_IRQ_WORK) {
-			irq_work_single(csd);
+			if (type == CSD_TYPE_ASYNC) {
+				smp_call_func_t func = csd->func;
+				void *info = csd->info;
+
+				csd_unlock(csd);
+				func(info);
+			} else if (type == CSD_TYPE_IRQ_WORK) {
+				irq_work_single(csd);
+			}
+
+		} else {
+			prev = &csd->llist;
 		}
 	}
+
+	/*
+	 * Third; only CSD_TYPE_TTWU is left, issue those.
+	 */
+	if (entry)
+		sched_ttwu_pending(entry);
 }
 
 void flush_smp_call_function_from_idle(void)
@@ -659,6 +685,13 @@ void __init smp_init(void)
 	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
 		     offsetof(struct __call_single_data, flags));
 
+	/*
+	 * Assert the CSD_TYPE_TTWU layout is similar enough
+	 * for task_struct to be on the @call_single_queue.
+	 */
+	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
+		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
+
 	idle_threads_init();
 	cpuhp_threads_init();
 
