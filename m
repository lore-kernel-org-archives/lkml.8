Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2957C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57072076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJF3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:29:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:20778 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGJF0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:26:04 -0400
IronPort-SDR: wbJF9zqyWDeByJeOMrFkbfqlwrcozAHCkeGnAZ45ztkTmPLo4Mn+yfJ9l5zq060rRiSUkgvQRp
 Fs+wQo1qk+Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148142446"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="148142446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 22:25:37 -0700
IronPort-SDR: 4j1ShUqut6A/r8IhoUGs/RIzlFrgal+5jxzG2jIA7llcRJ+31FQnBAAPVZpv43cmICMrFm2BGN
 t9X91ktzGD3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="298313649"
Received: from xzhou33-mobl1.ccr.corp.intel.com (HELO [10.255.31.159]) ([10.255.31.159])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2020 22:25:35 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iommu/vt-d: Report page request faults for guest
 SVA
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645D22D2CBCECE1257CBFEF8C650@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <027ccdd4-003e-9cf7-c519-d5655606b702@linux.intel.com>
Date:   Fri, 10 Jul 2020 13:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645D22D2CBCECE1257CBFEF8C650@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/7/10 10:24, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, July 9, 2020 3:06 PM
>>
>> A pasid might be bound to a page table from a VM guest via the iommu
>> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
>> on the physical IOMMU, we need to inject the page fault request into
>> the guest. After the guest completes handling the page fault, a page
>> response need to be sent back via the iommu ops.page_response().
>>
>> This adds support to report a page request fault. Any external module
>> which is interested in handling this fault should regiester a notifier
>> with iommu_register_device_fault_handler().
>>
>> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 103 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 85 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index c23167877b2b..d24e71bac8db 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -815,8 +815,63 @@ static void intel_svm_drain_prq(struct device *dev,
>> int pasid)
>>   	}
>>   }
>>
>> +static int prq_to_iommu_prot(struct page_req_dsc *req)
>> +{
>> +	int prot = 0;
>> +
>> +	if (req->rd_req)
>> +		prot |= IOMMU_FAULT_PERM_READ;
>> +	if (req->wr_req)
>> +		prot |= IOMMU_FAULT_PERM_WRITE;
>> +	if (req->exe_req)
>> +		prot |= IOMMU_FAULT_PERM_EXEC;
>> +	if (req->pm_req)
>> +		prot |= IOMMU_FAULT_PERM_PRIV;
>> +
>> +	return prot;
>> +}
>> +
>> +static int
>> +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
>> +{
>> +	struct iommu_fault_event event;
>> +
>> +	/* Fill in event data for device specific processing */
>> +	memset(&event, 0, sizeof(struct iommu_fault_event));
>> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
>> +	event.fault.prm.addr = desc->addr;
>> +	event.fault.prm.pasid = desc->pasid;
>> +	event.fault.prm.grpid = desc->prg_index;
>> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return -ENODEV;
> 
> move the check before memset.

Yes.

> 
>> +
>> +	if (desc->lpig)
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +	if (desc->pasid_present) {
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
>> +	}
> 
> if pasid is not present, should we return error directly instead of
> submitting the req and let iommu core to figure out? I don't have

This has been done in prq_event_thread(), so I don't need to check it
again here.

> a strong preference, thus:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks a lot for your time.

Best regards,
baolu

> 
>> +	if (desc->priv_data_present) {
>> +		/*
>> +		 * Set last page in group bit if private data is present,
>> +		 * page response is required as it does for LPIG.
>> +		 * iommu_report_device_fault() doesn't understand this
>> vendor
>> +		 * specific requirement thus we set last_page as a
>> workaround.
>> +		 */
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +		event.fault.prm.flags |=
>> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
>> +		memcpy(event.fault.prm.private_data, desc->priv_data,
>> +		       sizeof(desc->priv_data));
>> +	}
>> +
>> +	return iommu_report_device_fault(dev, &event);
>> +}
>> +
>>   static irqreturn_t prq_event_thread(int irq, void *d)
>>   {
>> +	struct intel_svm_dev *sdev = NULL;
>>   	struct intel_iommu *iommu = d;
>>   	struct intel_svm *svm = NULL;
>>   	int head, tail, handled = 0;
>> @@ -828,7 +883,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
>> PRQ_RING_MASK;
>>   	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
>> PRQ_RING_MASK;
>>   	while (head != tail) {
>> -		struct intel_svm_dev *sdev;
>>   		struct vm_area_struct *vma;
>>   		struct page_req_dsc *req;
>>   		struct qi_desc resp;
>> @@ -864,6 +918,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			}
>>   		}
>>
>> +		if (!sdev || sdev->sid != req->rid) {
>> +			struct intel_svm_dev *t;
>> +
>> +			sdev = NULL;
>> +			rcu_read_lock();
>> +			list_for_each_entry_rcu(t, &svm->devs, list) {
>> +				if (t->sid == req->rid) {
>> +					sdev = t;
>> +					break;
>> +				}
>> +			}
>> +			rcu_read_unlock();
>> +		}
>> +
>>   		result = QI_RESP_INVALID;
>>   		/* Since we're using init_mm.pgd directly, we should never
>> take
>>   		 * any faults on kernel addresses. */
>> @@ -874,6 +942,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   		if (!is_canonical_address(address))
>>   			goto bad_req;
>>
>> +		/*
>> +		 * If prq is to be handled outside iommu driver via receiver of
>> +		 * the fault notifiers, we skip the page response here.
>> +		 */
>> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
>> +			if (sdev && !intel_svm_prq_report(sdev->dev, req))
>> +				goto prq_advance;
>> +			else
>> +				goto bad_req;
>> +		}
>> +
>>   		/* If the mm is already defunct, don't handle faults. */
>>   		if (!mmget_not_zero(svm->mm))
>>   			goto bad_req;
>> @@ -892,24 +971,11 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			goto invalid;
>>
>>   		result = QI_RESP_SUCCESS;
>> -	invalid:
>> +invalid:
>>   		mmap_read_unlock(svm->mm);
>>   		mmput(svm->mm);
>> -	bad_req:
>> -		/* Accounting for major/minor faults? */
>> -		rcu_read_lock();
>> -		list_for_each_entry_rcu(sdev, &svm->devs, list) {
>> -			if (sdev->sid == req->rid)
>> -				break;
>> -		}
>> -		/* Other devices can go away, but the drivers are not
>> permitted
>> -		 * to unbind while any page faults might be in flight. So it's
>> -		 * OK to drop the 'lock' here now we have it. */
>> -		rcu_read_unlock();
>> -
>> -		if (WARN_ON(&sdev->list == &svm->devs))
>> -			sdev = NULL;
>> -
>> +bad_req:
>> +		WARN_ON(!sdev);
>>   		if (sdev && sdev->ops && sdev->ops->fault_cb) {
>>   			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>>   				(req->exe_req << 1) | (req->pm_req);
>> @@ -920,7 +986,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   		   and these can be NULL. Do not use them below this point!
>> */
>>   		sdev = NULL;
>>   		svm = NULL;
>> -	no_pasid:
>> +no_pasid:
>>   		if (req->lpig || req->priv_data_present) {
>>   			/*
>>   			 * Per VT-d spec. v3.0 ch7.7, system software must
>> @@ -945,6 +1011,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			resp.qw3 = 0;
>>   			qi_submit_sync(iommu, &resp, 1, 0);
>>   		}
>> +prq_advance:
>>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>   	}
>>
>> --
>> 2.17.1
> 
