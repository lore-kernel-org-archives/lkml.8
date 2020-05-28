Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A192DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E1720776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="eKBdtoMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbgE1XIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgE1XIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:08:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68440C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:08:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so975144wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwgj6E9D3HYNDLpG/tXHp4hKNZ51Ebu1gu1zyX/LBmg=;
        b=eKBdtoMU2S5v42sEqcXy8Bcn6D3jlj+Zmc2RkpBWpuwt9pe6UCkgyQ9dviQ9CUBJ6U
         +j/FJ4/r0vEAA4ZuzSNHPOJrIeaIHWdyFazU5DVidj45KyO5GpIF2TdISzTu4QtGZWa/
         Yi8IPT0D68amZf9yrvlzQjdo2mTuu5mU/ToOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwgj6E9D3HYNDLpG/tXHp4hKNZ51Ebu1gu1zyX/LBmg=;
        b=YNCUEvSgmJmFoO6gjz8GAkrLCyoUVQSnVgDrbWjwMshVb7VB+NRmmep04ElMkI6/kS
         kgxW21b8bnvMPLSBhtd6EFnVh4xonaWNYD37L5SfyHZS5NSMrhqo6sb86tFfekLba1FP
         r60yAr25XHv4dTmDr6JfzelZ8/qoqkfEEnb+CCcjg1RDuuecGqyt0hrULrMLebSm/HOC
         vst5waY/meOMVptaKiuZ6igVBtczB/TFTyefYaJR4DYLsOuiNNwlVhLFFfR1p1/ZQRE4
         Y3TT9vrDa311k4CYr8R2cnchdUWTRbteYzzH8k/bqCcorsm+2c7ZGaaJEcc6t/1tD/vm
         //5g==
X-Gm-Message-State: AOAM533U3LMudSyDeKyRuJE4tCZdu1IiTpqlaRpeqoD2w1RyVMBV/U+r
        Klm199Yefl0mpjUGG0cP1ogPikzxHteXPSVzjYjtTVQ=
X-Google-Smtp-Source: ABdhPJw4kaEVV34t2cEZXq+mqdaNLLx7uzsUiCPUzRX2Ss5tayR3bmdPfnfs7awSp3in1+7tmPyjkiSOscIiMuSZfgo=
X-Received: by 2002:a7b:c622:: with SMTP id p2mr5546999wmk.55.1590707322980;
 Thu, 28 May 2020 16:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-2-anup.patel@wdc.com>
In-Reply-To: <20200521133301.816665-2-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 May 2020 16:08:31 -0700
Message-ID: <CAOnJCULxy6N_FwhxTFH8ym7Xnpf1sOkyLEk7-Uap-xiUwZkywQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] RISC-V: self-contained IPI handling routine
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:34 AM Anup Patel <anup.patel@wdc.com> wrote:
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
> index a65a8fa0c22d..b1d4f452f843 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -123,11 +123,14 @@ static inline void clear_ipi(void)
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
> @@ -138,7 +141,7 @@ void riscv_software_interrupt(void)
>
>                 ops = xchg(pending_ipis, 0);
>                 if (ops == 0)
> -                       return;
> +                       goto done;
>
>                 if (ops & (1 << IPI_RESCHEDULE)) {
>                         stats[IPI_RESCHEDULE]++;
> @@ -160,6 +163,10 @@ void riscv_software_interrupt(void)
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
> 2.25.1
>
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
