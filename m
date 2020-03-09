Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DEC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCIS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:59:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgCIS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:59:33 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBNcV-0005S7-Oy; Mon, 09 Mar 2020 19:59:19 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0305E10408A; Mon,  9 Mar 2020 19:59:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
In-Reply-To: <20200309141546.5b574908@gandalf.local.home>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home>
Date:   Mon, 09 Mar 2020 19:59:18 +0100
Message-ID: <87fteh73sp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Mon, 09 Mar 2020 18:02:32 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> #1 Fragile low level entry code
>> 
>>    While I understand the desire of instrumentation to observe
>>    everything we really have to ask the question whether it is worth the
>>    trouble especially with entry trainwrecks like x86, PTI and other
>>    horrors in that area.
>> 
>>    I don't think so and we really should just bite the bullet and forbid
>>    any instrumentation in that code unless it is explicitly designed
>>    for that case, makes sense and has a real value from an observation
>>    perspective.
>> 
>>    This is very much related to #3..
>
> Now for just entry portions (entering into interrupt context or
> coming from userspace into normal kernel code) I agree, and I'm fine if we
> can move things around and not trace these entry points if possible.

I think we can. I spent quite some effort on splitting up the syscall
entry/exit stuff so only the low level entry up to the point where RCU
is watching and the low level exit where RCU is evtl. going back to idle
plus the related ASM maze. It's quite some tedious work, that's why I
came up with the section approach.
 
>> #2) Breakpoint utilization
>> 
>>     As recent findings have shown, breakpoint utilization needs to be
>>     extremly careful about not creating infinite breakpoint recursions.
>> 
>>     I think that's pretty much obvious, but falls into the overall
>>     question of how to protect callchains.
>
> This is rather unique, and I agree that its best to at least get to a point
> where we limit the tracing within breakpoint code. I'm fine with making
> rcu_nmi_exit() nokprobe too.

Yes, the break point stuff is unique, but it has nicely demonstrated how
much of the code is affected by it.

>> #3) RCU idle
>> 
>>     Being able to trace code inside RCU idle sections is very similar to
>>     the question raised in #1.
>> 
>>     Assume all of the instrumentation would be doing conditional RCU
>>     schemes, i.e.:
>> 
>>     if (rcuidle)
>>     	....
>>     else
>>         rcu_read_lock_sched()
>> 
>>     before invoking the actual instrumentation functions and of course
>>     undoing that right after it, that really begs the question whether
>>     it's worth it.
>> 
>>     Especially constructs like:
>> 
>>     trace_hardirqs_off()
>>        idx = srcu_read_lock()
>>        rcu_irq_enter_irqson();
>>        ...
>>        rcu_irq_exit_irqson();
>>        srcu_read_unlock(idx);
>> 
>>     if (user_mode)
>>        user_exit_irqsoff();
>>     else
>>        rcu_irq_enter();
>> 
>>     are really more than questionable. For 99.9999% of instrumentation
>>     users it's absolutely irrelevant whether this traces the interrupt
>>     disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
>> 
>>     But what's relevant is the tracer overhead which is e.g. inflicted
>>     with todays trace_hardirqs_off/on() implementation because that
>>     unconditionally uses the rcuidle variant with the scru/rcu_irq dance
>>     around every tracepoint.
>> 
>>     Even if the tracepoint sits in the ASM code it just covers about ~20
>>     low level ASM instructions more. The tracer invocation, which is
>>     even done twice when coming from user space on x86 (the second call
>>     is optimized in the tracer C-code), costs definitely way more
>>     cycles. When you take the scru/rcu_irq dance into account it's a
>>     complete disaster performance wise.
>
> Is this specifically to do with the kernel/trace/trace_preemptirqs.c code
> that was added by Joel?

Don't know who it added, but yes, the above is what it does when it's
expanded. I did some profiling with a trivial invalid syscall and
trace_hardirqs_off() shows very prominent there, while with the approach
I have in my entry series which does:

       lockdep_irq_off();
       enter_from_user_mode();
       __trace_hardirqs_off();

The tracing overhead goes down by ~ factor 2. That's a lot.
 
>> #4 Protecting call chains
>> 
>>    Our current approach of annotating functions with notrace/noprobe is
>>    pretty much broken.
>> 
>>    Functions which are marked NOPROBE or notrace call out into functions
>>    which are not marked and while this might be ok, there are enough
>>    places where it is not. But we have no way to verify that.
>
> Note, if notrace is an issue it shows up pretty quickly, as just enabling
> function tracing will enable all non notrace locations, and if something
> shouldn't be traced, it will crash immediately.

Steven, you're not really serious about this, right? This is tinkering
at best.

We have code pathes which are not necessarily covered in regular
testing, depend on config options etc.

Have you ever looked at code coverage maps? There are quite some spots
which we don't reach in testing.

So how do you explain the user that the blind spot he hit in the weird
situation on his server which he wanted to analyze crashed his machine?

Having 'off limit' sections allows us to do proper tool based analysis
with full coverage. That's really the only sensible approach.

> I have a RCU option for ftrace ops to set, if it requires RCU to be
> watching, and in that case, it wont call the callback if RCU is not
> watching.

That's nice but does not solve the problem.

>>    That's just a recipe for disaster. We really cannot request from
>>    sysadmins who want to use instrumentation to stare at the code first
>>    whether they can place/enable an instrumentation point somewhere.
>>    That'd be just a bad joke.
>> 
>>    I really think we need to have proper text sections which are off
>>    limit for any form of instrumentation and have tooling to analyze the
>>    calls into other sections. These calls need to be annotated as safe
>>    and intentional.
>> 
>> Thoughts?
>
> This can expand quite a bit. At least when I did something similar with
> NMIs, as there was a time I wanted to flag all places that could be called
> from NMI, and found that there's a lot of code that can be.
>
> I can imagine the same for marking nokprobes as well. And I really don't
> want to make all notrace stop tracing the entire function and all that it
> can call, as that will go back to removing all callers from NMIs as
> do_nmi() itself is notrace.

The point is that you have something like this:

section "text.offlimit"

nmi()
{
        do_fragile_stuff_on_enter();

        offlimit_safecall(do_some_instrumentable_stuff());

        do_fragile_stuff_on_exit();
}

section "text"

do_some_instrumentable_stuff()
{
}

So if someone adds another call

section "text.offlimit"

nmi()
{
        do_fragile_stuff_on_enter();

        offlimit_safecall(do_some_instrumentable_stuff());

        do_some_other_instrumentable_stuff();

        do_fragile_stuff_on_exit();
}

which is also in section "text" then the analysis tool will find the
missing offlimit_safecall() - or what ever method we chose to annotate
that stuff. Surely not an annotation on the called function itself
because that might be safe to call in one context but not in another.

These annotations are halfways easy to monitor for abuse and they should
be prominent enough in the code that at least for the people dealing
with that kind of code they act as a warning flag.

Thanks,

        tglx
