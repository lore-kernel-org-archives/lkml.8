Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3275C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8362721927
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBXOFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:05:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:45777 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbgBXOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:05:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 06:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="435914695"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230]) ([10.254.212.230])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2020 06:05:08 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
To:     Yonghyun Hwang <yonghyun@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20200220194431.169629-1-yonghyun@google.com>
 <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ab64969a-5a52-5a22-061b-de57a5ac5627@linux.intel.com>
Date:   Mon, 24 Feb 2020 22:05:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <795521c0-af5b-36a1-e05c-324377d04d8a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg and Yonghyun,

I found a problem in the test. I am still working on this. Please hold
on for a while.

Best regards,
baolu

On 2020/2/22 21:05, Lu Baolu wrote:
> Hi,
> 
> On 2020/2/21 3:44, Yonghyun Hwang wrote:
>> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a 
>> huge
>> page onto its corresponding physical address. This commit fixes the 
>> bug by
>> accomodating the level of page entry for the IOVA and adds IOVA's lower
>> address to the physical address.
>>
>> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> 
> This fix looks good to me.
> 
> Cc: <stable@kernel.org> # As far back as possible
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> baolu
> 
>> ---
>>
>> Changes from v1:
>> - level cannot be 0. So, the condition, "if (level > 1)", is removed, 
>> which results in a simple code.
>> - a macro, BIT_MASK, is used to have a bit mask
>>
>> ---
>>   drivers/iommu/intel-iommu.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 932267f49f9a..4fd5c6287b6d 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5554,7 +5554,9 @@ static phys_addr_t 
>> intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>       pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>>       if (pte)
>> -        phys = dma_pte_addr(pte);
>> +        phys = dma_pte_addr(pte) +
>> +            (iova & (BIT_MASK(level_to_offset_bits(level) +
>> +                        VTD_PAGE_SHIFT) - 1));
>>       return phys;
>>   }
>>
