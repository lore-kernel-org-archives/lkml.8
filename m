Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74128C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512B121734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgAaOZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:25:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbgAaOZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:25:28 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 791D2706EB0C1209BA6E;
        Fri, 31 Jan 2020 14:25:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 14:25:26 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 14:25:25 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: About irq_create_affinity_masks() for a platform device driver
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
 <87o8uveoye.fsf@nanos.tec.linutronix.de>
 <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com>
Message-ID: <19dc0422-5536-5565-e29f-ccfbcb8525d3@huawei.com>
Date:   Fri, 31 Jan 2020 14:25:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4b447127-737e-a729-4dc7-82fc8b68af77@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> John Garry <john.garry@huawei.com> writes:
>>> Would there be any issue with a SCSI platform device driver referencing
>>> this function?
>>>
>>> So I have a multi-queue platform device, and I want to spread interrupts
>>> over all possible CPUs, just like we can do for PCI MSI vectors. This
>>> topic was touched on in [0].
>>>
>>> And, if so it's ok, could we export that same symbol?
>>

Hi Thomas,

>> I think you will need something similar to what we have in the pci/msi
>> code, but that shouldn't be in your device driver. So I'd rather create
>> platform infrastructure for this and export that.
>>
> 
> That would seem the proper thing do to.
> 
> So I was doing this for legacy hw as a cheap and quick performance 
> boost, but I doubt how many other users there would be in future for any 
> new API. Also, the effort could be more than the reward and so I may 
> consider dropping the whole idea.
> 
> But I'll have a play with how the code could look now.

So I'd figure that an API like this would be required:

--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -11,6 +11,7 @@
  #define _PLATFORM_DEVICE_H_

  #include <linux/device.h>
+#include <linux/interrupt.h>

  #define PLATFORM_DEVID_NONE	(-1)
  #define PLATFORM_DEVID_AUTO	(-2)
@@ -27,6 +28,7 @@ struct platform_device {
  	u64		dma_mask;
  	u32		num_resources;
  	struct resource	*resource;
+	struct irq_affinity_desc *desc;

and in platform.c, adding:

/**
  * platform_get_irqs_affinity - get all IRQs for a device with affinity
  * @dev: platform device
  * @affd: Affinity descriptor
  * @count: pointer to count of IRQS
  * @irqs: pointer holder for irqs numbers
  *
  * Gets a full set of IRQs for a platform device
  *
  * Return: 0 on success, negative error number on failure.
  */
int platform_get_irqs_affinity(struct platform_device *dev, struct 
irq_affinity *affd, unsigned int *count, int **irqs)
{
	int i;
	int *pirqs;

	if (ACPI_COMPANION(&dev->dev)) {
		*count = acpi_irq_get_count(ACPI_HANDLE(&dev->dev));
	} else {
		// TODO
	}

	pirqs = kzalloc(*count * sizeof(int), GFP_KERNEL);
	if (!pirqs)
		return -ENOMEM;

	dev->desc = irq_create_affinity_masks(*count, affd);
	if (!dev->desc) {
		kfree(irqs);
		return -ENOMEM;
	}

	for (i = 0; i < *count; i++) {
		pirqs[i] = platform_get_irq(dev, i);
		if (irqs[i] < 0) {
			kfree(dev->desc);
			kfree(irqs);
			return -ENOMEM;
		}
	}

	*irqs = pirqs;

	return 0;
}
EXPORT_SYMBOL_GPL(platform_get_irqs_affinity);

Here we pass the affinity descriptor and allocate all IRQs for a device.

So this is less than a half-baked solution. We only create the affinity 
masks but do nothing with them, and the actual irq_desc 's generated 
would not would have their affinity mask set and would not be managed. 
Only the platform device driver itself would access the masks, to set 
the irq affinity hint, etc.

To achieve the proper result, we would somehow need to pass the per-IRQ 
affinity descriptor all the way down through 
platform_get_irq()->acpi_irq_get()->irq_create_fwspec_mapping()->irq_domain_alloc_irqs(), 
which could involve disruptive changes in different subsystems - not 
welcome, I'd say.

I could take the alt approach to generate the interrupt affinity masks 
in my LLDD instead. Considering I know some of the CPU and numa node 
properties of the device host, I could generate the masks in the LLDD 
itself simply, but I still would rather avoid this if possible and use 
standard APIs.

So if there are any better ideas on this, then it would be good to hear 
them.

Thanks,
john

