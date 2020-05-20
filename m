Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24FE206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589988982;
	bh=49YLLqcvb+eJRtXRk21PLd4rwRMtDXWCAYpZYFWDpEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zDicHNSgjx8mQLZotH8Z4vc2xWYaUETyKGpKwfyJzvj5F8Cw1zEolCiWTnBR8EojS
	 +Qz8D9EOxRQbfb6OwbRx6mBn+c0vgvVkFE9/F+eoBEcTJybr8ka/YU1Ab9qWYfiD50
	 YTRlOd7eY7NLK6i3nQFoyIzIxIIlPtzulLrMeF+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgETPgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgETPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:36:20 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4372207D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589988980;
        bh=49YLLqcvb+eJRtXRk21PLd4rwRMtDXWCAYpZYFWDpEY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FqWvkYvhqoqhwfG3xtcsKPGJvQPM4jXEbGv887ZXWQ3qDz1FqaI0yRyh+oek4Dw10
         mVWNFPF8+mycfOILE5mF8wnQm3Y4iR8H8OfomneOsRtCC3wDS3oxuMDPSmpwAQUbFE
         KxdsCldCArBV2//gC0gcI49FHYtA8wRMl+ivP9sc=
Received: by mail-wr1-f41.google.com with SMTP id j5so3647149wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:36:19 -0700 (PDT)
X-Gm-Message-State: AOAM5317g2tKgl8Sku3P3TG3OjaSfFuP340tbzgCZdQX7VlpB55b+qRT
        +/szTkQ/xWryIJr1RamgVjr7sh0c00wNOe1cMZdAxg==
X-Google-Smtp-Source: ABdhPJy3/OlRYfyYfe0ObkHzxtqg28UPkqTqEIs+bLW67/FIJIS+sDFDTaA0/6lCyySe3YoRr4diIqtk5P9eTObcxYU=
X-Received: by 2002:adf:f446:: with SMTP id f6mr4521220wrp.75.1589988978124;
 Wed, 20 May 2020 08:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200520022353.GN2869@paulmck-ThinkPad-P72>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 08:36:06 -0700
X-Gmail-Original-Message-ID: <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
Message-ID: <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
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

On Tue, May 19, 2020 at 7:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 05:26:58PM -0700, Andy Lutomirski wrote:
> > On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Andy Lutomirski <luto@kernel.org> writes:
> > > > On Tue, May 19, 2020 at 1:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >> Thomas Gleixner <tglx@linutronix.de> writes:
> > > >> It's about this:
> > > >>
> > > >> rcu_nmi_enter()
> > > >> {
> > > >>         if (!rcu_is_watching()) {
> > > >>             make it watch;
> > > >>         } else if (!in_nmi()) {
> > > >>             do_magic_nohz_dyntick_muck();
> > > >>         }
> > > >>
> > > >> So if we do all irq/system vector entries conditional then the
> > > >> do_magic() gets never executed. After that I got lost...
> > > >
> > > > I'm also baffled by that magic, but I'm also not suggesting doing this
> > > > to *all* entries -- just the not-super-magic ones that use
> > > > idtentry_enter().
> > > >
> > > > Paul, what is this code actually trying to do?
> > >
> > > Citing Paul from IRC:
> > >
> > >   "The way things are right now, you can leave out the rcu_irq_enter()
> > >    if this is not a nohz_full CPU.
> > >
> > >    Or if this is a nohz_full CPU, and the tick is already
> > >    enabled, in that case you could also leave out the rcu_irq_enter().
> > >
> > >    Or even if this is a nohz_full CPU and it does not have the tick
> > >    enabled, if it has been in the kernel less than a few tens of
> > >    milliseconds, still OK to avoid invoking rcu_irq_enter()
> > >
> > >    But my guess is that it would be a lot simpler to just always call
> > >    it.
> > >
> > > Hope that helps.
> >
> > Maybe?
> >
> > Unless I've missed something, the effect here is that #PF hitting in
> > an RCU-watching context will skip rcu_irq_enter(), whereas all IRQs
> > (because you converted them) as well as other faults and traps will
> > call rcu_irq_enter().
> >
> > Once upon a time, we did this horrible thing where, on entry from user
> > mode, we would turn on interrupts while still in CONTEXT_USER, which
> > means we could get an IRQ in an extended quiescent state.  This means
> > that the IRQ code had to end the EQS so that IRQ handlers could use
> > RCU.  But I killed this a few years ago -- x86 Linux now has a rule
> > that, if IF=1, we are *not* in an EQS with the sole exception of the
> > idle code.
> >
> > In my dream world, we would never ever get IRQs while in an EQS -- we
> > would do MWAIT with IF=0 and we would exit the EQS before taking the
> > interrupt.  But I guess we still need to support HLT, which means we
> > have this mess.
> >
> > But I still think we can plausibly get rid of the conditional.
>
> You mean the conditional in rcu_nmi_enter()?  In a NO_HZ_FULL=n system,
> this becomes:

So, I meant the conditional in tglx's patch that makes page faults special.

>
> >                                                                 If we
> > get an IRQ or (egads!) a fault in idle context, we'll have
> > !__rcu_is_watching(), but, AFAICT, we also have preemption off.
>
> Or we could be early in the kernel-entry code or late in the kernel-exit
> code, but as far as I know, preemption is disabled on those code paths.
> As are interrupts, right?  And interrupts are disabled on the portions
> of the CPU-hotplug code where RCU is not watching, if I recall correctly.

Interrupts are off in the parts of the entry/exit that RCU considers
to be user mode.  We can get various faults, although these should be
either NMI-like or events that genuinely or effectively happened in
user mode.

>
> A nohz_full CPU does not enable the scheduling-clock interrupt upon
> entry to the kernel.  Normally, this is fine because that CPU will very
> quickly exit back to nohz_full userspace execution, so that RCU will
> see the quiescent state, either by sampling it directly or by deducing
> the CPU's passage through that quiescent state by comparing with state
> that was captured earlier.  The grace-period kthread notices the lack
> of a quiescent state and will eventually set ->rcu_urgent_qs to
> trigger this code.
>
> But if the nohz_full CPU stays in the kernel for an extended time,
> perhaps due to OOM handling or due to processing of some huge I/O that
> hits in-memory buffers/cache, then RCU needs some way of detecting
> quiescent states on that CPU.  This requires the scheduling-clock
> interrupt to be alive and well.
>
> Are there other ways to get this done?  But of course!  RCU could
> for example use smp_call_function_single() or use workqueues to force
> execution onto that CPU and enable the tick that way.  This gets a
> little involved in order to avoid deadlock, but if the added check
> in rcu_nmi_enter() is causing trouble, something can be arranged.
> Though that something would cause more latency excursions than
> does the current code.
>
> Or did you have something else in mind?

I'm trying to understand when we actually need to call the function.
Is it just the scheduling interrupt that's supposed to call
rcu_irq_enter()?  But the scheduling interrupt is off, so I'm
confused.
