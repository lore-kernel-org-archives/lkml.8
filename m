Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8259C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D38206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H5xU6XpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgGHMFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:05:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9027 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgGHMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:05:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05b6290000>; Wed, 08 Jul 2020 05:03:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:05:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 08 Jul 2020 05:05:40 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:05:34 +0000
Subject: Re: [PATCH v10 2/5] iommu/arm-smmu: ioremap smmu mmio region before
 implementation init
To:     Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robh+dt@kernel.org>,
        <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-3-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <73aa8adb-2a62-f482-7a2f-cea3ad1c0d29@nvidia.com>
Date:   Wed, 8 Jul 2020 13:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-3-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594209833; bh=gxQcl9bpk0BxcF/j6fxcVpCc4kYEvyi3JouVPj5UA8g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=H5xU6XpOQP6NJAMN7gju07RMXH67AVI2gqLWDfsLEEZfr2cFgxo9KyrW3mmXxKdqA
         deWyWZfoLZcaTKnbtZGNnLCnVwP2fXN6I2ITanKIxD1Cy0BmX4QTVENJVGeC8NPWeL
         XwBbIL2PlMMbVz/JYbolgVUXTnWRPNQ3zGaFMycCDhBFh7ZIFBNODIhogPsQKbB2RN
         jjMjQS5b/m534AJc5R4hjOhLA5E2OUmX+ZvIrOwQEtB5y7XI39PK2aUmsFyWP3dD5L
         lXdBMnFpn8steP4v3rQwcmAixPnhb+IOAIhdftl4dF+H/yvuZUHtY8eApCEPAz3xPy
         6KlCUsW6GOc6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2020 06:00, Krishna Reddy wrote:
> ioremap smmu mmio region before calling into implementation init.
> This is necessary to allow mapped address available during vendor
> specific implementation init.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d2054178df35..e03e873d3bca 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2120,10 +2120,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	smmu = arm_smmu_impl_init(smmu);
> -	if (IS_ERR(smmu))
> -		return PTR_ERR(smmu);
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ioaddr = res->start;
>  	smmu->base = devm_ioremap_resource(dev, res);
> @@ -2135,6 +2131,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	 */
>  	smmu->numpage = resource_size(res);
>  
> +	smmu = arm_smmu_impl_init(smmu);
> +	if (IS_ERR(smmu))
> +		return PTR_ERR(smmu);
> +
>  	num_irqs = 0;
>  	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>  		num_irqs++;
> 


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
