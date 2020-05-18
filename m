Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC0DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C2720756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589808314;
	bh=LUiGLJFtm9eoZ+pZaHm/Fmfo9ae62W+XvOQCZJC6g+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KHBtcreDlvpW2UIbH1VSK0DWc3qLojpXPOdH4jloPT8jeMpOo10yb5ZhqK021KYoL
	 u4nuOHqF0qVdc/QSsIOGc/05FT3ZX6pJm1iQy7ghopdA7B4jbqBQdN4jGgwIAz2VnU
	 w+c7rVqe5sooHWQABz9ixdvYx1wpn7NwZecHNTWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgERNZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:25:12 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3411620709;
        Mon, 18 May 2020 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589808311;
        bh=LUiGLJFtm9eoZ+pZaHm/Fmfo9ae62W+XvOQCZJC6g+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQwCPtJf0yA++YRbg9Kzoyhy/MUwgnB/BBJSOipLZhaMpUBuYWE8bVLHftNhTX+6U
         peufVqbqF2frSo2064XbfCoCQ1hL8oOzS7f7tl8ye5qiixE0pDGwYDnF5/7X7pIURQ
         0fT8T09KV8gtlTWj2drIGbgtgKuKC5ZhrDi61Tig=
Date:   Mon, 18 May 2020 15:25:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@kernel.org
Subject: Re: [PATCH] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Message-ID: <20200518132506.GB30646@lenoir>
References: <20200515003429.4317-1-frederic@kernel.org>
 <20200518085758.GK2940@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518085758.GK2940@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:57:58AM +0200, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 02:34:29AM +0200, Frederic Weisbecker wrote:
> > So far setting a tick dependency on any task, including current, used to
> > trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
> > an issue as long as it was only used by posix-cpu-timers on nohz_full,
> > a combo that nobody seemed to use in real life.
> > 
> > But RCU started to use task tick dependency on current task to fix
> > stall issues on callbacks processing. These trigger regular and
> > undesired system wide IPIs on nohz_full.
> > 
> > The fix is very easy while setting a tick dependency on the current
> > task, only its CPU needs an IPI.
> > 
> > Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
> > Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: stable@kernel.org
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/time/tick-sched.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 3e2dc9b8858c..f0199a4ba1ad 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
> >  EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
> >  
> >  /*
> > - * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
> > - * per task timers.
> > + * Set a per-task tick dependency. RCU need this. Also posix CPU timers
> > + * in order to elapse per task timers.
> >   */
> >  void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
> >  {
> > -	/*
> > -	 * We could optimize this with just kicking the target running the task
> > -	 * if that noise matters for nohz full users.
> > -	 */
> > -	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
> > +	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
> 
> So why not simply:
> 
> 		tick_nohz_full_kick_cpu(task_cpu(tsk)); ?
> 
> If it got preempted, the scheduling involved would already have observed
> the bit we just set and kept the tick on anyway, same for migration.
> 
> Or am I missing something?

Hmm, I guess we would then need some sort of ordering like
this:

         CPU 0                            CPU 1
         -----                            -----
         p->cpu = smp_processor_id()      atomic_fetch_or(bit, p->tick_dep_mask)
         smp_mb();                        smp_mb(); //actually implied by atomic_fetch_or()
         READ p->tick_dep_mask            irq_work_on(...., p->cpu)

And since p->cpu is already set and visible on context switch, it should work
indeed. Now in the case CPU 1 reads a stale task_cpu(), that's fine as CPU 0 sees
the new tick_dep_mask, but CPU 1 might be dealing with an offlined CPU, right?

So I guess I should still protect against hotplug with cpus_read_lock() but
tick_nohz_dep_set_task() isn't supposed to sleep...

Or preempt_disable() could help us with that somehow? I'm always confused with
the guarantees that disabled preemption can offer toward hotplug.


> 
> > +		if (tsk == current) {
> > +			preempt_disable();
> > +			tick_nohz_full_kick();
> > +			preempt_enable();
> > +		} else {
> > +			/*
> > +			 * Some future tick_nohz_full_kick_task()
> > +			 * should optimize this.
> > +			 */
> > +			tick_nohz_full_kick_all();
> > +		}
> > +	}
> 
