Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAC7C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jsKnTUal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIKIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIKIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:41:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F41C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pjxf7cU3wZPZFhxr/36czSE4rB6OEvHpSGCVSMdCVd0=; b=jsKnTUalTqx3OSEdpMtmOenxgq
        ZoeZFtdAqmMn1lnwoeEEJwvDuRm3zlxOinpR+98uK+WYdXOcWjur5HUt2yw/pCzFhV3V8o5YrV2jb
        dcIX3GhvEnIJKxghP4dYztjpSULpOh/ntu4+bNHd/BsTLKFYoIcviEblWMd6t7CFADLIMcqUQLVjI
        eHKiBqx9f8sz5CwDnBAZH5tGKjF0IeJ3LmV5YzS5QIGNgeDCmTSaE1rQdT5Ky1Qbyc+2RPa+hCnx+
        EhIx1VHZBgGMi401bnIDYqtC3MNrfwXLq8u9ZspBrZw/KNRkKSoA39sjUBb9Z6CKKlm6eFgjd+F3w
        R3+zCEug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGecX-0007bQ-8h; Fri, 11 Sep 2020 08:41:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBD6D3012DC;
        Fri, 11 Sep 2020 10:41:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8D2922143B29A; Fri, 11 Sep 2020 10:41:21 +0200 (CEST)
Message-ID: <20200911082536.528661716@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Sep 2020 10:17:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com, peterz@infradead.org
Subject: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run during hotplug
References: <20200911081745.214686199@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for migrate_disable(), make sure only per-cpu kthreads
are allowed to run on !active CPUs.

This is ran (as one of the very first steps) from the cpu-hotplug
task which is a per-cpu kthread and completion of the hotplug
operation only requires such tasks.

This contraint enables the migrate_disable() implementation to wait
for completion of all migrate_disable regions on this CPU at hotplug
time without fear of any new ones starting.

This replaces the unlikely(rq->balance_callbacks) test at the tail of
context_switch with an unlikely(rq->balance_work), the fast path is
not affected.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |    5 ++
 2 files changed, 106 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3513,8 +3513,10 @@ static inline struct callback_head *spli
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head)
+	if (head) {
 		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
 
 	return head;
 }
@@ -3569,6 +3571,8 @@ prepare_lock_switch(struct rq *rq, struc
 #endif
 }
 
+static bool balance_push(struct rq *rq);
+
 static inline void finish_lock_switch(struct rq *rq)
 {
 	/*
@@ -3577,7 +3581,16 @@ static inline void finish_lock_switch(st
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	if (unlikely(rq->balance_flags)) {
+		/*
+		 * Run the balance_callbacks, except on hotplug
+		 * when we need to push the current task away.
+		 */
+		if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+		    !(rq->balance_flags & BALANCE_PUSH) ||
+		    !balance_push(rq))
+			__balance_callbacks(rq);
+	}
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -6836,6 +6849,87 @@ static void migrate_tasks(struct rq *dea
 
 	rq->stop = stop;
 }
+
+static int __balance_push_stop(void *arg)
+{
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	rq_lock(rq, &rf);
+
+	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq = __migrate_task(rq, &rf, p, cpu);
+	}
+
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
+
+/*
+ * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ */
+static bool balance_push(struct rq *rq)
+{
+	struct task_struct *push_task = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
+	/*
+	 * Both the cpu-hotplug and stop task are in this class and are
+	 * required to complete the hotplug process.
+	 */
+	if (is_per_cpu_kthread(push_task))
+		return false;
+
+	get_task_struct(push_task);
+	/*
+	 * Temporarily drop rq->lock such that we can wake-up the stop task.
+	 * Both preemption and IRQs are still disabled.
+	 */
+	raw_spin_unlock(&rq->lock);
+	stop_one_cpu_nowait(rq->cpu, __balance_push_stop, push_task,
+			    this_cpu_ptr(&push_work));
+	/*
+	 * At this point need_resched() is true and we'll take the loop in
+	 * schedule(). The next pick is obviously going to be the stop task
+	 * which is_per_cpu_kthread() and will push this task away.
+	 */
+	raw_spin_lock(&rq->lock);
+
+	return true;
+}
+
+static void balance_push_set(int cpu, bool on)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (on)
+		rq->balance_flags |= BALANCE_PUSH;
+	else
+		rq->balance_flags &= ~BALANCE_PUSH;
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+#else
+
+static inline bool balance_push(struct rq *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6921,6 +7015,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6968,6 +7064,8 @@ int sched_cpu_deactivate(unsigned int cp
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -6981,6 +7079,7 @@ int sched_cpu_deactivate(unsigned int cp
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -973,6 +973,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1384,6 +1385,9 @@ init_numa_balancing(unsigned long clone_
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1397,6 +1401,7 @@ queue_balance_callback(struct rq *rq,
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \


