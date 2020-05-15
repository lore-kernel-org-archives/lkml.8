Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E24C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFF12076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="clTDFWVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEOOZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:25:43 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60802C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JIwsSKtv1G3aNDSr5Iw448MyeXECjAhn02FyF9i0T0Y=; b=clTDFWVGK7DKEdfowlRkhDjqrs
        HuiT7MmYXAgF/C/Q56VvfaqtJQWgLA8rKo9f+yzOWAnASDUTEBHLTiIyQ1ZPCKhy4WJxgnNBVbOlg
        fclDFnk3YrP41N3YNfF7hY6EYuq0xSOVtBT4Iwcr1y6ovEp41S0Po0Lv+8zBIMquOFtY4XoYS413z
        v7BrHD1uhDkI7LY0h8LiaQB7/1UMCCtfkSHMMZtcnypM/lgqitKvWHrJ7IMInR1Mjd5B7ZK7hTJ0A
        VzLIb+/YBBWD1q4f/lDLSaE8VB+dAyj1rGi7hbD+iMtPfVDbL66qLK3I+cMnmID9S9jqBWvjllQ5P
        vWMCEiKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbGa-0002XF-A5; Fri, 15 May 2020 14:24:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFA52300455;
        Fri, 15 May 2020 16:24:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 748E220249972; Fri, 15 May 2020 16:24:44 +0200 (CEST)
Date:   Fri, 15 May 2020 16:24:44 +0200
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
Message-ID: <20200515142444.GK3001@hirez.programming.kicks-ass.net>
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515111732.GS2957@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:17:32PM +0200, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> 
> > However, the wakeups are so rapid that the wakeup
> > happens while the server is descheduling. That forces the waker to spin
> > on smp_cond_load_acquire for longer. In this case, it can be cheaper to
> > add the task to the rq->wake_list even if that potentially requires an IPI.
> 
> Right, I think Rik ran into that as well at some point. He wanted to
> make ->on_cpu do a hand-off, but simply queueing the wakeup on the prev
> cpu (which is currently in the middle of schedule()) should be an easier
> proposition.
> 
> Maybe something like this untested thing... could explode most mighty,
> didn't thing too hard.
> 

Mel pointed out that that patch got mutilated somewhere (my own .Sent
copy was fine), let me try again.


---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b64ffd6c728..df588ac75bf0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2330,7 +2330,7 @@ void scheduler_ipi(void)
 	irq_exit();
 }
 
-static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
@@ -2372,6 +2372,17 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
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
@@ -2380,11 +2391,8 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -2568,7 +2576,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
@@ -2599,15 +2615,10 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
@@ -2615,14 +2626,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
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
