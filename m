Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4222075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589995399;
	bh=BFLQ/xq4FnWU6i5c9z1NolKnkBi9zZFq5E30La70Lg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pq3fI2Lyqe4G2wbYNK4iKzoiWiBijhQvlmt6sQ/nCvIFvK4Y4EJVOgpd3W405nAan
	 U35tWiOufQFjS7x+aBhrRFSxZQU++yYbdFGy9kZl9IKFCzDtkHZ/WlYYFz2ciPi6gr
	 wY27wyuMRJkhDyYF7uFxWzRlac6Nt08Yx2gcvFMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgETRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgETRXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:23:13 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82CAD20899
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589995392;
        bh=BFLQ/xq4FnWU6i5c9z1NolKnkBi9zZFq5E30La70Lg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nBfvpKHE44qsSO+QmT+g2rruAlPKAgHvdSBWsGy4VQIoUumXO2FbQ+ka6HJa1dHlA
         lhbZnnm0aa7OXw6BR7aENphWEmDmm7kwF+2co5hIEShPUydU0KifdTdTAkDKAQirkx
         jm6IKJRr6G5tIq92umLeJHet4YHv6nBFXIJK9qhc=
Received: by mail-wr1-f53.google.com with SMTP id l17so3987150wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:23:12 -0700 (PDT)
X-Gm-Message-State: AOAM531/uQgRzUf7fUkNi13C0c8JBDa86PlYC+C2QXLB4xx6gYzj61QI
        9UOQHNS+4uxmEz0KZiJGG3LtJ5lEr8evpeeJxLFMvw==
X-Google-Smtp-Source: ABdhPJzWvveFwpAQLFHvuEIoe9jrHdH4/Ldhlhxp5aUDQkEtAEipDdH3KGVIbAT358jzodam/q3jU4pN6EJiOrd/mnk=
X-Received: by 2002:adf:a389:: with SMTP id l9mr5199865wrb.18.1589995390910;
 Wed, 20 May 2020 10:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de>
 <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
 <87imgr7nwp.fsf@nanos.tec.linutronix.de> <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
 <87y2pm4ruh.fsf@nanos.tec.linutronix.de> <CALCETrUvH5DQvL6Lo6EkM04pr7wWj+7eZbTg3H_eLNXcZsH0FA@mail.gmail.com>
In-Reply-To: <CALCETrUvH5DQvL6Lo6EkM04pr7wWj+7eZbTg3H_eLNXcZsH0FA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 10:22:59 -0700
X-Gmail-Original-Message-ID: <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com>
Message-ID: <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Wed, May 20, 2020 at 8:16 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Andy Lutomirski <luto@kernel.org> writes:
> > > On Tue, May 19, 2020 at 11:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> Which brings you into the situation that you call schedule() from the
> > >> point where we just moved it out. If we would go there we'd need to
> > >> ensure that RCU is watching as well. idtentry_exit() might have it
> > >> turned off ....
> > >
> > > I don't think this is possible.  Once you untangle all the wrappers,
> > > the call sites are effectively:
> > >
> > > __this_cpu_write(xen_in_preemptible_hcall, true);
> > > CALL_NOSPEC to the hypercall page
> > > __this_cpu_write(xen_in_preemptible_hcall, false);
> > >
> > > I think IF=1 when this happens, but I won't swear to it.  RCU had
> > > better be watching.
> > >
> > > As I understand it, the one and only situation Xen wants to handle is
> > > that an interrupt gets delivered during the hypercall.  The hypervisor
> > > is too clever for its own good and deals with this by rewinding RIP to
> > > the beginning of whatever instruction did the hypercall and delivers
> > > the interrupt, and we end up in this handler.  So, if this happens,
> > > the idea is to not only handle the interrupt but to schedule if
> > > scheduling would be useful.
> > >
> > > So I don't think we need all this RCU magic.  This really ought to be
> > > able to be simplified to:
> > >
> > > idtentry_exit();
> > >
> > > if (appropriate condition)
> > >   schedule();
> >
> > This is exactly the kind of tinkering which causes all kinds of trouble.
> >
> > idtentry_exit()
> >
> >         if (user_mode(regs)) {
> >                 prepare_exit_to_usermode(regs);
> >         } else if (regs->flags & X86_EFLAGS_IF) {
> >                 /* Check kernel preemption, if enabled */
> >                 if (IS_ENABLED(CONFIG_PREEMPTION)) {
> >                     ....
> >                 }
> >                 instrumentation_begin();
> >                 /* Tell the tracer that IRET will enable interrupts */
> >                 trace_hardirqs_on_prepare();
> >                 lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> >                 instrumentation_end();
> >                 rcu_irq_exit();
> >                 lockdep_hardirqs_on(CALLER_ADDR0);
> >         } else {
> >                 /* IRQ flags state is correct already. Just tell RCU */
> >                 rcu_irq_exit();
> >         }
> >
> > So in case IF is set then this already told the tracer and lockdep that
> > interrupts are enabled. And contrary to the ugly version this exit path
> > does not use rcu_irq_exit_preempt() which is there to warn about crappy
> > RCU state when trying to schedule.
> >
> > So we went great length to sanitize _all_ of this and make it consistent
> > just to say: screw it for that xen thingy.
> >
> > The extra checks and extra warnings for scheduling come with the
> > guarantee to bitrot when idtentry_exit() or any logic invoked from there
> > is changed. It's going to look like this:
> >
> >         /*
> >          * If the below causes problems due to inconsistent state
> >          * or out of sync sanity checks, please complain to
> >          * luto@kernel.org directly.
> >          */
> >         idtentry_exit();
> >
> >         if (user_mode(regs) || !(regs->flags & X86_FlAGS_IF))
> >                 return;
> >
> >         if (!__this_cpu_read(xen_in_preemptible_hcall))
> >                 return;
> >
> >         rcu_sanity_check_for_preemption();
> >
> >         if (need_resched()) {
> >                 instrumentation_begin();
> >                 xen_maybe_preempt_hcall();
> >                 trace_hardirqs_on();
> >                 instrumentation_end();
> >         }
> >
> > Of course you need the extra rcu_sanity_check_for_preemption() function
> > just for this muck.
> >
> > That's a true win on all ends? I don't think so.
>
> Hmm, fair enough.  I guess the IRQ tracing messes a bunch of this logic up.
>
> Let's keep your patch as is and consider cleanups later.  One approach
> might be to make this work more like extable handling: instead of
> trying to schedule from inside the interrupt handler here, patch up
> RIP and perhaps some other registers and let the actual Xen code just
> do cond_resched().  IOW, try to make this work the way it always
> should have:
>
> int ret;
> do {
>   ret = issue_the_hypercall();
>   cond_resched();
> } while (ret == EAGAIN);

Andrew Cooper pointed out that there is too much magic in Xen for this
to work.  So never mind.
