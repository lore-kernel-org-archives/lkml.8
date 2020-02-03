Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26743C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040322086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgBCPAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:00:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgBCPAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:00:44 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E6D5F686E93FC46A28C9;
        Mon,  3 Feb 2020 15:00:39 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 15:00:39 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 15:00:39 +0000
Subject: Re: About irq_create_affinity_masks() for a platform device driver
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
 <87o8uveoye.fsf@nanos.tec.linutronix.de>
 <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com>
 <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com>
 <87ftfvuww7.fsf@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2b381b20-512a-27a5-38d7-2f6a673bb621@huawei.com>
Date:   Mon, 3 Feb 2020 15:00:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87ftfvuww7.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

>>
>> 	pirqs = kzalloc(*count * sizeof(int), GFP_KERNEL);
>> 	if (!pirqs)
>> 		return -ENOMEM;
>>
>> 	dev->desc = irq_create_affinity_masks(*count, affd);
>> 	if (!dev->desc) {
>> 		kfree(irqs);
> 
> pirqs I assume and this also leaks the affinity masks and the pointer in
> dev.

Right

> 
>> 		return -ENOMEM;
>> 	}
>>
>> 	for (i = 0; i < *count; i++) {
>> 		pirqs[i] = platform_get_irq(dev, i);
>> 		if (irqs[i] < 0) {
>> 			kfree(dev->desc);
>> 			kfree(irqs);
>> 			return -ENOMEM;
> 
> That's obviously broken as well :)

Right, again

> 
>> 		}
>> 	}
>>
>> 	*irqs = pirqs;
>>
>> 	return 0;
>> }
>> EXPORT_SYMBOL_GPL(platform_get_irqs_affinity);

[...]

> 
> I wouldn't mind to expose a function which allows you to switch the
> allocated interrupts to managed. The reason why we do it in one go in
> the PCI code is that we get automatically the irq descriptors allocated
> on the correct node. So if the node aware allocation is not a
> showstopper 

I wouldn't say so for now.

for this then your function would do:
> 
> 	...
> 	for (i = 0; i < count; i++) {
> 		pirqs[i] = platform_get_irq(dev, i);
> 
>                  irq_update_affinity_desc(pirqs[i], affdescs + i);
> 
>          }
> 
> int irq_update_affinity_desc(unsigned int irq, irq_affinity_desc *affinity)
> {
> 	unsigned long flags;
> 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
> 
>          if (!desc)
>          	return -EINVAL;
> 
>          if (affinity->is_managed) {
>          	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
> 	        irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);

Are these correct? I assume we want to follow alloc_descs() here.

>          }
>          cpumask_copy(desc->irq_common_data.affinity, affinity);
>          return 0;
> }

I see. So I made a couple of changes and it did work:

int irq_update_affinity_desc(unsigned int irq, struct irq_affinity_desc 
*affinity)
{
	unsigned long flags;
	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);

	if (!desc)
		return -EINVAL;

	if (affinity->is_managed) {
		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
	}

	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
	irq_put_desc_unlock(desc, flags);
	return 0;
}

And if we were to go this way, then we don't need to add the pointer in 
struct platform_device to hold affinity mask descriptors as we're using 
them immediately. Or even have a single function to do it all in the irq 
code (create the masks and update the affinity desc).

And since we're just updating the masks, I figure we shouldn't need to 
add acpi_irq_get_count(), which I invented to get the irq count (without 
creating the IRQ mapping).

Thanks,
John
