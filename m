Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87845C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B863206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d+UqhUrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgF3Qcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:32:51 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9409 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgF3Qcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:32:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb68cf0000>; Tue, 30 Jun 2020 09:31:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 09:32:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 09:32:50 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 16:32:43 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Krishna Reddy <vdumpa@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
Date:   Tue, 30 Jun 2020 17:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593534671; bh=BrdgzbzbGOaqIwpth+UjSE/3zpix62EIsg7FYiFJ6po=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d+UqhUrDKQr8qFYOz/u1vjt8DsYokVFOhzKCisRgy5ftkePf+uBolfrmg8FgEHwdS
         piLlBWJ0pLcqmaeAwHPOo/UaGVj9zVUQNskhfOXQpG0k6Ias7wEyUgS7An8mBhyL5p
         tMQrr173OXX1OggHX8tDrBt3AxuIsi9WThAIxJW/79t3EfyxVilU+9a6SqzZALM6S/
         p1xDklctnzMXhkzlodCLxyMmAnpk+KM94/7MvD6rRAYRUePSHy3nAMp+tNqgKSvViJ
         3fQ+OW2hvHql+Q6b6F2BYaMga1HaxbS7PeG+b1/qaNATJXb75hdM3242unbLTHx59U
         Q/kF7UjjTvN8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2020 17:23, Krishna Reddy wrote:
>>> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device 
>>> +*smmu) {
>>> +	unsigned int i;
> ....
>>> +	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
>>> +		struct resource *res;
>>> +
>>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>>> +		if (!res)
>>> +			break;
> 
>> Currently this driver is only supported for Tegra194 which I understand has 3 SMMUs. Therefore, I don't feel that we should fail silently here, I think it is better to return an error if all 3 cannot be initialised.
> 
> Initialization of all the three SMMU instances is not necessary here.

That is not what I am saying.

> The driver can work with all the possible number of instances 1, 2 and 3 based on the DT config though it doesn't make much sense to use it with 1 instance.
> There is no silent failure here from driver point of view. If there is misconfig in DT, SMMU faults would catch issues.

I disagree and you should return a proper error here.

>>> +		nvidia_smmu->bases[i] = devm_ioremap_resource(smmu->dev, res);
>>> +		if (IS_ERR(nvidia_smmu->bases[i]))
>>> +			return ERR_CAST(nvidia_smmu->bases[i]);
> 
>> You want to use PTR_ERR() here.
> 
> PTR_ERR() returns long integer. 
> This function returns a pointer. ERR_CAST is the right one to use here. 

Ah yes, indeed. OK that's fine.

Jon

-- 
nvpublic
