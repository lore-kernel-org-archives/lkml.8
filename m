Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52811C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A6021835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVFk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:40:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:6335 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgAVFk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:40:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 21:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="215791760"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 21:40:55 -0800
Cc:     baolu.lu@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
To:     Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
 <20200117102151.GF15760@8bytes.org>
 <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
 <b721d3f7-6292-35d6-a9eb-154d3233dcc0@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f04c590b-d966-88e8-7309-e73b600d4e9f@linux.intel.com>
Date:   Wed, 22 Jan 2020 13:39:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b721d3f7-6292-35d6-a9eb-154d3233dcc0@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 1/21/20 8:45 PM, Robin Murphy wrote:
> On 19/01/2020 6:29 am, Lu Baolu wrote:
>> Hi Joerg,
>>
>> On 1/17/20 6:21 PM, Joerg Roedel wrote:
>>> On Wed, Jan 01, 2020 at 01:26:47PM +0800, Lu Baolu wrote:
>>>> This splits iommu group allocation from adding devices. This makes
>>>> it possible to determine the default domain type for each group as
>>>> all devices belonging to the group have been determined.
>>>
>>> I think its better to keep group allocation as it is and just defer
>>> default domain allocation after each device is in its group. But take
>>
>> I tried defering default domain allocation, but it seems not possible.
>>
>> The call path of adding devices into their groups:
>>
>> iommu_probe_device
>> -> ops->add_device(dev)
>>     -> (iommu vendor driver) iommu_group_get_for_dev(dev)
>>
>> After doing this, the vendor driver will get the default domain and
>> apply dma_ops according to the domain type. If we defer the domain
>> allocation, they will get a NULL default domain and cause panic in
>> the vendor driver.
>>
>> Any suggestions?
> 
> https://lore.kernel.org/linux-iommu/6dbbfc10-3247-744c-ae8d-443a336e0c50@linux.intel.com/ 
> 
> 
> Haven't we been here before? ;)
> 
> Since we can't (safely or reasonably) change a group's default domain 
> after ops->add_device() has returned, and in general it gets impractical 
> to evaluate "all device in a group" once you look beyond &pci_bus_type 
> (or consider hotplug as mentioned), then AFAICS there's no reasonable 
> way to get away from the default domain type being defined by the first 
> device to attach.

Yes, agreed.

> But in practice it's hardly a problem anyway - if 
> every device in a given group requests the same domain type then it 
> doesn't matter which comes first, and if they don't then we ultimately 
> end up with an impossible set of constraints, so are doomed to do the 
> 'wrong' thing regardless.

The third case is, for example, three devices A, B, C in a group. The
first device A is neutral about which type of default domain type is
used. So the iommu framework will use a static default domain. But the
device B requires to use a specific one which is different from the
default. Currently, this is handled in the vendor iommu driver and one
motivation of this patch set is to handle this in the generic layer.

> 
> Thus unless anyone wants to start redefining the whole group concept to 
> separate the notions of ID aliasing and peer-to-peer isolation (which 
> still wouldn't necessarily help), I think this user override effectively 
> boils down to just another flavour of iommu_request_*_for_dev(), and as 
> such comes right back to the "just pass the bloody device to 
> ops->domain_alloc() and resolve everything up-front" argument.
> 
> Robin.

Best regards,
baolu
