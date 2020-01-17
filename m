Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7126AC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DAD2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opf/YVH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgAQBvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:51:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgAQBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579225893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTV9BrRK+jptUKNJ1q34L0IflYnH+Zg5gZp88i+G4K4=;
        b=Opf/YVH+snn6IHsSs5Waqg4wzQonTFJWIq2DGyvTrB3MoxjZUuj79n0IKXmrRmFArVKNuh
        OGrjNilf9kLAgjo/0mmrl8efhg6VeyasVg6/nrWqdXte/BFig10o5OuXYC8K2oZZ2tDumi
        xJiSi8Pyco81W6ZaVZxEAT09nwqVxrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-dXJ0aPG4M6OwzTp1DrWJ_A-1; Thu, 16 Jan 2020 20:51:31 -0500
X-MC-Unique: dXJ0aPG4M6OwzTp1DrWJ_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D0B10054E3;
        Fri, 17 Jan 2020 01:51:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC2125D72B;
        Fri, 17 Jan 2020 01:51:16 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:51:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/isolation: isolate from handling managed interrupt
Message-ID: <20200117015112.GA8887@ming.t460p>
References: <20200116094806.25372-1-ming.lei@redhat.com>
 <875zhbwqmm.fsf@nanos.tec.linutronix.de>
 <20200116215814.GA24827@ming.t460p>
 <87d0bjdj88.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0bjdj88.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jan 17, 2020 at 01:23:03AM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> > On Thu, Jan 16, 2020 at 01:08:17PM +0100, Thomas Gleixner wrote:
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> > -	ret = chip->irq_set_affinity(data, mask, force);
> >> > +	zalloc_cpumask_var(&tmp_mask, GFP_ATOMIC);
> >> 
> >> I clearly told you:
> >> 
> >>     "That's wrong. This code is called with interrupts disabled, so
> >>      GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation
> >>      here."
> >> 
> >> Is that last sentence unclear in any way?
> >
> > Yeah, it is clear.
> >
> > But GFP_ATOMIC is usually allowed in atomic context, could you
> > explain it a bit why it can't be done in this case?
> 
> You could have asked that question before sending this patch :)
> 
> > We still can fallback to current behavior if the allocation fails.
> 
> Allocation fail is not the main concern here. In general we avoid atomic
> allocations where ever we can, but even more so in contexts which are
> fully atomic even on PREEMPT_RT simply because PREEMPT_RT cannot support
> that.
> 
> Regular spin_lock(); GFP_ATOMIC; spin_unlock(); sections are not a
> problem because spinlocks turn into sleepable 'spinlocks' on RT and are
> preemptible.
> 
> irq_desc::lock is a raw spinlock which is a true spinlock on RT for
> obvious reasons and there any form of memory allocation is a NONO.

Got it now, thanks for your so great explanation.

> 
> > Or could you suggest to solve the issue in other way if GFP_ATOMIC
> > can't be done?
> 
> Just use the same mechanism as irq_setup_affinity() for now. Not pretty,
> but it does the job. I have a plan how to avoid that, but that's a
> larger surgery.

Good point.

> 
> Let me give you a few comments on the rest of the patch while at it.
> 
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/task.h>
> >  #include <uapi/linux/sched/types.h>
> >  #include <linux/task_work.h>
> > +#include <linux/sched/isolation.h>
> 
> Can you please move this include next to the other linux/sched/ one?

OK.

> 
> > @@ -212,12 +213,29 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  {
> >  	struct irq_desc *desc = irq_data_to_desc(data);
> >  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	const struct cpumask *housekeeping_mask =
> > +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> 
> Bah. This is unreadable garbage. What's wrong with defining the variable
> and retrieving the pointer later on? Especially as this is only required
> when there is an actual managed interrupt.

OK, just because default housekeeping_mask is cpu_possible_mask.

> 
> > +	/*
> > +	 * Userspace can't change managed irq's affinity, make sure that
> > +	 * isolated CPU won't be selected as the effective CPU if this
> > +	 * irq's affinity includes at least one housekeeping CPU.
> > +	 *
> > +	 * This way guarantees that isolated CPU won't be interrupted if
> > +	 * IO isn't submitted from isolated CPU.
> 
> This comment is more confusing than helpful. What about:
> 
> 	/*
>          * If this is a managed interrupt check whether the requested
>          * affinity mask intersects with a housekeeping CPU. If so, then
>          * remove the isolated CPUs from the mask and just keep the
>          * housekeeping CPU(s). This prevents the affinity setter from
>          * routing the interrupt to an isolated CPU to avoid that I/O
>          * submitted from a housekeeping CPU causes interrupts on an
>          * isolated one.
>          *
>          * If the masks do not intersect then keep the requested mask.
>          * The isolated target CPUs are only receiving interrupts
>          * when the I/O operation was submitted directly from them.
>          */
> 
> Or something to that effect. Hmm?

That is much better.

> 
> > +	 */
> > +	if (irqd_affinity_is_managed(data) && tmp_mask &&
> > +			cpumask_intersects(mask, housekeeping_mask))
> > +		cpumask_and(tmp_mask, mask, housekeeping_mask);
> 
> Now while writing the above comment the following interesting scenario
> came to my mind:
> 
> Housekeeping CPUs 0-2, Isolated CPUs 3-7
> 
> Device has 4 queues. So the spreading results in:
> 
>  q0:   CPU 0/1, q1:   CPU 2/3, q2:   CPU 4/5, q3:   CPU 6/7
> 
> q1 is the interesting one. It's the one which gets the housekeeping mask
> applied and CPU3 is removed.
> 
> So if CPU2 is offline when the mask is applied, then the result of the
> affinity setting operation is going to be an error code because the
> resulting mask is empty.
> 
> Admittedly this is a weird corner case, but it's bound to happen and the
> resulting bug report is going to be hard to decode unless the reporter
> can provide a 100% reproducer or a very accurate description of the
> scenario.

Good catch, we may fallback to normal affinity when all CPUs in the
generated mask are offline.


Thanks,
Ming

