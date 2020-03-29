Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E6C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F1E20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgC2HVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:21:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:53457 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgC2HVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 03:21:03 -0400
IronPort-SDR: cAF5qW/AKIxEUCm93tMX1Euw3w5cnkJkv6ja77TfCl/Auatxzs2PXN7aMIsYMM9+Jgcf9Pc8qS
 YGVxindXoAbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 00:21:03 -0700
IronPort-SDR: fI3FpOsSUfHzysvV2GBzOrfDHcQOb/YpAAA/E6IWpi0ONKLiVq0oNBf4P1u6/2IfvMGwJc5YRf
 dniQjCgFZNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,319,1580803200"; 
   d="scan'208";a="358882903"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.24]) ([10.254.210.24])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2020 00:20:56 -0700
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d17053c3-9a40-837a-dffa-57492cded028@linux.intel.com>
Date:   Sun, 29 Mar 2020 15:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/27 19:53, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Saturday, March 21, 2020 7:28 AM
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> could you elaborate in which scenario this helper function is required?

I added below commit message:

     An Intel iommu domain uses 5-level page table by default. If the
     iommu that the domain tries to attach supports less page levels,
     the top level page tables should be skipped. Add a helper to do
     this so that it could be used in other places.

Best regards,
baolu

>   
>> ---
>>   drivers/iommu/intel-pasid.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 22b30f10b396..191508c7c03e 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -500,6 +500,28 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   }
>>
>>   /*
>> + * Skip top levels of page tables for iommu which has less agaw
>> + * than default. Unnecessary for PT mode.
>> + */
>> +static inline int iommu_skip_agaw(struct dmar_domain *domain,
>> +				  struct intel_iommu *iommu,
>> +				  struct dma_pte **pgd)
>> +{
>> +	int agaw;
>> +
>> +	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>> +		*pgd = phys_to_virt(dma_pte_addr(*pgd));
>> +		if (!dma_pte_present(*pgd)) {
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	pr_debug_ratelimited("%s: pgd: %llx, agaw %d d_agaw %d\n",
>> __func__, (u64)*pgd,
>> +		iommu->agaw, domain->agaw);
>> +
>> +	return agaw;
>> +}
>> +
>> +/*
>>    * Set up the scalable mode pasid entry for second only translation type.
>>    */
>>   int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>> --
>> 2.7.4
> 
