Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3161C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6A12075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="wORpc4eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391596AbgE2Ckf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2Ckb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:40:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E31C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:40:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g5so461613pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qr2b5fc6Y7X/KJYiwVWwhWo1665lu0KpHP2ObEzCVz4=;
        b=wORpc4eLpF5AZw8xKcLdgsH6Eouojq4wVcCQC3S6HuAdde5MLOwrnGPCeGKYk8xDbk
         ry+PgYdRqzMai8wR1zHsqSnLVHNWq8OVIkr61P46Vl8lbGM7d/4s1soOp0fpebMjt0jW
         5yUpapqTKpMzZdzJGARf3rQjzqBTVYiNsDBGNen0dgpF9tlvEvBx4i93iwFJ4QYkkotL
         oum8Ps5J9o1jCDEUsuDiQtJJG4FSG6EZ5eL6O5RT8B+etOPsipF1RpQPz4akxZgBxPQX
         6iVmFXVafNNCHdg25p3nj0BBOTybwYnkkj0hN84UXOp/hQNzbD1NGCL9zsxwyt91KpGd
         apog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qr2b5fc6Y7X/KJYiwVWwhWo1665lu0KpHP2ObEzCVz4=;
        b=GwjtjxLp3zs2xGEyyjEXGCTePAuno7Vmx0QobH2wFQ3HT2Qudt8ZazQP2P2YCOa6E5
         sxm/++IDGkmFeUari8ch1WBldhEmlqUsxaqul7DzQaEPjoy+uDNT+Nw1ScdHOnxc1Yz2
         r7kP7QkOpIaJFwoVR0G6kinfRTKTVuTBQs6iVG4Ws/JSCJE7d0zFoGKAGcKjW5CIt/R1
         9V9xPea/Nl5X0iVkBqV629zvnUHwGShpZwGj0Ewc3Dqe5+or4On9Yekb6Eegrbw9R82z
         yrb7rGd8+aeTozSmZMda7JipopC99mVtec7jpi5EAdO/3JTFMJaWpAt15lG+stSAWJCT
         kllw==
X-Gm-Message-State: AOAM533Q7PbBOkcT9jh/c5F6GryEf3mRvVsmlGAnD1gDMwou4Fu5wUVp
        s/Kud4u5RAruYvyIHJ1K1Y0q0Q==
X-Google-Smtp-Source: ABdhPJzd2IYPDdm2LGUKaAnhXH+zQzRriCKTKlqIUdGqm/49Mj8QKWur6slyDIzIiPSTPLSC2bxM6Q==
X-Received: by 2002:a63:b219:: with SMTP id x25mr6139251pge.66.1590720030132;
        Thu, 28 May 2020 19:40:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i10sm5889004pfa.166.2020.05.28.19.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:40:29 -0700 (PDT)
Date:   Thu, 28 May 2020 19:40:29 -0700 (PDT)
X-Google-Original-Date: Thu, 28 May 2020 19:39:37 PDT (-0700)
Subject:     Re: [PATCH v5 3/6] irqchip: RISC-V per-HART local interrupt controller driver
In-Reply-To: <20200521133301.816665-4-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-0403a86a-bda6-4e69-ad73-71fb06c49e40@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:32:58 PDT (-0700), Anup Patel wrote:
> The RISC-V per-HART local interrupt controller manages software
> interrupts, timer interrupts, external interrupts (which are routed
> via the platform level interrupt controller) and other per-HART
> local interrupts.
>
> This patch adds a driver for the RISC-V local interrupt controller.
> It is a major re-write over perviously submitted version.
> (Refer, https://www.spinics.net/lists/devicetree/msg241230.html)
>
> Few advantages of this new driver over previous one are:
> 1. All local interrupts are registered as per-CPU interrupts
> 2. The RISC-V timer driver can register timer interrupt handler
>    using kernel irq subsystem without relying on arch/riscv to
>    explicitly call it's interrupt handler
> 3. The KVM RISC-V can use this driver to implement interrupt
>    handler for per-HART guest external interrupt defined by
>    the RISC-V H-Extension
> 4. In future, we can develop drivers for devices with per-HART
>    interrupts without changing arch code or this driver (example,
>    CLINT timer driver for RISC-V M-mode kernel)
>
> The RISC-V INTC driver is compliant with RISC-V Hart-Level Interrupt
> Controller DT bindings located at:
> Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig                     |   1 +
>  arch/riscv/include/asm/irq.h           |   2 -
>  arch/riscv/kernel/irq.c                |  33 +-----
>  arch/riscv/kernel/traps.c              |   2 -
>  drivers/irqchip/Kconfig                |  13 ++
>  drivers/irqchip/Makefile               |   1 +
>  drivers/irqchip/irq-riscv-intc.c       | 158 +++++++++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c      |  38 +++++-
>  include/linux/cpuhotplug.h             |   1 +
>  include/linux/irqchip/irq-riscv-intc.h |  20 ++++
>  10 files changed, 229 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
>  create mode 100644 include/linux/irqchip/irq-riscv-intc.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 90a008e28f7e..822cb0e1a380 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -40,6 +40,7 @@ config RISCV
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_SYSCALL_TRACEPOINTS
> +	select HANDLE_DOMAIN_IRQ
>  	select IRQ_DOMAIN
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 0183e15ace66..a9e5f07a7e9c 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -10,8 +10,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/linkage.h>
>
> -#define NR_IRQS         0
> -
>  void riscv_timer_interrupt(void);
>
>  #include <asm-generic/irq.h>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index bb0bfcd537e7..eb8777642ce6 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -7,7 +7,6 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
> -#include <linux/irqdomain.h>
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
>
> @@ -19,39 +18,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>
>  asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
>  {
> -	struct pt_regs *old_regs;
> -
> -	switch (regs->cause & ~CAUSE_IRQ_FLAG) {
> -	case RV_IRQ_TIMER:
> -		old_regs = set_irq_regs(regs);
> -		irq_enter();
> -		riscv_timer_interrupt();
> -		irq_exit();
> -		set_irq_regs(old_regs);
> -		break;
> -#ifdef CONFIG_SMP
> -	case RV_IRQ_SOFT:
> -		/*
> -		 * We only use software interrupts to pass IPIs, so if a non-SMP
> -		 * system gets one, then we don't know what to do.
> -		 */
> -		handle_IPI(regs);
> -		break;
> -#endif
> -	case RV_IRQ_EXT:
> -		old_regs = set_irq_regs(regs);
> -		irq_enter();
> +	if (handle_arch_irq)
>  		handle_arch_irq(regs);
> -		irq_exit();
> -		set_irq_regs(old_regs);
> -		break;
> -	default:
> -		pr_alert("unexpected interrupt cause 0x%lx", regs->cause);
> -		BUG();
> -	}
>  }
>
>  void __init init_IRQ(void)
>  {
>  	irqchip_init();
> +	if (!handle_arch_irq)
> +		panic("No interrupt controller found.");
>  }
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 7f58fa53033f..f48c76aadbf3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -178,6 +178,4 @@ void trap_init(void)
>  	csr_write(CSR_SCRATCH, 0);
>  	/* Set the exception vector address */
>  	csr_write(CSR_TVEC, &handle_exception);
> -	/* Enable interrupts */
> -	csr_write(CSR_IE, IE_SIE);
>  }
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index a85aada04a64..95d6137a8117 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -493,6 +493,19 @@ config TI_SCI_INTA_IRQCHIP
>  	  If you wish to use interrupt aggregator irq resources managed by the
>  	  TI System Controller, say Y here. Otherwise, say N.
>
> +config RISCV_INTC
> +	bool "RISC-V Local Interrupt Controller"
> +	depends on RISCV
> +	default y
> +	help
> +	   This enables support for the per-HART local interrupt controller
> +	   found in standard RISC-V systems.  The per-HART local interrupt
> +	   controller handles timer interrupts, software interrupts, and
> +	   hardware interrupts. Without a per-HART local interrupt controller,
> +	   a RISC-V system will be unable to handle any interrupts.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config SIFIVE_PLIC
>  	bool "SiFive Platform-Level Interrupt Controller"
>  	depends on RISCV
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 37bbe39bf909..b8319f045472 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>  obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
> +obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> new file mode 100644
> index 000000000000..2f364e6a87f9
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017-2018 SiFive
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#define pr_fmt(fmt) "riscv-intc: " fmt
> +#include <linux/atomic.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/irq-riscv-intc.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/smp.h>
> +
> +static struct device_node *intc_domain_node;
> +static struct irq_domain *intc_domain;
> +
> +static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs;
> +	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> +
> +	if (unlikely(cause >= BITS_PER_LONG))
> +		panic("unexpected interrupt cause");
> +
> +	switch (cause) {
> +	case RV_IRQ_TIMER:
> +		old_regs = set_irq_regs(regs);
> +		irq_enter();
> +		riscv_timer_interrupt();
> +		irq_exit();
> +		set_irq_regs(old_regs);
> +		break;
> +#ifdef CONFIG_SMP
> +	case RV_IRQ_SOFT:
> +		/*
> +		 * We only use software interrupts to pass IPIs, so if a
> +		 * non-SMP system gets one, then we don't know what to do.
> +		 */
> +		handle_IPI(regs);
> +		break;
> +#endif
> +	default:
> +		handle_domain_irq(intc_domain, cause, regs);
> +		break;
> +	}
> +}
> +
> +/*
> + * On RISC-V systems local interrupts are masked or unmasked by writing
> + * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
> + * on the local hart, these functions can only be called on the hart that
> + * corresponds to the IRQ chip.
> + */
> +
> +static void riscv_intc_irq_mask(struct irq_data *d)
> +{
> +	csr_clear(CSR_IE, 1 << (long)d->hwirq);
> +}
> +
> +static void riscv_intc_irq_unmask(struct irq_data *d)
> +{
> +	csr_set(CSR_IE, 1 << (long)d->hwirq);
> +}
> +
> +static int riscv_intc_cpu_starting(unsigned int cpu)
> +{
> +	csr_write(CSR_IE, 1UL << RV_IRQ_SOFT);
> +	csr_write(CSR_IP, 0);
> +	return 0;
> +}
> +
> +static int riscv_intc_cpu_dying(unsigned int cpu)
> +{
> +	csr_clear(CSR_IE, 1UL << RV_IRQ_SOFT);
> +	return 0;
> +}
> +
> +static struct irq_chip riscv_intc_chip = {
> +	.name = "RISC-V INTC",
> +	.irq_mask = riscv_intc_irq_mask,
> +	.irq_unmask = riscv_intc_irq_unmask,
> +};
> +
> +static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
> +				 irq_hw_number_t hwirq)
> +{
> +	irq_set_percpu_devid(irq);
> +	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
> +			    handle_percpu_devid_irq, NULL, NULL);
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops riscv_intc_domain_ops = {
> +	.map	= riscv_intc_domain_map,
> +	.xlate	= irq_domain_xlate_onecell,
> +};
> +
> +/* Get the OF device node used by INTC irq domain */
> +struct device_node *riscv_of_intc_domain_node(void)
> +{
> +	return intc_domain_node;
> +}
> +EXPORT_SYMBOL_GPL(riscv_of_intc_domain_node);
> +
> +static int __init riscv_intc_init(struct device_node *node,
> +				  struct device_node *parent)
> +{
> +	int hartid;
> +
> +	/*
> +	 * The DT will have one INTC DT node under each CPU (or HART)
> +	 * DT node so riscv_intc_init() function will be called once
> +	 * for each INTC DT node. We only need INTC initialization for
> +	 * the INTC DT node belonging to boot CPU (or boot HART).
> +	 */
> +	hartid = riscv_of_parent_hartid(node);
> +	if (hartid < 0)
> +		return 0;

This should at least be a warning, as it's an invalid device tree.

> +	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
> +		return 0;

There should be a comment about this one, as it only works becuase there's one
CPU up and running while interrupts are being enabled.

> +
> +	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
> +					    &riscv_intc_domain_ops, NULL);
> +	if (!intc_domain)
> +		goto error_add_linear;
> +
> +	/*
> +	 * We save the DT node used for creating irq domain and provide
> +	 * it to other drivers using iscv_of_intc_domain_node() function.

Missing the "r" in iscv_of_intc_domain_node

> +	 */
> +	intc_domain_node = of_node_get(node);
> +
> +	set_handle_irq(&riscv_intc_irq);

So there's now this implicit assumption that every CPU node has a
riscv,cpu-intc.  That's probably fine, as we don't have any other first-level
interrupt controllers, but at least whacking a warning if set_handle_irq()
fails seems prudent.  It'd be best to actually check that assumption (maybe
before quitting above?) and actually installing the percpu OF nodes, but that
would take a performance hit so I'm not sure it's worth it.

> +
> +	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
> +			  "irqchip/riscv/intc:starting",
> +			  riscv_intc_cpu_starting,
> +			  riscv_intc_cpu_dying);
> +
> +	pr_info("%lu local interrupts mapped\n", (long)BITS_PER_LONG);
> +
> +	return 0;
> +
> +error_add_linear:
> +	pr_warn("unable to add IRQ domain\n");
> +	return -ENXIO;
> +}
> +
> +IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 16d31d114c30..4f9b2877aa9d 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -9,6 +9,8 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqchip/irq-riscv-intc.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -60,6 +62,7 @@
>  #define	PLIC_ENABLE_THRESHOLD		0
>
>  struct plic_priv {
> +	int parent_irq;
>  	struct cpumask lmask;
>  	struct irq_domain *irqdomain;
>  	void __iomem *regs;
> @@ -219,15 +222,17 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
>   * that source ID back to the same claim register.  This automatically enables
>   * and disables the interrupt, so there's nothing else to do.
>   */
> -static void plic_handle_irq(struct pt_regs *regs)
> +static void plic_handle_irq(struct irq_desc *desc)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
>  	irq_hw_number_t hwirq;
>
>  	WARN_ON_ONCE(!handler->present);
>
> -	csr_clear(CSR_IE, IE_EIE);
> +	chained_irq_enter(chip, desc);
> +

Ya, it's pretty clear putting the local interrupt controller in irqchip is the
right way to go :)

>  	while ((hwirq = readl(claim))) {
>  		int irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
>
> @@ -237,7 +242,8 @@ static void plic_handle_irq(struct pt_regs *regs)
>  		else
>  			generic_handle_irq(irq);
>  	}
> -	csr_set(CSR_IE, IE_EIE);
> +
> +	chained_irq_exit(chip, desc);
>  }
>
>  static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
> @@ -250,7 +256,8 @@ static int plic_dying_cpu(unsigned int cpu)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>
> -	csr_clear(CSR_IE, IE_EIE);
> +	if (handler->priv->parent_irq)
> +		disable_percpu_irq(handler->priv->parent_irq);
>  	plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>
>  	return 0;
> @@ -259,8 +266,10 @@ static int plic_dying_cpu(unsigned int cpu)
>  static int plic_starting_cpu(unsigned int cpu)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	int pirq = handler->priv->parent_irq;
>
> -	csr_set(CSR_IE, IE_EIE);
> +	if (pirq)
> +		enable_percpu_irq(pirq, irq_get_trigger_type(pirq));
>  	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
>
>  	return 0;
> @@ -273,6 +282,7 @@ static int __init plic_init(struct device_node *node,
>  	u32 nr_irqs;
>  	struct plic_priv *priv;
>  	struct plic_handler *handler;
> +	struct of_phandle_args intc_args;
>
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -354,6 +364,23 @@ static int __init plic_init(struct device_node *node,
>  		nr_handlers++;
>  	}
>
> +	/*
> +	 * We can have multiple PLIC instances so setup chained handler
> +	 * for all PLIC instances.
> +	 */
> +	intc_args.np = riscv_of_intc_domain_node();
> +	intc_args.args_count = 1;
> +	intc_args.args[0] = RV_IRQ_EXT;

You could just use the value from the device tree rather than deciding on the
value a-priori.  It's a bit pedantic to worry about that now, as the PLIC
assumes that there's a RISC-V system and its parent is an cpu-intc, but it
always seems ugly that the PLIC driver is so RISC-V specific.

> +	priv->parent_irq = irq_create_of_mapping(&intc_args);
> +	if (priv->parent_irq)
> +		irq_set_chained_handler(priv->parent_irq,
> +					 plic_handle_irq);
> +	else {
> +		pr_err("%pOFP: intc mapping failed\n", node);
> +		error = -ENODEV;
> +		goto out_iounmap;
> +	}
> +
>  	/*
>  	 * We can have multiple PLIC instances so setup cpuhp state only
>  	 * when context handler for current/boot CPU is present.
> @@ -368,7 +395,6 @@ static int __init plic_init(struct device_node *node,
>
>  	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
>  		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
> -	set_handle_irq(plic_handle_irq);
>  	return 0;
>
>  out_iounmap:
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 77d70b633531..57b1f8f777d9 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -102,6 +102,7 @@ enum cpuhp_state {
>  	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>  	CPUHP_AP_IRQ_BCM2836_STARTING,
>  	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
> +	CPUHP_AP_IRQ_RISCV_STARTING,
>  	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  	CPUHP_AP_ARM_MVEBU_COHERENCY,
>  	CPUHP_AP_MICROCODE_LOADER,
> diff --git a/include/linux/irqchip/irq-riscv-intc.h b/include/linux/irqchip/irq-riscv-intc.h
> new file mode 100644
> index 000000000000..b11d38353099
> --- /dev/null
> +++ b/include/linux/irqchip/irq-riscv-intc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_RISCV_INTC_H
> +#define __INCLUDE_LINUX_IRQCHIP_IRQ_RISCV_INTC_H
> +
> +struct device_node;
> +
> +#ifdef CONFIG_RISCV_INTC
> +struct device_node *riscv_of_intc_domain_node(void);
> +#else
> +static inline struct device_node *riscv_of_intc_domain_node(void)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#endif

These issues are all pretty minor, so I'm OK with this getting merged as-is.  I
fixed up some minor stuff and have it on my intc branch as 2bd957e2b0b6
("irqchip: RISC-V per-HART local interrupt controller driver"), but if the
irqchip folks want to take the patches then I'm not opposed to either version
getting merged.

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
