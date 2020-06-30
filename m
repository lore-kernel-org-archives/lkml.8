Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769AAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6032065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="NV4gSMLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgF3VeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgF3Vdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E9C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t11so5123688pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Bqi959xnSqAIvbvkP4R1c1lQ3QAOYRVWRkTRYXzoITI=;
        b=NV4gSMLED+doZhmcc9osdmLk9/CCT7Xsy96VEOibTAGuOJ+Fo2sCw3ERJELbSCMHtM
         0amHS87oXHNwSrDk8MEKVIUaM05rLiuzWz0ZZIl40cnLPXz09WBbzVnBMCsaxn8nbGzM
         WzeEDYQT1HP2mCT4BRgtGIOmZwepi6eEH1TtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Bqi959xnSqAIvbvkP4R1c1lQ3QAOYRVWRkTRYXzoITI=;
        b=pHecjmPJxdvLKmnuLbMilB0GXowW8XLpAIkT1iJxpztDV7Tc2gjmz6v5cV2++v9J+y
         /LWQiMJldCBpbrNuA2gsIzjY8zZ0d0iFxCE/bK4/Emi+lyLjZCW3sVvjgG8ZeofiabOD
         dq6whJebtLPRs1dxiR6XLkNoLfHxRsvMIZkPfMDMxgWhv8O7xjwv0byFrKJJxyUGmWFV
         CqrvSx4MNBFQEiBCgrHvRjHPbkzO/o1W3nVACz7eAFpk3/5tLmv2cmLLUvN/55wQcll4
         8SkoH55AD22usfTK50Oi5Y77ATpBVceR3eDWeox94RjYOJAmS5CYHDLgWAOF1R9snyAp
         3/mw==
X-Gm-Message-State: AOAM532kJXZwbhhaaNnxv6VSV8YZvInyd7Z9gtRPip31dfX8lhNl9T7l
        TeCihAHYUf5pxSUJ9rGJygNdKg==
X-Google-Smtp-Source: ABdhPJyDV6wPGfkIOUIUTOWAwlEp/sE3gpAQdRf9YaoXmKfVe9+Z0ujbYRO4ooneICnlE3C1Q3eMzA==
X-Received: by 2002:a05:6a00:10:: with SMTP id h16mr19191176pfk.214.1593552832558;
        Tue, 30 Jun 2020 14:33:52 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id n7sm3068650pjq.22.2020.06.30.14.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:52 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 14/16] irq: Add support for core-wide protection of IRQ and softirq
Date:   Tue, 30 Jun 2020 21:32:35 +0000
Message-Id: <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

With current core scheduling patchset, non-threaded IRQ and softirq
victims can leak data from its hyperthread to a sibling hyperthread
running an attacker.

For MDS, it is possible for the IRQ and softirq handlers to leak data to
either host or guest attackers. For L1TF, it is possible to leak to
guest attackers. There is no possible mitigation involving flushing of
buffers to avoid this since the execution of attacker and victims happen
concurrently on 2 or more HTs.

The solution in this patch is to monitor the outer-most core-wide
irq_enter() and irq_exit() executed by any sibling. In between these
two, we mark the core to be in a special core-wide IRQ state.

In the IRQ entry, if we detect that the sibling is running untrusted
code, we send a reschedule IPI so that the sibling transitions through
the sibling's irq_exit() to do any waiting there, till the IRQ being
protected finishes.

We also monitor the per-CPU outer-most irq_exit(). If during the per-cpu
outer-most irq_exit(), the core is still in the special core-wide IRQ
state, we perform a busy-wait till the core exits this state. This
combination of per-cpu and core-wide IRQ states helps to handle any
combination of irq_entry()s and irq_exit()s happening on all of the
siblings of the core in any order.

Lastly, we also check in the schedule loop if we are about to schedule
an untrusted process while the core is in such a state. This is possible
if a trusted thread enters the scheduler by way of yielding CPU. This
would involve no transitions through the irq_exit() point to do any
waiting, so we have to explicitly do the waiting there.

Every attempt is made to prevent a busy-wait unnecessarily, and in
testing on real-world ChromeOS usecases, it has not shown a performance
drop. In ChromeOS, with this and the rest of the core scheduling
patchset, we see around a 300% improvement in key press latencies into
Google docs when Camera streaming is running simulatenously (90th
percentile latency of ~150ms drops to ~50ms).

This fetaure is controlled by the build time config option
CONFIG_SCHED_CORE_IRQ_PAUSE and is enabled by default. There is also a
kernel boot parameter 'sched_core_irq_pause' to enable/disable the
feature at boot time. Default is enabled at boot time.

Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Vineeth Pillai <vpillai@digitalocean.com>
Signed-off-by: Vineeth Pillai <vpillai@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/kernel-parameters.txt         |   9 +
 include/linux/sched.h                         |   5 +
 kernel/Kconfig.preempt                        |  13 ++
 kernel/sched/core.c                           | 161 ++++++++++++++++++
 kernel/sched/sched.h                          |   7 +
 kernel/softirq.c                              |  46 +++++
 6 files changed, 241 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5e2ce88d6eda..d44d7a997610 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4445,6 +4445,15 @@
 
 	sbni=		[NET] Granch SBNI12 leased line adapter
 
+	sched_core_irq_pause=
+			[SCHED_CORE, SCHED_CORE_IRQ_PAUSE] Pause SMT siblings
+			of a core if atleast one of the siblings of the core
+			is running nmi/irq/softirq. This is to guarentee that
+			kernel data is not leaked to tasks which are not trusted
+			by the kernel.
+			This feature is valid only when Core scheduling is
+			enabled(SCHED_CORE).
+
 	sched_debug	[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f9edf013df3..097746a9f260 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2025,4 +2025,9 @@ int sched_trace_rq_cpu(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+void sched_core_irq_enter(void);
+void sched_core_irq_exit(void);
+#endif
+
 #endif
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 4488fbf4d3a8..59094a66a987 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -86,3 +86,16 @@ config SCHED_CORE
 	default y
 	depends on SCHED_SMT
 
+config SCHED_CORE_IRQ_PAUSE
+	bool "Pause siblings on entering irq/softirq during core-scheduling"
+	default y
+	depends on SCHED_CORE
+	help
+	  This option enables pausing all SMT siblings of a core when atleast
+	  one of the siblings in the core is in nmi/irq/softirq. This is to
+	  enforce security such that information from kernel is not leaked to
+	  non-trusted tasks running on siblings. This option is valid only if
+	  Core Scheduling(CONFIG_SCHED_CORE) is enabled.
+
+	  If in doubt, select 'Y' when CONFIG_SCHED_CORE=y
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ede86fb37b4e..2ec56970d6bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4252,6 +4252,155 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+/*
+ * Helper function to pause the caller's hyperthread until the core exits the
+ * core-wide IRQ state. Obviously the CPU calling this function should not be
+ * responsible for the core being in the core-wide IRQ state otherwise it will
+ * deadlock. This function should be called from irq_exit() and from schedule().
+ * It is upto the callers to decide if calling here is necessary.
+ */
+static inline void sched_core_sibling_irq_pause(struct rq *rq)
+{
+	/*
+	 * Wait till the core of this HT is not in a core-wide IRQ state.
+	 *
+	 * Pair with smp_store_release() in sched_core_irq_exit().
+	 */
+	while (smp_load_acquire(&rq->core->core_irq_nest) > 0)
+		cpu_relax();
+}
+
+/*
+ * Enter the core-wide IRQ state. Sibling will be paused if it is running
+ * 'untrusted' code, until sched_core_irq_exit() is called. Every attempt to
+ * avoid sending useless IPIs is made. Must be called only from hard IRQ
+ * context.
+ */
+void sched_core_irq_enter(void)
+{
+	int i, cpu = smp_processor_id();
+	struct rq *rq = cpu_rq(cpu);
+	const struct cpumask *smt_mask;
+
+	if (!sched_core_enabled(rq))
+		return;
+
+	/* Count irq_enter() calls received without irq_exit() on this CPU. */
+	rq->core_this_irq_nest++;
+
+	/* If not outermost irq_enter(), do nothing. */
+	if (WARN_ON_ONCE(rq->core->core_this_irq_nest == UINT_MAX) ||
+	    rq->core_this_irq_nest != 1)
+		return;
+
+	raw_spin_lock(rq_lockp(rq));
+	smt_mask = cpu_smt_mask(cpu);
+
+	/* Contribute this CPU's irq_enter() to core-wide irq_enter() count. */
+	WRITE_ONCE(rq->core->core_irq_nest, rq->core->core_irq_nest + 1);
+	if (WARN_ON_ONCE(rq->core->core_irq_nest == UINT_MAX))
+		goto unlock;
+
+	if (rq->core_pause_pending) {
+		/*
+		 * Do nothing more since we are in a 'reschedule IPI' sent from
+		 * another sibling. That sibling would have sent IPIs to all of
+		 * the HTs.
+		 */
+		goto unlock;
+	}
+
+	/*
+	 * If we are not the first ones on the core to enter core-wide IRQ
+	 * state, do nothing.
+	 */
+	if (rq->core->core_irq_nest > 1)
+		goto unlock;
+
+	/* Do nothing more if the core is not tagged. */
+	if (!rq->core->core_cookie)
+		goto unlock;
+
+	for_each_cpu(i, smt_mask) {
+		struct rq *srq = cpu_rq(i);
+
+		if (i == cpu || cpu_is_offline(i))
+			continue;
+
+		if (!srq->curr->mm || is_idle_task(srq->curr))
+			continue;
+
+		/* Skip if HT is not running a tagged task. */
+		if (!srq->curr->core_cookie && !srq->core_pick)
+			continue;
+
+		/* IPI only if previous IPI was not pending. */
+		if (!srq->core_pause_pending) {
+			srq->core_pause_pending = 1;
+			smp_send_reschedule(i);
+		}
+	}
+unlock:
+	raw_spin_unlock(rq_lockp(rq));
+}
+
+/*
+ * Process any work need for either exiting the core-wide IRQ state, or for
+ * waiting on this hyperthread if the core is still in this state.
+ */
+void sched_core_irq_exit(void)
+{
+	int cpu = smp_processor_id();
+	struct rq *rq = cpu_rq(cpu);
+	bool wait_here = false;
+	unsigned int nest;
+
+	/* Do nothing if core-sched disabled. */
+	if (!sched_core_enabled(rq))
+		return;
+
+	rq->core_this_irq_nest--;
+
+	/* If not outermost on this CPU, do nothing. */
+	if (WARN_ON_ONCE(rq->core_this_irq_nest == UINT_MAX) ||
+	    rq->core_this_irq_nest > 0)
+		return;
+
+	raw_spin_lock(rq_lockp(rq));
+	/*
+	 * Core-wide nesting counter can never be 0 because we are
+	 * still in it on this CPU.
+	 */
+	nest = rq->core->core_irq_nest;
+	WARN_ON_ONCE(!nest);
+
+	/*
+	 * If we still have other CPUs in IRQs, we have to wait for them.
+	 * Either here, or in the scheduler.
+	 */
+	if (rq->core->core_cookie && nest > 1) {
+		/*
+		 * If we are entering the scheduler anyway, we can just wait
+		 * there for ->core_irq_nest to reach 0. If not, just wait here.
+		 */
+		if (!tif_need_resched()) {
+			wait_here = true;
+		}
+	}
+
+	if (rq->core_pause_pending)
+		rq->core_pause_pending = 0;
+
+	/* Pair with smp_load_acquire() in sched_core_sibling_irq_pause(). */
+	smp_store_release(&rq->core->core_irq_nest, nest - 1);
+	raw_spin_unlock(rq_lockp(rq));
+
+	if (wait_here)
+		sched_core_sibling_irq_pause(rq);
+}
+#endif /* CONFIG_SCHED_CORE_IRQ_PAUSE */
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -4732,6 +4881,18 @@ static void __sched notrace __schedule(bool preempt)
 		rq_unlock_irq(rq, &rf);
 	}
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	/*
+	 * If a CPU  that was running a trusted task entered the scheduler, and
+	 * the next task is untrusted, then check if waiting for core-wide IRQ
+	 * state to cease is needed since we would not have been able to get
+	 * the services of irq_exit() to do that waiting.
+	 */
+	if (sched_core_enabled(rq) &&
+	    !is_idle_task(next) && next->mm && next->core_cookie)
+		sched_core_sibling_irq_pause(rq);
+#endif
+
 	balance_callback(rq);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a5450886c4e4..6445943d3215 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1041,11 +1041,18 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 	unsigned char		core_forceidle;
+	unsigned char		core_pause_pending;
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	unsigned int		core_this_irq_nest;
+#endif
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	unsigned int		core_irq_nest;
+#endif
 #endif
 };
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a47c6dd57452..0745f1c6b352 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -246,6 +246,24 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+DEFINE_STATIC_KEY_TRUE(sched_core_irq_pause);
+static int __init set_sched_core_irq_pause(char *str)
+{
+	unsigned long val = 0;
+	if (!str)
+		return 0;
+
+	val = simple_strtoul(str, &str, 0);
+
+	if (val == 0)
+		static_branch_disable(&sched_core_irq_pause);
+
+	return 1;
+}
+__setup("sched_core_irq_pause=", set_sched_core_irq_pause);
+#endif
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
@@ -273,6 +291,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	/*
+	 * Core scheduling mitigations require entry into softirq to send stall
+	 * IPIs to sibling hyperthreads if needed (ex, sibling is running
+	 * untrusted task). If we are here from irq_exit(), no IPIs are sent.
+	 */
+	if (static_branch_likely(&sched_core_irq_pause))
+		sched_core_irq_enter();
+#endif
+
 	local_irq_enable();
 
 	h = softirq_vec;
@@ -305,6 +333,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		rcu_softirq_qs();
 	local_irq_disable();
 
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	/* Inform the scheduler about exit from softirq. */
+	if (static_branch_likely(&sched_core_irq_pause))
+		sched_core_irq_exit();
+#endif
+
 	pending = local_softirq_pending();
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
@@ -345,6 +379,12 @@ asmlinkage __visible void do_softirq(void)
 void irq_enter(void)
 {
 	rcu_irq_enter();
+
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	if (static_branch_likely(&sched_core_irq_pause))
+		sched_core_irq_enter();
+#endif
+
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
@@ -413,6 +453,12 @@ void irq_exit(void)
 		invoke_softirq();
 
 	tick_irq_exit();
+
+#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
+	if (static_branch_likely(&sched_core_irq_pause))
+		sched_core_irq_exit();
+#endif
+
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();
-- 
2.17.1

