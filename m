Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45BC10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BAA20409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCHCPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 21:15:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:34693 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCHCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:15:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 18:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,528,1574150400"; 
   d="scan'208";a="414404843"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.93]) ([10.254.211.93])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2020 18:15:49 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] iommu/vt-d: Don't force 32bit devices to uses DMA
 domain
To:     Christoph Hellwig <hch@lst.de>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200307062014.3288-4-baolu.lu@linux.intel.com>
 <20200307142144.GB26190@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b86e2bce-9907-05d0-b937-4b120797ba06@linux.intel.com>
Date:   Sun, 8 Mar 2020 10:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307142144.GB26190@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2020/3/7 22:21, Christoph Hellwig wrote:
> On Sat, Mar 07, 2020 at 02:20:11PM +0800, Lu Baolu wrote:
>> Currently, if a 32bit device initially uses an identity domain,
>> Intel IOMMU driver will convert it forcibly to a DMA one if its
>> address capability is not enough for the whole system memory.
>> The motivation was to overcome the overhead caused by possible
>> bounced buffer.
>>
>> Unfortunately, this improvement has led to many problems. For
>> example, some 32bit devices are required to use an identity
>> domain, forcing them to use DMA domain will cause the device
>> not to work anymore. On the other hand, the VMD sub-devices
>> share a domain but each sub-device might have different address
>> capability. Forcing a VMD sub-device to use DMA domain blindly
>> will impact the operation of other sub-devices without any
>> notification. Further more, PCI aliased devices (PCI bridge
>> and all devices beneath it, VMD devices and various devices
>> quirked with pci_add_dma_alias()) must use the same domain.
>> Forcing one device to switch to DMA domain during runtime
>> will cause in-fligh DMAs for other devices to abort or target
>> to other memory which might cause undefind system behavior.
> 
> I still don't like the idea to enforce either a strict dynamic
> IOMMU mapping or an identify mapping mode.
> 
> Can we add a new AUTO domain which will allow using the identity
> mapping when available?  That somewhat matches the existing x86
> default, and also what powerpc does.

Sai is proposing a series to change the default domain through sysfs
during runtime.

https://lore.kernel.org/linux-iommu/FFF73D592F13FD46B8700F0A279B802F4FBF7E4B@ORSMSX114.amr.corp.intel.com/T/#mb919da5567da7692ee7058a00a137145adf950a1

It has evolved into v2. Not sure whether it's what you want.

> I have a series to lift
> that bypass mode into the core dma-mapping code that I need
> to repost, which I think would be suitable for intel-iommu as well.
> 

Looking forward to your repost.

Best regards,
baolu
