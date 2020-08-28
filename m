Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D129C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgH1AFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 20:05:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:47226 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1AFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 20:05:40 -0400
IronPort-SDR: VPErji24gt8T5p45jGtcxYg+iIusf6jnilQRj1jV0eIdXlhVFNqDWqFmB414htU5g5qEtoznUA
 qHIko6xg7qnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="144333166"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="144333166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 17:05:39 -0700
IronPort-SDR: v9peXfmc5VrHw0cZ+YxUQNp5p78XNfC9kwBhK26wof+XOZJ1+68uUXnPtkkJXqKAtvJh7qqUzt
 tl+qNiSkiakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="323800614"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2020 17:05:37 -0700
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200827042513.30292-1-baolu.lu@linux.intel.com>
 <MWHPR11MB164521E12E86B1681C132C0E8C550@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <131a9e8a-1299-cf55-3477-dd6e2c1373f4@linux.intel.com>
Date:   Fri, 28 Aug 2020 08:00:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB164521E12E86B1681C132C0E8C550@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/27/20 1:39 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 27, 2020 12:25 PM
>>
>> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG
>> General
>> Description) that:
>>
>> If multiple control fields in this register need to be modified, software
>> must serialize the modifications through multiple writes to this register.
>>
>> However, in irq_remapping.c, modifications of IRE and CFI are done in one
>> write. We need to do two separate writes with STS checking after each.
>>
>> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out
>> security warning mess")
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/irq_remapping.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> Change log:
>> v1->v2:
>>    - v1 posted here
>>      https://lore.kernel.org/linux-iommu/20200826025825.2322-1-
>> baolu.lu@linux.intel.com/;
>>    - Add status check before disabling CFI. (Kevin)
>>
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c
>> index 9564d23d094f..7552bb7e92c8 100644
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -507,12 +507,19 @@ static void iommu_enable_irq_remapping(struct
>> intel_iommu *iommu)
>>
>>   	/* Enable interrupt-remapping */
>>   	iommu->gcmd |= DMA_GCMD_IRE;
>> -	iommu->gcmd &= ~DMA_GCMD_CFI;  /* Block compatibility-format
>> MSIs */
>>   	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
>> -
>>   	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>>   		      readl, (sts & DMA_GSTS_IRES), sts);
>>
>> +	/* Block compatibility-format MSIs */
>> +	sts = readl(iommu->reg + DMAR_GSTS_REG);
> 
> no need of this readl as the status is already three in IOMMU_WAIT_OP.

Yes. Really!

Best regards,
baolu

> 
>> +	if (sts & DMA_GSTS_CFIS) {
>> +		iommu->gcmd &= ~DMA_GCMD_CFI;
>> +		writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
>> +		IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>> +			      readl, !(sts & DMA_GSTS_CFIS), sts);
>> +	}
>> +
>>   	/*
>>   	 * With CFI clear in the Global Command register, we should be
>>   	 * protected from dangerous (i.e. compatibility) interrupts
>> --
>> 2.17.1
> 
