Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E62187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgBNOJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:09:06 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbgBNOJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:09:06 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 32D03A8611647239498F;
        Fri, 14 Feb 2020 14:09:04 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Feb 2020 14:09:03 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 14:09:03 +0000
Subject: Re: arm64 iommu groups issue
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Will Deacon" <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
CC:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Saravana Kannan" <saravanak@google.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
 <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
Date:   Fri, 14 Feb 2020 14:09:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> @@ -2420,6 +2421,10 @@ void pci_device_add(struct pci_dev *dev, struct
>> pci_bus *bus)
>>        /* Set up MSI IRQ domain */
>>        pci_set_msi_domain(dev);
>>
>> +    parent = dev->dev.parent;
>> +    if (parent && parent->bus == &pci_bus_type)
>> +        device_link_add(&dev->dev, parent, DL_FLAG_AUTOPROBE_CONSUMER);
>> +
>>        /* Notifier could use PCI capabilities */
>>        dev->match_driver = false;
>>        ret = device_add(&dev->dev);
>> -- 
>>
>> This would work, but the problem is that if the port driver fails in
>> probing - and not just for -EPROBE_DEFER - then the child device will
>> never probe. This very thing happens on my dev board. However we could
>> expand the device links API to cover this sort of scenario.
> 
> Yes, that's an undesirable issue, but in fact I think it's mostly
> indicative that involving drivers in something which is designed to
> happen at a level below drivers is still fundamentally wrong and doomed
> to be fragile at best.

Right, and even worse is that it relies on the port driver even existing 
at all.

All this iommu group assignment should be taken outside device driver 
probe paths.

However we could still consider device links for sync'ing the SMMU and 
each device probing.

> 
> Another thought that crosses my mind is that when pci_device_group()
> walks up to the point of ACS isolation and doesn't find an existing
> group, it can still infer that everything it walked past *should* be put
> in the same group it's then eventually going to return. Unfortunately I
> can't see an obvious way for it to act on that knowledge, though, since
> recursive iommu_probe_device() is unlikely to end well.

I'd be inclined not to change that code.

> 
>> As for alternatives, it looks pretty difficult to me to disassociate the
>> group allocation from the dma_configure path.
> 
> Indeed it's non-trivial, but it really does need cleaning up at some point.
> 
> Having just had yet another spark, does something like the untested
> super-hack below work at all? 

I tried it and it doesn't (yet) work.

So when we try 
iommu_bus_replay()->add_iommu_group()->iommu_probe_device()->arm_smmu_add_device(),
the iommu_fwspec is still NULL for that device - this is not set until 
later when the device driver is going to finally probe in 
iort_iommu_xlate()->iommu_fwspec_init(), and it's too late...

And this looks to be the reason for which current 
iommu_bus_init()->bus_for_each_device(..., add_iommu_group) fails also.

On this current code mentioned, the principle of this seems wrong to me 
- we call bus_for_each_device(..., add_iommu_group) for the first SMMU 
in the system which probes, but we attempt to add_iommu_group() for all 
devices on the bus, even though the SMMU for that device may yet to have 
probed.

Thanks,
John

I doubt it's a viable direction to take in
> itself, but it could be food for thought if it at least proves the concept.
> 
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index aa3ac2a03807..554cde76c766 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3841,20 +3841,20 @@ static int arm_smmu_set_bus_ops(struct iommu_ops
> *ops)
>    	int err;
> 
>    #ifdef CONFIG_PCI
> -	if (pci_bus_type.iommu_ops != ops) {
> +	if (1) {
>    		err = bus_set_iommu(&pci_bus_type, ops);
>    		if (err)
>    			return err;
>    	}
>    #endif
>    #ifdef CONFIG_ARM_AMBA
> -	if (amba_bustype.iommu_ops != ops) {
> +	if (1) {
>    		err = bus_set_iommu(&amba_bustype, ops);
>    		if (err)
>    			goto err_reset_pci_ops;
>    	}
>    #endif
> -	if (platform_bus_type.iommu_ops != ops) {
> +	if (1) {
>    		err = bus_set_iommu(&platform_bus_type, ops);
>    		if (err)
>    			goto err_reset_amba_ops;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 660eea8d1d2f..b81ae2b4d4fb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1542,6 +1542,14 @@ static int iommu_bus_init(struct bus_type *bus,
> const struct iommu_ops *ops)
>    	return err;
>    }
> 
> +static int iommu_bus_replay(struct device *dev, void *data)
> +{
> +	if (dev->iommu_group)
> +		return 0;
> +
> +	return add_iommu_group(dev, data);
> +}
> +
>    /**
>     * bus_set_iommu - set iommu-callbacks for the bus
>     * @bus: bus.
> @@ -1564,6 +1572,9 @@ int bus_set_iommu(struct bus_type *bus, const
> struct iommu_ops *ops)
>    		return 0;
>    	}
> 
> +	if (bus->iommu_ops == ops)
> +		return bus_for_each_dev(bus, NULL, NULL, iommu_bus_replay);
> +
>    	if (bus->iommu_ops != NULL)
>    		return -EBUSY;
> 

