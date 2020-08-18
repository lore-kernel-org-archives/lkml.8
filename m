Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D496C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24514205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQ4atf5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRLbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942A0C06134A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JbSl2t5p8cAfzMtMbfY/wIhe7yeAb3xh6EtG6aeJTXo=; b=GQ4atf5Yfyr96rzysLgS+VexJ1
        krzBqmAZdoPBtODdP6XNJ53HraEtO3iu0V0I9rS2Hah7bQiR68YnrsS7aI4MTMt+q7lUu7+Cro/X+
        Hv44l/oIK8vGcjE1tDb35+n5BH+oO/ok4GckfSV3OC8Z6CPXefioDyhAla4mpLfJ6z9csVnUQNtfU
        fofz2xI+rycGPH+7XEwltjos7XEQ1gUgKFhh1PAjDa8N4DrX4iwJ3ucKCLitKPaZCMqgBJmYJbsey
        ZuPajG8uGMVInyjWnVuRvsjTsRNop/HQmpw51Zcl3UPRjdZxPnX0a/sAoH3447pv4gj9urUC+a632
        aZ3Ut8Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002AY-N5; Tue, 18 Aug 2020 11:27:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8B233060F2;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69111200D4C39; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.263774838@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v2 05/10] irq_work: Provide irq_work_queue_remote()
References: <20200818105102.926463950@infradead.org>
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


