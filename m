Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64655C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406FE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBDJUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:20:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgBDJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:20:32 -0500
Received: from [212.187.182.163] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iyuNM-0000dJ-BZ; Tue, 04 Feb 2020 10:20:08 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0F6E4100720; Tue,  4 Feb 2020 09:20:02 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: About irq_create_affinity_masks() for a platform device driver
In-Reply-To: <2b381b20-512a-27a5-38d7-2f6a673bb621@huawei.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com> <87o8uveoye.fsf@nanos.tec.linutronix.de> <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com> <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com> <87ftfvuww7.fsf@nanos.tec.linutronix.de> <2b381b20-512a-27a5-38d7-2f6a673bb621@huawei.com>
Date:   Tue, 04 Feb 2020 09:20:02 +0000
Message-ID: <871rrazp31.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

John Garry <john.garry@huawei.com> writes:
>> I wouldn't mind to expose a function which allows you to switch the
>> allocated interrupts to managed. The reason why we do it in one go in
>> the PCI code is that we get automatically the irq descriptors allocated
>> on the correct node. So if the node aware allocation is not a
>> showstopper 
>
> I wouldn't say so for now.

Good.

> for this then your function would do:
>> 
>> 	...
>> 	for (i = 0; i < count; i++) {
>> 		pirqs[i] = platform_get_irq(dev, i);
>> 
>>                  irq_update_affinity_desc(pirqs[i], affdescs + i);
>> 
>>          }
>> 
>> int irq_update_affinity_desc(unsigned int irq, irq_affinity_desc *affinity)
>> {
>> 	unsigned long flags;
>> 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
>> 
>>          if (!desc)
>>          	return -EINVAL;
>> 
>>          if (affinity->is_managed) {
>>          	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
>> 	        irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
>
> Are these correct? I assume we want to follow alloc_descs() here.

Yeah, copied the wrong chunk :)

>>          }
>>          cpumask_copy(desc->irq_common_data.affinity, affinity);
>>          return 0;
>> }
>
> I see. So I made a couple of changes and it did work:
>
> int irq_update_affinity_desc(unsigned int irq, struct irq_affinity_desc 
> *affinity)
> {
> 	unsigned long flags;
> 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
>
> 	if (!desc)
> 		return -EINVAL;
>
> 	if (affinity->is_managed) {
> 		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
> 		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
> 	}
>
> 	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
> 	irq_put_desc_unlock(desc, flags);
> 	return 0;
> }

Looks correct.

> And if we were to go this way, then we don't need to add the pointer in 
> struct platform_device to hold affinity mask descriptors as we're using 
> them immediately. Or even have a single function to do it all in the irq 
> code (create the masks and update the affinity desc).
>
> And since we're just updating the masks, I figure we shouldn't need to 
> add acpi_irq_get_count(), which I invented to get the irq count (without 
> creating the IRQ mapping).

Yes, you can create and apply the masks after setting up the interrupts.

Thanks,

        tglx
