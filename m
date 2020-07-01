Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163012082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGAS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:56:28 -0400
Received: from foss.arm.com ([217.140.110.172]:38898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGAS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:56:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27DFF1FB;
        Wed,  1 Jul 2020 11:56:27 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9501A3F68F;
        Wed,  1 Jul 2020 11:56:23 -0700 (PDT)
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
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
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
 <d59b7220-168c-419f-db16-194307e11065@arm.com>
 <BYAPR12MB2822FC263456303302EF30BEB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ae6b6e6-bd64-9c89-49ca-1f5785ef3f0c@arm.com>
Date:   Wed, 1 Jul 2020 19:56:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822FC263456303302EF30BEB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-01 19:18, Krishna Reddy wrote:
>>> + * When Linux kernel supports multiple SMMU devices, the SMMU
>>> device +used for + * isochornous HW devices should be added as a
>>> separate ARM MMU-500 +device + * in DT and be programmed
>>> independently for efficient TLB invalidates.
> 
>> I don't understand the "When" there - the driver has always
>> supported multiple independent SMMUs, and it's not something that
>> could be configured out or otherwise disabled. Plus I really don't
>> see why you would ever want to force unrelated SMMUs to be
>> >programmed together - beyond the TLB thing mentioned it would also
>> waste precious context bank resources and might lead to weird
>> device grouping via false stream ID aliasing, with no obvious
>> upside at all.
> 
> Sorry, I missed this comment. During the initial patches, when the
> iommu_ops were different between, support multiple SMMU drivers at
> the same is not possible as one of them(that gets probed last)
> overwrites the platform bus ops. On revisiting the original issue,
> This problem is no longer relevant. At this point, It makes more
> sense to just get rid of 3rd instance programming in
> arm-smmu-nvidia.c and just limit it to the SMMU instances that need
> identical programming.

Yeah, I realised later last night that this probably originated from 
forking the whole driver downstream. But even then you could have 
treated the other one as a separate nsmmu with a single instance ;)

Since it does add a bit of confusion to the code and comments, let's 
just keep things simple. I do like Jon's suggestion of actually 
enforcing that the number of "reg" regions exactly matches the number 
expected for the given compatible - I guess for now that means just 
hard-coding 2 and hoping the hardware folks don't cook up any more of 
these...

Robin.
