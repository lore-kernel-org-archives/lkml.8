Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9451CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A032137B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589171668;
	bh=8cxkOBY+9EGYNdm5+60pMObgZTrCL4Ui1+VzaqkIpZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RysKIW3sZKz0jaFEydlCBlNCjntNrtt/c8EZ/zuGrJQz6PK7htYNd9g4JHhp4IBDn
	 Io1Or8XJkkxn+MEyKNmOCh7vZaaYt6CJevl/8vxq4wUceZmXgb1feXrbidQQR783kp
	 f9KJBQRtSsxt+k0JOu7B3c2IgXus0hRK6+7e7oLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEKEe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgEKEe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:34:27 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FEF2184D
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589171666;
        bh=8cxkOBY+9EGYNdm5+60pMObgZTrCL4Ui1+VzaqkIpZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=icHPgs+m3HthZ5wt9gM3yK9UF6VIeTCPc/3n+R/liPRL9TH15bTwljCaz9WVGa7Sj
         n5vXV4iFfNa7F1nFipQnqQqo3xAeBC8PGE3Wxwj+YzWH4ujfXeU4UbRrMahYqAf+xx
         xgBe9wgam+nTQ6RgO+y/0DJXjydPuiL5g8vZq4JI=
Received: by mail-wr1-f46.google.com with SMTP id i15so9095794wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 21:34:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuYjLv5LYdRU8P7aG+xzw6fGOIG9QrI3TgJHHxrB7E1W156jRDh+
        7zjDT53xvi2kJI8ZaRf1uO6KhIuBOkpWAf+/1ydjzQ==
X-Google-Smtp-Source: APiQypLOI0V0OjmUYoU5+bXZs9UBJ7YTup8v3BS8zzZtKeow7wSPauRIgVPZNzMKVpyNW6DRZKQzRLnLSBWR5JD5NBI=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr16355884wrs.257.1589171664822;
 Sun, 10 May 2020 21:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de>
In-Reply-To: <20200505134904.457578656@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 May 2020 21:34:13 -0700
X-Gmail-Original-Message-ID: <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com>
Message-ID: <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com>
Subject: Re: [patch V4 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Provide functions which handle the low level entry and exit similiar to
> enter/exit from user mode.
>

> +
> +/**
> + * idtentry_exit - Common code to handle return from exceptions
> + * @regs:      Pointer to pt_regs (exception entry regs)
> + *
> + * Depending on the return target (kernel/user) this runs the necessary
> + * preemption and work checks if possible and reguired and returns to
> + * the caller with interrupts disabled and no further work pending.
> + *
> + * This is the last action before returning to the low level ASM code which
> + * just needs to return to the appropriate context.
> + *
> + * Invoked by all exception/interrupt IDTENTRY handlers which are not
> + * returning through the paranoid exit path (all except NMI, #DF and the IST
> + * variants of #MC and #DB).

The paranoid-exit bit is not really relevant.  The important part is
which stack we're on.  See below.

> + */
> +void noinstr idtentry_exit(struct pt_regs *regs)
> +{
> +       lockdep_assert_irqs_disabled();

How about:

#ifdef CONFIG_DEBUG_ENTRY
WARN_ON_ONCE(!on_thread_stack());
#endif

> +
> +       /* Check whether this returns to user mode */
> +       if (user_mode(regs)) {
> +               prepare_exit_to_usermode(regs);
> +       } else if (regs->flags & X86_EFLAGS_IF) {
> +               /* Check kernel preemption, if enabled */
> +               if (IS_ENABLED(CONFIG_PREEMPTION)) {
> +                       /*
> +                        * This needs to be done very carefully.
> +                        * idtentry_enter() invoked rcu_irq_enter(). This
> +                        * needs to undone before scheduling.
> +                        *
> +                        * Preemption is disabled inside of RCU idle
> +                        * sections. When the task returns from
> +                        * preempt_schedule_irq(), RCU is still watching.
> +                        *
> +                        * rcu_irq_exit_preempt() has additional state
> +                        * checking if CONFIG_PROVE_RCU=y
> +                        */
> +                       if (!preempt_count()) {
> +                               instr_begin();
> +                               rcu_irq_exit_preempt();
> +                               if (need_resched())
> +                                       preempt_schedule_irq();

This is an excellent improvement.  Thanks!

> +                               /* Covers both tracing and lockdep */
> +                               trace_hardirqs_on();
> +                               instr_end();
> +                               return;
> +                       }
> +               }
> +               instr_begin();
> +               /* Tell the tracer that IRET will enable interrupts */
> +               trace_hardirqs_on_prepare();

Why is trace_hardirqs_on() okay above but not here?  Is it that we
know we weren't RCU-quiescent if we had preemption and IF on?  But
even this code path came from an IF-on context.  I'm confused.  Maybe
some comments as to why this case seems to be ordered so differently
from the !preempt_count() case would be helpful.

> +               lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> +               instr_end();
> +               rcu_irq_exit();
> +               lockdep_hardirqs_on(CALLER_ADDR0);
> +       } else {
> +               /* IRQ flags state is correct already. Just tell RCU */
> +               rcu_irq_exit();
> +       }
> +}
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -7,6 +7,9 @@
>
>  #ifndef __ASSEMBLY__
>
> +void idtentry_enter(struct pt_regs *regs);
> +void idtentry_exit(struct pt_regs *regs);
> +
>  /**
>   * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>   *                   No error code pushed by hardware
>
