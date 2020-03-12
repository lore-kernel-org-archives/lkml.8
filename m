Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0C0206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCLPlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:41:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2555 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbgCLPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:41:49 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EBBAC556BB58C6108539;
        Thu, 12 Mar 2020 15:41:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Mar 2020 15:41:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Mar
 2020 15:41:47 +0000
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>
References: <20200312115552.29185-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d23436b5-a207-91e9-be11-f5d0e44b6e12@huawei.com>
Date:   Thu, 12 Mar 2020 15:41:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200312115552.29185-1-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 11:55, Marc Zyngier wrote:

Hi Marc,

> When mapping a LPI, the ITS driver picks the first possible
> affinity, which is in most cases CPU0, assuming that if
> that's not suitable, someone will come and set the affinity
> to something more interesting.
> 
> It apparently isn't the case, and people complain of poor
> performance when many interrupts are glued to the same CPU.
> So let's place the interrupts by finding the "least loaded"
> CPU (that is, the one that has the fewer LPIs mapped to it).
> So called 'managed' interrupts are an interesting case where
> the affinity is actually dictated by the kernel itself, and
> we should honor this.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Link: https://lore.kernel.org/r/1575642904-58295-1-git-send-email-john.garry@huawei.com
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
> Reviving this at John's request.

Thanks very much. I may request a colleague test this due to possible 
precautionary office closure.

  The major change is that the
> affinity follows the x86 model, as described by Thomas.

There seems to be a subtle difference between this implementation and 
what Thomas described for managed interrupts handling on x86. That 
being, managed interrupt loading is counted separately to total 
interrupts per CPU for x86. That seems quite important so that we spread 
managed interrupts evenly.

> I expect this to have an impact on platforms like D05, where
> the SAS driver cannot use managed affinity just yet.

I need some blk-mq and SCSI changes to go in first to improve the 
interrupt handling there, hopefully we can make progress on that soon.

Thanks,
John

> 
>   drivers/irqchip/irq-gic-v3-its.c | 125 ++++++++++++++++++++++++-------
>   1 file changed, 99 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 70d612adf15f..ee5568c20212 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -189,6 +189,8 @@ static DEFINE_IDA(its_vpeid_ida);
>   #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>   #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>   
> +static DEFINE_PER_CPU(atomic_t, cpu_lpi_count);
> +
>   static u16 get_its_list(struct its_vm *vm)
>   {
>   	struct its_node *its;
> @@ -1500,35 +1502,113 @@ static void its_unmask_irq(struct irq_data *d)
>   	lpi_update_config(d, 0, LPI_PROP_ENABLED);
>   }
>   
> +static unsigned int cpumask_pick_least_loaded(const struct cpumask *cpu_mask)
> +{

> +	unsigned int cpu = nr_cpu_ids, tmp;
> +	int count = S32_MAX;
> +
> +	for_each_cpu(tmp, cpu_mask) {
> +		int this_count = atomic_read(per_cpu_ptr(&cpu_lpi_count, tmp));
> +		if (this_count < count) {
> +			cpu = tmp;
> +		        count = this_count;
> +		}
> +	}
> +
> +	return cpu;
> +}
> +
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
> +			if (cpumask_empty(tmpmask))
> +				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
> +
> +			cpu = cpumask_pick_least_loaded(tmpmask);
> +			if (cpu < nr_cpu_ids)
> +				goto out;
> +
> +			/* If we can't cross sockets, give up */
> +			if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
> +				goto out;
> +
> +			/* If the above failed, expand the search */
> +		}
> +
> +		/* Try the intersection of the affinity and online masks */
> +		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
> +
> +		/* If that doesn't fly, the online mask is the last resort */
> +		if (cpumask_empty(tmpmask))
> +			cpumask_copy(tmpmask, cpu_online_mask);
> +
> +		cpu = cpumask_pick_least_loaded(tmpmask);
> +	} else {
> +		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
> +
> +		/* If we cannot cross sockets, limit the search to that node */
> +		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
> +		    node != NUMA_NO_NODE)
> +			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
> +
> +		cpu = cpumask_pick_least_loaded(tmpmask);
> +	}
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
> +		cpu = cpumask_pick_least_loaded(mask_val);
>   
> -	if (cpu >= nr_cpu_ids)
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
>   		return -EINVAL;
>   
>   	/* don't set the affinity when the target cpu is same as current one */
>   	if (cpu != its_dev->event_map.col_map[id]) {
> +		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
> +		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
> +				       its_dev->event_map.col_map[id]));
>   		target_col = &its_dev->its->collections[cpu];
>   		its_send_movi(its_dev, target_col, id);
>   		its_dev->event_map.col_map[id] = cpu;
> @@ -3390,22 +3470,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>   {
>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>   	u32 event = its_get_event_id(d);
> -	const struct cpumask *cpu_mask = cpu_online_mask;
>   	int cpu;
>   
> -	/* get the cpu_mask of local node */
> -	if (its_dev->its->numa_node >= 0)
> -		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
> -
> -	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> -	if (cpu >= nr_cpu_ids) {
> -		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
> -			return -EINVAL;
> -
> -		cpu = cpumask_first(cpu_online_mask);
> -	}
> +	cpu = its_select_cpu(d, cpu_online_mask);
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;
>   
> +	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>   	its_dev->event_map.col_map[event] = cpu;
>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>   
> @@ -3420,6 +3491,8 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>   	u32 event = its_get_event_id(d);
>   
> +	atomic_dec(per_cpu_ptr(&cpu_lpi_count,
> +			       its_dev->event_map.col_map[event]));
>   	/* Stop the delivery of interrupts */
>   	its_send_discard(its_dev, event);
>   }
> 

