Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE028C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655124683
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="IFrjxLAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBUGOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:14:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgBUGOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:14:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so434043wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NPzj0GacQ93xagAlNK8LgngBMkJMj6Y7tJEVRY8XPM=;
        b=IFrjxLAfYapdU82d5FN6Qpsf+Ekh+12KMYjkVEpMNW7/82DoOy8WVlYlz+Rzqoo34M
         JaoqTfkCCsbEeHTvN9kVq97rWd2e2Eygj+xOjfwThwCc/oD0gaqh7d+LTvjjKTjK000G
         07hI03SrOmtad3wAPZaSYI+Mll+T+Of2cb7W7o/cZKBwVc6byUMAdIZocZ/FFIj1h+b5
         UU/JAVH66iBb5kU+SjOB8BHk0vBXOZ2q2IN9PX4SSejcWucMniJO25FshU0UDI/u/QcC
         /MC/vrICzX4QuZc21dWcDs0hYHqKHSeNXxreulhqmbWe1g+axscyL9sWWuWceHf/Lsfs
         NKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NPzj0GacQ93xagAlNK8LgngBMkJMj6Y7tJEVRY8XPM=;
        b=WWxljIZFEyquVWmzzKmdEHaGytwr4Xwe556G/A/eLLz6n0FZzkb5Tn2PKHjazRHWoW
         0I0kpPFqE7/1/M91gh3KezRdSH0mT8nXObnabg1YlbbioNalrVu8K0c0pSbNZGV+HFe+
         ABakjQMA3jQ9SeA+CGxgNRk8JD5lOBDpu4K435oibeeE5RPuIXeVaRyrW9IzjtJlgTlK
         W7uMKyIgVGflQKMzfrBJFMrv2hR04by6XJB/NIKEIVxsIyUC8aDmjVDeje+PAN5N3YHg
         WieEJcwxBEhM53l4ZDLYtZAaPbKy+UXRzLsl5JvZbnpZG3Tn65jV1AzL44FCvlU7XAL/
         2/oA==
X-Gm-Message-State: APjAAAV+d+RzU2Szl3iyPJJIG+4JjN00m0EoF40MS/3kBwlYjjZiHheN
        UZZkfgOocR2DT6AOQ0At3ksJ5mXq95fDBGLssbtZQA==
X-Google-Smtp-Source: APXvYqz794x7M6ev4Ic+y22CYFH8oQAHpmcAHV37yjJe2Y9WTIKEB7WDPYuI8qFGk3AqjZnn1Zj5VoRdj+Y+lC3GDB4=
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr1535010wmk.120.1582265658118;
 Thu, 20 Feb 2020 22:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20200221004413.12869-1-atish.patra@wdc.com> <20200221004413.12869-13-atish.patra@wdc.com>
In-Reply-To: <20200221004413.12869-13-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Feb 2020 11:44:06 +0530
Message-ID: <CAAhSdy2nY1LStqDJPU10CN2d=p5XQzkE2RjXdkXoAoumhyO5-A@mail.gmail.com>
Subject: Re: [PATCH v9 12/12] irqchip/sifive-plic: Initialize the plic handler
 when cpu comes online
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 6:14 AM Atish Patra <atish.patra@wdc.com> wrote:
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
>  arch/riscv/kernel/traps.c         |  2 +-
>  drivers/irqchip/irq-sifive-plic.c | 38 +++++++++++++++++++++++++++----
>  include/linux/cpuhotplug.h        |  1 +
>  3 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 8e13ad45ccaa..16c59807da6a 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -157,5 +157,5 @@ void trap_init(void)
>         /* Set the exception vector address */
>         csr_write(CSR_TVEC, &handle_exception);
>         /* Enable interrupts */
> -       csr_write(CSR_IE, IE_SIE | IE_EIE);
> +       csr_write(CSR_IE, IE_SIE);
>  }
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index aa4af886e43a..7c7f37393f99 100644
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
> @@ -55,6 +56,9 @@
>  #define     CONTEXT_THRESHOLD          0x00
>  #define     CONTEXT_CLAIM              0x04
>
> +#define        PLIC_DISABLE_THRESHOLD          0xf
> +#define        PLIC_ENABLE_THRESHOLD           0
> +
>  static void __iomem *plic_regs;
>
>  struct plic_handler {
> @@ -230,6 +234,32 @@ static int plic_find_hart_id(struct device_node *node)
>         return -1;
>  }
>
> +static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
> +{
> +       /* priority must be > threshold to trigger an interrupt */
> +       writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> +}
> +
> +static int plic_dying_cpu(unsigned int cpu)
> +{
> +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
> +       csr_clear(CSR_IE, IE_EIE);
> +       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> +
> +       return 0;
> +}
> +
> +static int plic_starting_cpu(unsigned int cpu)
> +{
> +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
> +       csr_set(CSR_IE, IE_EIE);
> +       plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
> +
> +       return 0;
> +}
> +
>  static int __init plic_init(struct device_node *node,
>                 struct device_node *parent)
>  {
> @@ -267,7 +297,6 @@ static int __init plic_init(struct device_node *node,
>                 struct plic_handler *handler;
>                 irq_hw_number_t hwirq;
>                 int cpu, hartid;
> -               u32 threshold = 0;
>
>                 if (of_irq_parse_one(node, i, &parent)) {
>                         pr_err("failed to parse parent for context %d.\n", i);
> @@ -301,7 +330,7 @@ static int __init plic_init(struct device_node *node,
>                 handler = per_cpu_ptr(&plic_handlers, cpu);
>                 if (handler->present) {
>                         pr_warn("handler already present for context %d.\n", i);
> -                       threshold = 0xffffffff;
> +                       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>                         goto done;
>                 }
>
> @@ -313,13 +342,14 @@ static int __init plic_init(struct device_node *node,
>                         plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
>
>  done:
> -               /* priority must be > threshold to trigger an interrupt */
> -               writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
>                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
>                         plic_toggle(handler, hwirq, 0);
>                 nr_handlers++;
>         }
>
> +       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> +                                 "irqchip/sifive/plic:starting",
> +                                 plic_starting_cpu, plic_dying_cpu);
>         pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
>                 nr_irqs, nr_handlers, nr_contexts);
>         set_handle_irq(plic_handle_irq);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index d37c17e68268..77d70b633531 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -102,6 +102,7 @@ enum cpuhp_state {
>         CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>         CPUHP_AP_IRQ_BCM2836_STARTING,
>         CPUHP_AP_IRQ_MIPS_GIC_STARTING,
> +       CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>         CPUHP_AP_ARM_MVEBU_COHERENCY,
>         CPUHP_AP_MICROCODE_LOADER,
>         CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
> --
> 2.25.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

I will rebase my RISC-V local interrupt controller driver patches
upon this patch series.

Regards,
Anup
