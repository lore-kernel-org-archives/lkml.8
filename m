Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A15C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B11F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hdnZxgJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCJPDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:03:18 -0400
Received: from mail.efficios.com ([167.114.26.124]:51774 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:03:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CBB212703B2;
        Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gdOHo5P8aAL2; Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3E5122703B1;
        Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3E5122703B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583852595;
        bh=0dlIWC/Uel9bUWnObZ4STLaOrPOFsJD6lnPz6Zv3Cn4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hdnZxgJ+I3BKZRulYLNXDQ7lBM7XwiU3wbaSXn7JHZhSfNxaWaYetJbOyEC4qmozP
         MCIlj3KPIpyN5ucm3/to39ovCO49GqMOskotbF9bB2oePhDgYLc5Ak/m4Ifz2krXzV
         sphhL4g7yN8mRetNm+hba3LY2yTKLZ8v385eikyLLZkGThp5PPAjAR7hADdiXtgSlw
         UGj87m77AiqXv7XWpyo671EhM8GJ1WLL80S4amOWeFIFbhjwPEztSXJLygHOgzzgyD
         0RfqNI27eBBnc7zxUHNvRiIVkAf3pNlHMkKAa1i/c+myVYFLDnkNQ+fdqXmTR0UJ3B
         9WfBe3+SXm++Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2V2z5rhnD5pm; Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 23E612703B0;
        Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
Date:   Tue, 10 Mar 2020 11:03:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com>
In-Reply-To: <871rq171ca.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <871rq171ca.fsf@nanos.tec.linutronix.de>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: lfQf50G3B2kkQCcrHRiRh26RBEBatA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 9, 2020, at 3:52 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> ----- On Mar 9, 2020, at 1:02 PM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> 
>>> #3) RCU idle
>>>    are really more than questionable. For 99.9999% of instrumentation
>>>    users it's absolutely irrelevant whether this traces the interrupt
>>>    disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
>>> 
>>>    But what's relevant is the tracer overhead which is e.g. inflicted
>>>    with todays trace_hardirqs_off/on() implementation because that
>>>    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
>>>    around every tracepoint.
>>
>> I think one of the big issues here is that most of the uses of
>> trace_hardirqs_off() are from sites which already have RCU watching,
>> so we are doing heavy-weight operations for nothing.
> 
> That and in some places in the entry code we do the heavy weight
> operations to cover 100 instructions which turn on RCU anyway. That does
> not make any sense at all.
> 
>> I strongly suspect that most of the overhead we've been trying to avoid when
>> introducing use of SRCU in rcuidle tracepoints was actually caused by callsites
>> which use rcuidle tracepoints while having RCU watching, just because there is a
>> handful of callsites which don't have RCU watching. This is confirmed
>> by the commit message of commit e6753f23d9 "tracepoint: Make rcuidle
>> tracepoint callers use SRCU":
>>
>>    "In recent tests with IRQ on/off tracepoints, a large performance
>>     overhead ~10% is noticed when running hackbench. This is root caused to
>>     calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
>>     tracepoint code. Following a long discussion on the list [1] about this,
>>     we concluded that srcu is a better alternative for use during rcu idle.
>>     Although it does involve extra barriers, its lighter than the sched-rcu
>>     version which has to do additional RCU calls to notify RCU idle about
>>     entry into RCU sections.
>> [...]
>>     Test: Tested idle and preempt/irq tracepoints."
> 
> In a quick test I did with a invalid syscall number with profiling the
> trace_hardirqs_off() is pretty prominent and goes down by roughly a
> factor of 2 when I move it past enter_from_user_mode() and use just the
> non RCU idle variant.

I think one issue here is that trace_hardirqs_off() is now shared between
lockdep and tracing. For lockdep, we have the following comment:

        /*
         * IRQ from user mode.
         *
         * We need to tell lockdep that IRQs are off.  We can't do this until
         * we fix gsbase, and we should do it before enter_from_user_mode
         * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
         * the simplest way to handle it is to just call it twice if
         * we enter from user mode.  There's no reason to optimize this since
         * TRACE_IRQS_OFF is a no-op if lockdep is off.
         */
        TRACE_IRQS_OFF

        CALL_enter_from_user_mode

1:
        ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
        /* We entered an interrupt context - irqs are off: */
        TRACE_IRQS_OFF

which seems to imply that lockdep requires TRACE_IRQS_OFF to be performed
_before_ entering from usermode. I don't expect this to be useful at all for
other tracers though. I think this should be replaced by a new e.g.
LOCKDEP_ENTER_FROM_USER_MODE or such which would call into lockdep without
calling other tracers.

> 
>> So I think we could go back to plain RCU for rcuidle tracepoints if we do
>> the cheaper "rcu_is_watching()" check rather than invoking
>> rcu_irq_{enter,exit}_irqson() unconditionally.
> 
> Haven't tried that yet for the overall usage of trace_hardirqs_off(),
> but yes, it's going to be a measurable difference.

Ideally we should do both: change the TRACE_IRQS_OFF prior entering from usermode
for a lockdep-specific call, which would remove the frequent case which requires
temporarily enabling RCU, *and* change tracepoints to use rcu_is_watching(),
temporarily enable RCU, and use standard RCU for rcuidle cases.

> 
>>>    Even if the tracepoint sits in the ASM code it just covers about ~20
>>>    low level ASM instructions more. The tracer invocation, which is
>>>    even done twice when coming from user space on x86 (the second call
>>>    is optimized in the tracer C-code), costs definitely way more
>>>    cycles. When you take the scru/rcu_irq dance into account it's a
>>>    complete disaster performance wise.
>>
>> Part of the issue here is the current overhead of SRCU read-side lock,
>> which contains memory barriers. The other part of the issue is the fact that
>> rcu_irq_{enter,exit}_irqson() contains an atomic_add_return atomic instruction.
>>
>> We could use the approach proposed by Peterz's and Steven's patches to basically
>> do a lightweight "is_rcu_watching()" check for rcuidle tracepoint, and only
>> enable
>> RCU for those cases. We could then simply go back on using regular RCU
>> like so:
> 
> Right, but that still does the whole rcu_irq dance especially in the
> entry code just to trace 50 or 100 instructions which are turning on RCU
> anyway.

Agreed. Would changing this to a lockdep-specific call as I suggest above
solve this ?

> 
>>> #4 Protecting call chains
[...]
> 
>> In addition to splitting tracing code into a separate section, which I think
>> makes sense, I can think of another alternative way to provide call chains
>> protection: adding a "in_tracing" flag somewhere alongside each kernel stack.
>> Each thread and interrupt stack would have its own flag. However, trap handlers
>> should share the "in_tracing" flag with the context which triggers the trap.
>>
>> If a tracer recurses, or if a tracer attempts to trace another tracer, the
>> instrumentation would break the recursion chain by preventing instrumentation
>> from firing. If we end up caring about tracers tracing other tracers, we could
>> have one distinct flag per tracer and let each tracer break the recursion chain.
>>
>> Having this flag per kernel stack rather than per CPU or per thread would
>> allow tracing of nested interrupt handlers (and NMIs), but would break
>> call chains both within the same stack or going through a trap. I think
>> it could be a nice complementary safety net to handle mishaps in a non-fatal
>> way.
> 
> That works as long as none of this uses breakpoint based patching to
> dynamically disable/enable stuff.

I'm clearly missing something here. I was expecting the "in_tracing" flag trick
to be able to fix the breakpoint recursion issue. What is the problem I'm missing
here ?

An additional point about splitting core code into separate non-instrumentable
sections: The part I'm concerned about is instrumentation of trap handlers.
_That_ will likely need to remain shared between the kernel and the tracers.
This is where I think the "in_tracing" flag approach would help us solve the
recursion issue without losing that important instrumentation coverage.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
