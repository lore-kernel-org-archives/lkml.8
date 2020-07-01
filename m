Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E452082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGATDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:03:20 -0400
Received: from foss.arm.com ([217.140.110.172]:39426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgGATDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:03:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3441FB;
        Wed,  1 Jul 2020 12:03:14 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0A843F68F;
        Wed,  1 Jul 2020 12:03:11 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To:     Jon Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a9e0b213-0601-01fa-8664-e292bf7c81aa@arm.com>
Date:   Wed, 1 Jul 2020 20:03:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-01 19:47, Jon Hunter wrote:
> 
> On 01/07/2020 19:28, Krishna Reddy wrote:
>>>> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
>>> Hmm, there must be a better way to word that to express that it only applies to the sets of SMMUs that must be programmed identically, and not any other independent MMU-500s that might also happen to be in the same SoC.
>>
>> Let me reword it to "NVIDIA SoCs that must program multiple MMU-500s identically".
>>
>>>> +        items:
>>>> +          - enum:
>>>> +              - nvdia,tegra194-smmu
>>>> +          - const: arm,mmu-500
>>
>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
>>
>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.
> 
> The problem is, if for some reason someone had a Tegra194, but only set
> the compatible string to 'arm,mmu-500' it would assume that it was a
> normal arm,mmu-500 and only one instance would be programmed. We always
> want at least 2 of the 3 instances programmed and so we should only
> match 'nvidia,tegra194-smmu'. In fact, I think that we also need to
> update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with
> the data set to &arm_mmu500.

Right, the main concern is if the shiny new DT gets passed to an older 
kernel (or other OS entirely) which doesn't know the 
"nvdia,tegra194-smmu" compatible but would match on "arm,mmu-500" and 
bind a standard driver thinking it's going to work OK. The user would 
probably prefer that no driver matched and both instances were left 
turned off, than face the fallout of only one of them being set up.

Robin.
