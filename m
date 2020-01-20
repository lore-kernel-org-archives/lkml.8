Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1ABC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95192253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579542149;
	bh=biE8XwY4Bo1jeifjqLoLYliUDwbfeJrTbEIeWR0wp0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wgI6C0bU9/HnrpbxSr2MCxSHOy0nXhr5iagbDtJj3E1Kb3Rdzdga++zO+OGx/QTXE
	 QFfU9ZzIorZS8eIDjumb4wFE1CqpFpDwcateiK61O828AJbnDKFbxpoWiCrnrg0i1P
	 3IBpK2K2U4Q0OWylCfwCbpW+w9IOcOGR/5wdz3aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgATRm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATRm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:42:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C8222525;
        Mon, 20 Jan 2020 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579542147;
        bh=biE8XwY4Bo1jeifjqLoLYliUDwbfeJrTbEIeWR0wp0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wdUjSK2O7jNEkod2V97X0+Itooei3EqRHR5TBDuU+NGRVtNIFdarkmauC4cWFp8KZ
         cbgQBXuFriazpYCDlF16co1zvnc3GH0sEah1251zj4nKQHFyjVV4Fhu7A8KZVN6JaM
         H2iPdSMuZQ5S/ZiNtLlmrOkVoZxEXXO5vZTdbAwk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itb4D-000KZ3-Kv; Mon, 20 Jan 2020 17:42:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 17:42:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across
 CPUs
In-Reply-To: <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
References: <20200119190554.1002-1-maz@kernel.org>
 <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
Message-ID: <afb60c5f9a176470449a83126db326a9@kernel.org>
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

On 2020-01-20 16:13, John Garry wrote:
> On 19/01/2020 19:05, Marc Zyngier wrote:> When mapping a LPI, the ITS
> driver picks the first possible> affinity, which is in most cases
> CPU0, assuming that if> that's not suitable, someone will come and set
> the affinity> to something more interesting.> > It apparently isn't
> the case, and people complain of poor> performance when many
> interrupts are glued to the same CPU.> So let's place the interrupts
> by finding the "least loaded"> CPU (that is, the one that has the
> fewer LPIs mapped to it).> So called 'managed' interrupts are an
> interesting case where> the affinity is actually dictated by the
> kernel itself, and> we should honor this.> > Reported-by: John Garry
> <john.garry@huawei.com>> Link:
> https://lore.kernel.org/r/1575642904-58295-1-git-send-email-john.garry@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> So I tested on NVMe, and it showed a good performance boost - maybe
> ~20% for 2x NVMe disks on my D06. But a couple of comments below:
> 
> Thanks,
> John
> 
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 120 
>> +++++++++++++++++++++++--------
>>   1 file changed, 92 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index e05673bcd52b..ec50cc1b11a3 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -177,6 +177,8 @@ static DEFINE_IDA(its_vpeid_ida);
>>   #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>>   #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + 
>> SZ_128K)
>>   +static DEFINE_PER_CPU(atomic_t, cpu_lpi_count);
>> +
>>   static u16 get_its_list(struct its_vm *vm)
>>   {
>>   	struct its_node *its;
>> @@ -1287,42 +1289,96 @@ static void its_unmask_irq(struct irq_data *d)
>>   	lpi_update_config(d, 0, LPI_PROP_ENABLED);
>>   }
>>   +static int its_pick_target_cpu(const struct cpumask *cpu_mask)
>> +{
>> +	unsigned int cpu = nr_cpu_ids, tmp;
>> +	int count = S32_MAX;
>> +
>> +	/*
>> +	 * If we're only picking one of the online CPUs, just pick the
>> +	 * first one (there are drivers that depend on this behaviour).
>> +	 * At some point, we'll have to weed them out.
>> +	 */
>> +	if (cpu_mask == cpu_online_mask)
> 
> should this use cpumask_equal()?

Oops. yes. Good point.

> 
>> +		return cpumask_first(cpu_mask);
>> +
>> +	for_each_cpu(tmp, cpu_mask) {
>> +		int this_count = per_cpu(cpu_lpi_count, tmp).counter;
>> +		if (this_count < count) {
>> +			cpu = tmp;
>> +		        count = this_count;
>> +		}
>> +	}
>> +
>> +	return cpu;
>> +}
>> +
>> +static void its_compute_affinity(struct irq_data *d,
>> +				 const struct cpumask *requested,
>> +				 struct cpumask *computed)
>> +{
>> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +
>> +	cpumask_and(computed, requested, cpu_online_mask);
>> +
>> +	/* LPI cannot be routed to a redistributor that is on a foreign node 
>> */
>> +	if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
>> +	    its_dev->its->numa_node >= 0)
>> +		cpumask_and(computed, computed,
>> +			    cpumask_of_node(its_dev->its->numa_node));
>> +}
>> +
>>   static int its_set_affinity(struct irq_data *d, const struct cpumask 
>> *mask_val,
>>   			    bool force)
>>   {
>> -	unsigned int cpu;
>> -	const struct cpumask *cpu_mask = cpu_online_mask;
>>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -	struct its_collection *target_col;
>> +	int ret = IRQ_SET_MASK_OK_DONE;
>>   	u32 id = its_get_event_id(d);
>> +	cpumask_var_t tmpmask;
>> +	struct cpumask *mask;
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
>> +	if (!force) {
>> +		if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
>> +			return -ENOMEM;
>> +
>> +		mask = tmpmask;
>> +		its_compute_affinity(d, mask_val, mask);
>> +	} else	{
>> +		mask = (struct cpumask *)mask_val;
>>   	}
>>   -	cpu = cpumask_any_and(mask_val, cpu_mask);
>> +	if (cpumask_empty(mask)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>>   -	if (cpu >= nr_cpu_ids)
>> -		return -EINVAL;
>> +	if (!cpumask_test_cpu(its_dev->event_map.col_map[id], mask)) {
>> +		struct its_collection *target_col;
>> +		int cpu;
>> +
>> +		cpu = its_pick_target_cpu(mask);
>> +		if (cpu >= nr_cpu_ids) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>>   -	/* don't set the affinity when the target cpu is same as current 
>> one */
>> -	if (cpu != its_dev->event_map.col_map[id]) {
>> +		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>> +		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
>> +				       its_dev->event_map.col_map[id]));
>>   		target_col = &its_dev->its->collections[cpu];
>>   		its_send_movi(its_dev, target_col, id);
>>   		its_dev->event_map.col_map[id] = cpu;
>>   		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   	}
>>   -	return IRQ_SET_MASK_OK_DONE;
>> +out:
>> +	if (!force)
>> +		free_cpumask_var(tmpmask);
>> +	return ret;
>>   }
>>     static u64 its_irq_get_msi_base(struct its_device *its_dev)
>> @@ -2773,28 +2829,34 @@ static int its_irq_domain_activate(struct 
>> irq_domain *domain,
>>   {
>>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>   	u32 event = its_get_event_id(d);
>> -	const struct cpumask *cpu_mask = cpu_online_mask;
>> -	int cpu;
>> +	int ret = 0, cpu = nr_cpu_ids;
>> +	const struct cpumask *reqmask;
>> +	cpumask_var_t mask;
>>   -	/* get the cpu_mask of local node */
>> -	if (its_dev->its->numa_node >= 0)
>> -		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>> +	if (irqd_affinity_is_managed(d))
>> +		reqmask = irq_data_get_affinity_mask(d);
>> +	else
>> +		reqmask = cpu_online_mask;
>>   -	/* Bind the LPI to the first possible CPU */
>> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>> -	if (cpu >= nr_cpu_ids) {
>> -		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
>> -			return -EINVAL;
>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>> +		return -ENOMEM;
>>   -		cpu = cpumask_first(cpu_online_mask);
>> +	its_compute_affinity(d, reqmask, mask);
>> +	cpu = its_pick_target_cpu(mask);
>> +	if (cpu >= nr_cpu_ids) {
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   +	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
> 
> I wonder if we should only consider managed interrupts in this 
> accounting?
> 
> So cpu0 is effectively going to be excluded from the balancing, as it
> will have so many lpis targeted.

Maybe, but only if the provided managed affinity gives you the
opportunity of placing the LPI somewhere else. If the managed
affinity says CPU0 only, then that's where you end up.

> And, for the others, even if we balance all the LPIs, won't irqbalance
> (if running, obviously) can come along and fiddle with these
> non-managed interrupt affinities anyway?

Of course, irqbalance will move things around. But that should be to
CPUs that do not have too many screaming interrupts.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
