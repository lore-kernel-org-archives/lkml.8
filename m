Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662DC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4DC2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:29:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:7799 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgEHC3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:29:51 -0400
IronPort-SDR: KtXrgXfhLJD2kP+iAMwZIjZQPCwogai6s2ES6SUrcoA80wvykAZlfTMBxhPNW9l2aG6L8VfQRc
 MHMcJIeFG5IA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:29:50 -0700
IronPort-SDR: lYA0+S6rEXXxhg65kjZnYz7m4O6x3A5IdzbqkT2GRR/TGzl+7W30lXbtJ8J0IGHsN7L2U5V0AH
 KAgL5F5TvKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="278804999"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 19:29:48 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v4 4/5] iommu/vt-d: Add page request draining support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-5-baolu.lu@linux.intel.com>
 <MWHPR11MB1645726E6EB0D9248BC56DA78CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <602f36ae-9e93-cee5-d7ca-6c2350f3e88c@linux.intel.com>
Date:   Fri, 8 May 2020 10:26:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645726E6EB0D9248BC56DA78CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 5/7/20 2:35 PM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Thursday, May 7, 2020 8:56 AM
>>
>> When a PASID is stopped or terminated, there can be pending PRQs
>> (requests that haven't received responses) in remapping hardware.
>> This adds the interface to drain page requests and call it when a
>> PASID is terminated.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-svm.c   | 102 ++++++++++++++++++++++++++++++++++-
>> -
>>   include/linux/intel-iommu.h |   4 ++
>>   2 files changed, 101 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 9561ba59a170..7256eb965cf6 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -23,6 +23,7 @@
>>   #include "intel-pasid.h"
>>
>>   static irqreturn_t prq_event_thread(int irq, void *d);
>> +static void intel_svm_drain_prq(struct device *dev, int pasid);
>>
>>   #define PRQ_ORDER 0
>>
>> @@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>>   	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
>>   	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu-
>>> prq) | PRQ_ORDER);
>>
>> +	init_completion(&iommu->prq_complete);
>> +
>>   	return 0;
>>   }
>>
>> @@ -403,12 +406,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int
>> pasid)
>>   			list_del_rcu(&sdev->list);
>>   			intel_pasid_tear_down_entry(iommu, dev,
>>   						    svm->pasid, false);
>> +			intel_svm_drain_prq(dev, svm->pasid);
>>   			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>> -			/* TODO: Drain in flight PRQ for the PASID since it
>> -			 * may get reused soon, we don't want to
>> -			 * confuse with its previous life.
>> -			 * intel_svm_drain_prq(dev, pasid);
>> -			 */
>>   			kfree_rcu(sdev, rcu);
>>
>>   			if (list_empty(&svm->devs)) {
>> @@ -647,6 +646,7 @@ int intel_svm_unbind_mm(struct device *dev, int
>> pasid)
>>   			 * hard to be as defensive as we might like. */
>>   			intel_pasid_tear_down_entry(iommu, dev,
>>   						    svm->pasid, false);
>> +			intel_svm_drain_prq(dev, svm->pasid);
>>   			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   			kfree_rcu(sdev, rcu);
>>
>> @@ -725,6 +725,92 @@ static bool is_canonical_address(u64 addr)
>>   	return (((saddr << shift) >> shift) == saddr);
>>   }
>>
>> +/**
>> + * intel_svm_drain_prq:
>> + *
>> + * Drain all pending page requests and responses related to a specific
>> + * pasid in both software and hardware.
>> + */
>> +static void intel_svm_drain_prq(struct device *dev, int pasid)
>> +{
>> +	struct device_domain_info *info;
>> +	struct dmar_domain *domain;
>> +	struct intel_iommu *iommu;
>> +	struct qi_desc desc[3];
>> +	struct pci_dev *pdev;
>> +	int head, tail;
>> +	u16 sid, did;
>> +	int qdep;
>> +
>> +	info = get_domain_info(dev);
>> +	if (WARN_ON(!info || !dev_is_pci(dev)))
>> +		return;
>> +
>> +	if (!info->ats_enabled)
>> +		return;
> 
> ats_enabled -> pri_enabled

Yes. Sure!

> 
>> +
>> +	iommu = info->iommu;
>> +	domain = info->domain;
>> +	pdev = to_pci_dev(dev);
>> +	sid = PCI_DEVID(info->bus, info->devfn);
>> +	did = domain->iommu_did[iommu->seq_id];
>> +	qdep = pci_ats_queue_depth(pdev);
>> +
>> +	memset(desc, 0, sizeof(desc));
>> +	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>> +			QI_IWD_FENCE |
>> +			QI_IWD_TYPE;
>> +	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
>> +			QI_EIOTLB_DID(did) |
>> +			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
>> +			QI_EIOTLB_TYPE;
>> +	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
>> +			QI_DEV_EIOTLB_SID(sid) |
>> +			QI_DEV_EIOTLB_QDEP(qdep) |
>> +			QI_DEIOTLB_TYPE |
>> +			QI_DEV_IOTLB_PFSID(info->pfsid);
>> +
>> +	/*
>> +	 * Submit an invalidation wait descriptor with fence and page request
>> +	 * drain flags set to invalidation queue. This ensures that all requests
>> +	 * submitted to the invalidation queue ahead of this wait descriptor
>> are
>> +	 * processed and completed, and all already issued page requests
>> from
>> +	 * the device are put in the page request queue.
>> +	 */
> 
> I feel this comment is better moved earlier since it explains the overall
> flow including all 3 descriptors. Also it is not one wait descriptor which
> gets both fence and drain flags set. There are two wait descriptors with
> one setting fence and the other setting drain.
> 
>> +	qi_submit_sync(iommu, desc, 1, QI_OPT_WAIT_DRAIN);
> 
> the count is '3' instead of '1'.

Yes. Will fix it in the next version.

Best regards,
baolu
