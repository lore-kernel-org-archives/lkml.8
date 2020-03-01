Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ECAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BC4246CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCASMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 13:12:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCASMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:12:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j8T4k-0006sF-B9; Sun, 01 Mar 2020 19:12:26 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 23F3E100EA2; Sun,  1 Mar 2020 19:12:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
References: <87imjofkhx.fsf@nanos.tec.linutronix.de> <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net> <87d09wf6dw.fsf@nanos.tec.linutronix.de> <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
Date:   Sun, 01 Mar 2020 19:12:25 +0100
Message-ID: <878skkeygm.fsf@nanos.tec.linutronix.de>
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
> On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Andy Lutomirski <luto@amacapital.net> writes:
>> >> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
>> >> except trace_hardirq_off/on() as those trace functions do not allow to
>> >> attach anything AFAICT.
>> >
>> > Can you point to whatever makes those particular functions special?  I
>> > failed to follow the macro maze.
>>
>> Those are not tracepoints and not going through the macro maze. See
>> kernel/trace/trace_preemptirq.c
>
> That has:
>
> void trace_hardirqs_on(void)
> {
>         if (this_cpu_read(tracing_irq_cpu)) {
>                 if (!in_nmi())
>                         trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>                 tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>                 this_cpu_write(tracing_irq_cpu, 0);
>         }
>
>         lockdep_hardirqs_on(CALLER_ADDR0);
> }
> EXPORT_SYMBOL(trace_hardirqs_on);
> NOKPROBE_SYMBOL(trace_hardirqs_on);
>
> But this calls trace_irq_enable_rcuidle(), and that's the part of the
> macro maze I got lost in.  I found:
>
> #ifdef CONFIG_TRACE_IRQFLAGS
> DEFINE_EVENT(preemptirq_template, irq_disable,
>              TP_PROTO(unsigned long ip, unsigned long parent_ip),
>              TP_ARGS(ip, parent_ip));
>
> DEFINE_EVENT(preemptirq_template, irq_enable,
>              TP_PROTO(unsigned long ip, unsigned long parent_ip),
>              TP_ARGS(ip, parent_ip));
> #else
> #define trace_irq_enable(...)
> #define trace_irq_disable(...)
> #define trace_irq_enable_rcuidle(...)
> #define trace_irq_disable_rcuidle(...)
> #endif
>
> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> where I got lost in the macro maze.  I looked at the gcc asm output,
> and there is, indeed:

DEFINE_EVENT
  DECLARE_TRACE
    __DECLARE_TRACE
       __DECLARE_TRACE_RCU
         static inline void trace_##name##_rcuidle(proto)
            __DO_TRACE
               if (rcuidle)
                  ....

> But I also don't see why this is any different from any other tracepoint.

Indeed. I took a wrong turn at some point in the macro jungle :)

So tracing itself is fine, but then if you have probes or bpf programs
attached to a tracepoint these use rcu_read_lock()/unlock() which is
obviosly wrong in rcuidle context.

Thanks,

        tglx
