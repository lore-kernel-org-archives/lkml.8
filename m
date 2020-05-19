Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC38C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35757206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="swZTGhpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgESWZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:25:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GgP5zC47SHT+qNcVV1uheWiy+wsRUbO+ZR1apmeNXlo=; b=swZTGhpN+zvTVqTS4ZD59GZFW
        hHzA3m9p87R9Y+j/mTdvD3P7jI5pKBmdGW9/k/CnSKJpxrkOiQI9PdWFP89hbJeDjPoJAC8rySbKP
        OUgH0N8tlMdbOUqw0TB1eCZ2kHGJvOLVZHzgJA/cHNghCTEnxJnfbZnjrg3dMUUFeQJHgqGNycE5O
        tXd7LGW9JkzKYzSsCMjXPvkMG++XmGisuR2RCBd569gTtboXVQKd/n956PH4W4hRDhFQ0tknWC02D
        f6hFylVEa/nfaWFqpZFCskIpJbsXrbi24Uy6B6rR6Enw2c4CER7j4SKylTX6bPMaKRa6NKMfCCYjF
        6AyIbng5Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34354)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jbAfL-0006VH-6a; Tue, 19 May 2020 23:24:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jbAfH-000661-5J; Tue, 19 May 2020 23:24:47 +0100
Date:   Tue, 19 May 2020 23:24:47 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 04/11] ARM: Allow IPIs to be handled as normal interrupts
Message-ID: <20200519222447.GJ1551@shell.armlinux.org.uk>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519161755.209565-5-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:17:48PM +0100, Marc Zyngier wrote:
> In order to deal with IPIs as normal interrupts, let's add
> a new way to register them with the architecture code.
> 
> set_smp_ipi_range() takes a range of interrupts, and allows
> the arch code to request them as if the were normal interrupts.
> A standard handler is then called by the core IRQ code to deal
> with the IPI.
> 
> This means that we don't need to call irq_enter/irq_exit, and
> that we don't need to deal with set_irq_regs either. So let's
> move the dispatcher into its own function, and leave handle_IPI()
> as a compatibility function.
> 
> On the sending side, let's make use of ipi_send_mask, which
> already exists for this purpose.

You say nothing about the nesting of irq_enter() and irq_exit()
for scheduler_ipi().

Given that lockdep introduced the requirement that hard IRQs can't
be nested, are we sure that calling irq_exit() twice is safe?

Looking at irqtime_account_irq(), it seems that will cause double-
accounting of in-interrupt time, since we will increment
irq_start_time by just over twice the the period spent handling
the IPI.

I think the rest of irq_exit() should be safe, but still, this
behaviour should be documented at the very least, if not avoided.

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm/Kconfig           |  1 +
>  arch/arm/include/asm/smp.h |  5 ++
>  arch/arm/kernel/smp.c      | 97 ++++++++++++++++++++++++++++++++------
>  3 files changed, 88 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c77c93c485a0..0caaba9bf880 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -48,6 +48,7 @@ config ARM
>  	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>  	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +	select GENERIC_IRQ_IPI if SMP
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_IDLE_POLL_SETUP
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index a91f21e3c5b5..0e29730295ca 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -45,6 +45,11 @@ extern void smp_init_cpus(void);
>   */
>  extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
>  
> +/*
> + * Register IPI interrupts with the arch SMP code
> + */
> +extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
> +
>  /*
>   * Called from platform specific assembly code, this is the
>   * secondary CPU entry point.
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 46e1be9e57a8..618641978a5b 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -79,10 +79,19 @@ enum ipi_msg_type {
>  	 */
>  };
>  
> +static int ipi_irq_base;
> +static int nr_ipi = NR_IPI;
> +static struct irq_desc *ipi_desc[NR_IPI];
> +
> +static void ipi_setup(int cpu);
> +static void ipi_teardown(int cpu);
> +
>  static DECLARE_COMPLETION(cpu_running);
>  
>  static struct smp_operations smp_ops __ro_after_init;
>  
> +static void ipi_setup(int cpu);
> +
>  void __init smp_set_ops(const struct smp_operations *ops)
>  {
>  	if (ops)
> @@ -308,6 +317,8 @@ void arch_cpu_idle_dead(void)
>  
>  	local_irq_disable();
>  
> +	ipi_teardown(cpu);
> +
>  	/*
>  	 * Flush the data out of the L1 cache for this CPU.  This must be
>  	 * before the completion to ensure that data is safely written out
> @@ -424,6 +435,8 @@ asmlinkage void secondary_start_kernel(void)
>  
>  	notify_cpu_starting(cpu);
>  
> +	ipi_setup(cpu);
> +
>  	calibrate_delay();
>  
>  	smp_store_cpu_info(cpu);
> @@ -629,10 +642,9 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
>  	handle_IPI(ipinr, regs);
>  }
>  
> -void handle_IPI(int ipinr, struct pt_regs *regs)
> +static void do_handle_IPI(int ipinr)
>  {
>  	unsigned int cpu = smp_processor_id();
> -	struct pt_regs *old_regs = set_irq_regs(regs);
>  
>  	if ((unsigned)ipinr < NR_IPI) {
>  		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> @@ -645,9 +657,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  	case IPI_TIMER:
> -		irq_enter();
>  		tick_receive_broadcast();
> -		irq_exit();
>  		break;
>  #endif
>  
> @@ -656,36 +666,26 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		break;
>  
>  	case IPI_CALL_FUNC:
> -		irq_enter();
>  		generic_smp_call_function_interrupt();
> -		irq_exit();
>  		break;
>  
>  	case IPI_CPU_STOP:
> -		irq_enter();
>  		ipi_cpu_stop(cpu);
> -		irq_exit();
>  		break;
>  
>  #ifdef CONFIG_IRQ_WORK
>  	case IPI_IRQ_WORK:
> -		irq_enter();
>  		irq_work_run();
> -		irq_exit();
>  		break;
>  #endif
>  
>  	case IPI_COMPLETION:
> -		irq_enter();
>  		ipi_complete(cpu);
> -		irq_exit();
>  		break;
>  
>  	case IPI_CPU_BACKTRACE:
>  		printk_nmi_enter();
> -		irq_enter();
> -		nmi_cpu_backtrace(regs);
> -		irq_exit();
> +		nmi_cpu_backtrace(get_irq_regs());
>  		printk_nmi_exit();
>  		break;
>  
> @@ -697,9 +697,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  
>  	if ((unsigned)ipinr < NR_IPI)
>  		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +}
> +
> +/* Legacy version, should go away once all irqchips have been converted */
> +void handle_IPI(int ipinr, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +	do_handle_IPI(ipinr);
> +	irq_exit();
> +
>  	set_irq_regs(old_regs);
>  }
>  
> +static irqreturn_t ipi_handler(int irq, void *data)
> +{
> +	do_handle_IPI(irq - ipi_irq_base);
> +	return IRQ_HANDLED;
> +}
> +
> +static void ipi_send(const struct cpumask *target, unsigned int ipi)
> +{
> +	__ipi_send_mask(ipi_desc[ipi], target);
> +}
> +
> +static void ipi_setup(int cpu)
> +{
> +	if (ipi_irq_base) {
> +		int i;
> +
> +		for (i = 0; i < nr_ipi; i++)
> +			enable_percpu_irq(ipi_irq_base + i, 0);
> +	}
> +}
> +
> +static void ipi_teardown(int cpu)
> +{
> +	if (ipi_irq_base) {
> +		int i;
> +
> +		for (i = 0; i < nr_ipi; i++)
> +			disable_percpu_irq(ipi_irq_base + i);
> +	}
> +}
> +
> +void __init set_smp_ipi_range(int ipi_base, int n)
> +{
> +	int i;
> +
> +	WARN_ON(n < NR_IPI);
> +	nr_ipi = min(n, NR_IPI);
> +
> +	for (i = 0; i < nr_ipi; i++) {
> +		int err;
> +
> +		err = request_percpu_irq(ipi_base + i, ipi_handler,
> +					 "IPI", &irq_stat);
> +		WARN_ON(err);
> +
> +		ipi_desc[i] = irq_to_desc(ipi_base + i);
> +		irq_set_status_flags(ipi_base + i, IRQ_NO_ACCOUNTING);
> +	}
> +
> +	ipi_irq_base = ipi_base;
> +	set_smp_cross_call(ipi_send);
> +
> +	/* Setup the boot CPU immediately */
> +	ipi_setup(smp_processor_id());
> +}
> +
>  void smp_send_reschedule(int cpu)
>  {
>  	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
