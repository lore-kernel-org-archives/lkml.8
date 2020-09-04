Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A66C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBD206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgIDCVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:21:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:33414 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbgIDCVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:21:45 -0400
IronPort-SDR: cq+/z12XJIzCyQhHZzwFD3PL7tF0SAyV45/QFEamQE+LzU9nEVQvcNKigdWv5QSoFjZfwO3+5D
 E7shoswsRPFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158663527"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="158663527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 19:21:44 -0700
IronPort-SDR: i2m3C7pd7AOxFIR86a3NAYw5p5XIkpI9ax4IrhOzWJ4OTOE9Kvnd9kqCj0XOGcxZTm9uEYvL+A
 K2Fajbri+7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="331995898"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2020 19:21:42 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Use device numa domain if RHSA is
 missing
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200904010303.2961-1-baolu.lu@linux.intel.com>
 <MWHPR11MB1645A817E0C928BA83002B4C8C2D0@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <07fc34e2-27bb-590e-805d-083985acc39f@linux.intel.com>
Date:   Fri, 4 Sep 2020 10:16:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645A817E0C928BA83002B4C8C2D0@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 9/4/20 10:16 AM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Friday, September 4, 2020 9:03 AM
>>
>> If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
>> table, we could default to the device NUMA domain as fall back. This could
>> also benefit a vIOMMU use case where only single vIOMMU is exposed,
>> hence
>> no RHSA will be present but device numa domain can be correct.
> 
> My comment on this is not fixed. It is not restricted to single-vIOMMU situation.
> and actually this may also happen on physical platform if some FW doesn't
> provide RHSA information.

Ah, yes. I will remove this sentence since it's same for both bare metal
and virtualization.

> 
> with that being fixed:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thank you!

Best regards,
baolu

> 
>>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 37
>> +++++++++++++++++++++++++++++++++++--
>>   1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> Change log:
>> v1->v2:
>>    - Add a comment as suggested by Kevin.
>>      https://lore.kernel.org/linux-
>> iommu/MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1
>> 645.namprd11.prod.outlook.com/
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 7f844d1c8cd9..69d5a87188f4 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -698,12 +698,47 @@ static int
>> domain_update_iommu_superpage(struct dmar_domain *domain,
>>   	return fls(mask);
>>   }
>>
>> +static int domain_update_device_node(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	int nid = NUMA_NO_NODE;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +
>> +	if (list_empty(&domain->devices))
>> +		return NUMA_NO_NODE;
>> +
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!info->dev)
>> +			continue;
>> +
>> +		/*
>> +		 * There could possibly be multiple device numa nodes as
>> devices
>> +		 * within the same domain may sit behind different IOMMUs.
>> There
>> +		 * isn't perfect answer in such situation, so we select first
>> +		 * come first served policy.
>> +		 */
>> +		nid = dev_to_node(info->dev);
>> +		if (nid != NUMA_NO_NODE)
>> +			break;
>> +	}
>> +
>> +	return nid;
>> +}
>> +
>>   /* Some capabilities may be different across iommus */
>>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>>   {
>>   	domain_update_iommu_coherency(domain);
>>   	domain->iommu_snooping =
>> domain_update_iommu_snooping(NULL);
>>   	domain->iommu_superpage =
>> domain_update_iommu_superpage(domain, NULL);
>> +
>> +	/*
>> +	 * If RHSA is missing, we should default to the device numa domain
>> +	 * as fall back.
>> +	 */
>> +	if (domain->nid == NUMA_NO_NODE)
>> +		domain->nid = domain_update_device_node(domain);
>>   }
>>
>>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8
>> bus,
>> @@ -5096,8 +5131,6 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type)
>>   		if (type == IOMMU_DOMAIN_DMA)
>>   			intel_init_iova_domain(dmar_domain);
>>
>> -		domain_update_iommu_cap(dmar_domain);
>> -
>>   		domain = &dmar_domain->domain;
>>   		domain->geometry.aperture_start = 0;
>>   		domain->geometry.aperture_end   =
>> --
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
