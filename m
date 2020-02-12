Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC05C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAFB21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="AxIDPaJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBLFKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:10:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgBLFKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:10:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so550581wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 21:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF5Xa3xZXNzgn21SJKWAvWiwP+pxClkAhr89+lwhg6k=;
        b=AxIDPaJ60LIWZnzVnREbiTaxymYYk8wssYrGNUN+6GfYGAc1ZQLVaPxpZlf8vm3qu5
         REdelHOMVmlNv6jvRHk26iwxeVf7amCIUYuTjHfCpOdavb1ldQO7+T3xfZAAXrcELsQl
         egl6C5AoQCHXALkzwSKUt6pUMNUav4cUC6DOh5xVyxzSI5TZMKn0u4qzETfJZQeJkpHj
         RnGd/1HT8pUDdWx5f3V+zEuYVrXP+zhq0kAS/OLc/YMalvYQePL52Tzwqz/NUNNlsJcW
         f3/2mTSniXS3ZbMiBiZBkwBHhsLbh7Hez7JPWIgWJvRvho8zBQIuinSuhcK3vKRP61N2
         xUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF5Xa3xZXNzgn21SJKWAvWiwP+pxClkAhr89+lwhg6k=;
        b=rCNzF4qldDagdWPgbsQOW1BvDGkQqjtJ1yS88mCVRri/GvP/RI83I5r/Rn7QpkeDJt
         9xDfpZ3jHAiSQ5mWJclOoPIXwXJC1jAQ8N+hnJXzXezn/+t/43yxOhW0rRcj0xwtF+HV
         OAD46ohI6JZZ7PFfeGJybvo8wZ1r9oRdL7azSEUQg3/vcHvBLxgUANMX+3QkUe9HfLQc
         Mb6XoKWMgUiYVZtpqxnqSZEgLj6nCH4UABqtqEboOKHUm40cJXbmz8uY1c1I+tbhrdMU
         9i3Pk2uN/5Ebx4ZG8EfXwMZCzwwm2gmpLx7ke+o0cMcdH2GSHMlBOHtkIbVqYblkN32U
         QfWQ==
X-Gm-Message-State: APjAAAU+C10bky8V4DzEmpkckfuo7c44GjhNDKqvx6zZFPEZSYKSsau4
        ngRgjKJ+k+774JxAzdB75XTvhHAHCDLY68kiUtOdxg==
X-Google-Smtp-Source: APXvYqwd6UAjI2x7FRjOvOMVy286Xf7J5JUhekZ9tzx7ZzSgqBmWgbcFbg7mpYNZX6Ukik4GfvUBn94tOi73gvJLGPM=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr13404204wrv.358.1581484211357;
 Tue, 11 Feb 2020 21:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-11-atish.patra@wdc.com>
In-Reply-To: <20200212014822.28684-11-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Feb 2020 10:40:00 +0530
Message-ID: <CAAhSdy2kMgB4esz0atf92teR9j3x9a_aJcsjBB6ExcA-C78Fng@mail.gmail.com>
Subject: Re: [PATCH v8 10/11] irqchip/sifive-plic: Initialize the plic handler
 when cpu comes online
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:21 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, plic threshold and priority are only initialized once in the
> beginning. However, threshold can be set to disabled if cpu is marked
> offline with cpu hotplug feature. This will not allow to change the
> irq affinity to a cpu that just came online.
>
> Add plic specific cpu hotplug callback and initialize the per cpu handler
> when cpu comes online.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 34 ++++++++++++++++++++++++-------
>  include/linux/cpuhotplug.h        |  1 +
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 0aca5807a119..9b564b19f4bf 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2018 Christoph Hellwig
>   */
>  #define pr_fmt(fmt) "plic: " fmt
> +#include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -55,6 +56,8 @@
>  #define     CONTEXT_THRESHOLD          0x00
>  #define     CONTEXT_CLAIM              0x04
>
> +#define        PLIC_DISABLE_THRESHOLD          0xffffffff
> +
>  static void __iomem *plic_regs;
>
>  struct plic_handler {
> @@ -208,6 +211,26 @@ static int plic_find_hart_id(struct device_node *node)
>         return -1;
>  }
>
> +static void plic_handler_init(struct plic_handler *handler, u32 threshold)
> +{
> +       irq_hw_number_t hwirq;
> +
> +       /* priority must be > threshold to trigger an interrupt */
> +       writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> +       for (hwirq = 1; hwirq < plic_irqdomain->hwirq_max; hwirq++)
> +               plic_toggle(handler, hwirq, 0);

Ensuring that all IRQs are disabled is only required at boot-time. For run-time,
CPU hotplug, I am sure Linux irq subsystem will migrate-and-disable IRQs
routed to given CPU when the CPU does down.

Further, we should also ensure that all IRQs are disabled for PLIC contexts
not used by S-mode Linux kernel.

Based on the above rationale, the loop to disable all IRQs should still be
part of plic_init().

> +}
> +
> +static int plic_starting_cpu(unsigned int cpu)
> +{
> +       u32 threshold = 0;
> +       struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +       plic_handler_init(handler, threshold);
> +
> +       return 0;
> +}
> +

Addition to PLIC context threshold programming, the plic_starting_cpu()
should also set IE_EIE bit in CSR_IE instead of doing it in trap_init()
function of arch/riscv/kernel.trap.c

You can also define plic_stoping_cpu() which does the reverse of what
plic_starting_cpu() is doing.


>  static int __init plic_init(struct device_node *node,
>                 struct device_node *parent)
>  {
> @@ -243,9 +266,7 @@ static int __init plic_init(struct device_node *node,
>         for (i = 0; i < nr_contexts; i++) {
>                 struct of_phandle_args parent;
>                 struct plic_handler *handler;
> -               irq_hw_number_t hwirq;
>                 int cpu, hartid;
> -               u32 threshold = 0;
>
>                 if (of_irq_parse_one(node, i, &parent)) {
>                         pr_err("failed to parse parent for context %d.\n", i);
> @@ -279,7 +300,7 @@ static int __init plic_init(struct device_node *node,
>                 handler = per_cpu_ptr(&plic_handlers, cpu);
>                 if (handler->present) {
>                         pr_warn("handler already present for context %d.\n", i);
> -                       threshold = 0xffffffff;
> +                       plic_handler_init(handler, PLIC_DISABLE_THRESHOLD);
>                         goto done;
>                 }
>
> @@ -291,13 +312,12 @@ static int __init plic_init(struct device_node *node,
>                         plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
>
>  done:
> -               /* priority must be > threshold to trigger an interrupt */
> -               writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> -               for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> -                       plic_toggle(handler, hwirq, 0);
>                 nr_handlers++;
>         }
>
> +       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> +                                 "irqchip/sifive/plic:starting",
> +                                 plic_starting_cpu, NULL);
>         pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
>                 nr_irqs, nr_handlers, nr_contexts);
>         set_handle_irq(plic_handle_irq);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e51ee772b9f5..5360e03db08c 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -100,6 +100,7 @@ enum cpuhp_state {
>         CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>         CPUHP_AP_IRQ_BCM2836_STARTING,
>         CPUHP_AP_IRQ_MIPS_GIC_STARTING,
> +       CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>         CPUHP_AP_ARM_MVEBU_COHERENCY,
>         CPUHP_AP_MICROCODE_LOADER,
>         CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
> --
> 2.24.0
>

Regards,
Anup
