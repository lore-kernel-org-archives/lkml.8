Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8920CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF542065F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgF3Kqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:46:45 -0400
Received: from foss.arm.com ([217.140.110.172]:37864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbgF3Kqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:46:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59BF30E;
        Tue, 30 Jun 2020 03:46:43 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D153F68F;
        Tue, 30 Jun 2020 03:46:40 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Jon Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
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
        Bryan Huntsman <bhuntsman@nvidia.com>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
 <20200629215124.GD27967@Asurada-Nvidia>
 <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <b353b3f0-ee7f-f777-4d38-c595bc990564@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <be484deb-efc9-72cd-f83f-e11713539023@arm.com>
Date:   Tue, 30 Jun 2020 11:46:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b353b3f0-ee7f-f777-4d38-c595bc990564@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 11:23, Jon Hunter wrote:
> 
> On 29/06/2020 23:49, Krishna Reddy wrote:
>>>> +     if (!nvidia_smmu->bases[0])
>>>> +             nvidia_smmu->bases[0] = smmu->base;
>>>> +
>>>> +     return nvidia_smmu->bases[inst] + (page << smmu->pgshift); }
>>
>>> Not critical -- just a nit: why not put the bases[0] in init()?
>>
>> smmu->base is not available during nvidia_smmu_impl_init() call. It is set afterwards in arm-smmu.c.
>> It can't be avoided without changing the devm_ioremap() and impl_init() call order in arm-smmu.c.
> 
> 
> Why don't we move the call to devm_ioremap_resource() to before
> arm_smmu_impl_init() in arm_smmu_device_probe()? From a quick look I
> don't see why we cannot do this and seems better than what we are
> currently doing which is quite confusing and hard to understand.

Yeah, I don't see any problem with adding a patch to do that. 
impl_init() does need to happen before generic probe starts touching any 
registers, but it wouldn't have any business overriding the platform 
resources or anything that would affect the ioremap itself. Plus it's 
reasonable that some theoretical future impl_init() might want to check 
registers for, say, a particular hardware revision, so having 
smmmu->base mapped and valid at that point would be no bad thing.

Robin.
