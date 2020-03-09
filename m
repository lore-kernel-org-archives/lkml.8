Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B59DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F44205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pJYC8nJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCIL6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:58:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCIL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:58:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so640470wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iouomU3fha5mQRskwANgwh7TuSQV901CBUJScXX1uj0=;
        b=pJYC8nJJP+qpBuNr4ascYa7DIinBaYwRPte2DGewZ2ZK8SslwP7kjJRt9Fh2PPxjTM
         JH1SJ/KgU6nHhtfX9AXe2R+O8+RjzdyeLhzzcdYLhc6/fDVx0CySJD0avA6JO52iEReQ
         +/3JJUGB+exnvIJLaW+o21GhpmZ8pG/2YYDuI3jSj3Xfqxekrxon5JCLZQNOhAEQ2G9x
         0BGhfL+QrdJb2e0pRBPbMsoLeuK5+jFPHWeu4KFmZzlHCTGgO7COUX0ATIQMlzu9xKf7
         5JFyz15gNYegP50JifiO1parr/ayDRr+Z0vOHvuzQlxQkdKiRMlyLuH6yTCxuCz4o1Po
         35fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iouomU3fha5mQRskwANgwh7TuSQV901CBUJScXX1uj0=;
        b=KERXdV9W8xx21VotqoXkLl5ETrN3nW/rGf7jG+iEv2Akoo91CS1hYJSq+hcyN4aeWT
         HGajmwqXSLaqfFqoeygCl9jVptbESy36BXWAWtLIrdJGnUDpFZ/e/6rmcI03oj/s7DNM
         F/VU7w0C98U+UZzpKSy0S9N+VqpWHzU0FxB9ekB3Dse9gPKHct8tSC+3BjvE1G2066ug
         +vI+VmvFIu9RWky7pQ55bUP1jgjbxGL6pYtypyNCdm0pmXvT5tDADV6Era8n0NuHNGxZ
         9CQSDHaNjyiHVj8kWdMRFkaBX/3c0wsO5wEahjCvLjKGC4IzHknoxKlOZzANce1fR+FI
         YLNA==
X-Gm-Message-State: ANhLgQ1l/Hys4HAxIJZgqkw6qsyoIKcftGyhzDArzR0d688z9t1Qi7rf
        fg5LiPvjDscbeeIinQAL4k2Gopkx3zqxuohFiYLbMg==
X-Google-Smtp-Source: ADFU+vtrCjWs6CQwJnmeJ39QPsyuWxgiqXU7bH5sLs75SftA1kHPkRoASnBXRxutYlNOWYcg0/qZ2O9WVMD69QNdLCw=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr20444241wrn.230.1583755113268;
 Mon, 09 Mar 2020 04:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200309110211.91130-1-anup.patel@wdc.com> <20200309110211.91130-2-anup.patel@wdc.com>
In-Reply-To: <20200309110211.91130-2-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Mar 2020 17:28:19 +0530
Message-ID: <CAAhSdy0tNAX-XV9-rh+pDLV-MXQ+v1trMFp6Vq_a6yD3HecPyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] RISC-V: self-contained IPI handling routine
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Marc's email address.

On Mon, Mar 9, 2020 at 4:32 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> Currently, the IPI handling routine riscv_software_interrupt() does
> not take any argument and also does not perform irq_enter()/irq_exit().
>
> This patch makes IPI handling routine more self-contained by:
> 1. Passing "pt_regs *" argument
> 2. Explicitly doing irq_enter()/irq_exit()
> 3. Explicitly save/restore "pt_regs *" using set_irq_regs()
>
> With above changes, IPI handling routine does not depend on caller
> function to perform irq_enter()/irq_exit() and save/restore of
> "pt_regs *" hence its more self-contained. This also enables us
> to call IPI handling routine from IRQCHIP drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h |  1 -
>  arch/riscv/include/asm/smp.h |  3 +++
>  arch/riscv/kernel/irq.c      | 16 ++++++++++------
>  arch/riscv/kernel/smp.c      | 11 +++++++++--
>  4 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 6e1b0e0325eb..0183e15ace66 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -13,7 +13,6 @@
>  #define NR_IRQS         0
>
>  void riscv_timer_interrupt(void);
> -void riscv_software_interrupt(void);
>
>  #include <asm-generic/irq.h>
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index f4c7cfda6b7f..40bb1c15a731 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -28,6 +28,9 @@ void show_ipi_stats(struct seq_file *p, int prec);
>  /* SMP initialization hook for setup_arch */
>  void __init setup_smp(void);
>
> +/* Called from C code, this handles an IPI. */
> +void handle_IPI(struct pt_regs *regs);
> +
>  /* Hook for the generic smp_call_function_many() routine. */
>  void arch_send_call_function_ipi_mask(struct cpumask *mask);
>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 345c4f2eba13..bb0bfcd537e7 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -19,12 +19,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>
>  asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -       struct pt_regs *old_regs = set_irq_regs(regs);
> +       struct pt_regs *old_regs;
>
> -       irq_enter();
>         switch (regs->cause & ~CAUSE_IRQ_FLAG) {
>         case RV_IRQ_TIMER:
> +               old_regs = set_irq_regs(regs);
> +               irq_enter();
>                 riscv_timer_interrupt();
> +               irq_exit();
> +               set_irq_regs(old_regs);
>                 break;
>  #ifdef CONFIG_SMP
>         case RV_IRQ_SOFT:
> @@ -32,19 +35,20 @@ asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
>                  * We only use software interrupts to pass IPIs, so if a non-SMP
>                  * system gets one, then we don't know what to do.
>                  */
> -               riscv_software_interrupt();
> +               handle_IPI(regs);
>                 break;
>  #endif
>         case RV_IRQ_EXT:
> +               old_regs = set_irq_regs(regs);
> +               irq_enter();
>                 handle_arch_irq(regs);
> +               irq_exit();
> +               set_irq_regs(old_regs);
>                 break;
>         default:
>                 pr_alert("unexpected interrupt cause 0x%lx", regs->cause);
>                 BUG();
>         }
> -       irq_exit();
> -
> -       set_irq_regs(old_regs);
>  }
>
>  void __init init_IRQ(void)
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index eb878abcaaf8..1e8f44a47e14 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -121,11 +121,14 @@ static inline void clear_ipi(void)
>                 clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
>  }
>
> -void riscv_software_interrupt(void)
> +void handle_IPI(struct pt_regs *regs)
>  {
> +       struct pt_regs *old_regs = set_irq_regs(regs);
>         unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>         unsigned long *stats = ipi_data[smp_processor_id()].stats;
>
> +       irq_enter();
> +
>         clear_ipi();
>
>         while (true) {
> @@ -136,7 +139,7 @@ void riscv_software_interrupt(void)
>
>                 ops = xchg(pending_ipis, 0);
>                 if (ops == 0)
> -                       return;
> +                       goto done;
>
>                 if (ops & (1 << IPI_RESCHEDULE)) {
>                         stats[IPI_RESCHEDULE]++;
> @@ -158,6 +161,10 @@ void riscv_software_interrupt(void)
>                 /* Order data access and bit testing. */
>                 mb();
>         }
> +
> +done:
> +       irq_exit();
> +       set_irq_regs(old_regs);
>  }
>
>  static const char * const ipi_names[] = {
> --
> 2.17.1
>
