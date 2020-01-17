Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37776C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FD92072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAQPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:46:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:46:17 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isTp4-0003O1-M9; Fri, 17 Jan 2020 16:46:10 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E0AE8100C19; Fri, 17 Jan 2020 16:46:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH V2] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200117035326.20659-1-ming.lei@redhat.com>
References: <20200117035326.20659-1-ming.lei@redhat.com>
Date:   Fri, 17 Jan 2020 16:46:09 +0100
Message-ID: <87v9pa13y6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:
>  #ifdef CONFIG_CPU_ISOLATION
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 6c7ca2e983a5..20c7704ce019 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -77,7 +77,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	 * Note: Do not check desc->action as this might be a chained
>  	 * interrupt.
>  	 */
> -	if (irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d)) {
> +	if ((irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d))
> +			&& !irqd_managed_force_migrate(d)) {

That's broken. Assume the bit is set and then the remaining CPU goes
offline and shuts down the interupt. As a consequence the interrupt is
in shutdown state when the first CPU of the affinity set comes online
again. It will see the force migrate bit which prevents starting it up
again. FAIL!

>  		/*
>  		 * If an irq move is pending, abort it if the dying CPU is
>  		 * the sole target.
> @@ -192,6 +193,9 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
>  	 */
>  	if (!irqd_is_single_target(data))
>  		irq_set_affinity_locked(data, affinity, false);
> +
> +	if (irqd_managed_force_migrate(data))
> +		migrate_one_irq(desc);

That's not a good idea, really. This is forceful migration which we only
should do when there is no other option especially on X86 for the
interrupts which cannot be safely migrated outside of an actual
interrupt service routine of that interrupt line. When a CPU is
unplugged then we have to do this, no matter what. This isolation thing
is best effort and does not justify this at all.

I really do not like this force migrate wording either. We force stuff
when there is no other way out, but this is not the case here.

We know that there is an isolation mask set, right? So we can simply do:

-  	if (!irqd_is_single_target(data))
+	if (!irqd_is_single_target(data) || hk_should_isolate(data, affinity))
  		irq_set_affinity_locked(data, affinity, false);

and have

static bool hk_should_isolate(data, affinity)
{
        if (!hk_isolation)
        	return false;

        if (!irqd_is_managed(data))
        	return false;

        if (!cpumask_intersects(affinity, hk_isolmask))
        	return false;

        e = irq_data_get_effective_affinity_mask(data);
        return !cpumask_subset(e, hk_isolmask);
}

and let irq_set_affinity_locked() -> irq_do_set_affinity() do the right
thing, i.e. migrate it directly or mark it pending for migration.

> @@ -213,11 +214,45 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	struct irq_desc *desc = irq_data_to_desc(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
>  	int ret;
> +	const struct cpumask *mask_to_set = mask;
>
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> -	ret = chip->irq_set_affinity(data, mask, force);
>
> +	if (irqd_affinity_is_managed(data)) {
> +		static struct cpumask tmp_mask;

What protects this mask? Assume there are two concurrent callers on
different CPUs for different interrupts. -> FAIL!

The place I pointed you to does TheRightThing.

Aside of that this mask is only needed when ISOLATION is enabled in Kconfig.

> +		const struct cpumask *housekeeping =
> +			housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);

Can you please code in a way which makes these horrible line breaks go away?

> +
> +		if (cpumask_intersects(mask, housekeeping)) {
> +			cpumask_and(&tmp_mask, mask, housekeeping);
> +			if (cpumask_intersects(&tmp_mask, cpu_online_mask)) {
> +				mask_to_set = &tmp_mask;
> +				irqd_clear(data, IRQD_MANAGED_FORCE_MIGRATE);
> +			} else {
> +				irqd_set(data, IRQD_MANAGED_FORCE_MIGRATE);

And with the above this flag dance is not required at all.

Please take your time and analyze the code you are changing properly
before you send out the next half baken version.

I'm happy to review and help, but this frenzy mode sucks.

Thanks,

        tglx
