Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F3C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D975E20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgG0NxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgG0NxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:53:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D508206E7;
        Mon, 27 Jul 2020 13:53:09 +0000 (UTC)
Date:   Mon, 27 Jul 2020 09:53:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200727095306.7f369949@oasis.local.home>
In-Reply-To: <20200726155148.GA9341@ubuntu>
References: <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
        <20200724123528.36ea9c9e@oasis.local.home>
        <20200724171418.GB3123@ubuntu>
        <20200724133656.76c75629@oasis.local.home>
        <20200724134020.3160dc7c@oasis.local.home>
        <20200724175500.GD3123@ubuntu>
        <20200724143457.27755412@oasis.local.home>
        <20200725150914.GA3362@ubuntu>
        <20200726155148.GA9341@ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 17:52:42 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> > If I try to do this I will need some help. Some info that point me to the
> > right direction would be greatly appreciated. Some advice about what
> > functions I will need to implement would be really helpfull. Or point me
> > to the right piece of code that I can pick as base point.  
> 
> I've been searching and reading the code as much as possible. I've found
> two patches that I think can be useful to guide me. One [1] adds support
> for ftrace_ops to the riscv architecture. The other one [2] adds support
> for ftrace_ops to the parisc architecture.
> 
> [1] commit 71e736a7d655 ("riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support")
> [2] commit d562aca37a54 ("parisc/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support")
> 
> Due to powerpc arch calls the needed functions from assembly, I based my
> idea on the patch for the RISCV arch.
> 
> Can something like the following work?
> 
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index bc76970b6ee5..1c51ff5afae1 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -61,9 +61,8 @@ struct dyn_arch_ftrace {
>  };
>  #endif /* __ASSEMBLY__ */
> 
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
> -#endif
> +
>  #endif /* CONFIG_FUNCTION_TRACER */
> 
>  #ifndef __ASSEMBLY__
> diff --git a/arch/powerpc/kernel/trace/ftrace_32.S b/arch/powerpc/kernel/trace/ftrace_32.S
> index e023ae59c429..e69a4e945986 100644
> --- a/arch/powerpc/kernel/trace/ftrace_32.S
> +++ b/arch/powerpc/kernel/trace/ftrace_32.S
> @@ -29,6 +29,10 @@ _GLOBAL(ftrace_caller)
>         MCOUNT_SAVE_FRAME
>         /* r3 ends up with link register */
>         subi    r3, r3, MCOUNT_INSN_SIZE
> +
> +       /* Set ftrace_ops (r5) to the global variable function_trace_op */
> +       /* Set pt_regs (r6) to NULL */
> +
>  .globl ftrace_call
>  ftrace_call:
>         bl      ftrace_stub
> diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kernel/trace/ftrace_64_pg.S
> index 6708e24db0ab..a741448b1df9 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
> @@ -22,6 +22,10 @@ _GLOBAL_TOC(ftrace_caller)
>         std     r3, 128(r1)
>         ld      r4, 16(r11)
>         subi    r3, r3, MCOUNT_INSN_SIZE
> +
> +       /* Set ftrace_ops (r5) to the global variable function_trace_op */
> +       /* Set pt_regs (r6) to NULL */

I'm guessing you are going to do the above here. If so, this looks correct.

> +
>  .globl ftrace_call
>  ftrace_call:
>         bl      ftrace_stub
> 
> To add support for ftrace_ops to the powerpc architecture is only necessary
> to fill the r5 and r6 registers before the call to ftrace_stub in all the
> cases. The register r5 is a pointer to ftrace_ops struct and the register
> r6 is a pointer to pt_regs struct. These registers are the third and fourth
> parameters of a function with the following prototype. The first and second
> ones are yet set.

I guess you mean that the first and second ones are already set. But,
yeah, you are on the correct path here!

> 
> void func(unsigned long ip, unsigned long parent_ip,
> 	  struct ftrace_ops *ops, struct pt_regs *regs);
> 
> Am I in the right direction? or am I totally wrong?

No, you don't look wrong. But the true test is to try it out :-)

Don't forget to update ftrace_32.S as well.


> 
> Thanks for your time and patience.

My pleasure. Thanks for doing this. The more people that understand all
this, the better!

-- Steve
