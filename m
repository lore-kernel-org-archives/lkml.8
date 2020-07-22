Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8013F2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgGVBGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:06:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:26542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgGVBGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:06:13 -0400
IronPort-SDR: LNRIsgH6Ugs4ewlMnT6dqHK4PSvLbQ+BPGLvHvHBqE2shF5LkB1/3Cexs8tyfG1Mk2ajz/uDTc
 7wF4XR+O/JBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="235118367"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="235118367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 18:06:13 -0700
IronPort-SDR: rRK2QOhEswznu82D5O8AVJvsH3HtTfgWnE7Secv6pJtJlwm4qJNo8h8La5U3dnaOd5xK4cQNjM
 GVX7xVlahmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="462275980"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2020 18:06:10 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200721095036.1977e3bf@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
Date:   Wed, 22 Jul 2020 09:01:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200721095036.1977e3bf@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/22/20 12:50 AM, Jacob Pan wrote:
> Hi Baolu,
> 
> Not sure what state is this patch in, there is a bug in this patch
> (see below), shall I send out an updated version of this one only? or
> another incremental patch.

Please send an updated version. I hope Joerg could pick these as 5.8
fix.

Best regards,
baolu

> 
> Thanks,
> 
> Jacob
> 
> On Mon,  6 Jul 2020 17:12:51 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
>> From: Liu Yi L <yi.l.liu@intel.com>
>>
>> Address information for device TLB invalidation comes from userspace
>> when device is directly assigned to a guest with vIOMMU support.
>> VT-d requires page aligned address. This patch checks and enforce
>> address to be page aligned, otherwise reserved bits can be set in the
>> invalidation descriptor. Unrecoverable fault will be reported due to
>> non-zero value in the reserved bits.
>>
>> Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation
>> cache types")
>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> ---
>>   drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d9f973fa1190..b2c53bada905 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct
>> intel_iommu *iommu, u16 sid, u16 pfsid,
>>   	 * Max Invs Pending (MIP) is set to 0 for now until we have
>> DIT in
>>   	 * ECAP.
>>   	 */
>> -	desc.qw1 |= addr & ~mask;
>> -	if (size_order)
>> +	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>> +		pr_warn_ratelimited("Invalidate non-aligned address
>> %llx, order %d\n", addr, size_order); +
>> +	/* Take page address */
>> +	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
>> +
>> +	if (size_order) {
>> +		/*
>> +		 * Existing 0s in address below size_order may be
>> the least
>> +		 * significant bit, we must set them to 1s to avoid
>> having
>> +		 * smaller size than desired.
>> +		 */
>> +		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
>> +					VTD_PAGE_SHIFT);
> Yi reported the issue, it should be:
> desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
> 					VTD_PAGE_SHIFT);
> 
>> +		/* Clear size_order bit to indicate size */
>> +		desc.qw1 &= ~mask;
>> +		/* Set the S bit to indicate flushing more than 1
>> page */ desc.qw1 |= QI_DEV_EIOTLB_SIZE;
>> +	}
>>   
>>   	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
> 
> [Jacob Pan]
> 
