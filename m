Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937AC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3862077C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgAQAXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:23:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAQAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:23:13 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isFPl-0005sI-Nc; Fri, 17 Jan 2020 01:23:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C48A9100C19; Fri, 17 Jan 2020 01:23:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200116215814.GA24827@ming.t460p>
References: <20200116094806.25372-1-ming.lei@redhat.com> <875zhbwqmm.fsf@nanos.tec.linutronix.de> <20200116215814.GA24827@ming.t460p>
Date:   Fri, 17 Jan 2020 01:23:03 +0100
Message-ID: <87d0bjdj88.fsf@nanos.tec.linutronix.de>
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
> On Thu, Jan 16, 2020 at 01:08:17PM +0100, Thomas Gleixner wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> > -	ret = chip->irq_set_affinity(data, mask, force);
>> > +	zalloc_cpumask_var(&tmp_mask, GFP_ATOMIC);
>> 
>> I clearly told you:
>> 
>>     "That's wrong. This code is called with interrupts disabled, so
>>      GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation
>>      here."
>> 
>> Is that last sentence unclear in any way?
>
> Yeah, it is clear.
>
> But GFP_ATOMIC is usually allowed in atomic context, could you
> explain it a bit why it can't be done in this case?

You could have asked that question before sending this patch :)

> We still can fallback to current behavior if the allocation fails.

Allocation fail is not the main concern here. In general we avoid atomic
allocations where ever we can, but even more so in contexts which are
fully atomic even on PREEMPT_RT simply because PREEMPT_RT cannot support
that.

Regular spin_lock(); GFP_ATOMIC; spin_unlock(); sections are not a
problem because spinlocks turn into sleepable 'spinlocks' on RT and are
preemptible.

irq_desc::lock is a raw spinlock which is a true spinlock on RT for
obvious reasons and there any form of memory allocation is a NONO.

> Or could you suggest to solve the issue in other way if GFP_ATOMIC
> can't be done?

Just use the same mechanism as irq_setup_affinity() for now. Not pretty,
but it does the job. I have a plan how to avoid that, but that's a
larger surgery.

Let me give you a few comments on the rest of the patch while at it.

> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/task_work.h>
> +#include <linux/sched/isolation.h>

Can you please move this include next to the other linux/sched/ one?

> @@ -212,12 +213,29 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  {
>  	struct irq_desc *desc = irq_data_to_desc(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	const struct cpumask *housekeeping_mask =
> +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);

Bah. This is unreadable garbage. What's wrong with defining the variable
and retrieving the pointer later on? Especially as this is only required
when there is an actual managed interrupt.

> +	/*
> +	 * Userspace can't change managed irq's affinity, make sure that
> +	 * isolated CPU won't be selected as the effective CPU if this
> +	 * irq's affinity includes at least one housekeeping CPU.
> +	 *
> +	 * This way guarantees that isolated CPU won't be interrupted if
> +	 * IO isn't submitted from isolated CPU.

This comment is more confusing than helpful. What about:

	/*
         * If this is a managed interrupt check whether the requested
         * affinity mask intersects with a housekeeping CPU. If so, then
         * remove the isolated CPUs from the mask and just keep the
         * housekeeping CPU(s). This prevents the affinity setter from
         * routing the interrupt to an isolated CPU to avoid that I/O
         * submitted from a housekeeping CPU causes interrupts on an
         * isolated one.
         *
         * If the masks do not intersect then keep the requested mask.
         * The isolated target CPUs are only receiving interrupts
         * when the I/O operation was submitted directly from them.
         */

Or something to that effect. Hmm?

> +	 */
> +	if (irqd_affinity_is_managed(data) && tmp_mask &&
> +			cpumask_intersects(mask, housekeeping_mask))
> +		cpumask_and(tmp_mask, mask, housekeeping_mask);

Now while writing the above comment the following interesting scenario
came to my mind:

Housekeeping CPUs 0-2, Isolated CPUs 3-7

Device has 4 queues. So the spreading results in:

 q0:   CPU 0/1, q1:   CPU 2/3, q2:   CPU 4/5, q3:   CPU 6/7

q1 is the interesting one. It's the one which gets the housekeeping mask
applied and CPU3 is removed.

So if CPU2 is offline when the mask is applied, then the result of the
affinity setting operation is going to be an error code because the
resulting mask is empty.

Admittedly this is a weird corner case, but it's bound to happen and the
resulting bug report is going to be hard to decode unless the reporter
can provide a 100% reproducer or a very accurate description of the
scenario.

Thanks,

        tglx
