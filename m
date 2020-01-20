Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF862253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579545938;
	bh=GKQ3rDnjK9IbSwvFEZ4WhIRwBDBJ/V/VTOK18okuPuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pinFQWHZB5cdXGt/f1ILbH6Tx4danvaT0+vrZzkAEcjA5b7g13G4JdxCD7nr4c2Ja
	 A3LmuaCcr3fBu7NCt4zHG+0XQKT3/sZio6J/qno5BHsboYydv3fA0BcrmHd3jzJxQz
	 8mY9Jv2oxAshYCWHfmnwzebyp7hNKz7VA72WedMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgATSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:45:37 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0888E22314;
        Mon, 20 Jan 2020 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579545936;
        bh=GKQ3rDnjK9IbSwvFEZ4WhIRwBDBJ/V/VTOK18okuPuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qLQingpcI7+TdI/FQhbMWN3c3xnUrKTUJJH9BGqISwXcwUrkNvQAz3Nqw/Jhqb+EQ
         nDrAYmNj7rNT2DRQ5kbfy9CtoGLV4843DPpmNmqkKnImDJYZUl0+EkMPyo1FJeWWQ3
         /XcqY9sYOy/DoLUt2YG6ae5n5elIKiAllRF9clqY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itc3K-000LQB-9L; Mon, 20 Jan 2020 18:45:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 18:45:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across
 CPUs
In-Reply-To: <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com>
References: <20200119190554.1002-1-maz@kernel.org>
 <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
 <afb60c5f9a176470449a83126db326a9@kernel.org>
 <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com>
Message-ID: <7dc37b35d8ec6c78e75969d8c6c2d2e9@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, ming.lei@redhat.com, chenxiang66@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2020-01-20 18:21, John Garry wrote:
> On 20/01/2020 17:42, Marc Zyngier wrote:
> 
> Hi Marc,
> 
>>>>      static u64 its_irq_get_msi_base(struct its_device *its_dev)
>>>> @@ -2773,28 +2829,34 @@ static int its_irq_domain_activate(struct
>>>> irq_domain *domain,
>>>>    {
>>>>    	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>>>    	u32 event = its_get_event_id(d);
>>>> -	const struct cpumask *cpu_mask = cpu_online_mask;
>>>> -	int cpu;
>>>> +	int ret = 0, cpu = nr_cpu_ids;
>>>> +	const struct cpumask *reqmask;
>>>> +	cpumask_var_t mask;
>>>>    -	/* get the cpu_mask of local node */
>>>> -	if (its_dev->its->numa_node >= 0)
>>>> -		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>>>> +	if (irqd_affinity_is_managed(d))
>>>> +		reqmask = irq_data_get_affinity_mask(d);
>>>> +	else
>>>> +		reqmask = cpu_online_mask;
>>>>    -	/* Bind the LPI to the first possible CPU */
>>>> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>>>> -	if (cpu >= nr_cpu_ids) {
>>>> -		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
>>>> -			return -EINVAL;
>>>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>>>> +		return -ENOMEM;
>>>>    -		cpu = cpumask_first(cpu_online_mask);
>>>> +	its_compute_affinity(d, reqmask, mask);
>>>> +	cpu = its_pick_target_cpu(mask);
>>>> +	if (cpu >= nr_cpu_ids) {
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>>    	}
>>>>    +	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>>> 
>>> I wonder if we should only consider managed interrupts in this
>>> accounting?
>>> 
>>> So cpu0 is effectively going to be excluded from the balancing, as it
>>> will have so many lpis targeted.
>> 
>> Maybe, but only if the provided managed affinity gives you the
>> opportunity of placing the LPI somewhere else.
> 
> Of course, if there's no other cpu in the mask then so be it.
> 
> If the managed
>> affinity says CPU0 only, then that's where you end up.
>> 
> 
> If my debug code is correct (with the above fix), cpu0 had 763
> interrupts targeted on my D06 initially :)

You obviously have too many devices in this machine... ;-)

> But it's not just cpu0. I find initial non-managed interrupt affinity
> masks are set generally on cpu cluster/numa node masks, so the first
> cpus in those masks are bit over-subscribed, so then we may be
> spreading the managed interrupts over less cpus in the mask.
> 
> This is a taste of lpi distribution on my 96 core system:
> cpu0 763
> cpu1 2
> cpu3 1
> cpu4 2
> cpu5 2
> cpu6 0
> cpu7 0
> cpu8 2
> cpu9 1
> cpu10 0
> ...
> cpu16 2
> ...
> cpu24 8
> ...
> cpu48 10 (numa node boundary)
> ...

We're stuck between a rock and a hard place here:

(1) We place all interrupts on the least loaded CPU that matches
     the affinity -> results in performance issues on some funky
     HW (like D05's SAS controller).

(2) We place managed interrupts on the least loaded CPU that matches
     the affinity -> we have artificial load on NUMA boundaries, and
     reduced spread of overlapping managed interrupts.

(3) We don't account for non-managed LPIs, and we run the risk of
     unpredictable performance because we don't really know where
     the *other* interrupts are.

My personal preference would be to go for (1), as in my original post.
I find (3) the least appealing, because we don't track things anymore.
(2) feels like "the least of all evils", as it is a decent performance
gain, seems to give predictable performance, and doesn't regress lesser
systems...

I'm definitely open to suggestions here.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
