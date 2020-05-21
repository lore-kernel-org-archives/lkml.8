Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DF520671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0RXKPPF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgEULAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:00:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgEULAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZmUG7dBgwdfcd4tZquEzQk9e0BjnN8HVH0P/AP0xAQ=; b=0RXKPPF/qH45a9Uvz0d9Q0bWKZ
        0WAtXxt0m6432jYuZzuOwbeqGBH64mVBlpJFaCu0G0uFDelyIMjRL9RFXmEA7+GnBfUT/RRDarl3v
        YYh3Fd5GXjj/yvu/a6FSnpiqX0z35LmskqH9KArF+CnRtfhcfteIqBpwAL/Ly992IflTg4gC6pQcW
        dAYLa/EiLlPpqqgX+Hue6ulRPO+e0XYPG5Jl2JT4u1G8PFS3keKvJvhDGlxHNfXOv8kP4FDnuzw60
        v/K6OZKOtWrizC1RNu3IoeBvYNMoDyfUj5IW1oyzUeNqmMsbVA9MFZKN3JbScS/WTNhaDpSIwcnk4
        ZgK8AveA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbiw8-0002or-Ld; Thu, 21 May 2020 11:00:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74EAC3011C6;
        Thu, 21 May 2020 13:00:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59E96212820EE; Thu, 21 May 2020 13:00:27 +0200 (CEST)
Date:   Thu, 21 May 2020 13:00:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200521110027.GC325303@hirez.programming.kicks-ass.net>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
 <20200521093938.GG325280@hirez.programming.kicks-ass.net>
 <20200521104937.GB325303@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521104937.GB325303@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:49:37PM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 11:39:39AM +0200, Peter Zijlstra wrote:
> > On Thu, May 21, 2020 at 02:40:36AM +0200, Frederic Weisbecker wrote:
> 
> > This:
> > 
> > >         smp_call_function_single_async() {             smp_call_function_single_async() {
> > >             // verified csd->flags != CSD_LOCK             // verified csd->flags != CSD_LOCK
> > >             csd->flags = CSD_LOCK                          csd->flags = CSD_LOCK
> > 
> > concurrent smp_call_function_single_async() using the same csd is what
> > I'm looking at as well.
> 
> So something like this ought to cure the fundamental problem and make
> smp_call_function_single_async() more user friendly, but also more
> expensive.
> 
> The problem is that while the ILB case is easy to fix, I can't seem to
> find an equally nice solution for the ttwu_remote_queue() case; that
> would basically require sticking the wake_csd in task_struct, I'll also
> post that.
> 
> So it's either this:

Or this:

---
 include/linux/sched.h | 4 ++++
 kernel/sched/core.c   | 7 ++++---
 kernel/sched/fair.c   | 2 +-
 kernel/sched/sched.h  | 1 -
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f38d62c4632c..136ee400b568 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -696,6 +696,10 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+#ifdef CONFIG_SMP
+	call_single_data_t		wake_csd;
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b286469e26e..a7129652e89b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2320,7 +2320,7 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 
 	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
-			smp_call_function_single_async(cpu, &rq->wake_csd);
+			smp_call_function_single_async(cpu, &p->wake_csd);
 		else
 			trace_sched_wake_idle_without_ipi(cpu);
 	}
@@ -2921,6 +2921,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 #if defined(CONFIG_SMP)
 	p->on_cpu = 0;
+	p->wake_csd = (struct __call_single_data) {
+		.func = wake_csd_func,
+	};
 #endif
 	init_task_preempt_count(p);
 #ifdef CONFIG_SMP
@@ -6723,8 +6726,6 @@ void __init sched_init(void)
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
-		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
-
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 01f94cf52783..b6d8a7b991f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10033,7 +10033,7 @@ static void kick_ilb(unsigned int flags)
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
+	smp_call_function_single_async(ilb_cpu, &this_rq()->nohz_csd);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f7ab6334e992..c35f0ef43ab0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1021,7 +1021,6 @@ struct rq {
 #endif
 
 #ifdef CONFIG_SMP
-	call_single_data_t	wake_csd;
 	struct llist_head	wake_list;
 #endif
 
