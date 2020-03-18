Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AEFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010420773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584540250;
	bh=AP3k9sjl7+ePM5Ru82wMonpDrG1zEqiTg5zhPXkzWsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cRGl8xoAe2BqRrZKzJYBW4EbsoisUEMuBEoJiFAOiU0kQVpNPxTVXgSBEhlS4SyYF
	 jN9+765hPkrMdlX0qNWtkAtPfyES5cUzK1ihF77CAuHAgc7SlP2OA8rG5nfc9RiHfB
	 oG+7lSzYGEDpSZ1qH9Zm4Y1xReYtYd7WbgGmQQ+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCROEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgCROEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:04:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7916D20768;
        Wed, 18 Mar 2020 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584540248;
        bh=AP3k9sjl7+ePM5Ru82wMonpDrG1zEqiTg5zhPXkzWsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J5pn+/4MyfYEkqel5RKXFVVwjmzm2UTN4puAhPhoSLpXsEqbKSdzUi1qX+Q/5F5/f
         tSU0XpK6VFqx17NkGTO7Xb4Mnly1yzWkiWrrr3rKaypvBu94lsHUNYDpbLj6U/d86/
         VJ/qX8VmXM+V2KZiflx0ptxor/uIdmgwVGGVlk/c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jEZIk-00Denm-Ml; Wed, 18 Mar 2020 14:04:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Mar 2020 14:04:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, luojiaxing@huawei.com
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
In-Reply-To: <d3a6435b-bc1f-e518-6461-2ebff72bbc59@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <d3a6435b-bc1f-e518-6461-2ebff72bbc59@huawei.com>
Message-ID: <d74f9cb3df708335a56aec62963aa281@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, luojiaxing@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 12:22, John Garry wrote:
> I may have an idea about this:
> irq 196, cpu list 0-31, effective list 82
> 
> Just going back to comment on the code:
> 
>> +/*
>> + * As suggested by Thomas Gleixner in:
>> + * https://lore.kernel.org/r/87h80q2aoc.fsf@nanos.tec.linutronix.de
>> + */
>> +static int its_select_cpu(struct irq_data *d,
>> +			  const struct cpumask *aff_mask)
>> +{
>> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +	cpumask_var_t tmpmask;
>> +	int cpu, node;
>> +
>> +	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
>> +		return -ENOMEM;
>> +
>> +	node = its_dev->its->numa_node;
>> +
>> +	if (!irqd_affinity_is_managed(d)) {
>> +		/* First try the NUMA node */
>> +		if (node != NUMA_NO_NODE) {
>> +			/*
>> +			 * Try the intersection of the affinity mask and the
>> +			 * node mask (and the online mask, just to be safe).
>> +			 */
>> +			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
>> +			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
>> +
>> +			/* If that doesn't work, try the nodemask itself */
> 
> So if tmpmsk is empty...

Which means the proposed affinity mask isn't part of the node mask the 
first place.
Why did we get such an affinity the first place?

> 
>> +			if (cpumask_empty(tmpmask))
>> +				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
> 
>  now the tmpmask may have no intersection with the aff_mask...

But it has the mask for CPUs that are best suited for this interrupt, 
right?
If I understand the topology of your machine, it has an ITS per 64 CPUs, 
and
this device is connected to the ITS that serves the second socket.

> 
>> +
>> +			cpu = cpumask_pick_least_loaded(d, tmpmask);
>> +			if (cpu < nr_cpu_ids)
>> +				goto out;
>> +
>> +			/* If we can't cross sockets, give up */
>> +			if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
>> +				goto out;
>> +
>> +			/* If the above failed, expand the search */
>> +		}
> 
> SNIP
> 
>> +out:
>> +	free_cpumask_var(tmpmask);
>> +
>> +	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, 
>> cpumask_pr_args(aff_mask), cpu);
>> +	return cpu;
>> +}
>> +
>>   static int its_set_affinity(struct irq_data *d, const struct cpumask 
>> *mask_val,
>>   			    bool force)
>>   {
>> -	unsigned int cpu;
>> -	const struct cpumask *cpu_mask = cpu_online_mask;
>>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>   	struct its_collection *target_col;
>>   	u32 id = its_get_event_id(d);
>> +	int cpu;
>>     	/* A forwarded interrupt should use irq_set_vcpu_affinity */
>>   	if (irqd_is_forwarded_to_vcpu(d))
>>   		return -EINVAL;
>>   -       /* lpi cannot be routed to a redistributor that is on a 
>> foreign node */
>> -	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
>> -		if (its_dev->its->numa_node >= 0) {
>> -			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>> -			if (!cpumask_intersects(mask_val, cpu_mask))
>> -				return -EINVAL;
>> -		}
>> -	}
>> -
>> -	cpu = cpumask_any_and(mask_val, cpu_mask);
>> +	if (!force)
>> +		cpu = its_select_cpu(d, mask_val);
>> +	else
>> +		cpu = cpumask_pick_least_loaded(d, mask_val);
>>   -	if (cpu >= nr_cpu_ids)
>> +	if (cpu < 0 || cpu >= nr_cpu_ids)
>>   		return -EINVAL;
> 
> Annotate missing code:
> 
> 	if (cpu < 0 || cpu >= nr_cpu_ids)
> 		return -EINVAL;
> 
> 	if (cpu != its_dev->event_map.col_map[id]) {
> 		its_inc_lpi_count(d, cpu);
> 		its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
> 		target_col = &its_dev->its->collections[cpu];
> 		its_send_movi(its_dev, target_col, id);
> 		its_dev->event_map.col_map[id] = cpu;
> 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
> 	}
> 
> So cpu may not be a member of mask_val. Hence the inconsistency of the
> affinity list and effective affinity. We could just drop the AND of
> the ITS node mask in its_select_cpu().

That would be a departure from the algorithm Thomas proposed, which made
a lot of sense in my opinion. What its_select_cpu() does in this case is
probably the best that can be achieved from a latency perspective,
as it keeps the interrupt local to the socket that generated it.

What I wonder is how we end-up with this silly aff_mask the first place.

> Anyway, I don't think that this should stop us testing.

Agreed.

         M.
-- 
Jazz is not dead. It just smells funny...
