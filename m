Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7182208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ay5WOZ1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgFSNox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732706AbgFSNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:44:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D145C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=meqaf6iQuBRGgUfgP5F6yID4Z/FiQ0y148Kp4+ucoTk=; b=ay5WOZ1SDtbdh3nUziOTxM4kee
        w+MuMIDRukKGS6ZYu2b/RKCWuBF7vrraUkXGqVOsn2lP+KAz3sTV3RDGz2GFctClxMIfP0Dmlvuso
        yUM7NKFsXCKSOiwWmn7ExBWX2gawCppGxUnbaOIFZAOVL525TZdTix8fgDURzp09ZGufMMJ1G6Gdm
        017J7F5WawRkPGtjy4R3kEAAeGMV1o6m7JZoSOEkuVUJX5kduiS2thxmnRVercSLp9DvVFd8/KABS
        OyMdByRok0sUW9i5rPF71krrWk4Lt4qt8BC2AsN0bNPIBUf6RkIVLmtSYGtJf2cKTaXXGK338G7Hx
        WjFVGv9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmHJj-0008UE-4u; Fri, 19 Jun 2020 13:44:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 122BE3003E5;
        Fri, 19 Jun 2020 15:44:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 033102BA40ACD; Fri, 19 Jun 2020 15:44:23 +0200 (CEST)
Date:   Fri, 19 Jun 2020 15:44:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200619134423.GB577403@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200616170410.GL2554@hirez.programming.kicks-ass.net>
 <20200616171721.GM2554@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616171721.GM2554@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:17:21PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 07:04:10PM +0200, Peter Zijlstra wrote:
> > [19324.795303] ------------[ cut here ]------------
> > [19324.795304] WARNING: CPU: 10 PID: 76 at kernel/smp.c:138 __smp_call_single_queue+0x40/0x50
> > [19324.795305] Modules linked in:
> > [19324.795306] CPU: 10 PID: 76 Comm: ksoftirqd/10 Not tainted 5.8.0-rc1+ #8
> > [19324.795307] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> > [19324.795307] RIP: 0010:__smp_call_single_queue+0x40/0x50
> > [19324.795308] Code: c2 40 91 02 00 4c 89 e6 4c 89 e7 48 03 14 c5 e0 56 2d b4 e8 b2 3a 2f 00 84 c0 75 04 5d 41 5c c3 89 ef 5d 41 5c e9 40 af f9 ff <0f> 0b eb cd 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 49 89 f4 55
> > [19324.795309] RSP: 0000:ffffb3cb4030bd18 EFLAGS: 00010046
> > [19324.795310] RAX: 000000000000000a RBX: 0000000000000000 RCX: 00000000ffffffff
> > [19324.795310] RDX: 00000000000090aa RSI: ffffffffb420bc3f RDI: ffffffffb4232e3e
> > [19324.795311] RBP: 000000000000000a R08: 00001193646cd91c R09: ffff93c1df49c008
> > [19324.795312] R10: ffffb3cb4030bdf8 R11: 000000000000032e R12: ffff93c1dbed5b30
> > [19324.795312] R13: ffff93c1df4a8340 R14: 000000000000000a R15: ffff93c1df2e8340
> > [19324.795313] FS:  0000000000000000(0000) GS:ffff93c1df480000(0000) knlGS:0000000000000000
> > [19324.795313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [19324.795314] CR2: 00000000ffffffff CR3: 000000001e40a000 CR4: 00000000000006e0
> > [19324.795315] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [19324.795315] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [19324.795316] Call Trace:
> > [19324.795316]  ttwu_queue_wakelist+0xa4/0xc0
> > [19324.795316]  try_to_wake_up+0x432/0x530
> 
> This is indeed WF_ON_CPU... it had to be, but how ?!

So my latest theory is that we have a memory ordering problem. It would
fully explain the thing, but it would also render my patch #1
insufficient.

If we suppose the: task_cpu(p) load at the beginning of try_to_wake_up()
returns an old value, and this old value happens to be this_cpu. Further
assume that the p->on_cpu load accurately returns 1, it really is still
running, just not here.

Then, when we issue a local wakeup, we can crash in exactly the observed
manner because p->se.cfs_rq != rq->cfs_rq, because p's cfs_rq is from
the wrong CPU, therefore we'll iterate into the non-existant parents and
NULL deref.

The scenario is somewhat elaborate:


					X->cpu = 1
					rq(1)->curr = X


	CPU0				CPU1				CPU2

					// switch away from X
					LOCK rq(1)->lock
					smp_mb__after_spinlock
					dequeue_task(X)
					  X->on_rq = 9
					switch_to(Z)
					  X->on_cpu = 0
					UNLOCK rq(1)->lock


									// migrate X to cpu 0
									LOCK rq(1)->lock
									dequeue_task(X)
									set_task_cpu(X, 0)
									  X->cpu = 0
									UNLOCK rq(1)->lock

									LOCK rq(0)->lock
									enqueue_task(X)
									  X->on_rq = 1
									UNLOCK rq(0)->lock

	// switch to X
	LOCK rq(0)->lock
	smp_mb__after_spinlock
	switch_to(X)
	  X->on_cpu = 1
	UNLOCK rq(0)->lock

	// X goes sleep
	X->state = TASK_UNINTERRUPTIBLE
	smp_mb();			// wake X
					ttwu()
					  LOCK X->pi_lock
					  smp_mb__after_spinlock

					  if (p->state)

					  cpu = X->cpu; // =? 1

					  smp_rmb()

	// X calls schedule()
	LOCK rq(0)->lock
	smp_mb__after_spinlock
	dequeue_task(X)
	  X->on_rq = 0

					  if (p->on_rq)

					  smp_rmb();

					  if (p->on_cpu && ttwu_queue_wakelist(..)) [*]

					  smp_cond_load_acquire(&p->on_cpu, !VAL)

					  cpu = select_task_rq(X, X->wake_cpu, ...)
					  if (X->cpu != cpu)
	switch_to(Y)
	  X->on_cpu = 0
	UNLOCK rq(0)->lock


Furthermore, without the fancy new path [*] we would have hit
smp_cond_load_acquire(), and if we _really_ would have had ->on_cpu==1
and cpu==this_cpu there, that'd have been a deadlock, but no such
deadlocks have ever been observed.

Also, note how the rest of the code never actually uses the @cpu value
loaded earlier, all that is re-loaded after the load_aquire of
X->on_cpu.

I'm having trouble convincing myself that's actually possible on
x86_64 -- after all, every LOCK implies an smp_mb there, so if ttwu
observes ->state != RUNNING, it must also observe ->cpu != 1.

Most of the previous ttwu() races were found on very large PowerPC
machines which are far more 'interesting'. I suppose I should go write
me litmus tests...

Anyway, IFF any of this holds true; then I suppose a patch like the below
ought to cure things.

If not, I'm, once again, defeated by this...

---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8298b2c240ce..5534eb1ab79a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2378,6 +2378,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+		if (WARN_ON(cpu == smp_processor_id()))
+			return false;
+
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
@@ -2550,7 +2553,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/* We're going to change ->state: */
 	success = 1;
-	cpu = task_cpu(p);
 
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
@@ -2615,7 +2617,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
+	if (smp_load_acquire(&p->on_cpu) &&
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_RQ))
 		goto unlock;
 
 	/*
@@ -2635,6 +2638,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
 	}
+#else
+	cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);

