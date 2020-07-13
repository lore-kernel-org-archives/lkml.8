Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB02C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CD620791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgGMOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:02:33 -0400
Received: from foss.arm.com ([217.140.110.172]:36668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMOCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:02:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE97530E;
        Mon, 13 Jul 2020 07:02:31 -0700 (PDT)
Received: from [10.57.62.178] (unknown [10.57.62.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08FA73F7BB;
        Mon, 13 Jul 2020 07:02:28 -0700 (PDT)
Subject: Re: [PATCH v10 2/5] iommu/arm-smmu: ioremap smmu mmio region before
 implementation init
To:     Krishna Reddy <vdumpa@nvidia.com>, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com,
        nicoleotsuka@gmail.com
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-3-vdumpa@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <49c222ce-e889-937a-6f05-eb1b46739306@arm.com>
Date:   Mon, 13 Jul 2020 15:02:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-3-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 06:00, Krishna Reddy wrote:
> ioremap smmu mmio region before calling into implementation init.
> This is necessary to allow mapped address available during vendor
> specific implementation init.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   drivers/iommu/arm-smmu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d2054178df35..e03e873d3bca 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2120,10 +2120,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	if (err)
>   		return err;
>   
> -	smmu = arm_smmu_impl_init(smmu);
> -	if (IS_ERR(smmu))
> -		return PTR_ERR(smmu);
> -
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	ioaddr = res->start;
>   	smmu->base = devm_ioremap_resource(dev, res);
> @@ -2135,6 +2131,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	 */
>   	smmu->numpage = resource_size(res);
>   
> +	smmu = arm_smmu_impl_init(smmu);
> +	if (IS_ERR(smmu))
> +		return PTR_ERR(smmu);
> +
>   	num_irqs = 0;
>   	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>   		num_irqs++;
> 
