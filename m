Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9B20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="jZAyb0fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGXRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgGXRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:24:30 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F8C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=ZirEMoqFChKVP997rHvVKSuAF3dK0iS+WiW9fGpcVZQ=; b=jZAy
        b0fHk5lUfr3iaep4NHYBlvy/1pOM7SLSOGdJaCYPtdx2tmIYGjSVLsqkBoBMToeid0YSyFtErfE+k
        XjsOe/+x9wxVJbu01SQq2XjYHJBL9gii3O7pJN8f5tfzp5ajmNHY9OrbJjBCJOXVDethzgr2SzRwr
        kIrJWM3aqpODr8Z1qtquUEn4kWC2px61RoNA8ZRN9Jr4wwuwnPaACKtW0y+t6uIztOfmFdKmLz7go
        aJ/JMvgYeBoFO8cLHJgEKOr4B3g3Wo26xcLntA5431o3GctO2rdKKaLk5LEUVMACxgfenoHVaKzJ1
        7H2aWT4gq1hoYLkt9mRC8G12+5jk3g==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1jz1Qp-0000oh-OD; Fri, 24 Jul 2020 18:24:28 +0100
Date:   Fri, 24 Jul 2020 18:24:22 +0100
From:   John Keeping <john@metanate.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ben Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] genirq/affinity: Handle affinity setting on inactive
 interrupts correctly
Message-ID: <20200724182422.27ddced6.john@metanate.com>
In-Reply-To: <877dv2rv25.fsf@nanos.tec.linutronix.de>
References: <87k0z2s2q3.fsf@nanos.tec.linutronix.de>
        <877dv2rv25.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Jul 2020 18:00:02 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Setting interrupt affinity on inactive interrupts is inconsistent when
> hierarchical irq domains are enabled. The core code should just store the
> affinity and not call into the irq chip driver for inactive interrupts
> because the chip drivers may not be in a state to handle such requests.
> 
> X86 has a hacky workaround for that but all other irq chips have not which
> causes problems e.g. on GIC V3 ITS.
> 
> Instead of adding more ugly hacks all over the place, solve the problem in
> the core code. If the affinity is set on an inactive interrupt then:
> 
>     - Store it in the irq descriptors affinity mask
>     - Update the effective affinity to reflect that so user space has
>       a consistent view
>     - Don't call into the irq chip driver
> 
> This is the core equivalent of the X86 workaround and works correctly
> because the affinity setting is established in the irq chip when the
> interrupt is activated later on.
> 
> Note, that this is only effective when hierarchical irq domains are enabled
> by the architecture. Doing it unconditionally would break legacy irq chip
> implementations.
> 
> For hierarchial irq domains this works correctly as none of the drivers can
> have a dependency on affinity setting in inactive state by design.
> 
> Remove the X86 workaround as it is not longer required.
> 
> Fixes: 02edee152d6e ("x86/apic/vector: Ignore set_affinity call for inactive interrupts")
> Reported-by: Ali Saidi <alisaidi@amazon.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20200529015501.15771-1-alisaidi@amazon.com
> ---
> V2: Fix the fallout for CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=n (0day)

It seems that this patch breaks perf events on RK3288 because the PMU
interrupts that should be per-cpu are now all on CPU0 so no events are
collected from CPUs 1-3 and those interrupts are killed as spurious
after a few seconds.

I'm seeing this on 4.19.134 and 5.4.53 but as far as I can tell the
relevant code hasn't changed through to next-20200723.  Reverting the
backport of this change fixes the problem.

It looks like what happens is that because the interrupts are not
per-CPU in the hardware, armpmu_request_irq() calls irq_force_affinity()
while the interrupt is deactivated and then request_irq() with
IRQF_PERCPU | IRQF_NOBALANCING.

Now when irq_startup() runs with IRQ_STARTUP_NORMAL, it calls
irq_setup_affinity() which returns early because IRQF_PERCPU and
IRQF_NOBALANCING are set, leaving the interrupt on its original CPU.

At this point /proc/interrupts clearly shows the interrupts occurring on
CPU0 despite /proc/irq/N/effective_affinity and /proc/irq/N/smp_affinity
showing them spread across the cores as expected.

I don't think I understand what's meant to happen well enough to propose
a patch, but hopefully the above explanation explains the problem.


Regards,
John

> ---
>  arch/x86/kernel/apic/vector.c |   22 +++++-----------------
>  kernel/irq/manage.c           |   37 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 19 deletions(-)
> 
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -446,12 +446,10 @@ static int x86_vector_activate(struct ir
>  	trace_vector_activate(irqd->irq, apicd->is_managed,
>  			      apicd->can_reserve, reserve);
>  
> -	/* Nothing to do for fixed assigned vectors */
> -	if (!apicd->can_reserve && !apicd->is_managed)
> -		return 0;
> -
>  	raw_spin_lock_irqsave(&vector_lock, flags);
> -	if (reserve || irqd_is_managed_and_shutdown(irqd))
> +	if (!apicd->can_reserve && !apicd->is_managed)
> +		assign_irq_vector_any_locked(irqd);
> +	else if (reserve || irqd_is_managed_and_shutdown(irqd))
>  		vector_assign_managed_shutdown(irqd);
>  	else if (apicd->is_managed)
>  		ret = activate_managed(irqd);
> @@ -775,20 +773,10 @@ void lapic_offline(void)
>  static int apic_set_affinity(struct irq_data *irqd,
>  			     const struct cpumask *dest, bool force)
>  {
> -	struct apic_chip_data *apicd = apic_chip_data(irqd);
>  	int err;
>  
> -	/*
> -	 * Core code can call here for inactive interrupts. For inactive
> -	 * interrupts which use managed or reservation mode there is no
> -	 * point in going through the vector assignment right now as the
> -	 * activation will assign a vector which fits the destination
> -	 * cpumask. Let the core code store the destination mask and be
> -	 * done with it.
> -	 */
> -	if (!irqd_is_activated(irqd) &&
> -	    (apicd->is_managed || apicd->can_reserve))
> -		return IRQ_SET_MASK_OK;
> +	if (WARN_ON_ONCE(!irqd_is_activated(irqd)))
> +		return -EIO;
>  
>  	raw_spin_lock(&vector_lock);
>  	cpumask_and(vector_searchmask, dest, cpu_online_mask);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -195,9 +195,9 @@ void irq_set_thread_affinity(struct irq_
>  			set_bit(IRQTF_AFFINITY, &action->thread_flags);
>  }
>  
> +#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>  static void irq_validate_effective_affinity(struct irq_data *data)
>  {
> -#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>  	const struct cpumask *m = irq_data_get_effective_affinity_mask(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
>  
> @@ -205,9 +205,19 @@ static void irq_validate_effective_affin
>  		return;
>  	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
>  		     chip->name, data->irq);
> -#endif
>  }
>  
> +static inline void irq_init_effective_affinity(struct irq_data *data,
> +					       const struct cpumask *mask)
> +{
> +	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
> +}
> +#else
> +static inline void irq_validate_effective_affinity(struct irq_data *data) { }
> +static inline void irq_init_effective_affinity(struct irq_data *data,
> +					       const struct cpumask *mask) { }
> +#endif
> +
>  int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  			bool force)
>  {
> @@ -304,6 +314,26 @@ static int irq_try_set_affinity(struct i
>  	return ret;
>  }
>  
> +static bool irq_set_affinity_deactivated(struct irq_data *data,
> +					 const struct cpumask *mask, bool force)
> +{
> +	struct irq_desc *desc = irq_data_to_desc(data);
> +
> +	/*
> +	 * If the interrupt is not yet activated, just store the affinity
> +	 * mask and do not call the chip driver at all. On activation the
> +	 * driver has to make sure anyway that the interrupt is in a
> +	 * useable state so startup works.
> +	 */
> +	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) || irqd_is_activated(data))
> +		return false;
> +
> +	cpumask_copy(desc->irq_common_data.affinity, mask);
> +	irq_init_effective_affinity(data, mask);
> +	irqd_set(data, IRQD_AFFINITY_SET);
> +	return true;
> +}
> +
>  int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
>  			    bool force)
>  {
> @@ -314,6 +344,9 @@ int irq_set_affinity_locked(struct irq_d
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> +	if (irq_set_affinity_deactivated(data, mask, force))
> +		return 0;
> +
>  	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
>  		ret = irq_try_set_affinity(data, mask, force);
>  	} else {

