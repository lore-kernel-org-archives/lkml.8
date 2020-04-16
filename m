Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178C32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439574AbgDPHkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:40:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:21937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439525AbgDPHko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:40:44 -0400
IronPort-SDR: i1evGNAnXSA4N7qLfEQy1aX48rWdvl0iGcGDOYVN6XHoZ/JopmNCqBzUlnNt1KBAmUvJVsJJ/x
 tp01VMIofnYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 00:40:42 -0700
IronPort-SDR: VP83vGAdJ9meTq/qfmSI6r/NfD6Qw6KHe9qbmHBDKXmLIdPI77iMcyLhMZk7YBchrgSjfjkjJE
 Pmmv4CPyIqGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363906563"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.171]) ([10.254.209.171])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 00:40:38 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Allow 32bit devices to uses DMA domain
To:     Christoph Hellwig <hch@lst.de>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com>
 <20200416062354.10307-2-baolu.lu@linux.intel.com>
 <20200416070102.GA12588@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e11d8138-f704-2f5e-c0b1-70b367a33d5d@linux.intel.com>
Date:   Thu, 16 Apr 2020 15:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416070102.GA12588@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2020/4/16 15:01, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 02:23:52PM +0800, Lu Baolu wrote:
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
> This commit log doesn't actually explain what you are chaning, and
> as far as I can tell it just removes the code to change the domain
> at run time, which seems to not actually match the subject or

This removes the domain switching in iommu_need_mapping(). Another place
where the private domain is used is intel_iommu_add_device(). Joerg's
patch set has remove that. So with domain switching in
iommu_need_mapping() removed, the private domain helpers could be
removed now. Otherwise, the compiler will complain that some functions
are defined but not used.

> description.  I'd need to look at the final code, but it seems like
> this will still cause bounce buffering instead of using dynamic
> mapping, which still seems like an awful idea.

Yes. If the user chooses to use identity domain by default through
kernel command, identity domain will be applied for all devices. For
those devices with limited addressing capability, bounce buffering will
be used when they try to access the memory beyond their address
capability. This won't cause any kernel regression as far as I can see.

Switching domain during runtime with drivers loaded will cause real
problems as I said in the commit message. That's the reason why I am
proposing to remove it. If we want to keep it, we have to make sure that
switching domain for one device should not impact other devices which
share the same domain with it. Furthermore, it's better to implement it
in the generic layer to keep device driver behavior consistent on all
architectures.

> 
> Also from a purely stylistic perspective a lot of the lines seem
> very short and not use up the whole 73 charaters allowed.
> 

Yes. I will try to use up the allowed characters.

Best regards,
baolu
