Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957F220771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jA+vkX9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgF3KXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:23:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1066 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgF3KXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:23:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb12480000>; Tue, 30 Jun 2020 03:22:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 03:23:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 03:23:38 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 10:23:32 +0000
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Krishna Reddy <vdumpa@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
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
        Bryan Huntsman <bhuntsman@nvidia.com>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
 <20200629215124.GD27967@Asurada-Nvidia>
 <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b353b3f0-ee7f-f777-4d38-c595bc990564@nvidia.com>
Date:   Tue, 30 Jun 2020 11:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593512520; bh=hkVxLnq+dTBVptclOzrR1XDgzm1j91MigMWg/9IR+sc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jA+vkX9kGnJEYI414bhfejJlRZyrp5UzqC6J9cHezgBJHVXgkVVbxPzIw79ZCr1K2
         6NZM9rRZKisYQQmtP/17qWiYcfKSVBi1wt2agXRKs8zUczB2EJ+0Tqau/X1zH+pU+h
         9Jots5TvvQKE56CJvFZ6oEXf/L3ymPqIyvZcW86B7r4WSnl/BxaGzjl2IvNgtGRAKR
         kOCIwVbtWSDZkBqBlCNZocVhLWZI74uX19qdBLXiRr1XnzLjYF5SEp4Svosg9eWR2d
         q4bm+tZt15jQ1MldQCrAc4ibAr/k5xETp9f/+7dJd8rYOdcN36mM0s+7c/7q1KgPvr
         NXTHy46YcCPDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2020 23:49, Krishna Reddy wrote:
>>> +     if (!nvidia_smmu->bases[0])
>>> +             nvidia_smmu->bases[0] = smmu->base;
>>> +
>>> +     return nvidia_smmu->bases[inst] + (page << smmu->pgshift); }
> 
>> Not critical -- just a nit: why not put the bases[0] in init()?
> 
> smmu->base is not available during nvidia_smmu_impl_init() call. It is set afterwards in arm-smmu.c.
> It can't be avoided without changing the devm_ioremap() and impl_init() call order in arm-smmu.c.


Why don't we move the call to devm_ioremap_resource() to before
arm_smmu_impl_init() in arm_smmu_device_probe()? From a quick look I
don't see why we cannot do this and seems better than what we are
currently doing which is quite confusing and hard to understand.

Jon


-- 
nvpublic
