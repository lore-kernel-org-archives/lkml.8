Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6291C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD1220786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgH0Ebd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:31:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:39606 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgH0Ebc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:31:32 -0400
IronPort-SDR: +hJq/0M52o8s0Fqw7XzdUh/jAlvi3UvrAitB69cd5WQPuWzQhgIMZMjsdM72HRFfdmvlcLyBTZ
 G2mQzdJmc4Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="156425036"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="156425036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 21:31:31 -0700
IronPort-SDR: bHWjCkjSs3ij0pzEkwnq09bJzovba8n8j3KqSXNFlO05CtkIkCL9wYgGG1/K5Xryipxub56dM+
 BIQ1ZQyMey3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="323450235"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 21:31:30 -0700
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200826025825.2322-1-baolu.lu@linux.intel.com>
 <MWHPR11MB16457C6EC72943EF615AF2538C540@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3d7b8176-5535-26a5-a423-18de27c97424@linux.intel.com>
Date:   Thu, 27 Aug 2020 12:25:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16457C6EC72943EF615AF2538C540@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 8/26/20 1:29 PM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, August 26, 2020 10:58 AM
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
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/irq_remapping.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c
>> index 9564d23d094f..19d7e18876fe 100644
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -507,12 +507,16 @@ static void iommu_enable_irq_remapping(struct
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
>> +	iommu->gcmd &= ~DMA_GCMD_CFI;
>> +	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
>> +	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>> +		      readl, !(sts & DMA_GSTS_CFIS), sts);
>> +
> 
> Better do it only when CFI is actually enabled (by checking sts).

Yes. Make sense. Will send a new version with this changed.

Best regards,
baolu

> 
>>   	/*
>>   	 * With CFI clear in the Global Command register, we should be
>>   	 * protected from dangerous (i.e. compatibility) interrupts
>> --
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
