Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1582C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5020784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894606AbgDOIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:30:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:20237 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408049AbgDOIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:30:24 -0400
IronPort-SDR: Q83+BV94Vsja4E3ftE9q/OsR698zYpMy5n45PMbXPrpuTwiMOJbQnFX0CAxFKdxt4mZ4gQAy8+
 k1ETePawBbtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:30:23 -0700
IronPort-SDR: CjquGXrasSwTCvhBudoPJmdL6OaKLWC9jlj9FTOATiHLjGGp7TfNIZlkEqeVZdKjQzIGXaM+7G
 Hwp+t6iz4Tbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363612788"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.208]) ([10.254.210.208])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2020 01:30:21 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D82055A@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <85ee7356-dd36-e872-8196-ad44bbc1ad20@linux.intel.com>
Date:   Wed, 15 Apr 2020 16:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D82055A@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/15 16:18, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> Extend qi_submit_sync() function to support multiple descriptors.
>>
>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/dmar.c        | 39 +++++++++++++++++++++++--------------
>>   include/linux/intel-iommu.h |  1 +
>>   2 files changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>> index bb42177e2369..61d049e91f84 100644
>> --- a/drivers/iommu/dmar.c
>> +++ b/drivers/iommu/dmar.c
>> @@ -1157,12 +1157,11 @@ static inline void reclaim_free_desc(struct
>> q_inval *qi)
>>   	}
>>   }
>>
>> -static int qi_check_fault(struct intel_iommu *iommu, int index)
>> +static int qi_check_fault(struct intel_iommu *iommu, int index, int
>> wait_index)
>>   {
>>   	u32 fault;
>>   	int head, tail;
>>   	struct q_inval *qi = iommu->qi;
>> -	int wait_index = (index + 1) % QI_LENGTH;
>>   	int shift = qi_shift(iommu);
>>
>>   	if (qi->desc_status[wait_index] == QI_ABORT)
>> @@ -1234,12 +1233,12 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index)
>>   int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>>   		   unsigned int count, unsigned long options)
>>   {
>> -	int rc;
>>   	struct q_inval *qi = iommu->qi;
>> -	int offset, shift, length;
>>   	struct qi_desc wait_desc;
>>   	int wait_index, index;
>>   	unsigned long flags;
>> +	int offset, shift;
>> +	int rc, i;
>>
>>   	if (!qi)
>>   		return 0;
>> @@ -1248,32 +1247,41 @@ int qi_submit_sync(struct intel_iommu *iommu,
>> struct qi_desc *desc,
>>   	rc = 0;
>>
>>   	raw_spin_lock_irqsave(&qi->q_lock, flags);
>> -	while (qi->free_cnt < 3) {
>> +	/*
>> +	 * Check if we have enough empty slots in the queue to submit,
>> +	 * the calculation is based on:
>> +	 * # of desc + 1 wait desc + 1 space between head and tail
>> +	 */
>> +	while (qi->free_cnt < count + 2) {
>>   		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>>   		cpu_relax();
>>   		raw_spin_lock_irqsave(&qi->q_lock, flags);
>>   	}
>>
>>   	index = qi->free_head;
>> -	wait_index = (index + 1) % QI_LENGTH;
>> +	wait_index = (index + count) % QI_LENGTH;
>>   	shift = qi_shift(iommu);
>> -	length = 1 << shift;
>>
>> -	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
>> +	for (i = 0; i < count; i++) {
>> +		offset = ((index + i) % QI_LENGTH) << shift;
>> +		memcpy(qi->desc + offset, &desc[i], 1 << shift);
>> +		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
>> +	}
> what about doing one memcpy and leave the loop only for updating
> qi status?
> 

One memcpy might cross the table boundary.

Best regards,
baolu
