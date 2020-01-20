Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A01C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6822525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgATSVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:21:07 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgATSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:21:06 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AC278672C0F077319EE7;
        Mon, 20 Jan 2020 18:21:03 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 Jan 2020 18:21:03 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 18:21:03 +0000
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across
 CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20200119190554.1002-1-maz@kernel.org>
 <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
 <afb60c5f9a176470449a83126db326a9@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com>
Date:   Mon, 20 Jan 2020 18:21:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <afb60c5f9a176470449a83126db326a9@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2020 17:42, Marc Zyngier wrote:

Hi Marc,

>>>      static u64 its_irq_get_msi_base(struct its_device *its_dev)
>>> @@ -2773,28 +2829,34 @@ static int its_irq_domain_activate(struct
>>> irq_domain *domain,
>>>    {
>>>    	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>>    	u32 event = its_get_event_id(d);
>>> -	const struct cpumask *cpu_mask = cpu_online_mask;
>>> -	int cpu;
>>> +	int ret = 0, cpu = nr_cpu_ids;
>>> +	const struct cpumask *reqmask;
>>> +	cpumask_var_t mask;
>>>    -	/* get the cpu_mask of local node */
>>> -	if (its_dev->its->numa_node >= 0)
>>> -		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>>> +	if (irqd_affinity_is_managed(d))
>>> +		reqmask = irq_data_get_affinity_mask(d);
>>> +	else
>>> +		reqmask = cpu_online_mask;
>>>    -	/* Bind the LPI to the first possible CPU */
>>> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>>> -	if (cpu >= nr_cpu_ids) {
>>> -		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
>>> -			return -EINVAL;
>>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>>> +		return -ENOMEM;
>>>    -		cpu = cpumask_first(cpu_online_mask);
>>> +	its_compute_affinity(d, reqmask, mask);
>>> +	cpu = its_pick_target_cpu(mask);
>>> +	if (cpu >= nr_cpu_ids) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>>    	}
>>>    +	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>>
>> I wonder if we should only consider managed interrupts in this
>> accounting?
>>
>> So cpu0 is effectively going to be excluded from the balancing, as it
>> will have so many lpis targeted.
> 
> Maybe, but only if the provided managed affinity gives you the
> opportunity of placing the LPI somewhere else. 

Of course, if there's no other cpu in the mask then so be it.

If the managed
> affinity says CPU0 only, then that's where you end up.
> 

If my debug code is correct (with the above fix), cpu0 had 763 
interrupts targeted on my D06 initially :)

But it's not just cpu0. I find initial non-managed interrupt affinity 
masks are set generally on cpu cluster/numa node masks, so the first 
cpus in those masks are bit over-subscribed, so then we may be spreading 
the managed interrupts over less cpus in the mask.

This is a taste of lpi distribution on my 96 core system:
cpu0 763
cpu1 2
cpu3 1
cpu4 2
cpu5 2
cpu6 0
cpu7 0
cpu8 2
cpu9 1
cpu10 0
...
cpu16 2
...
cpu24 8
...
cpu48 10 (numa node boundary)
...


>> And, for the others, even if we balance all the LPIs, won't irqbalance
>> (if running, obviously) can come along and fiddle with these
>> non-managed interrupt affinities anyway?
> 
> Of course, irqbalance will move things around. But that should be to
> CPUs that do not have too many screaming interrupts.
> 
> Thanks,
> 
>           M.

Cheers,
John

> 

