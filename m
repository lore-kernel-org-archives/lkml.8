Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEDEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1052073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589537685;
	bh=Rm55P1g29RzmulH7WYu/+UpeNv0RkBorxUspG69nAe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VMwDGjXAmYEJYDtTDf5c91akV66HmDUSrJxVeajDqnqgTt8Jfo8CJYNqB9mgm7YfD
	 pUPlf9+zLAA8moFBevL3VcvCH4P7pKhedXM/o1alrVrd07srNJNfze9UMHL5+6aWxR
	 ZP3wdGS8gWFsCDRDPk8XV9s86DSmQM9b+VPqzLkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEOKOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgEOKOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:14:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E861720709;
        Fri, 15 May 2020 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589537682;
        bh=Rm55P1g29RzmulH7WYu/+UpeNv0RkBorxUspG69nAe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rtJvRrplSZRXulBMsWFJ2z53lp+Vt9sScf22YYTzJM2E+tIbzZAekmbAo4K5rYiof
         0HjEReDOAa08syurR0BYOBW8JAqgLwUIrufxJM2zIJ28vDYge9S2D9xGqx2H2oQ6BG
         4Nng4SJJbR/CAp/9TOi3RMt+aHBWlL3c31tGBgKA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZXMW-00CX9a-1u; Fri, 15 May 2020 11:14:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 15 May 2020 11:14:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        chenxiang <chenxiang66@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>, luojiaxing@huawei.com,
        Ming Lei <ming.lei@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
In-Reply-To: <7c05b08b-2edc-7f97-0175-898e9772673e@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
 <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
 <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
 <7c05b08b-2edc-7f97-0175-898e9772673e@huawei.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <668f819c8747104814245cd6faebdd9a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net, chenxiang66@hisilicon.com, robin.murphy@arm.com, luojiaxing@huawei.com, ming.lei@redhat.com, wangzhou1@hisilicon.com, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2020-05-14 13:05, John Garry wrote:
>> 
>> +       its_inc_lpi_count(d, cpu);
>> +
>>          return IRQ_SET_MASK_OK_DONE;
>>   }
>> 
>> Results look ok:
>>      nvme.use_threaded_interrupts=1    =0*
>> Before    950K IOPs            1000K IOPs
>> After    1100K IOPs            1150K IOPs
>> 
>> * as mentioned before, this is quite unstable and causes lockups. 
>> JFYI, there was an attempt to fix this:
>> 
>> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/
>> 
> 
> Hi Marc,
> 
> Just wondering if we can try to get this series over the line?

Absolutely. Life has got in the way, so let me page it back in...

> So I tested the patches on v5.7-rc5, and get similar performance
> improvement to above.
> 
> I did apply a couple of patches, below, to remedy the issues I
> experienced for my D06CS.

Comments on that below.

> 
> Thanks,
> John
> 
> 
> ---->8
> 
> 
> [PATCH 1/2] irqchip/gic-v3-its: Don't double account for target CPU
>  assignment
> 
> In its_set_affinity(), when a managed irq is already assigned to a CPU,
> we may needlessly reassign the irq to another CPU.
> 
> This is because when selecting the target CPU, being the least loaded
> CPU in the mask, we account of that irq still being assigned to a CPU;
> thereby we may unfairly select another CPU.
> 
> Modify this behaviour to pre-decrement the current target CPU LPI count
> when finding the least loaded CPU.
> 
> Alternatively we may be able to just bail out early when the current
> target CPU already falls within the requested mask.
> 
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 73f5c12..2b18feb 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1636,6 +1636,8 @@ static int its_set_affinity(struct irq_data *d,
> const struct cpumask *mask_val,
>  	if (irqd_is_forwarded_to_vcpu(d))
>  		return -EINVAL;
> 
> +	its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
> +
>  	if (!force)
>  		cpu = its_select_cpu(d, mask_val);
>  	else
> @@ -1646,14 +1648,14 @@ static int its_set_affinity(struct irq_data
> *d, const struct cpumask *mask_val,
> 
>  	/* don't set the affinity when the target cpu is same as current one 
> */
>  	if (cpu != its_dev->event_map.col_map[id]) {
> -		its_inc_lpi_count(d, cpu);
> -		its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
>  		target_col = &its_dev->its->collections[cpu];
>  		its_send_movi(its_dev, target_col, id);
>  		its_dev->event_map.col_map[id] = cpu;
>  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  	}
> 
> +	its_inc_lpi_count(d, cpu);
> +

I'm OK with that change, as it removes unnecessary churn.

>  	return IRQ_SET_MASK_OK_DONE;
>  }
> 
> ---
> 
> 
> [PATCH 2/2] irqchip/gic-v3-its: Handle no overlap of non-managed irq
>  affinity mask
> 
> In selecting the target CPU for a non-managed interrupt, we may select 
> a
> target CPU outside the requested affinity mask.
> 
> This is because there may be no overlap of the ITS node mask and the
> requested CPU affinity mask. The requested affinity mask may be coming
> from userspace or some drivers which try to set irq affinity, see [0].
> 
> In this case, just ignore the ITS node cpumask. This is a deviation 
> from
> what Thomas described. Having said that, I am not sure if the
> interrupt is ever bound to a node for us.
> 
> [0] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/hisilicon/hisi_uncore_pmu.c#n417
> 
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 2b18feb..12d5d4b4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1584,10 +1584,6 @@ static int its_select_cpu(struct irq_data *d,
>  			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
>  			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
> 
> -			/* If that doesn't work, try the nodemask itself */
> -			if (cpumask_empty(tmpmask))
> -				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
> -
>  			cpu = cpumask_pick_least_loaded(d, tmpmask);
>  			if (cpu < nr_cpu_ids)
>  				goto out;

I'm really not sure. Shouldn't we then drop the wider search on
cpu_inline_mask, because userspace could have given us something
that we cannot deal with?

What you are advocating for is a strict adherence to the provided
mask, and it doesn't seem to be what other architectures are providing.
I consider the userspace-provided affinity as a hint more that anything
else, as in this case the kernel does know better (routing the interrupt
to a foreign node might be costly, or even impossible, see the TX1
erratum).

 From what I remember of the earlier discussion, you saw an issue on
a system with two sockets and a single ITS, with the node mask limited
to the first socket. Is that correct?

I'll respin the series today and report it with you first patch
squased in.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
