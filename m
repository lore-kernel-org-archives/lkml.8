Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29591C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OhCbVkDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCISmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:42:42 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44962 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:42:42 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so9638949ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1cHoYe2u9DgToST9hIQjGF/Rfj9S0TnVh78F/vig4c=;
        b=OhCbVkDBy0ULrp7f5nJtRTxtwLXpCDrKy9CwNdVkF+E9kFFQCoodqc/q8eaGTUvXeU
         waOxFZr4ccv4BliwKQhUJmvX66JnDRetyd/KZYgSSMyzXmH4EA/KagRjSnxdYwx4osT8
         wTNvMvXOcvTQR71UyszaDexVi9ZuPJUMWs5lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1cHoYe2u9DgToST9hIQjGF/Rfj9S0TnVh78F/vig4c=;
        b=KsJHbIXvKziPuLqeVY/V71IiDfMl59wphfVXnxmgJX1XVG27ewCNEuBy7uMOI3dN3Q
         ye/sZaz4MxzOLWg2eiVKDY/Po153v8Sq8ZKSXp466DS1SFA03Bivn8R4wthBAkEZocEY
         NGAjMwat0hWj/hWl2q61HA10Ee1TMpAA1dMhd86n5vj0ow2KSFVbBCZkdcFZ09nx/Guu
         F+SyNhOEqgO28ONqnBnNeC8AmHhVgvjN03u3r4WWrjOFZ15qvRyFpy62vQZakys+ycVI
         EOfAaSbHD5T6RIM97mWEXAvpqTtl+8l4X+OiP65g6ovHa/GmileUlleuXZOeyL7IW5Vv
         74/w==
X-Gm-Message-State: ANhLgQ0BWuYSD5/HqFeLzhqtoifjlyNOh5/DaVbX+oZlhLBGndroJHNH
        NUGwvr4ArRti8uGVXddanm4rms0225iW22qGtDJgoewQnHvJmQ==
X-Google-Smtp-Source: ADFU+vvA6HxLOy/oeFCpBj4O30gvqDYIbi0eiMwDGOtJLHWOnA458P5IKf0zXNlsuDVhKOFPpwiuoxfk2a5S7fn0gzM=
X-Received: by 2002:a92:8901:: with SMTP id n1mr17948317ild.176.1583779360390;
 Mon, 09 Mar 2020 11:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home>
In-Reply-To: <20200309141546.5b574908@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 9 Mar 2020 11:42:28 -0700
Message-ID: <CAEXW_YQJ=vGxn5P=OtdkJT4NwE9+P0rAPEEQFdAUtyZ9Ck=qug@mail.gmail.com>
Subject: Re: Instrumentation and RCU
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 11:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 09 Mar 2020 18:02:32 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
> > #3) RCU idle
> >
> >     Being able to trace code inside RCU idle sections is very similar to
> >     the question raised in #1.
> >
> >     Assume all of the instrumentation would be doing conditional RCU
> >     schemes, i.e.:
> >
> >     if (rcuidle)
> >       ....
> >     else
> >         rcu_read_lock_sched()
> >
> >     before invoking the actual instrumentation functions and of course
> >     undoing that right after it, that really begs the question whether
> >     it's worth it.
> >
> >     Especially constructs like:
> >
> >     trace_hardirqs_off()
> >        idx = srcu_read_lock()
> >        rcu_irq_enter_irqson();
> >        ...
> >        rcu_irq_exit_irqson();
> >        srcu_read_unlock(idx);
> >
> >     if (user_mode)
> >        user_exit_irqsoff();
> >     else
> >        rcu_irq_enter();
> >
> >     are really more than questionable. For 99.9999% of instrumentation
> >     users it's absolutely irrelevant whether this traces the interrupt
> >     disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
> >
> >     But what's relevant is the tracer overhead which is e.g. inflicted
> >     with todays trace_hardirqs_off/on() implementation because that
> >     unconditionally uses the rcuidle variant with the scru/rcu_irq dance
> >     around every tracepoint.
> >
> >     Even if the tracepoint sits in the ASM code it just covers about ~20
> >     low level ASM instructions more. The tracer invocation, which is
> >     even done twice when coming from user space on x86 (the second call
> >     is optimized in the tracer C-code), costs definitely way more
> >     cycles. When you take the scru/rcu_irq dance into account it's a
> >     complete disaster performance wise.
>
> Is this specifically to do with the kernel/trace/trace_preemptirqs.c code
> that was added by Joel?

Just started a vacation here and will be back on January 12th. Will
take a detailed look at Thomas's email at that time.

Adding some more folks (Daniel, Valentin) who have used the
preempt/irq tracepoints.

I agree we should reorder things and avoid these circular
dependencies, it bothers me too. I am happy to help with any clean ups
related to it. Let us definitely discuss more and fix it. Thanks.

- Joel
