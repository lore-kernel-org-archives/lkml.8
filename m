Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6977020737
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbgDPCTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:19:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:1563 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbgDPCTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:19:32 -0400
IronPort-SDR: XmMmOO/wfzJ+LllXY2Z4FbuwEv5J8u+r5t00Gf0LrAZuKBzyrO9tqpfKNlQ13gzx6ClFUEG0qs
 6yXUygjT+S3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 19:19:32 -0700
IronPort-SDR: pAQS6ld+epnMiGhFpY9ElpfTOX7Ui3KLVMJRz7ZmQtWlcK3N07TXi8bQ+WbsuKE1b2+M29F4FV
 bcE6avtw/lKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245852114"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.171]) ([10.254.208.171])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 19:19:30 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] iommu/vt-d: Add page request draining support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-7-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <97bb69fe-4020-6487-6f1f-4454bcf0ba7a@linux.intel.com>
Date:   Thu, 16 Apr 2020 10:19:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8209CE@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/15 19:10, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> When a PASID is stopped or terminated, there can be pending
>> PRQs (requests that haven't received responses) in remapping
>> hardware. This adds the interface to drain page requests and
>> call it when a PASID is terminated.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-svm.c   | 90 ++++++++++++++++++++++++++++++++++---
>>   include/linux/intel-iommu.h |  1 +
>>   2 files changed, 86 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 05aeb8ea51c4..736dd39fb52b 100644
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
>> @@ -210,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier
>> *mn, struct mm_struct *mm)
>>   	rcu_read_lock();
>>   	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>>   		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm-
>>> pasid);
>> +		intel_svm_drain_prq(sdev->dev, svm->pasid);
> 
> I feel there is a problem here. If you clear the PASID entry before draining,
> in-fly requests will hit unrecoverable fault instead, due to invalid PASID
> entry.

The in-fly requests will be ignored by IOMMU if the pasid entry is
empty. It won't result in an unrecoverable fault.

> 
>>   		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   	}
>>   	rcu_read_unlock();
>> @@ -403,12 +405,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int
>> pasid)
>>   		if (!sdev->users) {
>>   			list_del_rcu(&sdev->list);
>>   			intel_pasid_tear_down_entry(iommu, dev, svm-
>>> pasid);
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
>> @@ -646,6 +644,7 @@ int intel_svm_unbind_mm(struct device *dev, int
>> pasid)
>>   			 * large and has to be physically contiguous. So it's
>>   			 * hard to be as defensive as we might like. */
>>   			intel_pasid_tear_down_entry(iommu, dev, svm-
>>> pasid);
>> +			intel_svm_drain_prq(dev, svm->pasid);
>>   			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>>   			kfree_rcu(sdev, rcu);
>>
>> @@ -703,6 +702,7 @@ struct page_req_dsc {
>>   struct page_req {
>>   	struct list_head list;
>>   	struct page_req_dsc desc;
>> +	struct completion complete;
>>   	unsigned int processing:1;
>>   	unsigned int drained:1;
>>   	unsigned int completed:1;
>> @@ -732,9 +732,83 @@ static bool is_canonical_address(u64 addr)
>>   	return (((saddr << shift) >> shift) == saddr);
>>   }
>>
>> +/**
>> + * intel_svm_drain_prq:
>> + *
>> + * Drain all pending page requests related to a specific pasid in both
>> + * software and hardware. The caller must guarantee that no more page
>> + * requests related to this pasid coming.
>> + */
>> +static void intel_svm_drain_prq(struct device *dev, int pasid)
>> +{
>> +	struct device_domain_info *info;
>> +	struct dmar_domain *domain;
>> +	struct intel_iommu *iommu;
>> +	struct qi_desc desc[3];
>> +	struct pci_dev *pdev;
>> +	struct page_req *req;
>> +	unsigned long flags;
>> +	u16 sid, did;
>> +	int qdep;
>> +
>> +	info = get_domain_info(dev);
>> +	if (WARN_ON(!info || !dev_is_pci(dev)))
>> +		return;
>> +
>> +	iommu = info->iommu;
>> +	domain = info->domain;
>> +	pdev = to_pci_dev(dev);
>> +
>> +	/* Mark all related pending requests drained. */
>> +	spin_lock_irqsave(&iommu->prq_lock, flags);
>> +	list_for_each_entry(req, &iommu->prq_list, list)
>> +		if (req->desc.pasid_present && req->desc.pasid == pasid)
>> +			req->drained = true;
>> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
>> +
>> +	/* Wait until all related pending requests complete. */
>> +retry:
>> +	spin_lock_irqsave(&iommu->prq_lock, flags);
>> +	list_for_each_entry(req, &iommu->prq_list, list) {
>> +		if (req->desc.pasid_present &&
>> +		    req->desc.pasid == pasid &&
>> +		    !req->completed) {
>> +			spin_unlock_irqrestore(&iommu->prq_lock, flags);
>> +			wait_for_completion_timeout(&req->complete, 5 *
>> HZ);
>> +			goto retry;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&iommu->prq_lock, flags);
>> +
>> +	/*
>> +	 * Perform steps described in VT-d spec CH7.10 to drain page
>> +	 * request and responses in hardware.
>> +	 */
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
>> +	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> 
> the completion of above sequence ensures that previous queued
> page group responses are sent out and received by the endpoint
> and vice versa all in-fly page requests from the endpoint are queued
> in iommu page request queue. Then comes a problem - you didn't
> wait for completion of those newly-queued requests and their
> responses.

We have emptied the pasid entry and invalidate the related caches, IOMMU
will ignore any new-coming page requests.

> 
> According to VT-d spec 7.10, step (d) mentions when queue overflow
> happens, software needs to repeat the above draining sequence to
> drain auto-responses.

Page request queue overflow is not checked and handled in the prq
interrupt thread. My plan is to add it in a separated patch set. Maybe I
need to state this in the cover letter.

> 
> According to VT-d spec 7.11, the device driver must be notified to
> revoke the PASID before this draining sequence happens. When
> does that happen? Possibly can add some comment to explain such
> background.

Currently, page request drain only happens in unbind() operations. That
ensures that the device driver and the endpoint device have revoked the
pasid. As for how should kernel handle pasid termination before
unbind(), it's still under discussion. For now, AFAICS, it seems that
the acceptable solution is to delay the release of a pasid until ubind()
happens.

Best regards,
baolu
