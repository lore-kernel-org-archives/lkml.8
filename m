Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D25C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD6720760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OlRYIRuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgF3KRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:17:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10565 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbgF3KRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:17:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb111b0000>; Tue, 30 Jun 2020 03:16:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 03:17:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 03:17:48 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 10:17:39 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
Date:   Tue, 30 Jun 2020 11:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630001051.12350-2-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593512219; bh=BfZIPiMPzpjUihBsAJUP01sDidpTF7q6kK3zqhZ7zvI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OlRYIRuGOhccq3GHllo7CDUevA5/1z9P5ceHZ3yzGD8KsarRUGUXIN80yEiRHK5Us
         OdXTUZ2OzIV3KlL9VebsZEIEm1ILF852V/JnTdES6+E8hwyFMf9bpU2uns7SP4/8Kb
         /SIWsLU6EIe98bqfD/Uwlkjf0wF2liX+WCNEO9+P1FnBIl2oZjhQu01H18Kj3SLgE8
         iUurpA47wuV7F+JlJlb0bav6z1grUoSWptSt01hQ+yVRKHa0cFoGlmihOH5eSNkSiE
         D80cjprdSxdGgGxNJH7eJy2c5NLkSw6jS1ci1ezFzxIMpLEcYMFEvYMLVcep1dhowz
         7uE3EY8UQtZ7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/2020 01:10, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 SoC SMMU topology.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/iommu/Makefile          |   2 +-
>  drivers/iommu/arm-smmu-impl.c   |   3 +
>  drivers/iommu/arm-smmu-nvidia.c | 196 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.h        |   1 +
>  5 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm-smmu-nvidia.c

...

> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +	unsigned int i;
> +	struct nvidia_smmu *nvidia_smmu;
> +	struct platform_device *pdev = to_platform_device(smmu->dev);
> +
> +	nvidia_smmu = devm_kzalloc(smmu->dev, sizeof(*nvidia_smmu), GFP_KERNEL);
> +	if (!nvidia_smmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nvidia_smmu->smmu = *smmu;
> +	/* Instance 0 is ioremapped by arm-smmu.c after this function returns */
> +	nvidia_smmu->num_inst = 1;
> +
> +	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
> +		struct resource *res;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			break;

Currently this driver is only supported for Tegra194 which I understand
has 3 SMMUs. Therefore, I don't feel that we should fail silently here,
I think it is better to return an error if all 3 cannot be initialised.
In the future if there is an SoC that has less (hopefully not more) than
Tegra194 then we should handle this via the DT compatible string. In
other words, we should always know how many SMMUs there are for a given
SoC and how many we should initialise.

> +
> +		nvidia_smmu->bases[i] = devm_ioremap_resource(smmu->dev, res);
> +		if (IS_ERR(nvidia_smmu->bases[i]))
> +			return ERR_CAST(nvidia_smmu->bases[i]);

You want to use PTR_ERR() here.

Jon

-- 
nvpublic
