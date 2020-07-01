Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB346C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A538720853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgGATOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:14:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgGATOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:14:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38971FB;
        Wed,  1 Jul 2020 12:14:14 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F743F68F;
        Wed,  1 Jul 2020 12:14:12 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
To:     Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Sachin Nikam <Snikam@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bitan Biswas <bbiswas@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
 <BYAPR12MB282244D2B008E1C8CA57916BB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <446ffe79-3a44-5d41-459f-b698a1cc361b@arm.com>
Date:   Wed, 1 Jul 2020 20:14:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB282244D2B008E1C8CA57916BB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-01 19:48, Krishna Reddy wrote:
>>>> +    for (inst = 0; inst < nvidia_smmu->num_inst; inst++) {
>>>> +            irq_ret = nvidia_smmu_global_fault_inst(irq, smmu, inst);
>>>> +            if (irq_ret == IRQ_HANDLED)
>>>> +                    return irq_ret;
>>>
>>> Any chance there could be more than one SMMU faulting by the time we
>>> service the interrupt?
> 
>> It certainly seems plausible if the interconnect is automatically load-balancing requests across the SMMU instances - say a driver bug caused a buffer to be unmapped too early, there could be many in-flight accesses to parts of that buffer that aren't all taking the same path and thus could now fault in parallel.
>> [ And anyone inclined to nitpick global vs. context faults, s/unmap a buffer/tear down a domain/ ;) ]
>> Either way I think it would be easier to reason about if we just handled these like a typical shared interrupt and always checked all the instances.
> 
> It would be optimal to check at the same time across all instances.
> 
>>>> +            for (idx = 0; idx < smmu->num_context_banks; idx++) {
>>>> +                    irq_ret = nvidia_smmu_context_fault_bank(irq, smmu,
>>>> +                                                             idx,
>>>> + inst);
>>>> +
>>>> +                    if (irq_ret == IRQ_HANDLED)
>>>> +                            return irq_ret;
>>>
>>> Any reason why we don't check all banks?
> 
>> As above, we certainly shouldn't bail out without checking the bank for the offending domain across all of its instances, and I guess the way this works means that we would have to iterate all the banks to achieve that.
> 
> With shared irq line, the context fault identification is not optimal already.  Reading all the context banks all the time can be additional mmio read overhead. But, it may not hurt the real use cases as these happen only when there are bugs.

Right, I did ponder the idea of a whole programmatic 
"request_context_irq" hook that would allow registering the handler for 
both interrupts with the appropriate context bank and instance data, but 
since all interrupts are currently unexpected it seems somewhat hard to 
justify the extra complexity. Obviously we can revisit this in future if 
you want to start actually doing something with faults like the qcom GPU 
folks do.

Robin.
