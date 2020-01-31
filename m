Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1748420707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAaVl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:41:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:41:28 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixe2P-0005ad-Te; Fri, 31 Jan 2020 22:41:18 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 91A2A105BDC; Fri, 31 Jan 2020 22:41:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: About irq_create_affinity_masks() for a platform device driver
In-Reply-To: <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com> <87o8uveoye.fsf@nanos.tec.linutronix.de> <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com> <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com>
Date:   Fri, 31 Jan 2020 22:41:12 +0100
Message-ID: <87ftfvuww7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John!

John Garry <john.garry@huawei.com> writes:
> So I'd figure that an API like this would be required:
>
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -11,6 +11,7 @@
>   #define _PLATFORM_DEVICE_H_
>
>   #include <linux/device.h>
> +#include <linux/interrupt.h>
>
>   #define PLATFORM_DEVID_NONE	(-1)
>   #define PLATFORM_DEVID_AUTO	(-2)
> @@ -27,6 +28,7 @@ struct platform_device {
>   	u64		dma_mask;
>   	u32		num_resources;
>   	struct resource	*resource;
> +	struct irq_affinity_desc *desc;
>
> and in platform.c, adding:
>
> /**
>   * platform_get_irqs_affinity - get all IRQs for a device with affinity
>   * @dev: platform device
>   * @affd: Affinity descriptor
>   * @count: pointer to count of IRQS
>   * @irqs: pointer holder for irqs numbers
>   *
>   * Gets a full set of IRQs for a platform device
>   *
>   * Return: 0 on success, negative error number on failure.
>   */
> int platform_get_irqs_affinity(struct platform_device *dev, struct 
> irq_affinity *affd, unsigned int *count, int **irqs)
> {
> 	int i;
> 	int *pirqs;
>
> 	if (ACPI_COMPANION(&dev->dev)) {
> 		*count = acpi_irq_get_count(ACPI_HANDLE(&dev->dev));
> 	} else {
> 		// TODO
> 	}
>
> 	pirqs = kzalloc(*count * sizeof(int), GFP_KERNEL);
> 	if (!pirqs)
> 		return -ENOMEM;
>
> 	dev->desc = irq_create_affinity_masks(*count, affd);
> 	if (!dev->desc) {
> 		kfree(irqs);

pirqs I assume and this also leaks the affinity masks and the pointer in
dev.

> 		return -ENOMEM;
> 	}
>
> 	for (i = 0; i < *count; i++) {
> 		pirqs[i] = platform_get_irq(dev, i);
> 		if (irqs[i] < 0) {
> 			kfree(dev->desc);
> 			kfree(irqs);
> 			return -ENOMEM;

That's obviously broken as well :)

> 		}
> 	}
>
> 	*irqs = pirqs;
>
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(platform_get_irqs_affinity);
>
> Here we pass the affinity descriptor and allocate all IRQs for a device.
>
> So this is less than a half-baked solution. We only create the affinity 
> masks but do nothing with them, and the actual irq_desc 's generated 
> would not would have their affinity mask set and would not be managed. 
> Only the platform device driver itself would access the masks, to set 
> the irq affinity hint, etc.
>
> To achieve the proper result, we would somehow need to pass the
> per-IRQ affinity descriptor all the way down through
> platform_get_irq()->acpi_irq_get()->irq_create_fwspec_mapping()->irq_domain_alloc_irqs(),
> which could involve disruptive changes in different subsystems - not
> welcome, I'd say.
>
> I could take the alt approach to generate the interrupt affinity masks 
> in my LLDD instead. Considering I know some of the CPU and numa node 
> properties of the device host, I could generate the masks in the LLDD 
> itself simply, but I still would rather avoid this if possible and use 
> standard APIs.
>
> So if there are any better ideas on this, then it would be good to hear 
> them.

I wouldn't mind to expose a function which allows you to switch the
allocated interrupts to managed. The reason why we do it in one go in
the PCI code is that we get automatically the irq descriptors allocated
on the correct node. So if the node aware allocation is not a
showstopper for this then your function would do:

	...
	for (i = 0; i < count; i++) {
		pirqs[i] = platform_get_irq(dev, i);

                irq_update_affinity_desc(pirqs[i], affdescs + i);

        }

int irq_update_affinity_desc(unsigned int irq, irq_affinity_desc *affinity)
{
	unsigned long flags;
	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);

        if (!desc)
        	return -EINVAL;

        if (affinity->is_managed) {
        	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
	        irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
        }
        cpumask_copy(desc->irq_common_data.affinity, affinity);
        return 0;
}

That should just work.

Thanks,

        tglx
