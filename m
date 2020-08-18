Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10AD205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yD7bg7eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRLbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgHRL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430AC06134B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sQ9oNWjV5tsaXyqykymTkyVGshnjTmfXe8uEPdAl1Zo=; b=yD7bg7eZ+Ti/cjvOH/iLbLTSGz
        641qwQluxEvjFxrCE9zjlzQaHCv8VLC17GrwpRghxw4VC/un9U1Dq07GAYEt211H1vQh45bwgJowg
        tqoBuM90ZvqLM2k3IPmFEV/u++j0v9L+k6h9l+IsP1gA1SJtc8bOHadyPdT4ji8BiQWOpxdpusSvx
        InpnkCzDoj7y4L313+xAksxyXPNf07LyXDFu1pwbOFk3hH8KGoBN4CGjQ64oEtacK7QiNDkP44Xra
        0u00sCkFDpt4TnXELOY+ha0DdW/grqlLA7KJKMUWIglq0xhv8vcyBKl5kc1yIzyr92O3+IAT2OOQX
        2wjn11/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002Aa-Nz; Tue, 18 Aug 2020 11:27:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA95E30769C;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 721CA200D4C3E; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.460474861@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the performance sensitive users of
smp_call_single_function_async() over to the new
irq_work_queue_remote_static().

The new API is marginally less crap but taking these users away allows
fixing up smp_call_single_function_async() without risk of performance
regressions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 block/blk-mq.c            |    8 ++++----
 include/linux/blkdev.h    |    4 ++--
 include/linux/netdevice.h |    3 ++-
 kernel/sched/core.c       |   16 ++++++++--------
 kernel/sched/fair.c       |    6 +++---
 kernel/sched/sched.h      |    4 ++--
 net/core/dev.c            |   15 ++++++++++-----
 7 files changed, 31 insertions(+), 25 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -622,9 +622,9 @@ static int blk_softirq_cpu_dead(unsigned
 }
 
 
-static void __blk_mq_complete_request_remote(void *data)
+static void __blk_mq_complete_request_remote(struct irq_work *work)
 {
-	struct request *rq = data;
+	struct request *rq = container_of(work, struct request, work);
 
 	/*
 	 * For most of single queue controllers, there is only one irq vector
@@ -671,8 +671,8 @@ bool blk_mq_complete_request_remote(stru
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		rq->work = IRQ_WORK_INIT_HARD(__blk_mq_complete_request_remote);
+		irq_work_queue_remote_static(rq->mq_ctx->cpu, &rq->work);
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -19,7 +19,7 @@
 #include <linux/stringify.h>
 #include <linux/gfp.h>
 #include <linux/bsg.h>
-#include <linux/smp.h>
+#include <linux/irq_work.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
@@ -234,7 +234,7 @@ struct request {
 	unsigned long deadline;
 
 	union {
-		struct __call_single_data csd;
+		struct irq_work work;
 		u64 fifo_time;
 	};
 
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/atomic.h>
 #include <linux/prefetch.h>
+#include <linux/irq_work.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
 
@@ -3144,7 +3145,7 @@ struct softnet_data {
 	unsigned int		input_queue_head ____cacheline_aligned_in_smp;
 
 	/* Elements below can be accessed between CPUs for RPS/RFS */
-	call_single_data_t	csd ____cacheline_aligned_in_smp;
+	struct irq_work		work ____cacheline_aligned_in_smp;
 	struct softnet_data	*rps_ipi_next;
 	unsigned int		cpu;
 	unsigned int		input_queue_tail;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -361,9 +361,9 @@ static void __hrtick_restart(struct rq *
 /*
  * called from hardirq (IPI) context
  */
-static void __hrtick_start(void *arg)
+static void __hrtick_start(struct irq_work *work)
 {
-	struct rq *rq = arg;
+	struct rq *rq = container_of(work, struct rq, hrtick_work);
 	struct rq_flags rf;
 
 	rq_lock(rq, &rf);
@@ -394,7 +394,7 @@ void hrtick_start(struct rq *rq, u64 del
 	if (rq == this_rq())
 		__hrtick_restart(rq);
 	else
-		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
+		irq_work_queue_remote_static(cpu_of(rq), &rq->hrtick_work);
 }
 
 #else
@@ -419,7 +419,7 @@ void hrtick_start(struct rq *rq, u64 del
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
+	rq->hrtick_work = IRQ_WORK_INIT_HARD(__hrtick_start);
 #endif
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
@@ -729,14 +729,14 @@ void wake_up_nohz_cpu(int cpu)
 		wake_up_idle_cpu(cpu);
 }
 
-static void nohz_csd_func(void *info)
+static void nohz_work_func(struct irq_work *work)
 {
-	struct rq *rq = info;
+	struct rq *rq = container_of(work, struct rq, nohz_work);
 	int cpu = cpu_of(rq);
 	unsigned int flags;
 
 	/*
-	 * Release the rq::nohz_csd.
+	 * Release rq::nohz_work.
 	 */
 	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
@@ -7181,7 +7181,7 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
-		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
+		rq->nohz_work = IRQ_WORK_INIT_HARD(nohz_work_func);
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10058,8 +10058,8 @@ static void kick_ilb(unsigned int flags)
 		return;
 
 	/*
-	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
-	 * the first flag owns it; cleared by nohz_csd_func().
+	 * Access to rq::nohz_work is serialized by NOHZ_KICK_MASK; he who sets
+	 * the first flag owns it; cleared by nohz_work_func().
 	 */
 	flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
 	if (flags & NOHZ_KICK_MASK)
@@ -10070,7 +10070,7 @@ static void kick_ilb(unsigned int flags)
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
+	irq_work_queue_remote_static(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_work);
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -910,7 +910,7 @@ struct rq {
 #ifdef CONFIG_SMP
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
-	call_single_data_t	nohz_csd;
+	struct irq_work		nohz_work;
 #endif /* CONFIG_SMP */
 	unsigned int		nohz_tick_stopped;
 	atomic_t		nohz_flags;
@@ -1021,7 +1021,7 @@ struct rq {
 
 #ifdef CONFIG_SCHED_HRTICK
 #ifdef CONFIG_SMP
-	call_single_data_t	hrtick_csd;
+	struct irq_work		hrtick_work;
 #endif
 	struct hrtimer		hrtick_timer;
 #endif
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4443,9 +4443,9 @@ EXPORT_SYMBOL(rps_may_expire_flow);
 #endif /* CONFIG_RFS_ACCEL */
 
 /* Called from hardirq (IPI) context */
-static void rps_trigger_softirq(void *data)
+static void rps_trigger_softirq(struct irq_work *work)
 {
-	struct softnet_data *sd = data;
+	struct softnet_data *sd = container_of(work, struct softnet_data, work);
 
 	____napi_schedule(sd, &sd->backlog);
 	sd->received_rps++;
@@ -6182,8 +6182,13 @@ static void net_rps_send_ipi(struct soft
 	while (remsd) {
 		struct softnet_data *next = remsd->rps_ipi_next;
 
-		if (cpu_online(remsd->cpu))
-			smp_call_function_single_async(remsd->cpu, &remsd->csd);
+		if (cpu_online(remsd->cpu)) {
+			/*
+			 * XXX can there be two CPUs calling into the same remsd?
+			 * XXX serialized by NAPI_STATE_SCHED ??
+			 */
+			irq_work_queue_remote_static(remsd->cpu, &remsd->work);
+		}
 		remsd = next;
 	}
 #endif
@@ -10965,7 +10970,7 @@ static int __init net_dev_init(void)
 		INIT_LIST_HEAD(&sd->poll_list);
 		sd->output_queue_tailp = &sd->output_queue;
 #ifdef CONFIG_RPS
-		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
+		init_irq_work(&sd->work, rps_trigger_softirq);
 		sd->cpu = i;
 #endif
 


