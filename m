Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B26246B6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583088893;
	bh=BYvsTMF5iWMyl7cJ62zKTnOrq0LAxRDt7DQosTG9erg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=053klcgVB9XAnBEPPWr0aIslYNn7M9tGfm+VEC26cWok9AoD4Ngn5FnqGBOWTDmkV
	 Nyg73o9B/Vhln3jXG2GxyFGdTUc5zjRH0ZPingT6bqTbeDXPSJtZT1Igq4HiLya9aa
	 acbXKZ3jWwTDiDTzEzOomkrzl6wYIseve++5M3w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCASyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 13:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCASyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:54:37 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BC7246B6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Mar 2020 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583088876;
        bh=BYvsTMF5iWMyl7cJ62zKTnOrq0LAxRDt7DQosTG9erg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sf+3FX95OKtV0W37ogsvbV0GEHRcLLJo3uw50BgQliuQWLT9s3fGTrAJ6M/q0Ysia
         jQtr+Rwfpf450uoomSqrjT4L8qySQ8FRK/fBjSC5wJAtNs1uU0GL9pqR8+vaBtx3K8
         Dm813TN3y4rMBuBi6QobxNwvRA6/7Et18p66CCRU=
Received: by mail-wm1-f50.google.com with SMTP id p9so8799905wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 10:54:36 -0800 (PST)
X-Gm-Message-State: APjAAAXTckReo1OKIMb5uq42amf/Ou6a2auw8xXRsRc2S4lDaBUxbzFz
        N6gA4LOU5LVm1A02CRqEDzHx2qaSLYRp/38fPOnBIg==
X-Google-Smtp-Source: APXvYqzRswfUPKMKd0WLghsCuVO2iivtVrhi5HQZhLCrAJhxjOV04jCpcltAgACYYHqTxn/k16xwesjwyDBUsiO2bbo=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr14915299wme.36.1583088874896;
 Sun, 01 Mar 2020 10:54:34 -0800 (PST)
MIME-Version: 1.0
References: <87imjofkhx.fsf@nanos.tec.linutronix.de> <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
 <87d09wf6dw.fsf@nanos.tec.linutronix.de> <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
 <878skkeygm.fsf@nanos.tec.linutronix.de> <20200301182605.GT2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200301182605.GT2935@paulmck-ThinkPad-P72>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 1 Mar 2020 10:54:23 -0800
X-Gmail-Original-Message-ID: <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
Message-ID: <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:
> > Andy Lutomirski <luto@kernel.org> writes:
> > > On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> Andy Lutomirski <luto@amacapital.net> writes:
> > >> >> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> >> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> > >> >> except trace_hardirq_off/on() as those trace functions do not allow to
> > >> >> attach anything AFAICT.
> > >> >
> > >> > Can you point to whatever makes those particular functions special?  I
> > >> > failed to follow the macro maze.
> > >>
> > >> Those are not tracepoints and not going through the macro maze. See
> > >> kernel/trace/trace_preemptirq.c
> > >
> > > That has:
> > >
> > > void trace_hardirqs_on(void)
> > > {
> > >         if (this_cpu_read(tracing_irq_cpu)) {
> > >                 if (!in_nmi())
> > >                         trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> > >                 tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> > >                 this_cpu_write(tracing_irq_cpu, 0);
> > >         }
> > >
> > >         lockdep_hardirqs_on(CALLER_ADDR0);
> > > }
> > > EXPORT_SYMBOL(trace_hardirqs_on);
> > > NOKPROBE_SYMBOL(trace_hardirqs_on);
> > >
> > > But this calls trace_irq_enable_rcuidle(), and that's the part of the
> > > macro maze I got lost in.  I found:
> > >
> > > #ifdef CONFIG_TRACE_IRQFLAGS
> > > DEFINE_EVENT(preemptirq_template, irq_disable,
> > >              TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > >              TP_ARGS(ip, parent_ip));
> > >
> > > DEFINE_EVENT(preemptirq_template, irq_enable,
> > >              TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > >              TP_ARGS(ip, parent_ip));
> > > #else
> > > #define trace_irq_enable(...)
> > > #define trace_irq_disable(...)
> > > #define trace_irq_enable_rcuidle(...)
> > > #define trace_irq_disable_rcuidle(...)
> > > #endif
> > >
> > > But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> > > where I got lost in the macro maze.  I looked at the gcc asm output,
> > > and there is, indeed:
> >
> > DEFINE_EVENT
> >   DECLARE_TRACE
> >     __DECLARE_TRACE
> >        __DECLARE_TRACE_RCU
> >          static inline void trace_##name##_rcuidle(proto)
> >             __DO_TRACE
> >                if (rcuidle)
> >                   ....
> >
> > > But I also don't see why this is any different from any other tracepoint.
> >
> > Indeed. I took a wrong turn at some point in the macro jungle :)
> >
> > So tracing itself is fine, but then if you have probes or bpf programs
> > attached to a tracepoint these use rcu_read_lock()/unlock() which is
> > obviosly wrong in rcuidle context.
>
> Definitely, any such code needs to use tricks similar to that of the
> tracing code.  Or instead use something like SRCU, which is OK with
> readers from idle.  Or use something like Steve Rostedt's workqueue-based
> approach, though please be very careful with this latter, lest the
> battery-powered embedded guys come after you for waking up idle CPUs
> too often.  ;-)
>

Are we okay if we somehow ensure that all the entry code before
enter_from_user_mode() only does rcuidle tracing variants and has
kprobes off?  Including for BPF use cases?

It would be *really* nice if we could statically verify this, as has
been mentioned elsewhere in the thread.  It would also probably be
good enough if we could do it at runtime.  Maybe with lockdep on, we
verify rcu state in tracepoints even if the tracepoint isn't active?
And we could plausibly have some widget that could inject something
into *every* kprobeable function to check rcu state.

--Andy
