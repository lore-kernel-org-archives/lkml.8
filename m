Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855D6206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVGS0KiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFDGCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFDGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:02:44 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D0C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:02:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so3895394otv.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnnBoUNb8YbnZYmKYOcPjU3YbYG/8fac3+VAiSLpC54=;
        b=YVGS0KiJZ9PhTfMsd1IiyW8G7T2MyvxQHKJ81nOsShsomLmMXfcLvxOiC77UspC/+f
         EdjU2rySULzgsUI80ajBPG6R4bOkOO8bkhBR+95jyNHYZQUmWqiyofHjjWZJty+jMIdm
         DkRYrI1bV/HV/RjtRxGgY/sU+1FBtc3SPnmQSh1socCK2zPIc0tkxNRg26verFrxc+Pr
         j0jyMWNfCa+59kTBlgrjCPq+2cb1yCA9Y9GgboNuebkWI8ngf382FuFdfOJV0FHmHE/R
         BX5gg4cNBWJHlGQ1rJVLoCG8+pwePnf+zfv5kB1PqbOCdPfg9ypgc6Rby1vO5Y62NtX/
         CQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnnBoUNb8YbnZYmKYOcPjU3YbYG/8fac3+VAiSLpC54=;
        b=NwQnu+KftOMKuu+37DG9PkLCPtyKFiIkO9IRiPbJgNMe3WuGfvAFhbvn3LpauKGZaC
         ymPj9E8Imu2CYUE4DXG2k+onzq/LRuu2JYuPaqRDjL0u/UrhZL5Iv0gmkTcS5I8DmfoY
         qUThmDfAYw1HGwvHbecHLx9YzHb8kJ8YBUNsKn9aZwNaRtVxeeuhyAhf2NujYThuBrh6
         PF0m1I6+jbk361jIsvJvG+4YRcourmnIeODK8Ho+jv6HtFVvGFBUVzz+7jOxmXriw++V
         8I2mMhSMIwSoUgPPYAsQK34PC6tzNvVUQr4H7RLlXfIGgn3NGS2rBChe14fbt6Z01+JO
         bo5g==
X-Gm-Message-State: AOAM530GPq6QAb/6vO0NqqVgjOsyRlmpYFOTbsL4NEqP8qA8MEN3ukgn
        sBzhr6Sq88DnrfZ3aj4PsK3sGXv7+Wz9bXwSGLHrQA==
X-Google-Smtp-Source: ABdhPJxQ+vZQwXnUpSW+FbdbS/JQIginAN+l79THqiBy9+1GpDFos92gUl5LYrIlqRJjONoW4w0xoVQEGEZfNKNoqJc=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr2392364otn.251.1591250563027;
 Wed, 03 Jun 2020 23:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72> <20200603171320.GE2570@hirez.programming.kicks-ass.net>
 <20200604033409.GX29598@paulmck-ThinkPad-P72>
In-Reply-To: <20200604033409.GX29598@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 08:02:31 +0200
Message-ID: <CANpmjNPmXLR1MsLonhn_gdDuOquzQ0Ovw7PAWejOJ-aV2F=iHg@mail.gmail.com>
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 05:34, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jun 03, 2020 at 07:13:20PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:
> >
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_ent
> > > >    * next idle sojourn.
> > > >    */
> > > >   rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> > > > - seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > > + seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > >
> > > To preserve KCSAN's ability to see this, there would be something like
> > > instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) prior
> > > to the instrumentation_end() invoked before rcu_dynticks_eqs_enter()
> > > in each of rcu_eqs_enter() and rcu_nmi_exit(), correct?
> >
> > Yes.
> >
> > > >   // RCU is no longer watching.  Better be in extended quiescent state!
> > > >   WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > > >                (seq & RCU_DYNTICK_CTRL_CTR));
> > > > @@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exi
> > > >    * and we also must force ordering with the next RCU read-side
> > > >    * critical section.
> > > >    */
> > > > - seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > > + seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > >
> > > And same here, but after the instrumentation_begin() following
> > > rcu_dynticks_eqs_exit() in both rcu_eqs_exit() and rcu_nmi_enter(),
> > > correct?
> >
> > Yep.
> >
> > > >   // RCU is now watching.  Better not be in an extended quiescent state!
> > > >   rcu_dynticks_task_trace_exit();  // After ->dynticks update!
> > > >   WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > > >                !(seq & RCU_DYNTICK_CTRL_CTR));
> > > >   if (seq & RCU_DYNTICK_CTRL_MASK) {
> > > > -         atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > > > +         arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > >
> > > This one is gone in -rcu.
> >
> > Good, because that would make things 'complicated' with the external
> > instrumentation call. And is actually the reason I didn't even attempt
> > it this time around.
> >
> > > >           smp_mb__after_atomic(); /* _exit after clearing mask. */
> > > >   }
> > > >  }
> > > > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> > > >  {
> > > >   struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >
> > > > - return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > > > + return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> >
> > The above is actually instrumented by KCSAN, due to arch_atomic_read()
> > being a READ_ONCE() and it now understanding volatile.
> >
> > > Also instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) as
>
> Right, this should instead be instrument_read(...).
>
> Though if KCSAN is unconditionally instrumenting volatile, how does
> this help?  Or does KCSAN's instrumentation of volatile somehow avoid
> causing trouble?

When used normally outside noinstr functions, because this is an
__always_inline function, it will be instrumented. Within noinstr
(which imply __no_kcsan) functions it should not be instrumented.

Thanks,
-- Marco


> > > follows:
> > >
> > > o   rcu_nmi_exit(): After each following instrumentation_begin().
> >
> > Yes
> >
> > > o   In theory in rcu_irq_exit_preempt(), but as this generates code
> > >     only in lockdep builds, it might not be worth worrying about.
> > >
> > > o   Ditto for rcu_irq_exit_check_preempt().
> > >
> > > o   Ditto for __rcu_irq_enter_check_tick().
> >
> > Not these, afaict they're all the above arch_atomic_read(), which is
> > instrumented due to volatile in these cases.
> >
> > > o   rcu_nmi_enter(): After each following instrumentation_begin().
> >
> > Yes
> >
> > > o   __rcu_is_watching() is itself noinstr:
> > >
> > >     o       idtentry_enter_cond_rcu(): After each following
> > >             instrumentation_begin().
> > >
> > > o   rcu_is_watching(): Either before or after the call to
> > >     rcu_dynticks_curr_cpu_in_eqs().
> >
> > Something like that yes.
> >
> > > >  }
> > > >
> > > >  /*
> > > > @@ -692,6 +692,7 @@ noinstr void rcu_nmi_exit(void)
> > > >  {
> > > >   struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >
> > > > + instrumentation_begin();
> > > >   /*
> > > >    * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> > > >    * (We are exiting an NMI handler, so RCU better be paying attention
> > > > @@ -705,7 +706,6 @@ noinstr void rcu_nmi_exit(void)
> > > >    * leave it in non-RCU-idle state.
> > > >    */
> > > >   if (rdp->dynticks_nmi_nesting != 1) {
> > > > -         instrumentation_begin();
> > > >           trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> > > >                             atomic_read(&rdp->dynticks));
> > > >           WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > > > @@ -714,7 +714,6 @@ noinstr void rcu_nmi_exit(void)
> > > >           return;
> > > >   }
> > > >
> > > > - instrumentation_begin();
> > > >   /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> > > >   trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> > > >   WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> > >
> > > This one looks to be having no effect on instrumentation of atomics, but
> > > rather coalescing a pair of instrumentation_begin() into one.
> > >
> > > Do I understand correctly?
> >
> > Almost, it puts the WARN_ON_ONCE()s under instrumentation_begin() too,
> > and that makes a differnce, iirc it was the
> > rcu_dynticks_curr_cpu_in_eqs() call that stood out. But that could've
> > been before I switched it to arch_atomic_read(). In any case, I find
> > this form a lot clearer.
>
> Got it, thank you.
>
>                                                 Thanx, Paul
