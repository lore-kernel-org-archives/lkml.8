Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3812F206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Nf9RGT2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgGHMFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:05:31 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9010 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgGHMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:05:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f05b61f0000>; Wed, 08 Jul 2020 05:03:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 05:05:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jul 2020 05:05:30 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:05:24 +0000
Subject: Re: [PATCH v10 1/5] iommu/arm-smmu: move TLB timeout and spin count
 macros
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
 <20200708050017.31563-2-vdumpa@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f078a879-0779-2bae-19d6-8537493f7124@nvidia.com>
Date:   Wed, 8 Jul 2020 13:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-2-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594209823; bh=39Xiwm/BPHYEB0uxotS0GtnjIsBpeBmuTtn4lOHl6Js=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Nf9RGT2xJJ493EJfEKuoILphz9FeltPWfENInDfdF38rOvZ8dpqygPuRM3VIE7GQw
         hg31ELt6ijAW7k7IOl/NTTS4KDPspvb1Q2VlF6WUH4UpgmG2dQ4lJ0bYK/yQTcydDv
         cFDzQrlgKNbZU4jotTnM+CAzxR2ZVnEIl+JZ/UX9eoABGYkW4B6UAyS++90FjAotqi
         OGgycWRgcBM3001e9Ryzs49IlxE4FoPAv7+A4FDz6eFBt50n6OvnPToiMHCeMj6W3l
         pWqg2DdUa76gPBDOTe39cnNJ2n/8j4Bfai/yMISyyj2mTX0xpUS/rsyocDSXkJMJaF
         /Sokri/GcxGpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2020 06:00, Krishna Reddy wrote:
> Move TLB timeout and spin count macros to header file to
> allow using the same from vendor specific implementations.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu.c | 3 ---
>  drivers/iommu/arm-smmu.h | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 243bc4cb2705..d2054178df35 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -52,9 +52,6 @@
>   */
>  #define QCOM_DUMMY_VAL -1
>  
> -#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> -#define TLB_SPIN_COUNT			10
> -
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index d172c024be61..c7d0122a7c6c 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -236,6 +236,8 @@ enum arm_smmu_cbar_type {
>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS		128
>  
> +#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> +#define TLB_SPIN_COUNT			10
>  
>  /* Shared driver definitions */
>  enum arm_smmu_arch_version {
> 


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
