Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B6AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426962071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgCaOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:19:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbgCaOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D33E7FA;
        Tue, 31 Mar 2020 07:19:12 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3A673F71E;
        Tue, 31 Mar 2020 07:19:10 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: move error checking into common path
To:     luanshi <zhangliguang@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1585663188-114303-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <749b7fb7-06c2-bde3-55e9-03232287d727@arm.com>
Date:   Tue, 31 Mar 2020 15:19:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585663188-114303-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-31 2:59 pm, luanshi wrote:
> Move error checking into common path to be consistent with
> drivers/iommu/arm-smmu.c.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index aa3ac2a..970f1c9 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3889,13 +3889,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	smmu->dev = dev;
>   
> -	if (dev->of_node) {
> +	if (dev->of_node)
>   		ret = arm_smmu_device_dt_probe(pdev, smmu);
> -	} else {
> +	else
>   		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> -		if (ret == -ENODEV)
> -			return ret;
> -	}
> +
> +	if (ret)
> +		return ret;

This completely changes the flow WRT the bypass decision below, so 
without a clear justification of why that's OK, NAK.

Robin.

>   
>   	/* Set bypass mode according to firmware probing result */
>   	bypass = !!ret;
> 
