Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2EEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451A206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgESS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgESS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:58:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A30C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:58:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jb7R8-0006vJ-Jc; Tue, 19 May 2020 20:57:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 187F7100D01; Tue, 19 May 2020 20:57:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
In-Reply-To: <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de> <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
Date:   Tue, 19 May 2020 20:57:58 +0200
Message-ID: <87imgr7nwp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> @@ -573,6 +578,16 @@ static __always_inline void __idtentry_exit(struct pt_regs *regs)
>>                                 instrumentation_end();
>>                                 return;
>>                         }
>> +               } else if (IS_ENABLED(CONFIG_XEN_PV)) {
>> +                       if (preempt_hcall) {
>> +                               /* See CONFIG_PREEMPTION above */
>> +                               instrumentation_begin();
>> +                               rcu_irq_exit_preempt();
>> +                               xen_maybe_preempt_hcall();
>> +                               trace_hardirqs_on();
>> +                               instrumentation_end();
>> +                               return;
>> +                       }
>
> Ewwwww!  This shouldn't be taken as a NAK -- it's just an expression
> of disgust.

I'm really not proud of it, but that was the least horrible thing I
could come up with.

> Shouldn't this be:
>
> instrumentation_begin();
> if (!irq_needs_irq_stack(...))
>   __blah();
> else
>   run_on_irqstack(__blah, NULL);
> instrumentation_end();
>
> or even:
>
> instrumentation_begin();
> run_on_irqstack_if_needed(__blah, NULL);
> instrumentation_end();

Yeah. In that case the instrumentation markers are not required as they
will be inside the run....() function.

> ****** BUT *******
>
> I think this is all arse-backwards.  This is a giant mess designed to
> pretend we support preemption and to emulate normal preemption in a
> non-preemptible kernel.  I propose one to two massive cleanups:
>
> A: Just delete all of this code.  Preemptible hypercalls on
> non-preempt kernels will still process interrupts but won't get
> preempted.  If you want preemption, compile with preemption.

I'm happy to do so, but the XEN folks might have opinions on that :)

> B: Turn this thing around.  Specifically, in the one and only case we
> care about, we know pretty much exactly what context we got this entry
> in: we're running in a schedulable context doing an explicitly
> preemptible hypercall, and we have RIP pointing at a SYSCALL
> instruction (presumably, but we shouldn't bet on it) in the hypercall
> page.  Ideally we would change the Xen PV ABI so the hypercall would
> return something like EAGAIN instead of auto-restarting and we could
> ditch this mess entirely.  But the ABI seems to be set in stone or at
> least in molasses, so how about just:
>
> idt_entry(exit(regs));
> if (inhcall && need_resched())
>   schedule();

Which brings you into the situation that you call schedule() from the
point where we just moved it out. If we would go there we'd need to
ensure that RCU is watching as well. idtentry_exit() might have it
turned off ....

That's why I did it this way to keep the code flow exactly the same for
all these exit variants.

Thanks,

        tglx
