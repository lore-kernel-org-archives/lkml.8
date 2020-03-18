Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7500C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D55420772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCRMWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:22:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2573 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCRMWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:22:24 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C98881FDEC3ADA6D060B;
        Wed, 18 Mar 2020 12:22:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Mar 2020 12:22:22 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Mar
 2020 12:22:21 +0000
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d3a6435b-bc1f-e518-6461-2ebff72bbc59@huawei.com>
Date:   Wed, 18 Mar 2020 12:22:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200316115433.9017-3-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I may have an idea about this:
irq 196, cpu list 0-31, effective list 82

Just going back to comment on the code:

> +/*
> + * As suggested by Thomas Gleixner in:
> + * https://lore.kernel.org/r/87h80q2aoc.fsf@nanos.tec.linutronix.de
> + */
> +static int its_select_cpu(struct irq_data *d,
> +			  const struct cpumask *aff_mask)
> +{
> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +	cpumask_var_t tmpmask;
> +	int cpu, node;
> +
> +	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	node = its_dev->its->numa_node;
> +
> +	if (!irqd_affinity_is_managed(d)) {
> +		/* First try the NUMA node */
> +		if (node != NUMA_NO_NODE) {
> +			/*
> +			 * Try the intersection of the affinity mask and the
> +			 * node mask (and the online mask, just to be safe).
> +			 */
> +			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
> +			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
> +
> +			/* If that doesn't work, try the nodemask itself */

So if tmpmsk is empty...

> +			if (cpumask_empty(tmpmask))
> +				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);

  now the tmpmask may have no intersection with the aff_mask...

> +
> +			cpu = cpumask_pick_least_loaded(d, tmpmask);
> +			if (cpu < nr_cpu_ids)
> +				goto out;
> +
> +			/* If we can't cross sockets, give up */
> +			if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
> +				goto out;
> +
> +			/* If the above failed, expand the search */
> +		}

SNIP

> +out:
> +	free_cpumask_var(tmpmask);
> +
> +	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
> +	return cpu;
> +}
> +
>   static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>   			    bool force)
>   {
> -	unsigned int cpu;
> -	const struct cpumask *cpu_mask = cpu_online_mask;
>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>   	struct its_collection *target_col;
>   	u32 id = its_get_event_id(d);
> +	int cpu;
>   
>   	/* A forwarded interrupt should use irq_set_vcpu_affinity */
>   	if (irqd_is_forwarded_to_vcpu(d))
>   		return -EINVAL;
>   
> -       /* lpi cannot be routed to a redistributor that is on a foreign node */
> -	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
> -		if (its_dev->its->numa_node >= 0) {
> -			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
> -			if (!cpumask_intersects(mask_val, cpu_mask))
> -				return -EINVAL;
> -		}
> -	}
> -
> -	cpu = cpumask_any_and(mask_val, cpu_mask);
> +	if (!force)
> +		cpu = its_select_cpu(d, mask_val);
> +	else
> +		cpu = cpumask_pick_least_loaded(d, mask_val);
>   
> -	if (cpu >= nr_cpu_ids)
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
>   		return -EINVAL;

Annotate missing code:

	if (cpu < 0 || cpu >= nr_cpu_ids)
		return -EINVAL;

	if (cpu != its_dev->event_map.col_map[id]) {
		its_inc_lpi_count(d, cpu);
		its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
		target_col = &its_dev->its->collections[cpu];
		its_send_movi(its_dev, target_col, id);
		its_dev->event_map.col_map[id] = cpu;
		irq_data_update_effective_affinity(d, cpumask_of(cpu));
	}

So cpu may not be a member of mask_val. Hence the inconsistency of the 
affinity list and effective affinity. We could just drop the AND of the 
ITS node mask in its_select_cpu().

Anyway, I don't think that this should stop us testing.

Cheers,
John
