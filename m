Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0058C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEB121D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCJQtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:49:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:49:05 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBi3h-0007Lw-Qi; Tue, 10 Mar 2020 17:48:45 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7040C1040A5; Tue, 10 Mar 2020 17:48:45 +0100 (CET)
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
In-Reply-To: <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <871rq171ca.fsf@nanos.tec.linutronix.de> <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com>
Date:   Tue, 10 Mar 2020 17:48:45 +0100
Message-ID: <87imjc5f6a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On Mar 9, 2020, at 3:52 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> In a quick test I did with a invalid syscall number with profiling the
>> trace_hardirqs_off() is pretty prominent and goes down by roughly a
>> factor of 2 when I move it past enter_from_user_mode() and use just the
>> non RCU idle variant.
>
> I think one issue here is that trace_hardirqs_off() is now shared between
> lockdep and tracing. For lockdep, we have the following comment:
>
>         /*
>          * IRQ from user mode.
>          *
>          * We need to tell lockdep that IRQs are off.  We can't do this until
>          * we fix gsbase, and we should do it before enter_from_user_mode
>          * (which can take locks).  Since TRACE_IRQS_OFF is idempotent,
>          * the simplest way to handle it is to just call it twice if
>          * we enter from user mode.  There's no reason to optimize this since
>          * TRACE_IRQS_OFF is a no-op if lockdep is off.
>          */
>         TRACE_IRQS_OFF
>
>         CALL_enter_from_user_mode
>
> 1:
>         ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
>         /* We entered an interrupt context - irqs are off: */
>         TRACE_IRQS_OFF
>
> which seems to imply that lockdep requires TRACE_IRQS_OFF to be performed
> _before_ entering from usermode. I don't expect this to be useful at all for
> other tracers though. I think this should be replaced by a new e.g.
> LOCKDEP_ENTER_FROM_USER_MODE or such which would call into lockdep without
> calling other tracers.

See the entry series I'm working on. Aside of moving all this nonsense
into C-code it splits lockdep and tracing so it looks like this:

            lockdep_hardirqs_off();
            user_exit_irqsoff();
            __trace_hardirqs_off();

The latter uses regular RCU and not the scru/rcu_irq dance.

>> Right, but that still does the whole rcu_irq dance especially in the
>> entry code just to trace 50 or 100 instructions which are turning on RCU
>> anyway.
>
> Agreed. Would changing this to a lockdep-specific call as I suggest above
> solve this ?

That split exist for a few weeks now at least in my patches :)

>>> If a tracer recurses, or if a tracer attempts to trace another tracer, the
>>> instrumentation would break the recursion chain by preventing instrumentation
>>> from firing. If we end up caring about tracers tracing other tracers, we could
>>> have one distinct flag per tracer and let each tracer break the recursion chain.
>>>
>>> Having this flag per kernel stack rather than per CPU or per thread would
>>> allow tracing of nested interrupt handlers (and NMIs), but would break
>>> call chains both within the same stack or going through a trap. I think
>>> it could be a nice complementary safety net to handle mishaps in a non-fatal
>>> way.
>> 
>> That works as long as none of this uses breakpoint based patching to
>> dynamically disable/enable stuff.
>
> I'm clearly missing something here. I was expecting the "in_tracing" flag trick
> to be able to fix the breakpoint recursion issue. What is the problem I'm missing
> here ?

How do you "fix" that when you can't reach the tracepoint because you
trip over a breakpoint and then while trying to fixup that stuff you hit
another one?

Thanks,

        tglx
