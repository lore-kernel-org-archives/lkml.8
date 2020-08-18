Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39639205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x3wQE0ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHRLcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHRL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D92C061348
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+5MRaBlU7D8V1hPPjuVlNz4t5+e8kPeVGTXvQPVgBzk=; b=x3wQE0llK3L142HlymnbIxxq7c
        +mOLtRC+0VqrfoyZDJ1tq7XobL7x4r+J1jqagqz4yku4WmjENWYwZEWXv6iwnTaihKE7mZmJvIW1A
        LvkAcimiUcYDLW5Ax72gxiZBJHYMwfm/OVP3yNR2la+sidRwuV4XX2t6MsNcY5scgJvjDqszR0Tti
        r0USUx7w0w7hAGGgcdiPt7ShldMfTuQQZIavP0YMGPtho6FJvq8UAQldNwosh/oNn3+RtuuPTkDYC
        M4MY21a7YojqoMILR2UHq1kQG7xSFkQuqBZjzgEVOS7ThYfmLPQsAdqqvG8Ybfox/lh6sKSOoZcha
        Yl7fBE4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmO-0002AH-4k; Tue, 18 Aug 2020 11:27:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93CAE305DD1;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57D64200D4C34; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112417.996049424@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v2 01/10] irq_work: Cleanup
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the __call_single_node union and clean up the API a little
to avoid external code relying on the structure layout as much.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/i915_request.c |    4 ++--
 include/linux/irq_work.h            |   33 +++++++++++++++++++++------------
 include/linux/irqflags.h            |    4 ++--
 kernel/bpf/stackmap.c               |    2 +-
 kernel/irq_work.c                   |   18 +++++++++---------
 kernel/printk/printk.c              |    6 ++----
 kernel/rcu/tree.c                   |    3 +--
 kernel/time/tick-sched.c            |    6 ++----
 kernel/trace/bpf_trace.c            |    2 +-
 9 files changed, 41 insertions(+), 37 deletions(-)

--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -196,7 +196,7 @@ static void __notify_execute_cb(struct i
 	if (llist_empty(&rq->execute_cb))
 		return;
 
-	llist_for_each_entry_safe(cb, cn, rq->execute_cb.first, work.llnode)
+	llist_for_each_entry_safe(cb, cn, rq->execute_cb.first, work.node.llist)
 		irq_work_queue(&cb->work);
 
 	/*
@@ -448,7 +448,7 @@ __await_execution(struct i915_request *r
 		i915_sw_fence_complete(cb->fence);
 		kmem_cache_free(global.slab_execute_cbs, cb);
 	} else {
-		__llist_add(&cb->work.llnode, &signal->execute_cb);
+		__llist_add(&cb->work.node.llist, &signal->execute_cb);
 	}
 	spin_unlock_irq(&signal->lock);
 
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -14,28 +14,37 @@
  */
 
 struct irq_work {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llnode;
-			atomic_t flags;
-		};
-	};
+	struct __call_single_node node;
 	void (*func)(struct irq_work *);
 };
 
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.node = { .u_flags = (_flags), },			\
+	.func = (_func),					\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
+#define DEFINE_IRQ_WORK(name, _f)				\
+	struct irq_work name = IRQ_WORK_INIT(_f)
+
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
-	atomic_set(&work->flags, 0);
-	work->func = func;
+	*work = IRQ_WORK_INIT(func);
 }
 
-#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
-		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+static inline bool irq_work_is_pending(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
 }
 
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -108,12 +108,12 @@ do {						\
 
 # define lockdep_irq_work_enter(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 1;			\
 	  } while (0)
 # define lockdep_irq_work_exit(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 0;			\
 	  } while (0)
 
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -294,7 +294,7 @@ static void stack_map_get_build_id_offse
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&up_read_work);
-			if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY) {
+			if (irq_work_is_busy(&work->irq_work)) {
 				/* cannot queue more up_read, fallback */
 				irq_work_busy = true;
 			}
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -31,7 +31,7 @@ static bool irq_work_claim(struct irq_wo
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
 	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
@@ -53,12 +53,12 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
+		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
 }
@@ -102,7 +102,7 @@ bool irq_work_queue_on(struct irq_work *
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->llnode);
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -142,7 +142,7 @@ void irq_work_single(void *arg)
 	 * to claim that work don't rely on us to handle their data
 	 * while we are in the middle of the func.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
 
 	lockdep_irq_work_enter(work);
 	work->func(work);
@@ -152,7 +152,7 @@ void irq_work_single(void *arg)
 	 * no-one else claimed it meanwhile.
 	 */
 	flags &= ~IRQ_WORK_PENDING;
-	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -166,7 +166,7 @@ static void irq_work_run_list(struct lli
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, llnode)
+	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
 		irq_work_single(work);
 }
 
@@ -198,7 +198,7 @@ void irq_work_sync(struct irq_work *work
 {
 	lockdep_assert_irqs_enabled();
 
-	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
+	while (irq_work_is_busy(work))
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3029,10 +3029,8 @@ static void wake_up_klogd_work_func(stru
 		wake_up_interruptible(&log_wait);
 }
 
-static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
-	.func = wake_up_klogd_work_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
-};
+static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
+	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
 void wake_up_klogd(void)
 {
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1305,8 +1305,6 @@ static int rcu_implicit_dynticks_qs(stru
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
-			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
-			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
@@ -3906,6 +3904,7 @@ int rcutree_prepare_cpu(unsigned int cpu
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
+	rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -243,10 +243,8 @@ static void nohz_full_kick_func(struct i
 	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
 }
 
-static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
-	.func = nohz_full_kick_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
-};
+static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
+	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
 
 /*
  * Kick this CPU if it's full dynticks in order to force it to
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1057,7 +1057,7 @@ static int bpf_send_signal_common(u32 si
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
+		if (irq_work_is_busy(&work->irq_work))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,


