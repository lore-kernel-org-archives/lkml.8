Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B063D20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGPNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:33:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgGPNdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:33:08 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9F5A2950D01906284ED5;
        Thu, 16 Jul 2020 14:33:06 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 14:33:05 +0100
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <54b0c8b9-d079-f832-2338-11cf6b09fa00@huawei.com>
Date:   Thu, 16 Jul 2020 14:31:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716102814.GD7036@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 11:28, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
>> On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
>>> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
>>>> As mentioned in [0], the CPU may consume many cycles processing
>>>> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
>>>> get space on the queue takes approx 25% of the cycles for this function.
>>>>
>>>> This series removes that cmpxchg().
>>>
>>> How about something much simpler like the diff below?
>>
>> Ah, scratch that, I don't drop the lock if we fail the cas with it held.
>> Let me hack it some more (I have no hardware so I can only build-test this).
> 
> Right, second attempt...
> 
> Will

Unfortunately that hangs my machine during boot:

[10.902893] 00:01: ttyS0 at MMIO 0x3f00003f8 (irq = 6, base_baud = 
115200) is a 16550A
[10.912048] SuperH (H)SCI(F) driver initialized
[10.916811] msm_serial: driver initialized
[10.921371] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[10.926946] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[10.935374] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
[10.942522] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq


> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f578677a5c41..e6bcddd6ef69 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
>   	atomic_long_t			*valid_map;
>   	atomic_t			owner_prod;
>   	atomic_t			lock;
> +	spinlock_t			slock;
>   };
>   
>   struct arm_smmu_cmdq_batch {
> @@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	u64 cmd_sync[CMDQ_ENT_DWORDS];
>   	u32 prod;
>   	unsigned long flags;
> -	bool owner;
> +	bool owner, locked = false;
>   	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>   	struct arm_smmu_ll_queue llq = {
>   		.max_n_shift = cmdq->q.llq.max_n_shift,
> @@ -1387,27 +1388,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   
>   	/* 1. Allocate some space in the queue */
>   	local_irq_save(flags);
> -	llq.val = READ_ONCE(cmdq->q.llq.val);
>   	do {
>   		u64 old;
> +		llq.val = READ_ONCE(cmdq->q.llq.val);
>   
> -		while (!queue_has_space(&llq, n + sync)) {
> +		if (queue_has_space(&llq, n + sync))
> +			goto try_cas;
> +
> +		if (locked)
> +			spin_unlock(&cmdq->slock);
> +
> +		do {
>   			local_irq_restore(flags);
>   			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>   			local_irq_save(flags);
> -		}
> +		} while (!queue_has_space(&llq, n + sync));
>   
> +try_cas:
>   		head.cons = llq.cons;
>   		head.prod = queue_inc_prod_n(&llq, n + sync) |
>   					     CMDQ_PROD_OWNED_FLAG;
>   
>   		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> -		if (old == llq.val)
> +		if (old != llq.val)

Not sure why you changed this. And if I change it back, it seems that we 
could drop out of the loop with cmdq->slock held, so need to drop the 
lock also.

I tried that and it stops my machine hanging. Let me know that was the 
intention, so I can test.

Thanks,
John

>   			break;
>   
> -		llq.val = old;
> +		if (!locked) {
> +			spin_lock(&cmdq->slock);
> +			locked = true;
> +		}
>   	} while (1);
> +
>   	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
>   	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
>   	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
> @@ -3192,6 +3204,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>   
>   	atomic_set(&cmdq->owner_prod, 0);
>   	atomic_set(&cmdq->lock, 0);
> +	spin_lock_init(&cmdq->slock);
>   
>   	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
>   	if (!bitmap) {
> .
> 

