Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0818C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29DC20791
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgFWLRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:17:03 -0400
Received: from foss.arm.com ([217.140.110.172]:57500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732458AbgFWLRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:17:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB441F1;
        Tue, 23 Jun 2020 04:16:58 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD7E3F6CF;
        Tue, 23 Jun 2020 04:16:56 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Cc:     treding@nvidia.com, bhuntsman@nvidia.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        mperttunen@nvidia.com, talho@nvidia.com, snikam@nvidia.com,
        nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
        praithatha@nvidia.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-2-vdumpa@nvidia.com> <20200623102927.GD4098287@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5f29c794-406a-db13-d6d0-75dcb0d0b0cc@arm.com>
Date:   Tue, 23 Jun 2020 12:16:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623102927.GD4098287@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 11:29, Thierry Reding wrote:
[...]
>> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
>> index c75b9d957b702..52c84c30f83e4 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -160,6 +160,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>>   	 */
>>   	switch (smmu->model) {
>>   	case ARM_MMU500:
>> +		if (of_device_is_compatible(smmu->dev->of_node,
>> +					    "nvidia,tegra194-smmu-500"))
>> +			return nvidia_smmu_impl_init(smmu);
> 
> Should NVIDIA_TEGRA194_SMMU be a separate value for smmu->model,
> perhaps? That way we avoid this somewhat odd check here.

No, this is simply in the wrong place. The design here is that we pick 
up anything related to the basic SMMU IP (model) first, then make any 
platform-specific integration checks. That way a platform-specific init 
function can see the model impl set and subclass it if necessary 
(although nobody's actually done that yet). The setup for Cavium is just 
a short-cut since their model is unique to their integration, so the 
lines get a bit blurred and there's little benefit to trying to separate 
it out.

In short, put this down below with the other of_device_is_compatible() 
checks.

>>   		smmu->impl = &arm_mmu500_impl;
>>   		break;
>>   	case CAVIUM_SMMUV2:
>> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> 
> I wonder if it would be better to name this arm-smmu-tegra.c to make it
> clearer that this is for a Tegra chip. We do have regular expressions in
> MAINTAINERS that catch anything with "tegra" in it to make this easier.

There was a notion that these would be grouped by vendor, but if there's 
a strong preference for all NVIDIA-SoC-related stuff to be named "Tegra" 
then I'm not going to complain too much.

>> new file mode 100644
>> index 0000000000000..dafc293a45217
>> --- /dev/null
>> +++ b/drivers/iommu/arm-smmu-nvidia.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Nvidia ARM SMMU v2 implementation quirks
> 
> s/Nvidia/NVIDIA/
> 
>> +// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.
> 
> I suppose this should now also include 2020.
> 
>> +
>> +#define pr_fmt(fmt) "nvidia-smmu: " fmt
> 
> Same here. Might be worth making this "tegra-smmu: " for consistency.

On the other hand, a log prefix that is literally the name of a 
completely unrelated driver seems more confusing to users than useful. 
Same for the function naming - the tegra_smmu_* namespace is already 
owned by that driver.

Robin.
