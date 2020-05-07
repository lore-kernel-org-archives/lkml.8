Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCFE20838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEGNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:23:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:43708 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGNX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:23:27 -0400
IronPort-SDR: lKffZWXyPFwrWByCIvdP+l/AkN2D6+A+ATHygF5RIkU9JdedACQRMEPY6Nv9uJ+Ar/kkc+juD6
 KGHI09OA9NhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:23:27 -0700
IronPort-SDR: /iXdlDacT1Lrk3AisM51SfQSSOWOuhmlxMXtPDVY3uze42MPWIRClui7FabbFjXZWuum+kios2
 HGyty3kvQ+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="278597920"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.169.187]) ([10.249.169.187])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 06:23:24 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
Date:   Thu, 7 May 2020 21:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/5/7 13:45, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, May 7, 2020 8:56 AM
>>
>> When a PASID is used for SVA by the device, it's possible that the PASID
>> entry is cleared before the device flushes all ongoing DMA requests. The
>> IOMMU should ignore the non-recoverable faults caused by these requests.
>> Intel VT-d provides such function through the FPD bit of the PASID entry.
>> This sets FPD bit when PASID entry is cleared in the mm notifier and
>> clear it when the pasid is unbound.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c |  4 ++--
>>   drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
>>   drivers/iommu/intel-pasid.h |  3 ++-
>>   drivers/iommu/intel-svm.c   |  9 ++++++---
>>   4 files changed, 31 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index d1866c0905b1..7811422b5a68 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5352,7 +5352,7 @@ static void __dmar_remove_one_dev_info(struct
>> device_domain_info *info)
>>   	if (info->dev) {
>>   		if (dev_is_pci(info->dev) && sm_supported(iommu))
>>   			intel_pasid_tear_down_entry(iommu, info->dev,
>> -					PASID_RID2PASID);
>> +					PASID_RID2PASID, false);
>>
>>   		iommu_disable_dev_iotlb(info);
>>   		domain_context_clear(iommu, info->dev);
>> @@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct
>> dmar_domain *domain,
>>   	auxiliary_unlink_device(domain, dev);
>>
>>   	spin_lock(&iommu->lock);
>> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
>> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid,
>> false);
>>   	domain_detach_iommu(domain, iommu);
>>   	spin_unlock(&iommu->lock);
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 7969e3dac2ad..11aef6c12972 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct
>> pasid_entry *pe)
>>   	WRITE_ONCE(pe->val[7], 0);
>>   }
>>
>> -static void intel_pasid_clear_entry(struct device *dev, int pasid)
>> +static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
>> +{
>> +	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
>> +	WRITE_ONCE(pe->val[1], 0);
>> +	WRITE_ONCE(pe->val[2], 0);
>> +	WRITE_ONCE(pe->val[3], 0);
>> +	WRITE_ONCE(pe->val[4], 0);
>> +	WRITE_ONCE(pe->val[5], 0);
>> +	WRITE_ONCE(pe->val[6], 0);
>> +	WRITE_ONCE(pe->val[7], 0);
>> +}
>> +
>> +static void
>> +intel_pasid_clear_entry(struct device *dev, int pasid, bool pf_ignore)
> Hi, Baolu,
> 
> Just curious whether it makes sense to always set FPD here. Yes, SVA is
> one known example that non-recoverable fault associated with a PASID
> entry might be caused after the entry is cleared and those are considered
> benign.  But even in a general context (w/o SVA) why do we care about
> such faults after a PASID entry is torn down?

First level page tables are also used for DMA protection. For example,
thunderbolt peripherals are always untrusted and should be protected
with IOMMU. IOMMU should always report unrecoverable faults generated
by those device to detect possible DMA attacks.

ATS/PRI devices are always trusted devices, hence we could tolerate
setting FPD bit in the time window between mm_release notifier and
unbind().

Best regards,
baolu
