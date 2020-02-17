Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1BC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F17D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBQMIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:08:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2431 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbgBQMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:08:51 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5A01FB48AA3C8B00CA05;
        Mon, 17 Feb 2020 12:08:50 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Feb 2020 12:08:50 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 12:08:49 +0000
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
 <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
 <68643b18-c920-f997-a6d4-a5d9177c0f4e@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <828ec7b3-27af-f0b9-b4a6-0886b0c24b5a@huawei.com>
Date:   Mon, 17 Feb 2020 12:08:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <68643b18-c920-f997-a6d4-a5d9177c0f4e@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Right, and even worse is that it relies on the port driver even 
>> existing at all.
>>
>> All this iommu group assignment should be taken outside device driver 
>> probe paths.
>>
>> However we could still consider device links for sync'ing the SMMU and 
>> each device probing.
> 
> Yes, we should get that for DT now thanks to the of_devlink stuff, but 
> cooking up some equivalent for IORT might be worthwhile.

It doesn't solve this problem, but at least we could remove the 
iommu_ops check in iort_iommu_xlate().

We would need to carve out a path from pci_device_add() or even 
device_add() to solve all cases.

> 
>>> Another thought that crosses my mind is that when pci_device_group()
>>> walks up to the point of ACS isolation and doesn't find an existing
>>> group, it can still infer that everything it walked past *should* be put
>>> in the same group it's then eventually going to return. Unfortunately I
>>> can't see an obvious way for it to act on that knowledge, though, since
>>> recursive iommu_probe_device() is unlikely to end well.
>>

[...]

>> And this looks to be the reason for which current 
>> iommu_bus_init()->bus_for_each_device(..., add_iommu_group) fails also.
> 
> Of course, just adding a 'correct' add_device replay without the 
> of_xlate process doesn't help at all. No wonder this looked suspiciously 
> simpler than where the first idea left off...
> 
> (on reflection, the core of this idea seems to be recycling the existing 
> iommu_bus_init walk rather than building up a separate "waiting list", 
> while forgetting that that wasn't the difficult part of the original 
> idea anyway)

We could still use a bus walk to add the group per iommu, but we would 
need an additional check to ensure the device is associated with the IOMMU.

> 
>> On this current code mentioned, the principle of this seems wrong to 
>> me - we call bus_for_each_device(..., add_iommu_group) for the first 
>> SMMU in the system which probes, but we attempt to add_iommu_group() 
>> for all devices on the bus, even though the SMMU for that device may 
>> yet to have probed.
> 
> Yes, iommu_bus_init() is one of the places still holding a 
> deeply-ingrained assumption that the ops go live for all IOMMU instances 
> at once, which is what warranted the further replay in 
> of_iommu_configure() originally. Moving that out of 
> of_platform_device_create() to support probe deferral is where the 
> trouble really started.

I'm not too familiar with the history here, but could this be reverted 
now with the introduction of of_devlink stuff?

Cheers,
John
