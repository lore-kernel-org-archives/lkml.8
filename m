Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670B32070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgETIGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:06:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:06:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57470ACA7;
        Wed, 20 May 2020 08:06:37 +0000 (UTC)
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to
 IDTENTRY
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
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
References: <20200515234547.710474468@linutronix.de>
 <20200515235125.425810667@linutronix.de>
 <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
 <87imgr7nwp.fsf@nanos.tec.linutronix.de>
 <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <3dd0e972-1b80-cd6b-6490-5b745ada68c8@suse.com>
Date:   Wed, 20 May 2020 10:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.20 21:44, Andy Lutomirski wrote:
> On Tue, May 19, 2020 at 11:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>>> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>> @@ -573,6 +578,16 @@ static __always_inline void __idtentry_exit(struct pt_regs *regs)
>>>>                                  instrumentation_end();
>>>>                                  return;
>>>>                          }
>>>> +               } else if (IS_ENABLED(CONFIG_XEN_PV)) {
>>>> +                       if (preempt_hcall) {
>>>> +                               /* See CONFIG_PREEMPTION above */
>>>> +                               instrumentation_begin();
>>>> +                               rcu_irq_exit_preempt();
>>>> +                               xen_maybe_preempt_hcall();
>>>> +                               trace_hardirqs_on();
>>>> +                               instrumentation_end();
>>>> +                               return;
>>>> +                       }
>>>
>>> Ewwwww!  This shouldn't be taken as a NAK -- it's just an expression
>>> of disgust.
>>
>> I'm really not proud of it, but that was the least horrible thing I
>> could come up with.
>>
>>> Shouldn't this be:
>>>
>>> instrumentation_begin();
>>> if (!irq_needs_irq_stack(...))
>>>    __blah();
>>> else
>>>    run_on_irqstack(__blah, NULL);
>>> instrumentation_end();
>>>
>>> or even:
>>>
>>> instrumentation_begin();
>>> run_on_irqstack_if_needed(__blah, NULL);
>>> instrumentation_end();
>>
>> Yeah. In that case the instrumentation markers are not required as they
>> will be inside the run....() function.
>>
>>> ****** BUT *******
>>>
>>> I think this is all arse-backwards.  This is a giant mess designed to
>>> pretend we support preemption and to emulate normal preemption in a
>>> non-preemptible kernel.  I propose one to two massive cleanups:
>>>
>>> A: Just delete all of this code.  Preemptible hypercalls on
>>> non-preempt kernels will still process interrupts but won't get
>>> preempted.  If you want preemption, compile with preemption.
>>
>> I'm happy to do so, but the XEN folks might have opinions on that :)

Indeed. :-)

>>
>>> B: Turn this thing around.  Specifically, in the one and only case we
>>> care about, we know pretty much exactly what context we got this entry
>>> in: we're running in a schedulable context doing an explicitly
>>> preemptible hypercall, and we have RIP pointing at a SYSCALL
>>> instruction (presumably, but we shouldn't bet on it) in the hypercall
>>> page.  Ideally we would change the Xen PV ABI so the hypercall would
>>> return something like EAGAIN instead of auto-restarting and we could
>>> ditch this mess entirely.  But the ABI seems to be set in stone or at
>>> least in molasses, so how about just:
>>>
>>> idt_entry(exit(regs));
>>> if (inhcall && need_resched())
>>>    schedule();
>>
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

Preemptible hypercalls are never done with interrupts off. To be more
precise: they are only ever done during ioctl() processing.

I can add an ASSERT() to xen_preemptible_hcall_begin() if you want.

> 
> As I understand it, the one and only situation Xen wants to handle is
> that an interrupt gets delivered during the hypercall.  The hypervisor
> is too clever for its own good and deals with this by rewinding RIP to
> the beginning of whatever instruction did the hypercall and delivers
> the interrupt, and we end up in this handler.  So, if this happens,
> the idea is to not only handle the interrupt but to schedule if
> scheduling would be useful.

Correct. More precise: the hypercalls in question can last very long
(up to several seconds) and so they need to be interruptible. As said
before: the interface how this is done is horrible. :-(

> 
> So I don't think we need all this RCU magic.  This really ought to be
> able to be simplified to:
> 
> idtentry_exit();
> 
> if (appropriate condition)
>    schedule();
> 
> Obviously we don't want to schedule if this is a nested entry, but we
> should be able to rule that out by checking that regs->flags &
> X86_EFLAGS_IF and by handling the percpu variable a little more
> intelligently.  So maybe the right approach is:
> 
> bool in_preemptible_hcall = __this_cpu_read(xen_in_preemptible_hcall);
> __this_cpu_write(xen_in_preemptible_hcall, false);
> idtentry_enter(...);
> 
> do the acutal work;
> 
> idtentry_exit(...);
> 
> if (in_preemptible_hcall) {
>    assert regs->flags & X86_EFLAGS_IF;
>    assert that RCU is watching;
>    assert that we're on the thread stack;
>    assert whatever else we feel like asserting;
>    if (need_resched())
>      schedule();
> }
> 
> __this_cpu_write(xen_in_preemptible_hcall, in_preemptible_hcall);
> 
> And now we don't have a special idtentry_exit() case just for Xen, and
> all the mess is entirely contained in the Xen PV code.  And we need to
> mark all the preemptible hypercalls noinstr.  Does this seem
> reasonable?

 From my point of view this sounds fine.

> 
> That being said, right now, with or without your patch, I think we're
> toast if the preemptible hypercall code gets traced.  So maybe the
> right thing is to just drop all the magic preemption stuff from your
> patch and let the Xen maintainers submit something new (maybe like
> what I suggest above) if they want magic preemption back.
> 

I'd prefer to not break preemptible hypercall in between.

IMO the patch should be modified along your suggestion. I'd be happy to
test it.


Juergen
