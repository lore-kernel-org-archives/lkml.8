Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C612BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D196204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r8XOY0Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgEOLSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:18:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD178C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GIdcvyq2kE8gcpK88REzvVaaDlKMW6+iuNTGRrLXlfM=; b=r8XOY0TrePE63Xd3nIt4PCULew
        TiMaMn+aZbqFsyUdhkgXv5WocqqUPzTm0jc4puEHqt1cT+SXpAtURJZOID/e1UZeqgEdM0LeH6HnD
        4L7HpYpygIJQgySonfLMjOwUyqlIXJ9SYM2I4FuCNrag8ywztNJf+RarXO0X4tOp4D8Jm0d/K4ezC
        tz/wPAb9kuiKmh2Gi98yT70fgAksoXvRGwz+ZhvxrLA88ZvN9mHDMpI30ygbBthOONcpNFnt0FV7T
        xpRx5QXeG5X0bfy+VrRX8ba1SFez2QRy8N7Nrs9BdRndM9f/Yb839yrdU/KuFO8mTkk9lyMThp8Ht
        4hA4XSMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZYLQ-0006J2-15; Fri, 15 May 2020 11:17:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5F9A3011F0;
        Fri, 15 May 2020 13:17:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C582620267E65; Fri, 15 May 2020 13:17:32 +0200 (CEST)
Date:   Fri, 15 May 2020 13:17:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200515111732.GS2957@hirez.programming.kicks-ass.net>
References: <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515084740.GJ3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:

> However, the wakeups are so rapid that the wakeup
> happens while the server is descheduling. That forces the waker to spin
> on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> add the task to the rq->wake_list even if that potentially requires an IPI.

Right, I think Rik ran into that as well at some point. He wanted to
make ->on_cpu do a hand-off, but simply queueing the wakeup on the prev
cpu (which is currently in the middle of schedule()) should be an easier
proposition.

Maybe something like this untested thing... could explode most mighty,
didn't thing too hard.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa6c19d38e82..c07b92a0ee5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,7 +2312,7 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
-static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -2354,6 +2354,17 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
+
+static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+{
+	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
+		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
+		__ttwu_queue_remote(p, cpu, wake_flags);
+		return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_SMP */
 
 static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
@@ -2362,11 +2373,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
-		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
-		ttwu_queue_remote(p, cpu, wake_flags);
+	if (ttwu_queue_remote(p, cpu, wake_flags))
 		return;
-	}
 #endif
 
 	rq_lock(rq, &rf);
@@ -2550,7 +2558,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (p->on_rq && ttwu_remote(p, wake_flags))
 		goto unlock;
 
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
+
 #ifdef CONFIG_SMP
+	p->sched_contributes_to_load = !!task_contributes_to_load(p);
+	p->state = TASK_WAKING;
+
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 	 * possible to, falsely, observe p->on_cpu == 0.
@@ -2581,15 +2597,10 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * This ensures that tasks getting woken will be fully ordered against
 	 * their previous state and preserve Program Order.
 	 */
-	smp_cond_load_acquire(&p->on_cpu, !VAL);
-
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
+	if (READ_ONCE(p->on_cpu) && __ttwu_queue_remote(p, cpu, wake_flags))
+		goto unlock;
 
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
+	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
@@ -2597,14 +2608,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
-
-#else /* CONFIG_SMP */
-
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
