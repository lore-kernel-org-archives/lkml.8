Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5A0207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589845750;
	bh=fAQjWZZptjuW+k9fX47WgQpQZjWEoYfMm80Kwi2F5VI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oYtsVOV3Zjt7Ob5S774O5qo3MDLUy60aLjZv5tB4J8YsAXZHyBo7DZln4I67S61Wf
	 fpDFh9+ZnYX3X42TQSyzz7yolxjVJtckvu48izgeXoL480SkzEcOOI9lVbE9sRd5zJ
	 yVvbdMZufhimZ15bi4xqdYtFI0aU068FdruVv0FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgERXtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgERXtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:49:08 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9FFD2084C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589845748;
        bh=fAQjWZZptjuW+k9fX47WgQpQZjWEoYfMm80Kwi2F5VI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kXe2rSGEAXfUIwbnINBR8wtQxZ65i+WOKYVJrFxswnGxe1f8vzKstCiDpGUAIhhxP
         GL9lmYUMwzPhhW5Q9EMK0DpmIPQiO1SfcGEK6kkjMiWe/guMAlgtsygvY0+vcuEtld
         DYbMmTaaS4A058Zp+kSmFPA/jq7iTJpKAveOgGhg=
Received: by mail-wr1-f46.google.com with SMTP id h17so13756802wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:49:07 -0700 (PDT)
X-Gm-Message-State: AOAM530BLfyKX/Z/WA5Y7UdDvBOEeFNyl+XjbmR1WjVWj4RoSp5zKGl4
        Bf+U2/2b+Wa7cPIYsOw9LaPdl4EtW1F0Knp/3xUVIQ==
X-Google-Smtp-Source: ABdhPJyYKsLmnLIDOyVLKCU9B5vwP3bP+8gz00rCHxBgfFJbu7Fca01BeYL2waTsSyiTPK8JJptwDFh7e9tC2RMxu74=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr22020166wro.70.1589845746155;
 Mon, 18 May 2020 16:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.219205621@linutronix.de>
In-Reply-To: <20200515235125.219205621@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:48:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXQKFdn+vu3z4p2iVcTOhwN5warx4TE+Dxq04d1=Exs8g@mail.gmail.com>
Message-ID: <CALCETrXQKFdn+vu3z4p2iVcTOhwN5warx4TE+Dxq04d1=Exs8g@mail.gmail.com>
Subject: Re: [patch V6 08/37] x86/entry/64: Move do_softirq_own_stack() to C
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
> The first step to get rid of the ENTER/LEAVE_IRQ_STACK ASM macro maze.  Use
> the new C code helpers to move do_softirq_own_stack() out of ASM code.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3b8da9f09297..bdf8391b2f95 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1145,19 +1145,6 @@ SYM_FUNC_START(asm_call_on_stack)
>         ret
>  SYM_FUNC_END(asm_call_on_stack)
>
> -/* Call softirq on interrupt stack. Interrupts are off. */
> -.pushsection .text, "ax"
> -SYM_FUNC_START(do_softirq_own_stack)
> -       pushq   %rbp
> -       mov     %rsp, %rbp
> -       ENTER_IRQ_STACK regs=0 old_rsp=%r11
> -       call    __do_softirq
> -       LEAVE_IRQ_STACK regs=0
> -       leaveq
> -       ret
> -SYM_FUNC_END(do_softirq_own_stack)
> -.popsection
> -
>  #ifdef CONFIG_XEN_PV
>  /*
>   * A note on the "critical region" in our callback handler.
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index 12df3a4abfdd..62cff52e03c5 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task_stack.h>
>
>  #include <asm/cpu_entry_area.h>
> +#include <asm/irq_stack.h>
>  #include <asm/io_apic.h>
>  #include <asm/apic.h>
>
> @@ -70,3 +71,11 @@ int irq_init_percpu_irqstack(unsigned int cpu)
>                 return 0;
>         return map_irq_stack(cpu);
>  }
> +
> +void do_softirq_own_stack(void)
> +{
> +       if (irqstack_active())
> +               __do_softirq();
> +       else
> +               run_on_irqstack(__do_softirq, NULL);
> +}

See my comment in patch 8.  I see no great reason that this should
open-code the conditional, except maybe that we don't have pt_regs
here so the condition needs to be a bit different.
