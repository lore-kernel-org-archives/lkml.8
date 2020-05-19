Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA5220709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589907982;
	bh=Q+yrETbVImO1E5Xvyhq3XAyizDi41LibvtObQeK03Q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rp4fqk+/5rvyQKee9SsI62a5IVjuM//JF1o3aii0vpPpmz86cqL3tG9HZ5juutaQX
	 HMCo2p0DKmOpZiAIYHUnTlSL0TAVp7EBbOnfG4ZZ0jWxYpvrZLgMZ021Jr6hEBSYHq
	 Z+/PBncjh83BhYlaLfmlOeJBefYKJlu7OjqcrI90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgESRGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESRGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:06:20 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4188420826
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907979;
        bh=Q+yrETbVImO1E5Xvyhq3XAyizDi41LibvtObQeK03Q0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e3AorEdhRH5pQTVmMXn9LIm3tOxiXnkrq/uw/M00hNk4fI7d6UcAYSNNzlXJqfXcE
         WC+lE4+dV/gW8rOQq8xTdI8s0JsRfy4TdLAmx8UT3PlrVkZiRGkrwYsjDwESrMYuOb
         4lMIpqm0TldqYKAkft9oaC7hxQtYLMMs8eLTBVoo=
Received: by mail-wr1-f45.google.com with SMTP id e1so225124wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:06:19 -0700 (PDT)
X-Gm-Message-State: AOAM530iGYI/vyc87Ywjxm4Z9gRHO3sK8Up0bsOetajk1AYNYTd1qO/G
        gtfaCFS+8kYFbe9hRSneV21WA4+QZfOeVY8oavDJAA==
X-Google-Smtp-Source: ABdhPJx1TJE66DkJfkY22rX7u//Gom5Ja6RkgtRBzy8FWG93dfL2Z9pXyiFp5KeRclMfGPXyBsMK9Fv5WRdUvs5Po5c=
X-Received: by 2002:adf:a389:: with SMTP id l9mr27181359wrb.18.1589907977639;
 Tue, 19 May 2020 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de>
In-Reply-To: <20200515235125.425810667@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 10:06:05 -0700
X-Gmail-Original-Message-ID: <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
Message-ID: <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Convert the XEN/PV hypercall to IDTENTRY:
>
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Remove the old prototypes
>
> The handler stubs need to stay in ASM code as it needs corner case handling
> and adjustment of the stack pointer.
>
> Provide a new C function which invokes the entry/exit handling and calls
> into the XEN handler on the interrupt stack.
>
> The exit code is slightly different from the regular idtentry_exit() on
> non-preemptible kernels. If the hypercall is preemptible and need_resched()
> is set then XEN provides a preempt hypercall scheduling function. Add it as
> conditional path to __idtentry_exit() so the function can be reused.
>
> __idtentry_exit() is forced inlined so on the regular idtentry_exit() path
> the extra condition is optimized out by the compiler.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 882ada245bd5..34caf3849632 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -27,6 +27,9 @@
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>
> +#include <xen/xen-ops.h>
> +#include <xen/events.h>
> +
>  #include <asm/desc.h>
>  #include <asm/traps.h>
>  #include <asm/vdso.h>
> @@ -35,6 +38,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/io_bitmap.h>
>  #include <asm/syscall.h>
> +#include <asm/irq_stack.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
> @@ -539,7 +543,8 @@ void noinstr idtentry_enter(struct pt_regs *regs)
>         }
>  }
>
> -static __always_inline void __idtentry_exit(struct pt_regs *regs)
> +static __always_inline void __idtentry_exit(struct pt_regs *regs,
> +                                           bool preempt_hcall)
>  {
>         lockdep_assert_irqs_disabled();
>
> @@ -573,6 +578,16 @@ static __always_inline void __idtentry_exit(struct pt_regs *regs)
>                                 instrumentation_end();
>                                 return;
>                         }
> +               } else if (IS_ENABLED(CONFIG_XEN_PV)) {
> +                       if (preempt_hcall) {
> +                               /* See CONFIG_PREEMPTION above */
> +                               instrumentation_begin();
> +                               rcu_irq_exit_preempt();
> +                               xen_maybe_preempt_hcall();
> +                               trace_hardirqs_on();
> +                               instrumentation_end();
> +                               return;
> +                       }

Ewwwww!  This shouldn't be taken as a NAK -- it's just an expression of disgust.

>                 }
>                 /*
>                  * If preemption is disabled then this needs to be done
> @@ -612,5 +627,43 @@ static __always_inline void __idtentry_exit(struct pt_regs *regs)
>   */
>  void noinstr idtentry_exit(struct pt_regs *regs)
>  {
> -       __idtentry_exit(regs);
> +       __idtentry_exit(regs, false);
> +}
> +
> +#ifdef CONFIG_XEN_PV
> +static void __xen_pv_evtchn_do_upcall(void)
> +{
> +       irq_enter_rcu();
> +       inc_irq_stat(irq_hv_callback_count);
> +
> +       xen_hvm_evtchn_do_upcall();
> +
> +       irq_exit_rcu();
> +}
> +
> +__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
> +{
> +       struct pt_regs *old_regs;
> +
> +       idtentry_enter(regs);
> +       old_regs = set_irq_regs(regs);
> +
> +       if (!irq_needs_irq_stack(regs)) {
> +               instrumentation_begin();
> +               __xen_pv_evtchn_do_upcall();
> +               instrumentation_end();
> +       } else {
> +               run_on_irqstack(__xen_pv_evtchn_do_upcall, NULL);
> +       }

Shouldn't this be:

instrumentation_begin();
if (!irq_needs_irq_stack(...))
  __blah();
else
  run_on_irqstack(__blah, NULL);
instrumentation_end();

or even:

instrumentation_begin();
run_on_irqstack_if_needed(__blah, NULL);
instrumentation_end();


****** BUT *******

I think this is all arse-backwards.  This is a giant mess designed to
pretend we support preemption and to emulate normal preemption in a
non-preemptible kernel.  I propose one to two massive cleanups:

A: Just delete all of this code.  Preemptible hypercalls on
non-preempt kernels will still process interrupts but won't get
preempted.  If you want preemption, compile with preemption.

B: Turn this thing around.  Specifically, in the one and only case we
care about, we know pretty much exactly what context we got this entry
in: we're running in a schedulable context doing an explicitly
preemptible hypercall, and we have RIP pointing at a SYSCALL
instruction (presumably, but we shouldn't bet on it) in the hypercall
page.  Ideally we would change the Xen PV ABI so the hypercall would
return something like EAGAIN instead of auto-restarting and we could
ditch this mess entirely.  But the ABI seems to be set in stone or at
least in molasses, so how about just:

idt_entry(exit(regs));
if (inhcall && need_resched())
  schedule();

Off the top of my head, I don't see any reason this wouldn't work, and
it's a heck of a lot cleaner.  Possibly it should really be:

if (inhcall) {
  if (!WARN_ON(regs->ip not in hypercall page))
    cond_resched();
}
