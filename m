Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D6C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5402072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgAJBSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:18:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:45574 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgAJBSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:18:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246847040"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 17:18:45 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 04/10] iommu/vt-d: Support flushing more translation
 cache types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <24cc06da-14ec-908d-361d-a8b321b10852@linux.intel.com>
 <20200109135038.7608d059@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <34ef67b6-53ef-d15f-0fad-ef4c39719155@linux.intel.com>
Date:   Fri, 10 Jan 2020 09:17:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109135038.7608d059@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/20 5:50 AM, Jacob Pan wrote:
> On Thu, 19 Dec 2019 10:46:51 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Hi,
>>
>> On 12/17/19 3:24 AM, Jacob Pan wrote:
>>> When Shared Virtual Memory is exposed to a guest via vIOMMU,
>>> scalable IOTLB invalidation may be passed down from outside IOMMU
>>> subsystems. This patch adds invalidation functions that can be used
>>> for additional translation cache types.
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/dmar.c        | 46
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>> drivers/iommu/intel-pasid.c |  3 ++- include/linux/intel-iommu.h |
>>> 21 +++++++++++++++++---- 3 files changed, 65 insertions(+), 5
>>> deletions(-)
>>>
>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>>> index 3acfa6a25fa2..f2f5d75da94a 100644
>>> --- a/drivers/iommu/dmar.c
>>> +++ b/drivers/iommu/dmar.c
>>> @@ -1348,6 +1348,20 @@ void qi_flush_iotlb(struct intel_iommu
>>> *iommu, u16 did, u64 addr, qi_submit_sync(&desc, iommu);
>>>    }
>>>    
>>> +/* PASID-based IOTLB Invalidate */
>>> +void qi_flush_iotlb_pasid(struct intel_iommu *iommu, u16 did, u64
>>> addr, u32 pasid,
>>> +		unsigned int size_order, u64 granu, int ih)
>>> +{
>>> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
>>> +
>>> +	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
>>> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
>>> +	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
>>> +		QI_EIOTLB_AM(size_order);
>>> +
>>> +	qi_submit_sync(&desc, iommu);
>>> +}
>> There's another version of pasid-based iotlb invalidation.
>>
>> https://lkml.org/lkml/2019/12/10/2128
>>
>> Let's consider merging them.
>>
> Absolutely, the difference i see is that the granularity is explicit
> here. Here we do invalidation request from the guest. Perhaps, we can
> look at consolidation once this use case is supported?
> 

Looks good to me. :-)

Best regards,
baolu
