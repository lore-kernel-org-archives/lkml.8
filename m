Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF4AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F92F207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETOOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:14:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:14:06 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbPTL-0002Rw-Tb; Wed, 20 May 2020 16:13:28 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C97CB100C99; Wed, 20 May 2020 16:13:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
In-Reply-To: <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de> <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com> <87imgr7nwp.fsf@nanos.tec.linutronix.de> <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
Date:   Wed, 20 May 2020 16:13:26 +0200
Message-ID: <87y2pm4ruh.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 19, 2020 at 11:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Which brings you into the situation that you call schedule() from the
>> point where we just moved it out. If we would go there we'd need to
>> ensure that RCU is watching as well. idtentry_exit() might have it
>> turned off ....
>
> I don't think this is possible.  Once you untangle all the wrappers,
> the call sites are effectively:
>
> __this_cpu_write(xen_in_preemptible_hcall, true);
> CALL_NOSPEC to the hypercall page
> __this_cpu_write(xen_in_preemptible_hcall, false);
>
> I think IF=1 when this happens, but I won't swear to it.  RCU had
> better be watching.
>
> As I understand it, the one and only situation Xen wants to handle is
> that an interrupt gets delivered during the hypercall.  The hypervisor
> is too clever for its own good and deals with this by rewinding RIP to
> the beginning of whatever instruction did the hypercall and delivers
> the interrupt, and we end up in this handler.  So, if this happens,
> the idea is to not only handle the interrupt but to schedule if
> scheduling would be useful.
>
> So I don't think we need all this RCU magic.  This really ought to be
> able to be simplified to:
>
> idtentry_exit();
>
> if (appropriate condition)
>   schedule();

This is exactly the kind of tinkering which causes all kinds of trouble.

idtentry_exit()

	if (user_mode(regs)) {
		prepare_exit_to_usermode(regs);
	} else if (regs->flags & X86_EFLAGS_IF) {
		/* Check kernel preemption, if enabled */
		if (IS_ENABLED(CONFIG_PREEMPTION)) {
                    ....
		}
		instrumentation_begin();
		/* Tell the tracer that IRET will enable interrupts */
		trace_hardirqs_on_prepare();
		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
		instrumentation_end();
		rcu_irq_exit();
		lockdep_hardirqs_on(CALLER_ADDR0);
	} else {
		/* IRQ flags state is correct already. Just tell RCU */
		rcu_irq_exit();
	}

So in case IF is set then this already told the tracer and lockdep that
interrupts are enabled. And contrary to the ugly version this exit path
does not use rcu_irq_exit_preempt() which is there to warn about crappy
RCU state when trying to schedule.

So we went great length to sanitize _all_ of this and make it consistent
just to say: screw it for that xen thingy.

The extra checks and extra warnings for scheduling come with the
guarantee to bitrot when idtentry_exit() or any logic invoked from there
is changed. It's going to look like this:

	/*
         * If the below causes problems due to inconsistent state
         * or out of sync sanity checks, please complain to
         * luto@kernel.org directly.
         */
        idtentry_exit();

	if (user_mode(regs) || !(regs->flags & X86_FlAGS_IF))
        	return;

        if (!__this_cpu_read(xen_in_preemptible_hcall))
        	return;

        rcu_sanity_check_for_preemption();

        if (need_resched()) {
        	instrumentation_begin();
		xen_maybe_preempt_hcall();
		trace_hardirqs_on();
		instrumentation_end();
	}  	

Of course you need the extra rcu_sanity_check_for_preemption() function
just for this muck.

That's a true win on all ends? I don't think so.

Thanks,

        tglx
