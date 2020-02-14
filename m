Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F82C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2222086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgBNSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:35:10 -0500
Received: from foss.arm.com ([217.140.110.172]:43648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgBNSfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:35:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DE8106F;
        Fri, 14 Feb 2020 10:35:08 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3E03F68E;
        Fri, 14 Feb 2020 10:35:06 -0800 (PST)
Subject: Re: arm64 iommu groups issue
To:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
 <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
 <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <68643b18-c920-f997-a6d4-a5d9177c0f4e@arm.com>
Date:   Fri, 14 Feb 2020 18:35:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 2:09 pm, John Garry wrote:
>>>
>>> @@ -2420,6 +2421,10 @@ void pci_device_add(struct pci_dev *dev, struct
>>> pci_bus *bus)
>>>        /* Set up MSI IRQ domain */
>>>        pci_set_msi_domain(dev);
>>>
>>> +    parent = dev->dev.parent;
>>> +    if (parent && parent->bus == &pci_bus_type)
>>> +        device_link_add(&dev->dev, parent, DL_FLAG_AUTOPROBE_CONSUMER);
>>> +
>>>        /* Notifier could use PCI capabilities */
>>>        dev->match_driver = false;
>>>        ret = device_add(&dev->dev);
>>> -- 
>>>
>>> This would work, but the problem is that if the port driver fails in
>>> probing - and not just for -EPROBE_DEFER - then the child device will
>>> never probe. This very thing happens on my dev board. However we could
>>> expand the device links API to cover this sort of scenario.
>>
>> Yes, that's an undesirable issue, but in fact I think it's mostly
>> indicative that involving drivers in something which is designed to
>> happen at a level below drivers is still fundamentally wrong and doomed
>> to be fragile at best.
> 
> Right, and even worse is that it relies on the port driver even existing 
> at all.
> 
> All this iommu group assignment should be taken outside device driver 
> probe paths.
> 
> However we could still consider device links for sync'ing the SMMU and 
> each device probing.

Yes, we should get that for DT now thanks to the of_devlink stuff, but 
cooking up some equivalent for IORT might be worthwhile.

>> Another thought that crosses my mind is that when pci_device_group()
>> walks up to the point of ACS isolation and doesn't find an existing
>> group, it can still infer that everything it walked past *should* be put
>> in the same group it's then eventually going to return. Unfortunately I
>> can't see an obvious way for it to act on that knowledge, though, since
>> recursive iommu_probe_device() is unlikely to end well.
> 
> I'd be inclined not to change that code.
> 
>>
>>> As for alternatives, it looks pretty difficult to me to disassociate the
>>> group allocation from the dma_configure path.
>>
>> Indeed it's non-trivial, but it really does need cleaning up at some 
>> point.
>>
>> Having just had yet another spark, does something like the untested
>> super-hack below work at all? 
> 
> I tried it and it doesn't (yet) work.

Bleh - further reinforcement of the "ideas after 6PM are bad ideas" rule...

> So when we try 
> iommu_bus_replay()->add_iommu_group()->iommu_probe_device()->arm_smmu_add_device(), 
> 
> the iommu_fwspec is still NULL for that device - this is not set until 
> later when the device driver is going to finally probe in 
> iort_iommu_xlate()->iommu_fwspec_init(), and it's too late...
> 
> And this looks to be the reason for which current 
> iommu_bus_init()->bus_for_each_device(..., add_iommu_group) fails also.

Of course, just adding a 'correct' add_device replay without the 
of_xlate process doesn't help at all. No wonder this looked suspiciously 
simpler than where the first idea left off...

(on reflection, the core of this idea seems to be recycling the existing 
iommu_bus_init walk rather than building up a separate "waiting list", 
while forgetting that that wasn't the difficult part of the original 
idea anyway)

> On this current code mentioned, the principle of this seems wrong to me 
> - we call bus_for_each_device(..., add_iommu_group) for the first SMMU 
> in the system which probes, but we attempt to add_iommu_group() for all 
> devices on the bus, even though the SMMU for that device may yet to have 
> probed.

Yes, iommu_bus_init() is one of the places still holding a 
deeply-ingrained assumption that the ops go live for all IOMMU instances 
at once, which is what warranted the further replay in 
of_iommu_configure() originally. Moving that out of 
of_platform_device_create() to support probe deferral is where the 
trouble really started.

Robin.
