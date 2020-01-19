Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8998AC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197E20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgASQu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:50:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:50:26 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1itDmF-00043F-E1; Sun, 19 Jan 2020 17:50:19 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E1CB4105BE3; Sun, 19 Jan 2020 17:50:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH V3] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200118125354.15796-1-ming.lei@redhat.com>
References: <20200118125354.15796-1-ming.lei@redhat.com>
Date:   Sun, 19 Jan 2020 17:50:17 +0100
Message-ID: <87ftgb4chi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

Ming Lei <ming.lei@redhat.com> writes:
>  
> +static bool hk_should_isolate(struct irq_data *data,
> +		const struct cpumask *affinity, unsigned int cpu)

Please align the first argument on the second line with the first
argument on the first line.

> +{
> +	const struct cpumask *hk_mask;
> +
> +	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
> +		return false;
> +
> +	if (!irqd_affinity_is_managed(data))
> +		return false;

Pointless. That's already checked at the begin of the calling function.

> +
> +	if (!cpumask_test_cpu(cpu, affinity))
> +		return false;

Ditto.

> +	hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> +	if (cpumask_subset(affinity, hk_mask))
> +		return false;
> +
> +	if (cpumask_intersects(irq_data_get_effective_affinity_mask(data),
> +				hk_mask))

I really had to think twice why this is correct. The example I gave you
is far more intuitive. It's just missing the check below.

> +		return false;
> +
> +	return cpumask_test_cpu(cpu, hk_mask);
> +}
> +
>  static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
>  {
>  	struct irq_data *data = irq_desc_get_irq_data(desc);
> @@ -190,7 +216,8 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
>  	 * CPU then it is already assigned to a CPU in the affinity
>  	 * mask. No point in trying to move it around.
>  	 */
> -	if (!irqd_is_single_target(data))
> +	if (!irqd_is_single_target(data) ||
> +			hk_should_isolate(data, affinity, cpu))

	if (!irqd_is_single_target(data) ||
	    hk_should_isolate(data, affinity, cpu))

Please.

>  		irq_set_affinity_locked(data, affinity, false);
>  }
>  
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1753486b440c..a8af2ca806e2 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched/isolation.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/task_work.h>
>  
> @@ -217,7 +218,40 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> -	ret = chip->irq_set_affinity(data, mask, force);
> +	/*
> +	 * If this is a managed interrupt and housekeeping is enabled on
> +	 * it check whether the requested affinity mask intersects with
> +	 * a housekeeping CPU. If so, then remove the isolated CPUs from
> +	 * the mask and just keep the housekeeping CPU(s). This prevents
> +	 * the affinity setter from routing the interrupt to an isolated
> +	 * CPU to avoid that I/O submitted from a housekeeping CPU causes
> +	 * interrupts on an isolated one.
> +	 *
> +	 * If the masks do not intersect or include online CPU(s) then
> +	 * keep the requested mask. The isolated target CPUs are only
> +	 * receiving interrupts when the I/O operation was submitted
> +	 * directly from them.
> +	 *
> +	 * If all housekeeping CPUs in the affinity mask are offline,
> +	 * we will migrate the irq from isolate CPU when any housekeeping
> +	 * CPU in the mask becomes online.
> +	 */
> +	if (irqd_affinity_is_managed(data) &&
> +			housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {

Same here.

> +		static DEFINE_RAW_SPINLOCK(prog_mask_lock);
> +		static struct cpumask prog_mask;
> +		const struct cpumask *hk_mask =
> +			housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> +

What's wrong with writing:

		const struct cpumask *hk_mask;

		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);

Hmm?

> +		raw_spin_lock(&prog_mask_lock);
> +		cpumask_and(&prog_mask, mask, hk_mask);
> +		if (!cpumask_intersects(&prog_mask, cpu_online_mask))
> +			cpumask_copy(&prog_mask, mask);

Why copy?

		static struct cpumask tmp_mask;
		const struct cpumask *hk_mask, *mp;

		raw_spin_lock(&mask_lock);
		cpumask_and(&tmp_mask, mask, hk_mask);
		if (cpumask_intersects(&prog_mask, cpu_online_mask))
                	mp = &tmp_mask;
                else
                	mp = mask;
                ....
Hmm?

Thanks,

        tglx
