Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15B420656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgGBQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:05:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBQFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:05:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD53C1FB;
        Thu,  2 Jul 2020 09:05:17 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70973F71E;
        Thu,  2 Jul 2020 09:05:14 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
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
 <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b10673f6-2a01-b9e5-0948-9684ffbe1813@nvidia.com>
 <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <04e35d51-5e65-047d-90ef-a2de901eb15d@arm.com>
Date:   Thu, 2 Jul 2020 17:05:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822EE99210BFA984ECB954AB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-01 20:39, Krishna Reddy wrote:
> On 01/07/2020 20:00, Krishna Reddy wrote:
>>>>>>> +        items:
>>>>>>> +          - enum:
>>>>>>> +              - nvdia,tegra194-smmu
>>>>>>> +          - const: arm,mmu-500
>>>>>
>>>>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
>>>>>
>>>>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.
>>>
>>>> The problem is, if for some reason someone had a Tegra194, but only set the compatible string to 'arm,mmu-500' it would assume that it was a normal arm,mmu-500 and only one instance would be programmed. We always want at least 2 of the 3 instances >>programmed and so we should only match 'nvidia,tegra194-smmu'. In fact, I think that we also need to update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with the data set to &arm_mmu500.
>>>
>>> In that case, new binding "nvidia,smmu-v2" can be added with data set to &arm_mmu500 and enumeration would have nvidia,tegra194-smmu and another variant for next generation SoC in future.
> 
>> I think you would be better off with nvidia,smmu-500 as smmu-v2 appears to be something different. I see others have a smmu-v2 but I am not sure if that is legacy. We have an smmu-500 and so that would seem more appropriate.
> 
> I tried to use the binding synonymous to other vendors.
> V2 is the architecture version.  MMU-500 is the actual implementation from ARM based on V2 arch.  As we just use the MMU-500 IP as it is, It can be named as nvidia,smmu-500 or similar as well.

Yup, that sounds OK to me if you want a broader compatible to 
potentially match other future SoCs as well.

> Others probably having their own implementation based on V2 arch.

Exactly - "cavium,smmu-v2" and "qcom,smmu-v2" are their own in-house 
microarchitectures, not one of Arm's designs, so they don't really have 
a suitable 'product name' we could have used for the bindings.

Robin.
