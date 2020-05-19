Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E59206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589917509;
	bh=prph2qoH9QCMW3pwAxbLaio9VKuKuClidqYb/wDuWzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BP3zXOr03/T8zxjHEHRKL/Yh3ZEhzLIx8bFsxJ1a26nOxg+Gjo1VimS9Xcy2ZE+D6
	 TscR4wwMUtNm7DYM7BeMLvqpR7e2dgiy2satkUWV8IZdLHBPvKKqCGojbuf3l+UpCL
	 iWT5/TINLj6H1BlgFEF58qxRH6BaAxZ3oTvrln0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgESTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgESTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:45:08 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05510206C3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589917507;
        bh=prph2qoH9QCMW3pwAxbLaio9VKuKuClidqYb/wDuWzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BFi5FVJ06lBapTZSSRbCWUzV32vFq/MmzdZvPPIUD8KJShdBwApyOsiZG08VAsI+7
         MfL/tRJNb9nMAnoX+Q5+0fG8mJQF/UljG6cO/KxHE3suMTNSyVVbTo9zykPg/1NIKs
         993iAY5SJY9m4atQ37no1oaF8yhhG64uX0koKqEY=
Received: by mail-wr1-f47.google.com with SMTP id y3so759328wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:45:06 -0700 (PDT)
X-Gm-Message-State: AOAM5317P26w8pmaxbyLLtQ/EVnHRz7fNhJR3ElcyXLG5dmWkyvDpjFm
        MQ5kevUhPFT9pccKtzDMPlhmRjPWJzknSxBZ+utY3Q==
X-Google-Smtp-Source: ABdhPJyiB+bDaICZ//Kz/mVmSO7q8gAV3mFcxyFlkC1g08m4eNH6FIjOSSS64LWaQgLf3F93Px2Focl0CPrcgQy7ofw=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr536305wro.70.1589917505450;
 Tue, 19 May 2020 12:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de>
 <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com> <87imgr7nwp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imgr7nwp.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 12:44:54 -0700
X-Gmail-Original-Message-ID: <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
Message-ID: <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Tue, May 19, 2020 at 11:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> @@ -573,6 +578,16 @@ static __always_inline void __idtentry_exit(struct pt_regs *regs)
> >>                                 instrumentation_end();
> >>                                 return;
> >>                         }
> >> +               } else if (IS_ENABLED(CONFIG_XEN_PV)) {
> >> +                       if (preempt_hcall) {
> >> +                               /* See CONFIG_PREEMPTION above */
> >> +                               instrumentation_begin();
> >> +                               rcu_irq_exit_preempt();
> >> +                               xen_maybe_preempt_hcall();
> >> +                               trace_hardirqs_on();
> >> +                               instrumentation_end();
> >> +                               return;
> >> +                       }
> >
> > Ewwwww!  This shouldn't be taken as a NAK -- it's just an expression
> > of disgust.
>
> I'm really not proud of it, but that was the least horrible thing I
> could come up with.
>
> > Shouldn't this be:
> >
> > instrumentation_begin();
> > if (!irq_needs_irq_stack(...))
> >   __blah();
> > else
> >   run_on_irqstack(__blah, NULL);
> > instrumentation_end();
> >
> > or even:
> >
> > instrumentation_begin();
> > run_on_irqstack_if_needed(__blah, NULL);
> > instrumentation_end();
>
> Yeah. In that case the instrumentation markers are not required as they
> will be inside the run....() function.
>
> > ****** BUT *******
> >
> > I think this is all arse-backwards.  This is a giant mess designed to
> > pretend we support preemption and to emulate normal preemption in a
> > non-preemptible kernel.  I propose one to two massive cleanups:
> >
> > A: Just delete all of this code.  Preemptible hypercalls on
> > non-preempt kernels will still process interrupts but won't get
> > preempted.  If you want preemption, compile with preemption.
>
> I'm happy to do so, but the XEN folks might have opinions on that :)
>
> > B: Turn this thing around.  Specifically, in the one and only case we
> > care about, we know pretty much exactly what context we got this entry
> > in: we're running in a schedulable context doing an explicitly
> > preemptible hypercall, and we have RIP pointing at a SYSCALL
> > instruction (presumably, but we shouldn't bet on it) in the hypercall
> > page.  Ideally we would change the Xen PV ABI so the hypercall would
> > return something like EAGAIN instead of auto-restarting and we could
> > ditch this mess entirely.  But the ABI seems to be set in stone or at
> > least in molasses, so how about just:
> >
> > idt_entry(exit(regs));
> > if (inhcall && need_resched())
> >   schedule();
>
> Which brings you into the situation that you call schedule() from the
> point where we just moved it out. If we would go there we'd need to
> ensure that RCU is watching as well. idtentry_exit() might have it
> turned off ....

I don't think this is possible.  Once you untangle all the wrappers,
the call sites are effectively:

__this_cpu_write(xen_in_preemptible_hcall, true);
CALL_NOSPEC to the hypercall page
__this_cpu_write(xen_in_preemptible_hcall, false);

I think IF=1 when this happens, but I won't swear to it.  RCU had
better be watching.

As I understand it, the one and only situation Xen wants to handle is
that an interrupt gets delivered during the hypercall.  The hypervisor
is too clever for its own good and deals with this by rewinding RIP to
the beginning of whatever instruction did the hypercall and delivers
the interrupt, and we end up in this handler.  So, if this happens,
the idea is to not only handle the interrupt but to schedule if
scheduling would be useful.

So I don't think we need all this RCU magic.  This really ought to be
able to be simplified to:

idtentry_exit();

if (appropriate condition)
  schedule();

Obviously we don't want to schedule if this is a nested entry, but we
should be able to rule that out by checking that regs->flags &
X86_EFLAGS_IF and by handling the percpu variable a little more
intelligently.  So maybe the right approach is:

bool in_preemptible_hcall = __this_cpu_read(xen_in_preemptible_hcall);
__this_cpu_write(xen_in_preemptible_hcall, false);
idtentry_enter(...);

do the acutal work;

idtentry_exit(...);

if (in_preemptible_hcall) {
  assert regs->flags & X86_EFLAGS_IF;
  assert that RCU is watching;
  assert that we're on the thread stack;
  assert whatever else we feel like asserting;
  if (need_resched())
    schedule();
}

__this_cpu_write(xen_in_preemptible_hcall, in_preemptible_hcall);

And now we don't have a special idtentry_exit() case just for Xen, and
all the mess is entirely contained in the Xen PV code.  And we need to
mark all the preemptible hypercalls noinstr.  Does this seem
reasonable?

That being said, right now, with or without your patch, I think we're
toast if the preemptible hypercall code gets traced.  So maybe the
right thing is to just drop all the magic preemption stuff from your
patch and let the Xen maintainers submit something new (maybe like
what I suggest above) if they want magic preemption back.
