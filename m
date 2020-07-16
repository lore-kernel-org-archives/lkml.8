Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBAC2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGPLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:22:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGPLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:22:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BA91FB;
        Thu, 16 Jul 2020 04:22:21 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D3C3F68F;
        Thu, 16 Jul 2020 04:22:16 -0700 (PDT)
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, trivial@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
Date:   Thu, 16 Jul 2020 12:22:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-16 11:56, John Garry wrote:
> On 16/07/2020 11:28, Will Deacon wrote:
>> On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
>>> On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
>>>> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
>>>>> As mentioned in [0], the CPU may consume many cycles processing
>>>>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() 
>>>>> loop to
>>>>> get space on the queue takes approx 25% of the cycles for this 
>>>>> function.
>>>>>
>>>>> This series removes that cmpxchg().
>>>>
>>>> How about something much simpler like the diff below? >>
>>> Ah, scratch that, I don't drop the lock if we fail the cas with it held.
>>> Let me hack it some more (I have no hardware so I can only build-test 
>>> this).
>>
>> Right, second attempt...
> 
> I can try it, but if performance if not as good, then please check mine 
> further (patch 4/4 specifically) - performance is really good, IMHO.

Perhaps a silly question (I'm too engrossed in PMU world ATM to get 
properly back up to speed on this), but couldn't this be done without 
cmpxchg anyway? Instinctively it feels like instead of maintaining a 
literal software copy of the prod value, we could resolve the "claim my 
slot in the queue" part with atomic_fetch_add on a free-running 32-bit 
"pseudo-prod" index, then whoever updates the hardware deals with the 
truncation and wrap bit to convert it to an actual register value.

Robin.

> 
> Thanks,
> 
>>
>> Will
>>
>> --->8
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index f578677a5c41..e6bcddd6ef69 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
>>       atomic_long_t            *valid_map;
>>       atomic_t            owner_prod;
>>       atomic_t            lock;
>> +    spinlock_t            slock;
>>   };
>>   struct arm_smmu_cmdq_batch {
>> @@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
>> arm_smmu_device *smmu,
>>       u64 cmd_sync[CMDQ_ENT_DWORDS];
>>       u32 prod;
>>       unsigned long flags;
>> -    bool owner;
>> +    bool owner, locked = false;
>>       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>>       struct arm_smmu_ll_queue llq = {
>>           .max_n_shift = cmdq->q.llq.max_n_shift,
>> @@ -1387,27 +1388,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
>> arm_smmu_device *smmu,
>>       /* 1. Allocate some space in the queue */
>>       local_irq_save(flags);
>> -    llq.val = READ_ONCE(cmdq->q.llq.val);
>>       do {
>>           u64 old;
>> +        llq.val = READ_ONCE(cmdq->q.llq.val);
>> -        while (!queue_has_space(&llq, n + sync)) {
>> +        if (queue_has_space(&llq, n + sync))
>> +            goto try_cas;
>> +
>> +        if (locked)
>> +            spin_unlock(&cmdq->slock);
>> +
>> +        do {
>>               local_irq_restore(flags);
>>               if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
>>                   dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>>               local_irq_save(flags);
>> -        }
>> +        } while (!queue_has_space(&llq, n + sync));
>> +try_cas:
>>           head.cons = llq.cons;
>>           head.prod = queue_inc_prod_n(&llq, n + sync) |
>>                            CMDQ_PROD_OWNED_FLAG;
>>           old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
>> -        if (old == llq.val)
>> +        if (old != llq.val)
>>               break;
>> -        llq.val = old;
>> +        if (!locked) {
>> +            spin_lock(&cmdq->slock);
>> +            locked = true;
>> +        }
>>       } while (1);
>> +
>>       owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
>>       head.prod &= ~CMDQ_PROD_OWNED_FLAG;
>>       llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
>> @@ -3192,6 +3204,7 @@ static int arm_smmu_cmdq_init(struct 
>> arm_smmu_device *smmu)
>>       atomic_set(&cmdq->owner_prod, 0);
>>       atomic_set(&cmdq->lock, 0);
>> +    spin_lock_init(&cmdq->slock);
>>       bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
>>       if (!bitmap) {
>> .
>>
> 
