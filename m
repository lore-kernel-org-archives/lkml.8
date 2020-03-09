Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B89C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297AD2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="aiB4rsOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgCIMAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:00:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43982 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCIMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:00:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so10705360wrf.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cn023W+lDLvUmt2wJVW7A9R+9F85X12O2o5qp06pjT4=;
        b=aiB4rsOjv7FriI7AKNbuM0AUGjZhfilCpNIfFVk0swNXkSpcgqXVSBDEUZ8LxMCZ6E
         3viu4sVUOVMgPzHQKoQAm4AiaEHw1GiqU2CWe7+FuZSxdJVkoizJ4aidUIvcRbiLOiaP
         OO5JHFQZHZhWsqWmIQVQVeu4c88YZfKsu0DtxHRJL21BOzXmsxkEP/ltl2sh41CNxF4A
         kMxHr1pzmnv5JWyyjHqNQ6JxghQp9pz7Z1VHmCM7Kob7XoMlSRZxQpcJKbsRzgblPJJt
         u7jFQ1Qgd2egN6otjyOBLLWlYzMazPJaZYWM6+//0kSpvU0Qj7ZCn/qHh0QsLzkSI0sP
         LNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cn023W+lDLvUmt2wJVW7A9R+9F85X12O2o5qp06pjT4=;
        b=BBSyk4eYkWxvjoL9FftvFQSRIF84iwgfSJJFWVY/ruBeSZk8sIOW3vy4PZFMKWIru0
         CCPAz5CvqtNZkKDlGg/sKcY/UTvVPgi99iU8DcZn2Nnj9j+1CBH38u6d3qwYj4EItd/a
         Uu9PbOafhlG6kPzYZEvxI2ZFAQouPTmxE8Z3XrqEn9O5oN7c4WsMhByeNHKFkxTnmDm+
         AzMSEVM150k2d83VhgsjA48/JI31MmY4uVxbWvA2bi7sPd8IKb4US7Lx3JacZBCUVY6Y
         MA4zFDH3YGmFn4qK2J2NaIHoaKbaWQKX2gxu2Nsx5sqGWALStHo3atncie3e0vqquHUB
         plgQ==
X-Gm-Message-State: ANhLgQ1Be1KwoLpE7sZ0YSdKkEv0Tw+F3WUIQkhsRmeBo/Yp/Z4RROru
        /Uwtmd9H36k/xJvdJ9mGYU9/ejQEnnWHU74XlWSfbQ==
X-Google-Smtp-Source: ADFU+vvY7GQ6J942nn/f2P09rIM1Wk7SWzB4NnIhI4pkObV4c9s4ftGHnGCXtlY+oFEE0YhXK/UlLR6Ls216Ib1QTxY=
X-Received: by 2002:a5d:4711:: with SMTP id y17mr17576182wrq.358.1583755210808;
 Mon, 09 Mar 2020 05:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200309110211.91130-1-anup.patel@wdc.com> <20200309110211.91130-5-anup.patel@wdc.com>
In-Reply-To: <20200309110211.91130-5-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Mar 2020 17:29:58 +0530
Message-ID: <CAAhSdy0N9S63yUYS9JYLcEtN0B+1nr9E6x_4EokXN2RQcvqf0g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] clocksource: timer-riscv: Make timer interrupt as
 a per-CPU interrupt
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

On Mon, Mar 9, 2020 at 4:33 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> Instead of directly calling RISC-V timer interrupt handler from
> RISC-V local interrupt conntroller driver, this patch implements
> RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
> of Linux IRQ subsystem.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h      |  2 -
>  drivers/clocksource/timer-riscv.c | 79 ++++++++++++++++++++-----------
>  drivers/irqchip/irq-riscv-intc.c  |  8 ----
>  3 files changed, 52 insertions(+), 37 deletions(-)
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
> index c4f15c4068c0..6b82f2e41f8e 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -14,7 +14,10 @@
>  #include <linux/irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> -#include <asm/smp.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <asm/sbi.h>
>
>  u64 __iomem *riscv_time_cmp;
> @@ -39,6 +42,7 @@ static int riscv_clock_next_event(unsigned long delta,
>         return 0;
>  }
>
> +static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>         .name                   = "riscv_timer_clockevent",
>         .features               = CLOCK_EVT_FEAT_ONESHOT,
> @@ -74,65 +78,86 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
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
> -       int cpuid, hartid, error;
> -
> -       hartid = riscv_of_processor_hartid(n);
> -       if (hartid < 0) {
> -               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> -                       n, hartid);
> -               return hartid;
> -       }
> -
> -       cpuid = riscv_hartid_to_cpuid(hartid);
> -       if (cpuid < 0) {
> -               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> -               return cpuid;
> -       }
> -
> -       if (cpuid != smp_processor_id())
> +       int error;
> +       struct of_phandle_args oirq;
> +
> +       /*
> +        * Either we have one INTC DT node under each CPU DT node
> +        * or a single system wide INTC DT node. Irrespective to
> +        * number of INTC DT nodes, we only proceed if we are able
> +        * to find irq_domain of INTC.
> +        *
> +        * Once we have INTC irq_domain, we create mapping for timer
> +        * interrupt HWIRQ and request_percpu_irq() on it.
> +        */
> +
> +       if (!irq_find_host(n) || riscv_clock_event_irq)
>                 return 0;
>
> -       pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> -              __func__, cpuid, hartid);
> +       oirq.np = n;
> +       oirq.args_count = 1;
> +       oirq.args[0] = RV_IRQ_TIMER;
> +       riscv_clock_event_irq = irq_create_of_mapping(&oirq);
> +       if (!riscv_clock_event_irq)
> +               return -ENODEV;
> +
>         error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>         if (error) {
> -               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -                      error, cpuid);
> +               pr_err("registering clocksource failed [%d]\n", error);
>                 return error;
>         }
>
>         sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
>
> +       error = request_percpu_irq(riscv_clock_event_irq,
> +                                  riscv_timer_interrupt,
> +                                  "riscv-timer", &riscv_clock_event);
> +       if (error) {
> +               pr_err("registering percpu irq failed [%d]\n", error);
> +               return error;
> +       }
> +
>         error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>                          "clockevents/riscv/timer:starting",
>                          riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> -       if (error)
> +       if (error) {
>                 pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>                        error);
> -       return error;
> +               return error;
> +       }
> +
> +       pr_info("running at %lu.%02luMHz frequency\n",
> +               (unsigned long)riscv_timebase / 1000000,
> +               (unsigned long)(riscv_timebase / 10000) % 100);
> +
> +       return 0;
>  }
>
> -TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> +TIMER_OF_DECLARE(riscv_timer, "riscv,cpu-intc", riscv_timer_init_dt);
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index e8f7af6dd3c2..93d9d2a38059 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -20,20 +20,12 @@ static struct irq_domain *intc_domain;
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
> 2.17.1
>
