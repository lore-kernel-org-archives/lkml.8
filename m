Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A43EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68ABE205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hv3IIbxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHRLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHRL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DAC061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zEyQaZl+BH4Ca7RHWpVGJSeXguzr0RPSrKA3yktCFqU=; b=hv3IIbxaV0z8+eAqMWJrsd6C0l
        34wJFaGoWDYSvErP/2gwNI7vDv8Q+F+ThVbs8B9yNtyJwddM0Vn102CY4sFRdvYSMVPTQa5ba5LLI
        VdYr+uDAakBWSwah633bE6/3pz0WbZe8rW+sW2O8LbArcuNd2Vs4IJPfWM6OR6kbISsNTKd8D8Qso
        B/FJCR3mY8TUfI+UD/oZ0UOIMW6rKobpawaWCNjQ1ByraqV/6Uv3qJhnkgp5avjmGaqguVxYaGvyJ
        R35vZ0b0BFE4EUzIP1B1hWoIP+aqWcZsSRO09xn2TMf3TOIQGO3knU6BXQb4w5GA7a1/GHTjEQ8bA
        s7t1OUWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002Ab-Nf; Tue, 18 Aug 2020 11:27:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED98B30785A;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B42422E9BD68; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.591210082@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH v2 10/10] irq_work: Add a few comments
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |   80 +++++++++++++++++++++++++++++++++++++++++------
 kernel/irq_work.c        |   10 +++++
 2 files changed, 80 insertions(+), 10 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -4,15 +4,6 @@
 
 #include <linux/smp_types.h>
 
-/*
- * An entry can be in one of four states:
- *
- * free	     NULL, 0 -> {claimed}       : free to be used
- * claimed   NULL, 3 -> {pending}       : claimed to be enqueued
- * pending   next, 3 -> {busy}          : queued, pending callback
- * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
- */
-
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
@@ -36,11 +27,19 @@ void init_irq_work(struct irq_work *work
 	*work = IRQ_WORK_INIT(func);
 }
 
+/*
+ * irq_work_is_pending(): if @work is already queued
+ */
 static inline bool irq_work_is_pending(struct irq_work *work)
 {
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
 }
 
+/*
+ * irq_work_is_busy(): true until after func() has run
+ *
+ * Does not work with irq_work_queue_remote_static().
+ */
 static inline bool irq_work_is_busy(struct irq_work *work)
 {
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
@@ -48,12 +47,45 @@ static inline bool irq_work_is_busy(stru
 
 #ifdef CONFIG_IRQ_WORK
 
+/*
+ * irq_work_queue(): run @work in IRQ context on this CPU
+ * @work: work to run
+ *
+ * Self-IPI, NMI-safe
+ *
+ * When the function returns false; @work is already queued and
+ * any eventual execution of it's func() is guaranteed to see
+ * any state before the failing enqueue.
+ */
 bool irq_work_queue(struct irq_work *work);
+
+/*
+ * irq_work_queue_on(): run @work in IRQ context on @cpu
+ * @work: work to run
+ * @cpu: cpu to run @work on
+ *
+ * *NOT* NMI-safe
+ *
+ * When the function returns false; @work is already queued and
+ * any eventual execution of it's func() is guaranteed to see
+ * any state before the failing enqueue.
+ */
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
-void irq_work_tick(void);
+/*
+ * irq_work_sync(): wait for completion of @work
+ * @work:
+ *
+ * Expects no concurrent irq_work_queue()
+ *
+ * Will return once @work is no longer 'busy'.
+ *
+ * Does not work with irq_work_queue_remote_static().
+ */
 void irq_work_sync(struct irq_work *work);
 
+void irq_work_tick(void);
+
 #include <asm/irq_work.h>
 
 void irq_work_run(void);
@@ -67,8 +99,36 @@ static inline bool irq_work_needs_cpu(vo
 #endif /* CONFIG_IRQ_WORK */
 
 #ifdef CONFIG_SMP
+
+/*
+ * irq_work_queue_remote(): run @work in IRQ context on @cpu
+ * @cpu:
+ * @work:
+ *
+ * like irq_work_queue_on(), except it requires @cpu != smp_processor_id() and
+ * is available for any SMP build.
+ *
+ * Return -EBUSY when already queued, 0 on success.
+ */
 extern int irq_work_queue_remote(int cpu, struct irq_work *work);
+
+/*
+ * irq_work_queue_remote_state(): like irq_work_queue_remote() except dangerous
+ * @cpu:
+ * @work:
+ *
+ * DO NOT USE, this function is horrible/dangerous.
+ *
+ * The test-and-set-PENDING is not atomic, it also doesn't set
+ * the BUSY bit and with that breaks irq_work_sync().
+ *
+ * This means that the caller needs external serialization; life-time,
+ * where relevant, also needs to be externally orchestated.
+ *
+ * There is no validation/debugging to help you if you get it wrong.
+ */
 extern int irq_work_queue_remote_static(int cpu, struct irq_work *work);
+
 extern void irq_work_single(void *arg);
 #endif
 
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -23,6 +23,15 @@
 #if defined(CONFIG_IRQ_WORK) || defined(CONFIG_SMP)
 
 /*
+ * An entry can be in one of four states:
+ *
+ * free	     NULL, 0 -> {claimed}       : free to be used
+ * claimed   NULL, 3 -> {pending}       : claimed to be enqueued
+ * pending   next, 3 -> {busy}          : queued, pending callback
+ * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
+ */
+
+/*
  * Claim the entry so that no one else will poke at it.
  */
 static bool irq_work_claim(struct irq_work *work)
@@ -37,6 +46,7 @@ static bool irq_work_claim(struct irq_wo
 	 */
 	if (oflags & IRQ_WORK_PENDING)
 		return false;
+
 	return true;
 }
 


