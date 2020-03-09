Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBBC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A17724654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCITwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:52:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCITwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:52:33 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBORp-0006n7-VS; Mon, 09 Mar 2020 20:52:22 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1F1F510409D; Mon,  9 Mar 2020 20:52:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
In-Reply-To: <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
Date:   Mon, 09 Mar 2020 20:52:21 +0100
Message-ID: <871rq171ca.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On Mar 9, 2020, at 1:02 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> #1 Fragile low level entry code
>> 
>>   While I understand the desire of instrumentation to observe
>>   everything we really have to ask the question whether it is worth the
>>   trouble especially with entry trainwrecks like x86, PTI and other
>>   horrors in that area.
>> 
>>   I don't think so and we really should just bite the bullet and forbid
>>   any instrumentation in that code unless it is explicitly designed
>>   for that case, makes sense and has a real value from an observation
>>   perspective.
>> 
>>   This is very much related to #3..
>
> Do I understand correctly that you intend on moving all kernel low level
> entry/exit code into sections which cannot be instrumented by kprobes nor
> the function tracer, and require explicit whitelisting, either through
> annotations or use of explicit tracepoints ?

Pretty much so.

>> #2) Breakpoint utilization
>> 
>>    As recent findings have shown, breakpoint utilization needs to be
>>    extremly careful about not creating infinite breakpoint recursions.
>> 
>>    I think that's pretty much obvious, but falls into the overall
>>    question of how to protect callchains.
>
> I think there is another question that arises here: the lack of automated
> continuous testing of the kprobes coverage. We have performed some testing of
> various random permutations of kprobes instrumentation, and have succeeded in
> crashing the kernel in various ways. Unfortunately, that testing is not done
> on a continuous basis, and maintainers understandably have little spare time
> to play the whack-a-mole game of adding missing nokprobes annotations as
> the kernel code evolves.

That's why I think a section approach is more practicable.
 
>> #3) RCU idle
>>    are really more than questionable. For 99.9999% of instrumentation
>>    users it's absolutely irrelevant whether this traces the interrupt
>>    disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
>> 
>>    But what's relevant is the tracer overhead which is e.g. inflicted
>>    with todays trace_hardirqs_off/on() implementation because that
>>    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
>>    around every tracepoint.
>
> I think one of the big issues here is that most of the uses of
> trace_hardirqs_off() are from sites which already have RCU watching,
> so we are doing heavy-weight operations for nothing.

That and in some places in the entry code we do the heavy weight
operations to cover 100 instructions which turn on RCU anyway. That does
not make any sense at all.

> I strongly suspect that most of the overhead we've been trying to avoid when
> introducing use of SRCU in rcuidle tracepoints was actually caused by callsites
> which use rcuidle tracepoints while having RCU watching, just because there is a
> handful of callsites which don't have RCU watching. This is confirmed
> by the commit message of commit e6753f23d9 "tracepoint: Make rcuidle
> tracepoint callers use SRCU":
>
>    "In recent tests with IRQ on/off tracepoints, a large performance
>     overhead ~10% is noticed when running hackbench. This is root caused to
>     calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
>     tracepoint code. Following a long discussion on the list [1] about this,
>     we concluded that srcu is a better alternative for use during rcu idle.
>     Although it does involve extra barriers, its lighter than the sched-rcu
>     version which has to do additional RCU calls to notify RCU idle about
>     entry into RCU sections.
> [...]
>     Test: Tested idle and preempt/irq tracepoints."

In a quick test I did with a invalid syscall number with profiling the
trace_hardirqs_off() is pretty prominent and goes down by roughly a
factor of 2 when I move it past enter_from_user_mode() and use just the
non RCU idle variant.

> So I think we could go back to plain RCU for rcuidle tracepoints if we do
> the cheaper "rcu_is_watching()" check rather than invoking
> rcu_irq_{enter,exit}_irqson() unconditionally.

Haven't tried that yet for the overall usage of trace_hardirqs_off(),
but yes, it's going to be a measurable difference.

>>    Even if the tracepoint sits in the ASM code it just covers about ~20
>>    low level ASM instructions more. The tracer invocation, which is
>>    even done twice when coming from user space on x86 (the second call
>>    is optimized in the tracer C-code), costs definitely way more
>>    cycles. When you take the scru/rcu_irq dance into account it's a
>>    complete disaster performance wise.
>
> Part of the issue here is the current overhead of SRCU read-side lock,
> which contains memory barriers. The other part of the issue is the fact that
> rcu_irq_{enter,exit}_irqson() contains an atomic_add_return atomic instruction.
>
> We could use the approach proposed by Peterz's and Steven's patches to basically
> do a lightweight "is_rcu_watching()" check for rcuidle tracepoint, and only enable
> RCU for those cases. We could then simply go back on using regular RCU
> like so:

Right, but that still does the whole rcu_irq dance especially in the
entry code just to trace 50 or 100 instructions which are turning on RCU
anyway.

>> #4 Protecting call chains
>> 
>>   Our current approach of annotating functions with notrace/noprobe is
>>   pretty much broken.
>> 
>>   Functions which are marked NOPROBE or notrace call out into functions
>>   which are not marked and while this might be ok, there are enough
>>   places where it is not. But we have no way to verify that.
>> 
>>   That's just a recipe for disaster. We really cannot request from
>>   sysadmins who want to use instrumentation to stare at the code first
>>   whether they can place/enable an instrumentation point somewhere.
>>   That'd be just a bad joke.
>> 
>>   I really think we need to have proper text sections which are off
>>   limit for any form of instrumentation and have tooling to analyze the
>>   calls into other sections. These calls need to be annotated as safe
>>   and intentional.
>
> If we go all the way into that direction, I suspect it might even make sense
> to duplicate some kernel functions so they can still be part of the code which
> can be instrumented, but provide tracing-specific copy which would be hidden
> from instrumentation. I wonder what would be the size cost of this
> duplication.

That might happen, but we'll see how much of that is truly
requried. It's not horrible large. For the int3 isolation most of it was
fixing up code which should have been protected in the first place and
the only copied code was bsearch which is tiny.

> In addition to splitting tracing code into a separate section, which I think
> makes sense, I can think of another alternative way to provide call chains
> protection: adding a "in_tracing" flag somewhere alongside each kernel stack.
> Each thread and interrupt stack would have its own flag. However, trap handlers
> should share the "in_tracing" flag with the context which triggers the trap.
>
> If a tracer recurses, or if a tracer attempts to trace another tracer, the
> instrumentation would break the recursion chain by preventing instrumentation
> from firing. If we end up caring about tracers tracing other tracers, we could
> have one distinct flag per tracer and let each tracer break the recursion chain.
>
> Having this flag per kernel stack rather than per CPU or per thread would
> allow tracing of nested interrupt handlers (and NMIs), but would break
> call chains both within the same stack or going through a trap. I think
> it could be a nice complementary safety net to handle mishaps in a non-fatal
> way.

That works as long as none of this uses breakpoint based patching to
dynamically disable/enable stuff.

Thanks,

        tglx




