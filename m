Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579E520884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aunVW1ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgETWhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgETWhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:37:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:37:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so5306550qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=baqNmHJmJaRAolWweU9v8hhZaehFJfxBPfuFN53EiNg=;
        b=aunVW1uxj64uPndcDiMOZxCVc61M7dNBGrdTg9a58oWkD7RYYVfUEapZHZH4oSp+m1
         5Zbkdizo7qR+xOBJh7QbttXHpS0h9WU4QjPtDEOvK1Fg9Z9fY1Af49SHHIgkekT9RXaM
         fQmId4G75V14D1Q2fDgIBb6S9ro6D0qXIBuOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=baqNmHJmJaRAolWweU9v8hhZaehFJfxBPfuFN53EiNg=;
        b=p88jF74pxFXzcNgR8nOoS+E7UpdBy2lqz6AO6tVEw40GGRAG5kM4g3vMvnwf4X9nnW
         350b57Z1i9+DdNYfR4lts/X3GEonY5saBDLqzM3QTlS6k8oJEkGGoqyDgLirIYi01YPI
         IvEm3PEQvjhMt2/xSNsX93AlSK9+QhcRzerge0A9LrMw7qu2xWo0cPDua3SwY9KankCs
         7Icg4OTyzXpa8J4M4afTSjXojTmi5JLid6dBaTVmJUz4vao9g8znIQhd938kFfIspr9D
         ykrLkhvFLTDIwGPBNeeWjNaMnVDPHnZRp7eVZcKGhIoCjTaFLQs3ZrosFqywDmFmXzX1
         iqeQ==
X-Gm-Message-State: AOAM530rxRVBZtVmMD/QvVw/2WXRlyY00d0ze8pqlNZZaFvHR6yn4op+
        Oy1KvRs0yzCjxGpKsjtiNeJuJg==
X-Google-Smtp-Source: ABdhPJzBiIsTkEY5uq8gfWGuwCIuaOozEkoslTHJH+BaULmvJ4gWTrDgnPaytdQyflW3AU0VXt8bsw==
X-Received: by 2002:a05:620a:792:: with SMTP id 18mr6441706qka.181.1590014252828;
        Wed, 20 May 2020 15:37:32 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g26sm3662672qtk.76.2020.05.20.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:37:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2] Add support for core-wide protection of IRQ and softirq
Date:   Wed, 20 May 2020 18:37:21 -0400
Message-Id: <20200520223721.74447-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
If you like some pictures of the cases handled by this patch, please
see the OSPM slide deck (the below link jumps straight to relevant
slides - about 6-7 of them in total): https://bit.ly/2zvzxWk

v1->v2:
  Fixed a bug where softirq was causing deadlock (thanks Vineeth/Julien)

The issue was because of the following flow:

On CPU0:
local_bh_enable()
  ->  Enter softirq
   -> Softirq takes a lock.
   -> <new Interrupt received during softirq>
   -> New interrupt's irq_exit() : Wait since it is not outermost
                                   core-wide irq_exit().

On CPU1:
 <interrupt received>
irq_enter()  -> Enter the core wide IRQ state.
    <ISR raises a softirq which will run from irq_exit().
irq_exit()   ->
    -> enters softirq
         -> softirq tries to take a lock and blocks.

So it is an A->B and B->A deadlock.
A  = Enter the core-wide IRQ state or wait for it to end.
B =  Acquire a lock during softirq or wait for it to be released.

The fix is to enter the core-wide IRQ state even when entering through
the local_bh_enable -> softirq path (When there is no hardirq
context). which basically becomes:

On CPU0:
local_bh_enable()
    (Fix: Call sched_core_irq_enter() --> similar to irq_enter()).
  ->  Enter softirq
   -> Softirq takes a lock.
     -> <new Interrupt received during softirq> -> irq_enter()
     -> New interrupt's irq_exit()   (Will not wait since we are inner
        irq_exit()).

 include/linux/sched.h |   8 +++
 kernel/sched/core.c   | 159 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |   3 +
 kernel/softirq.c      |  12 ++++
 4 files changed, 182 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 710e9a8956007..fe6ae59fcadbe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2018,4 +2018,12 @@ int sched_trace_rq_cpu(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+void sched_core_irq_enter(void);
+void sched_core_irq_exit(void);
+#else
+static void sched_core_irq_enter(void) { }
+static void sched_core_irq_exit(void) { }
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21c640170323b..684359ff357e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4391,6 +4391,153 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
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
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -4910,6 +5057,18 @@ static void __sched notrace __schedule(bool preempt)
 		rq_unlock_irq(rq, &rf);
 	}
 
+#ifdef CONFIG_SCHED_CORE
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
index a7d9f156242e2..3a065d133ef51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1018,11 +1018,14 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 	unsigned char		core_forceidle;
+	unsigned char		core_pause_pending;
+	unsigned int		core_this_irq_nest;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned int		core_irq_nest;
 #endif
 };
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0427a86743a46..147abd6d82599 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -273,6 +273,13 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
 
+	/*
+	 * Core scheduling mitigations require entry into softirq to send stall
+	 * IPIs to sibling hyperthreads if needed (ex, sibling is running
+	 * untrusted task). If we are here from irq_exit(), no IPIs are sent.
+	 */
+	sched_core_irq_enter();
+
 	local_irq_enable();
 
 	h = softirq_vec;
@@ -305,6 +312,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		rcu_softirq_qs();
 	local_irq_disable();
 
+	/* Inform the scheduler about exit from softirq. */
+	sched_core_irq_exit();
+
 	pending = local_softirq_pending();
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
@@ -345,6 +355,7 @@ asmlinkage __visible void do_softirq(void)
 void irq_enter(void)
 {
 	rcu_irq_enter();
+	sched_core_irq_enter();
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
@@ -413,6 +424,7 @@ void irq_exit(void)
 		invoke_softirq();
 
 	tick_irq_exit();
+	sched_core_irq_exit();
 	rcu_irq_exit();
 	trace_hardirq_exit(); /* must be last! */
 }
-- 
2.26.2.761.g0e0b3e54be-goog

