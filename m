Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3DCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56FC207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="FpJaxduZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2FEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2FEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:04:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7B7C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:04:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so1758331wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQJmrk0V5PrbHI+gX8ojTZANmtmzX/J0DrLuxxy0xYY=;
        b=FpJaxduZV1R9mG8WI3Sg80SbbryBsNhUOWenjb2Mcgt6g4o36xwm8Yy5C+B0WT46cJ
         FgHqoK6viudK2NTH5JGUuEDSBFlLmbqLztCD2bJsCdaK0WqqkJKHIAajtGGhu9/9s/Bf
         FTBMyXQQiewG8yUxZnMhRbXFAX+TWVLIQnCbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQJmrk0V5PrbHI+gX8ojTZANmtmzX/J0DrLuxxy0xYY=;
        b=kTG6qtN+2ZoRFbKF/ANGAdsjnOem5lZ1G0CzGPud0q7H5CI7MZXp/sAPaZ1P9tlYB5
         OW4E2I+t46c1LhRTEKnSGFrRcSB0t2GbPq+p4Nrrz0uNiPtzaMd8H3lirOGAfp6CWE8D
         E7BCk9eiO+WVV/1a+Q9bnyWa5zsxWgedFZL0VrzKHSQuw1GBxjwb/cdMxReSZsYvZqFG
         kUsWWa6/pNTgIHk1J+YRaBL6sWbo4sW4oxdU4vdHIK3gHsSNRtzO7qwlK6pC0q9lXl7Y
         qZLv261k76jotk+YF/E8m5mcn5klTCygrKzSHwyQ/FBLSeLx1Leea+CH4ir3MJNNtsr+
         ydig==
X-Gm-Message-State: AOAM531fx9vdvKquvo3puFHfq8g3tuqWsGO9XrRT7xmyLG/cPUnL5pFW
        3lsaEyZrp1q2I09tlFdobnwQ5hg2AdpuclCDrbYI
X-Google-Smtp-Source: ABdhPJyiY/MYFoX8EqaqySlCOPVN+kjGR049gcdqYbGrIqsSMLx2IJHzLdJcF1ZZVmOXlpRdoyld+a/Xx5Ihn9a3Jmk=
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr371335wmj.176.1590728674524;
 Thu, 28 May 2020 22:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-5-anup.patel@wdc.com>
In-Reply-To: <20200521133301.816665-5-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 May 2020 22:04:23 -0700
Message-ID: <CAOnJCUKX_+TZR8sMFDL2K4vNRwo0v12Fb5=rX5KUNpRaw8LGsg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
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
> Instead of directly calling RISC-V timer interrupt handler from
> RISC-V local interrupt conntroller driver, this patch implements
> RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
> of Linux IRQ subsystem.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h      |  2 --
>  drivers/clocksource/timer-riscv.c | 30 +++++++++++++++++++++++++++---
>  drivers/irqchip/irq-riscv-intc.c  |  8 --------
>  3 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index a9e5f07a7e9c..9807ad164015 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -10,8 +10,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/linkage.h>
>
> -void riscv_timer_interrupt(void);
> -
>  #include <asm-generic/irq.h>
>
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index c4f15c4068c0..5fb7c5ba5c91 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -14,6 +14,9 @@
>  #include <linux/irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/irqchip/irq-riscv-intc.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
>  #include <asm/smp.h>
>  #include <asm/sbi.h>
>
> @@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long delta,
>         return 0;
>  }
>
> +static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>         .name                   = "riscv_timer_clockevent",
>         .features               = CLOCK_EVT_FEAT_ONESHOT,
> @@ -74,30 +78,35 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>         struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
>
>         ce->cpumask = cpumask_of(cpu);
> +       ce->irq = riscv_clock_event_irq;
>         clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>
> -       csr_set(CSR_IE, IE_TIE);
> +       enable_percpu_irq(riscv_clock_event_irq,
> +                         irq_get_trigger_type(riscv_clock_event_irq));
>         return 0;
>  }
>
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
> -       csr_clear(CSR_IE, IE_TIE);
> +       disable_percpu_irq(riscv_clock_event_irq);
>         return 0;
>  }
>
>  /* called directly from the low-level interrupt handler */
> -void riscv_timer_interrupt(void)
> +static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
>  {
>         struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
>
>         csr_clear(CSR_IE, IE_TIE);
>         evdev->event_handler(evdev);
> +
> +       return IRQ_HANDLED;
>  }
>
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
>         int cpuid, hartid, error;
> +       struct of_phandle_args oirq;
>
>         hartid = riscv_of_processor_hartid(n);
>         if (hartid < 0) {
> @@ -115,6 +124,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>         if (cpuid != smp_processor_id())
>                 return 0;
>
> +       oirq.np = riscv_of_intc_domain_node();
> +       oirq.args_count = 1;
> +       oirq.args[0] = RV_IRQ_TIMER;
> +       riscv_clock_event_irq = irq_create_of_mapping(&oirq);
> +       if (!riscv_clock_event_irq)
> +               return -ENODEV;
> +

As the error case will result in a system without a clock, a warning message
may be a good option.

>         pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>                __func__, cpuid, hartid);
>         error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
> @@ -126,6 +142,14 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>
>         sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
>
> +       error = request_percpu_irq(riscv_clock_event_irq,
> +                                   riscv_timer_interrupt,
> +                                   "riscv-timer", &riscv_clock_event);
> +       if (error) {
> +               pr_err("registering percpu irq failed [%d]\n", error);
> +               return error;
> +       }
> +
>         error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>                          "clockevents/riscv/timer:starting",
>                          riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 2f364e6a87f9..d4fbc3543459 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -23,20 +23,12 @@ static struct irq_domain *intc_domain;
>
>  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  {
> -       struct pt_regs *old_regs;
>         unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
>
>         if (unlikely(cause >= BITS_PER_LONG))
>                 panic("unexpected interrupt cause");
>
>         switch (cause) {
> -       case RV_IRQ_TIMER:
> -               old_regs = set_irq_regs(regs);
> -               irq_enter();
> -               riscv_timer_interrupt();
> -               irq_exit();
> -               set_irq_regs(old_regs);
> -               break;
>  #ifdef CONFIG_SMP
>         case RV_IRQ_SOFT:
>                 /*
> --
> 2.25.1
>
>
Otherwise, LGTM.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
