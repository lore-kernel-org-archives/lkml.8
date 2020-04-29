Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B6C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC1E206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2GAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:00:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:37800 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgD2GAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:00:10 -0400
IronPort-SDR: oHqEgtaXIhl3isy6Hf8G2t+e//ONqNeSicsrJSoyfIwwtyH91kg2Oyary+Dpg6ts79rOmDbTYd
 sdKdbFsE8ibA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 23:00:10 -0700
IronPort-SDR: tdP0JcozjqYHzyECyiw/jSMEsOE06f5G+Xx1KzyJMydy7oBY26+A7gv7lcK33Wa9GZIUsD60eM
 YTMGInxN1rcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="404937027"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.254]) ([10.254.210.254])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2020 23:00:06 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, Liu Yi L <yi.l.liu@intel.com>,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iommu/vt-d: Add page request draining support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
 <20200422080611.15689-4-baolu.lu@linux.intel.com>
 <20200428203644.3dcf13f2@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3dd69b64-fc2c-bcfe-dc5f-cbca2b8c351f@linux.intel.com>
Date:   Wed, 29 Apr 2020 14:00:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428203644.3dcf13f2@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/4/29 11:36, Jacob Pan wrote:
> On Wed, 22 Apr 2020 16:06:10 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> When a PASID is stopped or terminated, there can be pending PRQs
>> (requests that haven't received responses) in remapping hardware.
>> This adds the interface to drain page requests and call it when a
>> PASID is terminated.
>>
>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Liu Yi L<yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-svm.c   | 103
>> ++++++++++++++++++++++++++++++++++-- include/linux/intel-iommu.h |
>> 4 ++ 2 files changed, 102 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 83dc4319f661..2534641ef707 100644
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
>>   	dmar_writeq(iommu->reg + DMAR_PQA_REG,
>> virt_to_phys(iommu->prq) | PRQ_ORDER);
>> +	init_completion(&iommu->prq_complete);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -208,6 +211,7 @@ static void intel_mm_release(struct mmu_notifier
>> *mn, struct mm_struct *mm) rcu_read_lock();
>>   	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>>   		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
>> svm->pasid);
>> +		intel_svm_drain_prq(sdev->dev, svm->pasid);
> mmu_notifier release is called in atomic context, drain_prq needs to
> wait for completion. I tested exit path when a process crashes. I got
> 
> [  +0.696214] BUG: sleeping function called from invalid context at kernel/sched/completion.c:101
> [  +0.000068] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3235, name: dsatest
> [  +0.000046] INFO: lockdep is turned off.
> [  +0.000002] CPU: 1 PID: 3235 Comm: dsatest Not tainted 5.7.0-rc1-z-svmtest+ #1637
> [  +0.000000] Hardware name: Intel Corporation Kabylake Client platform/Skylake Halo DDR4 RVP11, BIOS
> 04.1709050855 09/05/2017
> [  +0.000001] Call Trace:
> [  +0.000004]  dump_stack+0x68/0x9b
> [  +0.000003]  ___might_sleep+0x229/0x250
> [  +0.000003]  wait_for_completion_timeout+0x3c/0x110
> [  +0.000003]  intel_svm_drain_prq+0x12f/0x210
> [  +0.000003]  intel_mm_release+0x73/0x110
> [  +0.000003]  __mmu_notifier_release+0x94/0x220
> [  +0.000002]  ? do_munmap+0x10/0x10
> [  +0.000002]  ? prepare_ftrace_return+0x5c/0x80
> [  +0.000003]  exit_mmap+0x156/0x1a0
> [  +0.000002]  ? mmput+0x44/0x120
> [  +0.000003]  ? exit_mmap+0x5/0x1a0
> [  +0.000002]  ? ftrace_graph_caller+0xa0/0xa0
> [  +0.000001]  mmput+0x5e/0x120
> 
> 

Thanks a lot!

Actually, we can't drain page requests in this mm_notifier code path,
right? The assumptions of page request draining are that 1) the device
driver has drained DMA requests in the device end; 2) the pasid entry
has been marked as non-present. So we could only drain page requests in
the unbind path.

Thought?

Best regards,
baolu
