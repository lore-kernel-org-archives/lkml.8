Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE73C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85A9207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vpnCvrEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgGVPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbgGVPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB19C0619E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JbSl2t5p8cAfzMtMbfY/wIhe7yeAb3xh6EtG6aeJTXo=; b=vpnCvrEfL6Pk3XrT3Jx+BEmagT
        dLrsKjPIQhe0uU4VsNt6TJSOQRWEwOPxD/WDVOWA7XXnJHBCOEVgrFSzj3Tj+WtdVc82IApr8YoB+
        ywjbbpVYDUaSEwZwwBx0nJGNquFGa1zPoHsVZGrIyyWKQzt90L1ABLu6k89KxOnk99GM/b5fwO2s9
        NZdf3K1JDg53wjyf1v3eBrIAwBGcVMsZ9+fW2wasf7MkCAdZ1z/dHjRJCaJGNbOBXf6G95G7X5ssC
        DM0JFwhNgV923I7Uo9BGvHeispPM1fxuO1ogf29gkaxAOALJ7dK9s7bOtPwaIsao5DFZIw0HlWurG
        ibIaK48Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjw-0007sO-Uu; Wed, 22 Jul 2020 15:33:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8A96307697;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4C177200D4174; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722153017.311972826@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 5/9] irq_work: Provide irq_work_queue_remote()
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the traditional irq_work relies on the ability to self-IPI, it
makes sense to provide an unconditional irq_work_queue_remote()
interface.

This can be used to replace the plagued smp_call_function_single_async().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |   17 ++++--
 kernel/irq_work.c        |  129 ++++++++++++++++++++++++++++-------------------
 kernel/rcu/tree.c        |    6 +-
 3 files changed, 95 insertions(+), 57 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -46,22 +46,29 @@ static inline bool irq_work_is_busy(stru
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
 
+#ifdef CONFIG_IRQ_WORK
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
 
-#ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
 
 void irq_work_run(void);
 bool irq_work_needs_cpu(void);
-void irq_work_single(void *arg);
-#else
-static inline bool irq_work_needs_cpu(void) { return false; }
+
+#else /* !CONFIG_IRQ_WORK */
+
 static inline void irq_work_run(void) { }
-static inline void irq_work_single(void *arg) { }
+static inline bool irq_work_needs_cpu(void) { return false; }
+
+#endif /* CONFIG_IRQ_WORK */
+
+#ifdef CONFIG_SMP
+extern int irq_work_queue_remote(int cpu, struct irq_work *work);
+extern void irq_work_single(void *arg);
 #endif
 
 #endif /* _LINUX_IRQ_WORK_H */
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,10 +20,7 @@
 #include <linux/smp.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_IRQ_WORK
-
-static DEFINE_PER_CPU(struct llist_head, raised_list);
-static DEFINE_PER_CPU(struct llist_head, lazy_list);
+#if defined(CONFIG_IRQ_WORK) || defined(CONFIG_SMP)
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -43,6 +40,82 @@ static bool irq_work_claim(struct irq_wo
 	return true;
 }
 
+void irq_work_single(void *arg)
+{
+	struct irq_work *work = arg;
+	int flags;
+
+	/*
+	 * Clear the PENDING bit, after this point the @work can be re-used.
+	 * The PENDING bit acts as a lock, and we own it, so we can clear it
+	 * without atomic ops.
+	 */
+	flags = atomic_read(&work->node.a_flags);
+	flags &= ~IRQ_WORK_PENDING;
+	atomic_set(&work->node.a_flags, flags);
+
+	/*
+	 * See irq_work_claim().
+	 */
+	smp_mb();
+
+	lockdep_irq_work_enter(flags);
+	work->func(work);
+	lockdep_irq_work_exit(flags);
+
+	/*
+	 * Clear the BUSY bit, if set, and return to the free state if no-one
+	 * else claimed it meanwhile.
+	 */
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+}
+
+/*
+ * Synchronize against the irq_work @entry, ensures the entry is not
+ * currently in use.
+ */
+void irq_work_sync(struct irq_work *work)
+{
+	lockdep_assert_irqs_enabled();
+
+	while (irq_work_is_busy(work))
+		cpu_relax();
+}
+EXPORT_SYMBOL_GPL(irq_work_sync);
+
+#endif /* CONFIG_IRQ_WORK || CONFIG_SMP */
+
+#ifdef CONFIG_SMP
+
+static void __irq_work_queue_remote(int cpu, struct irq_work *work)
+{
+	/* Arch remote IPI send/receive backend aren't NMI safe */
+	WARN_ON_ONCE(in_nmi());
+	__smp_call_single_queue(cpu, &work->node.llist);
+}
+
+int irq_work_queue_remote(int cpu, struct irq_work *work)
+{
+	/*
+	 * Ensures preemption is disabled in the caller.
+	 */
+	WARN_ON_ONCE(cpu == smp_processor_id());
+
+	if (!irq_work_claim(work))
+		return -EBUSY;
+
+	__irq_work_queue_remote(cpu, work);
+
+	return 0;
+}
+
+#endif /* CONFIG_SMP */
+
+#ifdef CONFIG_IRQ_WORK
+
+static DEFINE_PER_CPU(struct llist_head, raised_list);
+static DEFINE_PER_CPU(struct llist_head, lazy_list);
+
 void __weak arch_irq_work_raise(void)
 {
 	/*
@@ -101,9 +174,7 @@ bool irq_work_queue_on(struct irq_work *
 
 	preempt_disable();
 	if (cpu != smp_processor_id()) {
-		/* Arch remote IPI send/receive backend aren't NMI safe */
-		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->node.llist);
+		__irq_work_queue_remote(cpu, work);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -131,36 +202,6 @@ bool irq_work_needs_cpu(void)
 	return true;
 }
 
-void irq_work_single(void *arg)
-{
-	struct irq_work *work = arg;
-	int flags;
-
-	/*
-	 * Clear the PENDING bit, after this point the @work can be re-used.
-	 * The PENDING bit acts as a lock, and we own it, so we can clear it
-	 * without atomic ops.
-	 */
-	flags = atomic_read(&work->node.a_flags);
-	flags &= ~IRQ_WORK_PENDING;
-	atomic_set(&work->node.a_flags, flags);
-
-	/*
-	 * See irq_work_claim().
-	 */
-	smp_mb();
-
-	lockdep_irq_work_enter(flags);
-	work->func(work);
-	lockdep_irq_work_exit(flags);
-
-	/*
-	 * Clear the BUSY bit, if set, and return to the free state if no-one
-	 * else claimed it meanwhile.
-	 */
-	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
-}
-
 static void irq_work_run_list(struct llist_head *list)
 {
 	struct irq_work *work, *tmp;
@@ -196,17 +237,5 @@ void irq_work_tick(void)
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
-/*
- * Synchronize against the irq_work @entry, ensures the entry is not
- * currently in use.
- */
-void irq_work_sync(struct irq_work *work)
-{
-	lockdep_assert_irqs_enabled();
-
-	while (irq_work_is_busy(work))
-		cpu_relax();
-}
-EXPORT_SYMBOL_GPL(irq_work_sync);
-
 #endif /* CONFIG_IRQ_WORK */
+
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1284,13 +1284,15 @@ static int rcu_implicit_dynticks_qs(stru
 			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 		}
-		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
-		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
+#ifdef CONFIG_IRQ_WORK
+		// XXX should we use irq_work_queue_remote() ?
+		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
 		}
+#endif
 	}
 
 	return 0;


