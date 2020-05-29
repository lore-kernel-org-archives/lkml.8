Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A25C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8295214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgE2EHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:07:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbgE2EHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:07:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1A4569FBB21838E7DBA;
        Fri, 29 May 2020 12:07:50 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 12:07:42 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
To:     Ali Saidi <alisaidi@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <benh@amazon.com>, <zorik@amazon.com>, <zeev@amazon.com>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.com>
References: <20200529015501.15771-1-alisaidi@amazon.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f463c9cd-6078-4c57-d5c9-72c7018f25ef@huawei.com>
Date:   Fri, 29 May 2020 12:07:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200529015501.15771-1-alisaidi@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/5/29 9:55, Ali Saidi wrote:
> If an interrupt is disabled the ITS driver has sent a discard removing
> the DeviceID and EventID from the ITT. After this occurs it can't be
> moved to another collection with a MOVI and a command error occurs if
> attempted. Before issuing the MOVI command make sure that the IRQ isn't
> disabled and change the activate code to try and use the previous
> affinity.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 124251b0ccba..1235dd9a2fb2 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1540,7 +1540,11 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>   	/* don't set the affinity when the target cpu is same as current one */
>   	if (cpu != its_dev->event_map.col_map[id]) {
>   		target_col = &its_dev->its->collections[cpu];
> -		its_send_movi(its_dev, target_col, id);
> +
> +		/* If the IRQ is disabled a discard was sent so don't move */
> +		if (!irqd_irq_disabled(d))
> +			its_send_movi(its_dev, target_col, id);

It looks to me that if the IRQ is disabled, we mask the enable bit in
the corresponding LPI configuration table entry, but not sending DISCARD
to remove the DevID/EventID mapping. And moving a disabled LPI is
actually allowed by the GIC architecture, right?

> +
>   		its_dev->event_map.col_map[id] = cpu;
>   		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>   	}
> @@ -3439,8 +3443,16 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>   	if (its_dev->its->numa_node >= 0)
>   		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>   
> -	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	/* If the cpu set to a different CPU that is still online use it */
> +	cpu = its_dev->event_map.col_map[event];
> +
> +	cpumask_and(cpu_mask, cpu_mask, cpu_online_mask);
> +
> +	if (!cpumask_test_cpu(cpu, cpu_mask)) {
> +		/* Bind the LPI to the first possible CPU */
> +		cpu = cpumask_first(cpu_mask);
> +	}

I'd like to know what actual problem you had seen and the way to
reproduce it :-)


Thanks,
Zenghui
