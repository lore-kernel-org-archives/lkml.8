Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A244C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B7C2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGJFhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:37:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:11897 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgGJFg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:36:56 -0400
IronPort-SDR: TPtxezKunFKRMv6y99AUMwmhK7cXltkVRoOfEGBZ+RQx9I8OgnjfzQLgvxptpd5HUReobjiDAr
 LXqtuvYLcXXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128220408"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="128220408"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 22:36:55 -0700
IronPort-SDR: K+wowf0uMUswNseS39PCMQD0pPB1bMIhI6y921hmx2APHY2qqY9u4ObAeFisHr/2u4sUoxRjuU
 Vf56zqPvmTeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="298315557"
Received: from xzhou33-mobl1.ccr.corp.intel.com (HELO [10.255.31.159]) ([10.255.31.159])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2020 22:36:53 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-5-baolu.lu@linux.intel.com>
 <MWHPR11MB164546581C5F6B6B77AE28C88C650@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cbf470fe-933a-54d5-e215-afb32d40165f@linux.intel.com>
Date:   Fri, 10 Jul 2020 13:36:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB164546581C5F6B6B77AE28C88C650@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/7/10 10:42, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, July 9, 2020 3:06 PM
>>
>> After page requests are handled, software must respond to the device
>> which raised the page request with the result. This is done through
>> the iommu ops.page_response if the request was reported to outside of
>> vendor iommu driver through iommu_report_device_fault(). This adds the
>> VT-d implementation of page_response ops.
>>
>> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c |   1 +
>>   drivers/iommu/intel/svm.c   | 100
>> ++++++++++++++++++++++++++++++++++++
>>   include/linux/intel-iommu.h |   3 ++
>>   3 files changed, 104 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 4a6b6960fc32..98390a6d8113 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -6057,6 +6057,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.sva_bind		= intel_svm_bind,
>>   	.sva_unbind		= intel_svm_unbind,
>>   	.sva_get_pasid		= intel_svm_get_pasid,
>> +	.page_response		= intel_svm_page_response,
>>   #endif
>>   };
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index d24e71bac8db..839d2af377b6 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -1082,3 +1082,103 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
>>
>>   	return pasid;
>>   }
>> +
>> +int intel_svm_page_response(struct device *dev,
>> +			    struct iommu_fault_event *evt,
>> +			    struct iommu_page_response *msg)
>> +{
>> +	struct iommu_fault_page_request *prm;
>> +	struct intel_svm_dev *sdev = NULL;
>> +	struct intel_svm *svm = NULL;
>> +	struct intel_iommu *iommu;
>> +	bool private_present;
>> +	bool pasid_present;
>> +	bool last_page;
>> +	u8 bus, devfn;
>> +	int ret = 0;
>> +	u16 sid;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return -ENODEV;
>> +
>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>> +	if (!iommu)
>> +		return -ENODEV;
>> +
>> +	if (!msg || !evt)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pasid_mutex);
>> +
>> +	prm = &evt->fault.prm;
>> +	sid = PCI_DEVID(bus, devfn);
>> +	pasid_present = prm->flags &
>> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
>> +	private_present = prm->flags &
>> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
>> +	last_page = prm->flags &
>> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +
>> +	if (pasid_present) {
>> +		if (prm->pasid == 0 || prm->pasid >= PASID_MAX) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
>> +		if (ret || !sdev) {
>> +			ret = -ENODEV;
>> +			goto out;
>> +		}
>> +
>> +		/*
>> +		 * For responses from userspace, need to make sure that the
>> +		 * pasid has been bound to its mm.
>> +		*/
>> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
>> +			struct mm_struct *mm;
>> +
>> +			mm = get_task_mm(current);
>> +			if (!mm) {
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +
>> +			if (mm != svm->mm) {
>> +				ret = -ENODEV;
>> +				mmput(mm);
>> +				goto out;
>> +			}
>> +
>> +			mmput(mm);
>> +		}
>> +	} else {
>> +		pr_err_ratelimited("Invalid page response: no pasid\n");
>> +		ret = -EINVAL;
>> +		goto out;
> 
> check pasid=0 first, then no need to indent so many lines above.

Yes.

> 
>> +	}
>> +
>> +	/*
>> +	 * Per VT-d spec. v3.0 ch7.7, system software must respond
>> +	 * with page group response if private data is present (PDP)
>> +	 * or last page in group (LPIG) bit is set. This is an
>> +	 * additional VT-d requirement beyond PCI ATS spec.
>> +	 */
> 
> What is the behavior if system software doesn't follow the requirement?
> en... maybe the question is really about whether the information in prm
> comes from userspace or from internally-recorded info in iommu core.
> The former cannot be trusted. The latter one is OK.

We require a page response when reporting such event. The upper layer
(IOMMU core or VFIO) will be implemented with a timer, if userspace
doesn't respond in time, the timer will get expired and a FAILURE
response will be sent to device.

Best regards,
baolu

> 
> Thanks
> Kevin
> 
>> +	if (last_page || private_present) {
>> +		struct qi_desc desc;
>> +
>> +		desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid)
>> |
>> +				QI_PGRP_PASID_P(pasid_present) |
>> +				QI_PGRP_PDP(private_present) |
>> +				QI_PGRP_RESP_CODE(msg->code) |
>> +				QI_PGRP_RESP_TYPE;
>> +		desc.qw1 = QI_PGRP_IDX(prm->grpid) |
>> QI_PGRP_LPIG(last_page);
>> +		desc.qw2 = 0;
>> +		desc.qw3 = 0;
>> +		if (private_present)
>> +			memcpy(&desc.qw2, prm->private_data,
>> +			       sizeof(prm->private_data));
>> +
>> +		qi_submit_sync(iommu, &desc, 1, 0);
>> +	}
>> +out:
>> +	mutex_unlock(&pasid_mutex);
>> +	return ret;
>> +}
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index fc2cfc3db6e1..bf6009a344f5 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -741,6 +741,9 @@ struct iommu_sva *intel_svm_bind(struct device
>> *dev, struct mm_struct *mm,
>>   				 void *drvdata);
>>   void intel_svm_unbind(struct iommu_sva *handle);
>>   int intel_svm_get_pasid(struct iommu_sva *handle);
>> +int intel_svm_page_response(struct device *dev, struct iommu_fault_event
>> *evt,
>> +			    struct iommu_page_response *msg);
>> +
>>   struct svm_dev_ops;
>>
>>   struct intel_svm_dev {
>> --
>> 2.17.1
> 
