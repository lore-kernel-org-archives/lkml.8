Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA609C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A320704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBFndTeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgEZQTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbgEZQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:19:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9910C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eTj/YKIAMK7fb6FVAI9IceIEjbd82P7TPKgwouRg/6A=; b=oBFndTeQgox8Nl5acIDWn8jwu9
        XEc/ZafAoLGwjtvHJz438itg0enR/9IR1q82VLJDy7R9zmtl/g1YjpPqxXJQb6VT24Pv/TPi38TDb
        QtQIfVMdBYha+4erAy4OuvgKJ/n7XimQ3vmVVf7pEgF793xHSM7/rX5TvTm1un3Ztg88DbOs5XDWh
        88PLll7epxOVQT7/K/FiDOrmAHXoNFNipChdgI9O/HaxdbR1tVN2Rv17U5F6K1bC2+6VP8CX2lprm
        KQ5UMyJ49MhutjGor1itwYcc/YLE6dahEofMqq6uyncSFlg11IjusGtw/Lhk47u/Xs+k30VgCCEVU
        umG34+yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIs-0000HW-93; Tue, 26 May 2020 16:19:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFC353069A4;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5BF8020FF793D; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161908.011635912@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:11:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on call_single_queue
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently irq_work_queue_on() will issue an unconditional
arch_send_call_function_single_ipi() and has the handler do
irq_work_run().

This is unfortunate in that it makes the IPI handler look at a second
cacheline and it misses the opportunity to avoid the IPI. Instead note
that struct irq_work and struct __call_single_data are very similar in
layout, so use a few bits in the flags word to encode a type and stick
the irq_work on the call_single_queue list.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |    7 ++
 include/linux/smp.h      |   23 ++++++++-
 kernel/irq_work.c        |   53 +++++++++++---------
 kernel/smp.c             |  119 ++++++++++++++++++++++++++++-------------------
 4 files changed, 130 insertions(+), 72 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -13,6 +13,8 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
+/* flags share CSD_FLAG_ space */
+
 #define IRQ_WORK_PENDING	BIT(0)
 #define IRQ_WORK_BUSY		BIT(1)
 
@@ -23,9 +25,12 @@
 
 #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
 
+/*
+ * structure shares layout with single_call_data_t.
+ */
 struct irq_work {
-	atomic_t flags;
 	struct llist_node llnode;
+	atomic_t flags;
 	void (*func)(struct irq_work *);
 };
 
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -16,17 +16,38 @@
 
 typedef void (*smp_call_func_t)(void *info);
 typedef bool (*smp_cond_func_t)(int cpu, void *info);
+
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+
+	/* IRQ_WORK_flags */
+
+	CSD_TYPE_ASYNC		= 0x00,
+	CSD_TYPE_SYNC		= 0x10,
+	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_FLAG_TYPE_MASK	= 0xF0,
+};
+
+/*
+ * structure shares (partial) layout with struct irq_work
+ */
 struct __call_single_data {
 	struct llist_node llist;
+	unsigned int flags;
 	smp_call_func_t func;
 	void *info;
-	unsigned int flags;
 };
 
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+/*
+ * Enqueue a llist_node on the call_single_queue; be very careful, read
+ * flush_smp_call_function_queue() in detail.
+ */
+extern void __smp_call_single_queue(int cpu, struct llist_node *node);
+
 /* total number of cpus in this system (may exceed NR_CPUS) */
 extern unsigned int total_cpus;
 
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -31,7 +31,7 @@ static bool irq_work_claim(struct irq_wo
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
 	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
@@ -102,8 +102,7 @@ bool irq_work_queue_on(struct irq_work *
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
-			arch_send_call_function_single_ipi(cpu);
+		__smp_call_single_queue(cpu, &work->llnode);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -131,6 +130,31 @@ bool irq_work_needs_cpu(void)
 	return true;
 }
 
+void irq_work_single(void *arg)
+{
+	struct irq_work *work = arg;
+	int flags;
+
+	/*
+	 * Clear the PENDING bit, after this point the @work
+	 * can be re-used.
+	 * Make it immediately visible so that other CPUs trying
+	 * to claim that work don't rely on us to handle their data
+	 * while we are in the middle of the func.
+	 */
+	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+
+	lockdep_irq_work_enter(work);
+	work->func(work);
+	lockdep_irq_work_exit(work);
+	/*
+	 * Clear the BUSY bit and return to the free state if
+	 * no-one else claimed it meanwhile.
+	 */
+	flags &= ~IRQ_WORK_PENDING;
+	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+}
+
 static void irq_work_run_list(struct llist_head *list)
 {
 	struct irq_work *work, *tmp;
@@ -142,27 +166,8 @@ static void irq_work_run_list(struct lli
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, llnode) {
-		int flags;
-		/*
-		 * Clear the PENDING bit, after this point the @work
-		 * can be re-used.
-		 * Make it immediately visible so that other CPUs trying
-		 * to claim that work don't rely on us to handle their data
-		 * while we are in the middle of the func.
-		 */
-		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
-
-		lockdep_irq_work_enter(work);
-		work->func(work);
-		lockdep_irq_work_exit(work);
-		/*
-		 * Clear the BUSY bit and return to the free state if
-		 * no-one else claimed it meanwhile.
-		 */
-		flags &= ~IRQ_WORK_PENDING;
-		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
-	}
+	llist_for_each_entry_safe(work, tmp, llnode, llnode)
+		irq_work_single(work);
 }
 
 /*
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -23,10 +23,8 @@
 
 #include "smpboot.h"
 
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-	CSD_FLAG_SYNCHRONOUS	= 0x02,
-};
+
+#define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
 
 struct call_function_data {
 	call_single_data_t	__percpu *csd;
@@ -137,15 +135,33 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(cal
 
 extern void send_call_function_single_ipi(int cpu);
 
+void __smp_call_single_queue(int cpu, struct llist_node *node)
+{
+	/*
+	 * The list addition should be visible before sending the IPI
+	 * handler locks the list to pull the entry off it because of
+	 * normal cache coherency rules implied by spinlocks.
+	 *
+	 * If IPIs can go out of order to the cache coherency protocol
+	 * in an architecture, sufficient synchronisation should be added
+	 * to arch code to make it appear to obey cache coherency WRT
+	 * locking and barrier primitives. Generic code isn't really
+	 * equipped to do the right thing...
+	 */
+	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
+		send_call_function_single_ipi(cpu);
+}
+
 /*
  * Insert a previously allocated call_single_data_t element
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, call_single_data_t *csd,
-			       smp_call_func_t func, void *info)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
+		smp_call_func_t func = csd->func;
+		void *info = csd->info;
 		unsigned long flags;
 
 		/*
@@ -159,28 +175,12 @@ static int generic_exec_single(int cpu,
 		return 0;
 	}
 
-
 	if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {
 		csd_unlock(csd);
 		return -ENXIO;
 	}
 
-	csd->func = func;
-	csd->info = info;
-
-	/*
-	 * The list addition should be visible before sending the IPI
-	 * handler locks the list to pull the entry off it because of
-	 * normal cache coherency rules implied by spinlocks.
-	 *
-	 * If IPIs can go out of order to the cache coherency protocol
-	 * in an architecture, sufficient synchronisation should be added
-	 * to arch code to make it appear to obey cache coherency WRT
-	 * locking and barrier primitives. Generic code isn't really
-	 * equipped to do the right thing...
-	 */
-	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
-		send_call_function_single_ipi(cpu);
+	__smp_call_single_queue(cpu, &csd->llist);
 
 	return 0;
 }
@@ -194,16 +194,10 @@ static int generic_exec_single(int cpu,
 void generic_smp_call_function_single_interrupt(void)
 {
 	flush_smp_call_function_queue(true);
-
-	/*
-	 * Handle irq works queued remotely by irq_work_queue_on().
-	 * Smp functions above are typically synchronous so they
-	 * better run first since some other CPUs may be busy waiting
-	 * for them.
-	 */
-	irq_work_run();
 }
 
+extern void irq_work_single(void *);
+
 /**
  * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
  *
@@ -241,9 +235,21 @@ static void flush_smp_call_function_queu
 		 * We don't have to use the _safe() variant here
 		 * because we are not invoking the IPI handlers yet.
 		 */
-		llist_for_each_entry(csd, entry, llist)
-			pr_warn("IPI callback %pS sent to offline CPU\n",
-				csd->func);
+		llist_for_each_entry(csd, entry, llist) {
+			switch (CSD_TYPE(csd)) {
+			case CSD_TYPE_ASYNC:
+			case CSD_TYPE_SYNC:
+			case CSD_TYPE_IRQ_WORK:
+				pr_warn("IPI callback %pS sent to offline CPU\n",
+					csd->func);
+				break;
+
+			default:
+				pr_warn("IPI callback, unknown type %d, sent to offline CPU\n",
+					CSD_TYPE(csd));
+				break;
+			}
+		}
 	}
 
 	/*
@@ -251,16 +257,17 @@ static void flush_smp_call_function_queu
 	 */
 	prev = NULL;
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
-		smp_call_func_t func = csd->func;
-		void *info = csd->info;
-
 		/* Do we wait until *after* callback? */
-		if (csd->flags & CSD_FLAG_SYNCHRONOUS) {
+		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
+			smp_call_func_t func = csd->func;
+			void *info = csd->info;
+
 			if (prev) {
 				prev->next = &csd_next->llist;
 			} else {
 				entry = &csd_next->llist;
 			}
+
 			func(info);
 			csd_unlock(csd);
 		} else {
@@ -272,11 +279,17 @@ static void flush_smp_call_function_queu
 	 * Second; run all !SYNC callbacks.
 	 */
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
-		smp_call_func_t func = csd->func;
-		void *info = csd->info;
+		int type = CSD_TYPE(csd);
 
-		csd_unlock(csd);
-		func(info);
+		if (type == CSD_TYPE_ASYNC) {
+			smp_call_func_t func = csd->func;
+			void *info = csd->info;
+
+			csd_unlock(csd);
+			func(info);
+		} else if (type == CSD_TYPE_IRQ_WORK) {
+			irq_work_single(csd);
+		}
 	}
 }
 
@@ -305,7 +318,7 @@ int smp_call_function_single(int cpu, sm
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
-		.flags = CSD_FLAG_LOCK | CSD_FLAG_SYNCHRONOUS,
+		.flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC,
 	};
 	int this_cpu;
 	int err;
@@ -339,7 +352,10 @@ int smp_call_function_single(int cpu, sm
 		csd_lock(csd);
 	}
 
-	err = generic_exec_single(cpu, csd, func, info);
+	csd->func = func;
+	csd->info = info;
+
+	err = generic_exec_single(cpu, csd);
 
 	if (wait)
 		csd_lock_wait(csd);
@@ -385,7 +401,7 @@ int smp_call_function_single_async(int c
 	csd->flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
-	err = generic_exec_single(cpu, csd, csd->func, csd->info);
+	err = generic_exec_single(cpu, csd);
 
 out:
 	preempt_enable();
@@ -500,7 +516,7 @@ static void smp_call_function_many_cond(
 
 		csd_lock(csd);
 		if (wait)
-			csd->flags |= CSD_FLAG_SYNCHRONOUS;
+			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
@@ -632,6 +648,17 @@ void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
 
+	/*
+	 * Ensure struct irq_work layout matches so that
+	 * flush_smp_call_function_queue() can do horrible things.
+	 */
+	BUILD_BUG_ON(offsetof(struct irq_work, llnode) !=
+		     offsetof(struct __call_single_data, llist));
+	BUILD_BUG_ON(offsetof(struct irq_work, func) !=
+		     offsetof(struct __call_single_data, func));
+	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
+		     offsetof(struct __call_single_data, flags));
+
 	idle_threads_init();
 	cpuhp_threads_init();
 


