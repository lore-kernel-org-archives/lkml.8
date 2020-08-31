Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0428C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77BD2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHaBVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:21:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:18375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgHaBVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:21:41 -0400
IronPort-SDR: /gjYJnUWtj7VAIUwFNQDDiewG7VRfx9bMJqEJUMOoRSvUI2d8tUy52tfxc8j9RD5H4B17ZPHAg
 zj6uaVBu45yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144639119"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="144639119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:21:41 -0700
IronPort-SDR: qjEmzA0Hzk/Z7aJAVcRPHrQ+lVeFSGOwvrJe/040UfCFmiT+3vNbiK3/3n2WxVtP2xhLZ9QTWS
 WO2OalPcCPSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="324742092"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2020 18:21:38 -0700
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200827055640.31408-1-baolu.lu@linux.intel.com>
 <MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <757c4e10-519a-6736-8f22-7ae7308434b4@linux.intel.com>
Date:   Mon, 31 Aug 2020 09:16:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks a lot for looking at my patch.

On 8/28/20 10:13 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 27, 2020 1:57 PM
>>
>> If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
>> table, we could default to the device NUMA domain as fall back. This also
>> benefits the vIOMMU use case where only a single vIOMMU is exposed,
>> hence
>> no RHSA will be present but device numa domain can be correct.
> 
> this benefits vIOMMU but not necessarily only applied to single-vIOMMU
> case. The logic still holds in multiple vIOMMU cases as long as RHSA is
> not provided.

Yes. Will refine the description.

> 
>>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index e0516d64d7a3..bce158468abf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -700,12 +700,41 @@ static int
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
>> +		nid = dev_to_node(info->dev);
>> +		if (nid != NUMA_NO_NODE)
>> +			break;
>> +	}
> 
> There could be multiple device numa nodes as devices within the
> same domain may sit behind different IOMMUs. Of course there
> is no perfect answer in such situation, and this patch is still an
> obvious improvement on current always-on-node0 policy. But
> some comment about such implication is welcomed.

I will add some comments here. Without more knowledge, currently we
choose to use the first hit.

> 
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
>> @@ -5086,8 +5115,6 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type)
>>   		if (type == IOMMU_DOMAIN_DMA)
>>   			intel_init_iova_domain(dmar_domain);
>>
>> -		domain_update_iommu_cap(dmar_domain);
>> -
> 
> Is it intended or by mistake? If the former, looks it is a separate fix...

It's a cleanup. When a domain is newly created, this function is
actually a no-op.

> 
>>   		domain = &dmar_domain->domain;
>>   		domain->geometry.aperture_start = 0;
>>   		domain->geometry.aperture_end   =
>> --
>> 2.17.1
> 

Best regards,
baolu
