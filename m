Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A38C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D30C24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgAUMpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:45:12 -0500
Received: from foss.arm.com ([217.140.110.172]:42812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgAUMpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:45:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370E730E;
        Tue, 21 Jan 2020 04:45:11 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F8B3F6C4;
        Tue, 21 Jan 2020 04:45:09 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
 <20200117102151.GF15760@8bytes.org>
 <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b721d3f7-6292-35d6-a9eb-154d3233dcc0@arm.com>
Date:   Tue, 21 Jan 2020 12:45:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2020 6:29 am, Lu Baolu wrote:
> Hi Joerg,
> 
> On 1/17/20 6:21 PM, Joerg Roedel wrote:
>> On Wed, Jan 01, 2020 at 01:26:47PM +0800, Lu Baolu wrote:
>>> This splits iommu group allocation from adding devices. This makes
>>> it possible to determine the default domain type for each group as
>>> all devices belonging to the group have been determined.
>>
>> I think its better to keep group allocation as it is and just defer
>> default domain allocation after each device is in its group. But take
> 
> I tried defering default domain allocation, but it seems not possible.
> 
> The call path of adding devices into their groups:
> 
> iommu_probe_device
> -> ops->add_device(dev)
>     -> (iommu vendor driver) iommu_group_get_for_dev(dev)
> 
> After doing this, the vendor driver will get the default domain and
> apply dma_ops according to the domain type. If we defer the domain
> allocation, they will get a NULL default domain and cause panic in
> the vendor driver.
> 
> Any suggestions?

https://lore.kernel.org/linux-iommu/6dbbfc10-3247-744c-ae8d-443a336e0c50@linux.intel.com/

Haven't we been here before? ;)

Since we can't (safely or reasonably) change a group's default domain 
after ops->add_device() has returned, and in general it gets impractical 
to evaluate "all device in a group" once you look beyond &pci_bus_type 
(or consider hotplug as mentioned), then AFAICS there's no reasonable 
way to get away from the default domain type being defined by the first 
device to attach. But in practice it's hardly a problem anyway - if 
every device in a given group requests the same domain type then it 
doesn't matter which comes first, and if they don't then we ultimately 
end up with an impossible set of constraints, so are doomed to do the 
'wrong' thing regardless.

Thus unless anyone wants to start redefining the whole group concept to 
separate the notions of ID aliasing and peer-to-peer isolation (which 
still wouldn't necessarily help), I think this user override effectively 
boils down to just another flavour of iommu_request_*_for_dev(), and as 
such comes right back to the "just pass the bloody device to 
ops->domain_alloc() and resolve everything up-front" argument.

Robin.
