Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAAE2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FJGEwQA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgEULmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEULmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D4C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cm5rOd27FgXfN7VmtOGwF1egJaEfLVL7cmoGCUCmRe4=; b=FJGEwQA7azNd5f/JZMdxS0OsvB
        jR6fZHV2pN8f37GH2bLV1HvMDFGHhtEFaLudZBkLO3WdWpL5aWzgHUWx0HGVtZsC98zP/Erf8BpNE
        MmAsbmsF9NBUYoQqcTcXhG+YlTx9D6BdkyMf1zfiUuwRdVz7FB94DGnyD/S6o4DurPxC7/jw13DOG
        DPjNteJf8a5ItKoitcci2/QLf7XnFIrXKRlINl3L2RFNbpxag9A47dceNOhsRw41OnjeaApYYg/uB
        0aGiXby4fBk99O0gbM6/PZna3v/rpLcbi0Vt/8AGUY38iBpmbZXC1pDsCbH1PcuygGCn8FDou9Olc
        4v3fSDxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbjZv-00083U-1w; Thu, 21 May 2020 11:41:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72A71305EEE;
        Thu, 21 May 2020 13:41:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5088C20BE0DF7; Thu, 21 May 2020 13:41:32 +0200 (CEST)
Date:   Thu, 21 May 2020 13:41:32 +0200
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
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        riel@surriel.com
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200521114132.GI325280@hirez.programming.kicks-ass.net>
References: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
 <20200515142444.GK3001@hirez.programming.kicks-ass.net>
 <20200521103816.GA7167@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521103816.GA7167@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:38:16AM +0100, Mel Gorman wrote:
> IIUC, this patch front-loads as much work as possible before checking if
> the task is on_rq and then the waker/wakee shares a cache, queue task on
> the wake_list and otherwise do a direct wakeup.
> 
> The advantage is that spinning is avoided on p->on_rq when p does not
> share a cache. The disadvantage is that it may result in tasks being
> stacked but this should only happen when the domain is overloaded and
> select_task_eq() is unlikely to find an idle CPU. The load balancer would
> soon correct the situation anyway.
> 
> In terms of netperf for my testing, the benefit is marginal because the
> wakeups are primarily between tasks that share cache. It does trigger as
> perf indicates that some time is spent in ttwu_queue_remote with this
> patch, it's just that the overall time spent spinning on p->on_rq is
> very similar. I'm still waiting on other workloads to complete to see
> what the impact is.

So it might make sense to play with the exact conditions under which
we'll attempt this remote queue, if we see a large 'local' p->on_cpu
spin time, it might make sense to attempt the queue even in this case.

We could for example change it to:

	if (REAC_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags | WF_ON_CPU))
		goto unlock;

and then use that in ttwu_queue_remote() to differentiate between these
two cases.

Anyway, if it's a wash (atomic op vs spinning) then it's probably not
worth it.

Another optimization might be to forgo the IPI entirely in this case and
instead stick a sched_ttwu_pending() at the end of __schedule() or
something like that.

> However, intuitively at least, it makes sense to avoid spinning on p->on_rq
> when it's unnecessary and the other changes appear to be safe.  Even if
> wake_list should be used in some cases for local wakeups, it would make
> sense to put that on top of this patch. Do you want to slap a changelog
> around this and update the comments or do you want me to do it? I should
> have more results in a few hours even if they are limited to one machine
> but ideally Rik would test his workload too.

I've written you a Changelog, but please carry it in your set to
evaluate if it's actually worth it.

---
Subject: sched: Optimize ttwu() spinning on p->on_cpu
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 15 May 2020 16:24:44 +0200

Both Rik and Mel reported seeing ttwu() spend significant time on:

  smp_cond_load_acquire(&p->on_cpu, !VAL);

Attempt to avoid this by queueing the wakeup on the CPU that own's the
p->on_cpu value. This will then allow the ttwu() to complete without
further waiting.

Since we run schedule() with interrupts disabled, the IPI is
guaranteed to happen after p->on_cpu is cleared, this is what makes it
safe to queue early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,7 +2312,7 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
-static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -2354,6 +2354,17 @@ bool cpus_share_cache(int this_cpu, int
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
@@ -2362,11 +2373,8 @@ static void ttwu_queue(struct task_struc
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
@@ -2550,7 +2558,15 @@ try_to_wake_up(struct task_struct *p, un
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
@@ -2581,15 +2597,10 @@ try_to_wake_up(struct task_struct *p, un
 	 * This ensures that tasks getting woken will be fully ordered against
 	 * their previous state and preserve Program Order.
 	 */
-	smp_cond_load_acquire(&p->on_cpu, !VAL);
-
-	p->sched_contributes_to_load = !!task_contributes_to_load(p);
-	p->state = TASK_WAKING;
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags))
+		goto unlock;
 
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
+	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
@@ -2597,14 +2608,6 @@ try_to_wake_up(struct task_struct *p, un
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
