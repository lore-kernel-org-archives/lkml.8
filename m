Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C4AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241E9207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589996289;
	bh=6jp24/mpfyiKgQ3k/6Hr8SbZZRvP41WNJB65vofbraY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Sn6RZoTgBqF1P+huUgHL3HCb+i3c6VzY+vw6U9fNnFvGy+1vh6sfXa3JkugIO/eR7
	 BWv/yPJFJAWjpIY2iWhFwID7Q4vOY8j+ynUUmAO/JaYE/IG5TjXHUDDxr/k51KHJGJ
	 Aucj7m3helWOTiNL9edrmKo2/HQuBvhYAN/Sf/tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETRiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgETRiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:38:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CF720709;
        Wed, 20 May 2020 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589996286;
        bh=6jp24/mpfyiKgQ3k/6Hr8SbZZRvP41WNJB65vofbraY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lidtU/gxkJYxq2/3uqlQoAtwb/KSDmZR/5LxuXmXSDnzACeGZ+fW7WJVham5JOXhj
         9lwF0IAMXRtRUwEokpgWa0AQO8bYfS8XsZI7JVDWEXXxQ8LSX4tLOp/l7oA5YXfB0X
         D/xkAKpplzWT3b4wdvQ6ZkpMBAysJBoKLKYIFHJM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C0A083522A2B; Wed, 20 May 2020 10:38:06 -0700 (PDT)
Date:   Wed, 20 May 2020 10:38:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200520173806.GP2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200515234547.710474468@linutronix.de>
 <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
 <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de>
 <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:36:06AM -0700, Andy Lutomirski wrote:
> On Tue, May 19, 2020 at 7:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, May 19, 2020 at 05:26:58PM -0700, Andy Lutomirski wrote:
> > > On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > Andy Lutomirski <luto@kernel.org> writes:
> > > > > On Tue, May 19, 2020 at 1:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >> Thomas Gleixner <tglx@linutronix.de> writes:
> > > > >> It's about this:
> > > > >>
> > > > >> rcu_nmi_enter()
> > > > >> {
> > > > >>         if (!rcu_is_watching()) {
> > > > >>             make it watch;
> > > > >>         } else if (!in_nmi()) {
> > > > >>             do_magic_nohz_dyntick_muck();
> > > > >>         }
> > > > >>
> > > > >> So if we do all irq/system vector entries conditional then the
> > > > >> do_magic() gets never executed. After that I got lost...
> > > > >
> > > > > I'm also baffled by that magic, but I'm also not suggesting doing this
> > > > > to *all* entries -- just the not-super-magic ones that use
> > > > > idtentry_enter().
> > > > >
> > > > > Paul, what is this code actually trying to do?
> > > >
> > > > Citing Paul from IRC:
> > > >
> > > >   "The way things are right now, you can leave out the rcu_irq_enter()
> > > >    if this is not a nohz_full CPU.
> > > >
> > > >    Or if this is a nohz_full CPU, and the tick is already
> > > >    enabled, in that case you could also leave out the rcu_irq_enter().
> > > >
> > > >    Or even if this is a nohz_full CPU and it does not have the tick
> > > >    enabled, if it has been in the kernel less than a few tens of
> > > >    milliseconds, still OK to avoid invoking rcu_irq_enter()
> > > >
> > > >    But my guess is that it would be a lot simpler to just always call
> > > >    it.
> > > >
> > > > Hope that helps.
> > >
> > > Maybe?
> > >
> > > Unless I've missed something, the effect here is that #PF hitting in
> > > an RCU-watching context will skip rcu_irq_enter(), whereas all IRQs
> > > (because you converted them) as well as other faults and traps will
> > > call rcu_irq_enter().
> > >
> > > Once upon a time, we did this horrible thing where, on entry from user
> > > mode, we would turn on interrupts while still in CONTEXT_USER, which
> > > means we could get an IRQ in an extended quiescent state.  This means
> > > that the IRQ code had to end the EQS so that IRQ handlers could use
> > > RCU.  But I killed this a few years ago -- x86 Linux now has a rule
> > > that, if IF=1, we are *not* in an EQS with the sole exception of the
> > > idle code.
> > >
> > > In my dream world, we would never ever get IRQs while in an EQS -- we
> > > would do MWAIT with IF=0 and we would exit the EQS before taking the
> > > interrupt.  But I guess we still need to support HLT, which means we
> > > have this mess.
> > >
> > > But I still think we can plausibly get rid of the conditional.
> >
> > You mean the conditional in rcu_nmi_enter()?  In a NO_HZ_FULL=n system,
> > this becomes:
> 
> So, I meant the conditional in tglx's patch that makes page faults special.

OK.

> > >                                                                 If we
> > > get an IRQ or (egads!) a fault in idle context, we'll have
> > > !__rcu_is_watching(), but, AFAICT, we also have preemption off.
> >
> > Or we could be early in the kernel-entry code or late in the kernel-exit
> > code, but as far as I know, preemption is disabled on those code paths.
> > As are interrupts, right?  And interrupts are disabled on the portions
> > of the CPU-hotplug code where RCU is not watching, if I recall correctly.
> 
> Interrupts are off in the parts of the entry/exit that RCU considers
> to be user mode.  We can get various faults, although these should be
> either NMI-like or events that genuinely or effectively happened in
> user mode.

Fair enough!

> > A nohz_full CPU does not enable the scheduling-clock interrupt upon
> > entry to the kernel.  Normally, this is fine because that CPU will very
> > quickly exit back to nohz_full userspace execution, so that RCU will
> > see the quiescent state, either by sampling it directly or by deducing
> > the CPU's passage through that quiescent state by comparing with state
> > that was captured earlier.  The grace-period kthread notices the lack
> > of a quiescent state and will eventually set ->rcu_urgent_qs to
> > trigger this code.
> >
> > But if the nohz_full CPU stays in the kernel for an extended time,
> > perhaps due to OOM handling or due to processing of some huge I/O that
> > hits in-memory buffers/cache, then RCU needs some way of detecting
> > quiescent states on that CPU.  This requires the scheduling-clock
> > interrupt to be alive and well.
> >
> > Are there other ways to get this done?  But of course!  RCU could
> > for example use smp_call_function_single() or use workqueues to force
> > execution onto that CPU and enable the tick that way.  This gets a
> > little involved in order to avoid deadlock, but if the added check
> > in rcu_nmi_enter() is causing trouble, something can be arranged.
> > Though that something would cause more latency excursions than
> > does the current code.
> >
> > Or did you have something else in mind?
> 
> I'm trying to understand when we actually need to call the function.
> Is it just the scheduling interrupt that's supposed to call
> rcu_irq_enter()?  But the scheduling interrupt is off, so I'm
> confused.

The scheduling-clock interrupt is indeed off, but if execution remains
in the kernel for an extended time period, this becomes a problem.
RCU quiescent states don't happen, or if they do, they are not reported
to RCU.  Grace periods never end, and the system eventually OOMs.

And it is not all that hard to make a CPU stay in the kernel for minutes
at a time on a large system.

So what happens is that if RCU notices that a given CPU has not responded
in a reasonable time period, it sets that CPU's ->rcu_urgent_qs.  This
flag plays various roles in various configurations, but on nohz_full CPUs
it causes that CPU's next rcu_nmi_enter() invocation to turn that CPU's
tick on.  It also sets that CPU's ->rcu_forced_tick flag, which prevents
redundant turning on of the tick and also causes the quiescent-state
detection code to turn off the tick for this CPU.

As you say, the scheduling-clock tick cannot turn itself on, but
there might be other interrupts, exceptions, and so on that could.
And if nothing like that happens (as might well be the case on a
well-isolated CPU), RCU will eventually force one.  But it waits a few
hundred milliseconds in order to take advantage of whatever naturally
occurring interrupt might appear in the meantime.

Does that help?

							Thanx, Paul
