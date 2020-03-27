Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DACC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D30F2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0Rwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:52:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgC0Rwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:52:46 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F1561EC14A638CABF194;
        Fri, 27 Mar 2020 17:52:44 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 27 Mar 2020 17:52:44 +0000
Received: from [127.0.0.1] (10.47.10.23) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 27 Mar
 2020 17:52:43 +0000
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7ea4e410-72cb-db3f-f141-a2f3c70b801d@huawei.com>
Date:   Fri, 27 Mar 2020 17:52:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200316115433.9017-3-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.23]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> +
> +		/* Try the intersection of the affinity and online masks */
> +		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
> +
> +		/* If that doesn't fly, the online mask is the last resort */
> +		if (cpumask_empty(tmpmask))
> +			cpumask_copy(tmpmask, cpu_online_mask);
> +
> +		cpu = cpumask_pick_least_loaded(d, tmpmask);
> +	} else {


Hi Marc,


> +		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
> +

Please consider this flow:

- in its_irq_domain_activate()->its_select_cpu(), for a managed 
interrupt we select the target cpu from the interrupt affin mask

- then in its_set_affinity() call for the same interrupt, we may 
needlessly reselect the target cpu. This is because in the 
its_set_affinity()->its_select_cpu() call, we account for that interrupt 
in the load for the current target cpu, and may find a lesser loaded cpu 
in the mask and switch.

For example, from mask 0-5 we select cpu0 initially. Then on the 2nd 
call, we find cpu0 has a greater load (1) then cpu1 (0), and switch to cpu1.

Cheers,
John


> +		/* If we cannot cross sockets, limit the search to that node */
> +		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
> +		    node != NUMA_NO_NODE)
> +			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
> +
> +		cpu = cpumask_pick_least_loaded(d, tmpmask);
> +	}
> +out:
> +	free_cpumask_var(tmpmask);
> +
> +	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
> +	return cpu;
> +}
