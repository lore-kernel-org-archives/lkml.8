Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA8C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D4E2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHBml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:42:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:48829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHBmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:42:40 -0400
IronPort-SDR: kPv0nNBnfnJRqW8dVPBW2xXTHXd7scxBUGFf8j7o69zZLyUq4odpo+ZCvrLbGjbBnneVTguovI
 GvuY1qIO+5yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 18:42:40 -0700
IronPort-SDR: 6GpZO+gW4OH6LS1UMq12TtONG1C91mHtsFKgYYmsktsvd1pIW662D2u/nmBWnfmoD8iXQ8UScS
 pXAz4jP+jOEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="278794707"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 18:42:37 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, Liu Yi L <yi.l.liu@intel.com>,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
 <20200507095522.3863b197@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f282cb12-3bda-44c9-d8dc-6074aa251cf1@linux.intel.com>
Date:   Fri, 8 May 2020 09:39:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507095522.3863b197@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 12:55 AM, Jacob Pan wrote:
> On Thu,  7 May 2020 08:55:32 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> When a PASID is used for SVA by the device, it's possible that the
>> PASID entry is cleared before the device flushes all ongoing DMA
>> requests. The IOMMU should ignore the non-recoverable faults caused
>> by these requests.
> Perhaps be more specific, only untranslated requests causes UR.

Yes. Sure!

> 
>> Intel VT-d provides such function through the FPD
>> bit of the PASID entry. This sets FPD bit when PASID entry is cleared
>> in the mm notifier and clear it when the pasid is unbound.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
>> device_domain_info *info) if (info->dev) {
>>   		if (dev_is_pci(info->dev) && sm_supported(iommu))
>>   			intel_pasid_tear_down_entry(iommu, info->dev,
>> -					PASID_RID2PASID);
>> +					PASID_RID2PASID, false);
>>   
>>   		iommu_disable_dev_iotlb(info);
>>   		domain_context_clear(iommu, info->dev);
>> @@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct
>> dmar_domain *domain, auxiliary_unlink_device(domain, dev);
>>   
>>   	spin_lock(&iommu->lock);
>> -	intel_pasid_tear_down_entry(iommu, dev,
>> domain->default_pasid);
>> +	intel_pasid_tear_down_entry(iommu, dev,
>> domain->default_pasid, false); domain_detach_iommu(domain, iommu);
>>   	spin_unlock(&iommu->lock);
>>   
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 7969e3dac2ad..11aef6c12972 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct
>> pasid_entry *pe) WRITE_ONCE(pe->val[7], 0);
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
>> +intel_pasid_clear_entry(struct device *dev, int pasid, bool
>> pf_ignore) {
>>   	struct pasid_entry *pe;
>>   
>> @@ -300,7 +313,10 @@ static void intel_pasid_clear_entry(struct
>> device *dev, int pasid) if (WARN_ON(!pe))
>>   		return;
>>   
>> -	pasid_clear_entry(pe);
>> +	if (pf_ignore)
>> +		pasid_clear_entry_with_fpd(pe);
>> +	else
>> +		pasid_clear_entry(pe);
>>   }
>>   
>>   static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
>> @@ -533,8 +549,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu
>> *iommu, qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 -
>> VTD_PAGE_SHIFT); }
>>   
>> -void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>> -				 struct device *dev, int pasid)
>> +void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct
>> device *dev,
>> +				 int pasid, bool pf_ignore)
>>   {
>>   	struct pasid_entry *pte;
>>   	u16 did;
>> @@ -544,7 +560,7 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, return;
>>   
>>   	did = pasid_get_domain_id(pte);
>> -	intel_pasid_clear_entry(dev, pasid);
>> +	intel_pasid_clear_entry(dev, pasid, pf_ignore);
>>   
>>   	if (!ecap_coherent(iommu->ecap))
>>   		clflush_cache_range(pte, sizeof(*pte));
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index a41b09b3ffde..e6dd95ffe381 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -15,6 +15,7 @@
>>   #define PASID_MAX			0x100000
>>   #define PASID_PTE_MASK			0x3F
>>   #define PASID_PTE_PRESENT		1
>> +#define PASID_PTE_FPD			2
>>   #define PDE_PFN_MASK			PAGE_MASK
>>   #define PASID_PDE_SHIFT			6
>>   #define MAX_NR_PASID_BITS		20
>> @@ -120,7 +121,7 @@ int intel_pasid_setup_nested(struct intel_iommu
>> *iommu, struct iommu_gpasid_bind_data_vtd *pasid_data,
>>   			     struct dmar_domain *domain, int
>> addr_width); void intel_pasid_tear_down_entry(struct intel_iommu
>> *iommu,
>> -				 struct device *dev, int pasid);
>> +				 struct device *dev, int pasid, bool
>> pf_ignore); int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned
>> int *pasid); void vcmd_free_pasid(struct intel_iommu *iommu, unsigned
>> int pasid); #endif /* __INTEL_PASID_H */
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 83dc4319f661..9561ba59a170 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -207,7 +207,8 @@ static void intel_mm_release(struct mmu_notifier
>> *mn, struct mm_struct *mm) */
>>   	rcu_read_lock();
>>   	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>> -		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
>> svm->pasid);
>> +		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
>> +					    svm->pasid, true);
>>   		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   	}
>>   	rcu_read_unlock();
>> @@ -400,7 +401,8 @@ int intel_svm_unbind_gpasid(struct device *dev,
>> int pasid) sdev->users--;
>>   		if (!sdev->users) {
>>   			list_del_rcu(&sdev->list);
>> -			intel_pasid_tear_down_entry(iommu, dev,
>> svm->pasid);
>> +			intel_pasid_tear_down_entry(iommu, dev,
>> +						    svm->pasid,
>> false); intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   			/* TODO: Drain in flight PRQ for the PASID
>> since it
>>   			 * may get reused soon, we don't want to
>> @@ -643,7 +645,8 @@ int intel_svm_unbind_mm(struct device *dev, int
>> pasid)
>>   			 * to use. We have a *shared* PASID table,
>> because it's
>>   			 * large and has to be physically
>> contiguous. So it's
>>   			 * hard to be as defensive as we might like.
>> */
>> -			intel_pasid_tear_down_entry(iommu, dev,
>> svm->pasid);
>> +			intel_pasid_tear_down_entry(iommu, dev,
>> +						    svm->pasid,
>> false); intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   			kfree_rcu(sdev, rcu);
>>   
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 

Best regards,
baolu
