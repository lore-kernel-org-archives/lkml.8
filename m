Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 23:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D3520737
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f0sOII3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgEJXrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 19:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729078AbgEJXrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 19:47:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 16:47:20 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h6so3787633qvz.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9Vy0tFCWO2RuZ7/nrQfpzHEci8oDeocRjFLXUoIWNg=;
        b=f0sOII3Ixboa2qaXBZ/I6Cc5Z9pQPLR8WV4i2WZUubyQ8s6loqlywIrp0j2/LDoTG7
         5RuDnSDk+BOH6s5LU2jHfHAtmuOnj4A8JyYVzDCMWbcFMnT6MhC/PUCTFFeD9RAhGQCJ
         7Z/vF1kdhhy/C7UEF79m7gpSpYxN/ulWdIknU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9Vy0tFCWO2RuZ7/nrQfpzHEci8oDeocRjFLXUoIWNg=;
        b=sppM2mPYK2Qk9XIXf9yy7PYheHr6R4niiuPZtk5rqONZjv1EJH10My0iuxaMkdV3Fn
         90JQIIb8DpofAotYgIpkyv9vwrh0js7nXU4MtIHQTuWA2eUIF9ybUPkLOZ0FSmYnIFB4
         cvYqY4n3/XEpMOwglpg77TDePHJmhw6u7KNtVg1E28scPMEi5Y0T4URlY6bgMpMkGIhE
         Wq16lANhb8hHk5DeKUa5g+fiLET+G+U2KP+sRFaL0hw9XMTc3PBPpQJdpNwy5LGB9zbq
         s/r10Za9Vt3hHI1BqZ8QbvJGzQjmvCn+2kSuPZu8qhR2k1Mk3Sd6y51GY9ZT5zoQoRdp
         xqDQ==
X-Gm-Message-State: AGi0PuZZikjUhtRJkoBbaRuB5RGqLDj+A2iSyhJEOFPz7SB8/XmKA2n3
        0pllHdiY0j03So36F/NhYti1PPvM6R0=
X-Google-Smtp-Source: APiQypL1NW1t7PgDFhU6HjjXINCwitORJaimkzC/Kkm7LWxcRStv7aRLino0WiP4n6k5IRtsY1rsHg==
X-Received: by 2002:a0c:e8c2:: with SMTP id m2mr12377177qvo.24.1589154438902;
        Sun, 10 May 2020 16:47:18 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g6sm7812987qtc.52.2020.05.10.16.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 16:47:18 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Muchun Song <smuchun@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH RFC] Add support for core-wide protection of IRQ and softirq
Date:   Sun, 10 May 2020 19:46:52 -0400
Message-Id: <20200510234652.249917-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
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

Cc: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Vineeth Pillai <vpillai@digitalocean.com>
Signed-off-by: Vineeth Pillai <vpillai@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
If you like some pictures of the cases handled by this patch, please
see the OSPM slide deck (the below link jumps straight to relevant
slides - about 6-7 of them in total): https://bit.ly/2zvzxWk

TODO:
1. Any optimziations for VM usecases (can we do something better than
   scheduler IPI?)
2. Waiting in schedule() can likely be optimized, example no need to
   wait if previous task was idle, as there would have been an IRQ
   involved with the wake up of the next task.

 include/linux/sched.h |   8 +++
 kernel/sched/core.c   | 159 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |   3 +
 kernel/softirq.c      |   2 +
 4 files changed, 172 insertions(+)

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
index 21c640170323b..e06195dcca7a0 100644
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
+	if (rq->core_this_irq_nest != 1 ||
+	    WARN_ON_ONCE(rq->core->core_this_irq_nest == UINT_MAX))
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
+	if (rq->core_this_irq_nest > 0 ||
+	    WARN_ON_ONCE(rq->core_this_irq_nest == UINT_MAX))
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
index 0427a86743a46..b953386c8f62f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -345,6 +345,7 @@ asmlinkage __visible void do_softirq(void)
 void irq_enter(void)
 {
 	rcu_irq_enter();
+	sched_core_irq_enter();
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
@@ -413,6 +414,7 @@ void irq_exit(void)
 		invoke_softirq();
 
 	tick_irq_exit();
+	sched_core_irq_exit();
 	rcu_irq_exit();
 	trace_hardirq_exit(); /* must be last! */
 }
-- 
2.26.2.645.ge9eca65c58-goog
