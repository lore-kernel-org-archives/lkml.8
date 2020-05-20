Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E076C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E7E206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589996866;
	bh=6vCbwame/s4vn+1MS12qKyJlcAtRHtCt72K6bHuFWcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WU4QSRp+LL2R23zl2DYSsUtWi1nyneZU8Fb3QpLhX3WbT0B/kiilrmlS+4VoF3LAU
	 fsauhX9MQp0ML9L85vgTHpY+oyLU4az3STNZlBftg4nnmjw8r/s1D62Zusg+wWxG0T
	 prMlOhlfk7whuTRD58XPSLSFdP8OfsmxAKlHIVTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETRro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:47:44 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B0A206BE
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589996863;
        bh=6vCbwame/s4vn+1MS12qKyJlcAtRHtCt72K6bHuFWcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0oRH0JjO7XOCpvcd+bCo5/vTYP8q8ftj7NnFCQyLSQ953Yom7nvU4Rj8fC36s+lNo
         Ul+AUeeG+Xo54vlj12mK/c85Z6dEBOmzT43a/1XdVwX4jMdzTtIgrlN/V1a+yeXzL+
         3TCdeyYa0pDyN8zixA/N0DTP+jgfZJq9zQ8jGEaI=
Received: by mail-wm1-f44.google.com with SMTP id u1so3303383wmn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:47:42 -0700 (PDT)
X-Gm-Message-State: AOAM533ndA5ZH3fvjDwp5MxplDupCjyfBrumDK12EyusCBdxTuf7OGuE
        IYyaN2abDK2ayC0DgYxMW3fXigRpHFVUnTCPCdZxVQ==
X-Google-Smtp-Source: ABdhPJyoyw7HchRBCMpQlEJtmX+XUbd5/wq/8vvqPW+DqHlapkFLC3l2K6B9pj+zoIxpNwFAi5+Sx05lCATL6gXRNjM=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr5599391wmf.138.1589996861361;
 Wed, 20 May 2020 10:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72> <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <20200520173806.GP2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200520173806.GP2869@paulmck-ThinkPad-P72>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 10:47:29 -0700
X-Gmail-Original-Message-ID: <CALCETrWy7==Lo22o87QCb5XANRqX8ZuE_bfvaKMViA_0eSS1ew@mail.gmail.com>
Message-ID: <CALCETrWy7==Lo22o87QCb5XANRqX8ZuE_bfvaKMViA_0eSS1ew@mail.gmail.com>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:38 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 08:36:06AM -0700, Andy Lutomirski wrote:
> > On Tue, May 19, 2020 at 7:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Tue, May 19, 2020 at 05:26:58PM -0700, Andy Lutomirski wrote:
> > > > On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > Andy Lutomirski <luto@kernel.org> writes:
> > > > > > On Tue, May 19, 2020 at 1:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >> Thomas Gleixner <tglx@linutronix.de> writes:
> > > > > >> It's about this:
> > > > > >>
> > > > > >> rcu_nmi_enter()
> > > > > >> {
> > > > > >>         if (!rcu_is_watching()) {
> > > > > >>             make it watch;
> > > > > >>         } else if (!in_nmi()) {
> > > > > >>             do_magic_nohz_dyntick_muck();
> > > > > >>         }
> > > > > >>
> > > > > >> So if we do all irq/system vector entries conditional then the
> > > > > >> do_magic() gets never executed. After that I got lost...
> > > > > >
> > > > > > I'm also baffled by that magic, but I'm also not suggesting doing this
> > > > > > to *all* entries -- just the not-super-magic ones that use
> > > > > > idtentry_enter().
> > > > > >
> > > > > > Paul, what is this code actually trying to do?
> > > > >
> > > > > Citing Paul from IRC:
> > > > >
> > > > >   "The way things are right now, you can leave out the rcu_irq_enter()
> > > > >    if this is not a nohz_full CPU.
> > > > >
> > > > >    Or if this is a nohz_full CPU, and the tick is already
> > > > >    enabled, in that case you could also leave out the rcu_irq_enter().
> > > > >
> > > > >    Or even if this is a nohz_full CPU and it does not have the tick
> > > > >    enabled, if it has been in the kernel less than a few tens of
> > > > >    milliseconds, still OK to avoid invoking rcu_irq_enter()
> > > > >
> > > > >    But my guess is that it would be a lot simpler to just always call
> > > > >    it.
> > > > >
> > > > > Hope that helps.
> > > >
> > > > Maybe?
> > > >
> > > > Unless I've missed something, the effect here is that #PF hitting in
> > > > an RCU-watching context will skip rcu_irq_enter(), whereas all IRQs
> > > > (because you converted them) as well as other faults and traps will
> > > > call rcu_irq_enter().
> > > >
> > > > Once upon a time, we did this horrible thing where, on entry from user
> > > > mode, we would turn on interrupts while still in CONTEXT_USER, which
> > > > means we could get an IRQ in an extended quiescent state.  This means
> > > > that the IRQ code had to end the EQS so that IRQ handlers could use
> > > > RCU.  But I killed this a few years ago -- x86 Linux now has a rule
> > > > that, if IF=1, we are *not* in an EQS with the sole exception of the
> > > > idle code.
> > > >
> > > > In my dream world, we would never ever get IRQs while in an EQS -- we
> > > > would do MWAIT with IF=0 and we would exit the EQS before taking the
> > > > interrupt.  But I guess we still need to support HLT, which means we
> > > > have this mess.
> > > >
> > > > But I still think we can plausibly get rid of the conditional.
> > >
> > > You mean the conditional in rcu_nmi_enter()?  In a NO_HZ_FULL=n system,
> > > this becomes:
> >
> > So, I meant the conditional in tglx's patch that makes page faults special.
>
> OK.
>
> > > >                                                                 If we
> > > > get an IRQ or (egads!) a fault in idle context, we'll have
> > > > !__rcu_is_watching(), but, AFAICT, we also have preemption off.
> > >
> > > Or we could be early in the kernel-entry code or late in the kernel-exit
> > > code, but as far as I know, preemption is disabled on those code paths.
> > > As are interrupts, right?  And interrupts are disabled on the portions
> > > of the CPU-hotplug code where RCU is not watching, if I recall correctly.
> >
> > Interrupts are off in the parts of the entry/exit that RCU considers
> > to be user mode.  We can get various faults, although these should be
> > either NMI-like or events that genuinely or effectively happened in
> > user mode.
>
> Fair enough!
>
> > > A nohz_full CPU does not enable the scheduling-clock interrupt upon
> > > entry to the kernel.  Normally, this is fine because that CPU will very
> > > quickly exit back to nohz_full userspace execution, so that RCU will
> > > see the quiescent state, either by sampling it directly or by deducing
> > > the CPU's passage through that quiescent state by comparing with state
> > > that was captured earlier.  The grace-period kthread notices the lack
> > > of a quiescent state and will eventually set ->rcu_urgent_qs to
> > > trigger this code.
> > >
> > > But if the nohz_full CPU stays in the kernel for an extended time,
> > > perhaps due to OOM handling or due to processing of some huge I/O that
> > > hits in-memory buffers/cache, then RCU needs some way of detecting
> > > quiescent states on that CPU.  This requires the scheduling-clock
> > > interrupt to be alive and well.
> > >
> > > Are there other ways to get this done?  But of course!  RCU could
> > > for example use smp_call_function_single() or use workqueues to force
> > > execution onto that CPU and enable the tick that way.  This gets a
> > > little involved in order to avoid deadlock, but if the added check
> > > in rcu_nmi_enter() is causing trouble, something can be arranged.
> > > Though that something would cause more latency excursions than
> > > does the current code.
> > >
> > > Or did you have something else in mind?
> >
> > I'm trying to understand when we actually need to call the function.
> > Is it just the scheduling interrupt that's supposed to call
> > rcu_irq_enter()?  But the scheduling interrupt is off, so I'm
> > confused.
>
> The scheduling-clock interrupt is indeed off, but if execution remains
> in the kernel for an extended time period, this becomes a problem.
> RCU quiescent states don't happen, or if they do, they are not reported
> to RCU.  Grace periods never end, and the system eventually OOMs.
>
> And it is not all that hard to make a CPU stay in the kernel for minutes
> at a time on a large system.
>
> So what happens is that if RCU notices that a given CPU has not responded
> in a reasonable time period, it sets that CPU's ->rcu_urgent_qs.  This
> flag plays various roles in various configurations, but on nohz_full CPUs
> it causes that CPU's next rcu_nmi_enter() invocation to turn that CPU's
> tick on.  It also sets that CPU's ->rcu_forced_tick flag, which prevents
> redundant turning on of the tick and also causes the quiescent-state
> detection code to turn off the tick for this CPU.
>
> As you say, the scheduling-clock tick cannot turn itself on, but
> there might be other interrupts, exceptions, and so on that could.
> And if nothing like that happens (as might well be the case on a
> well-isolated CPU), RCU will eventually force one.  But it waits a few
> hundred milliseconds in order to take advantage of whatever naturally
> occurring interrupt might appear in the meantime.
>
> Does that help?

Yes, I think.  Could this go in a comment in the new function?
