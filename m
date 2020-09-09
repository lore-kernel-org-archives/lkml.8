Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B704C21D94
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIIM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:29:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbgIIMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:24:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC786101E;
        Wed,  9 Sep 2020 05:23:30 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C22013F68F;
        Wed,  9 Sep 2020 05:23:29 -0700 (PDT)
Subject: Re: [PATCH 1/5] iommu/io-pgtable-arm: Add BROKEN_NS quirk to disable
 shareability on ARM LPAE
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-2-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f8ec460a-d61f-852d-2620-a49306bb1de4@arm.com>
Date:   Wed, 9 Sep 2020 13:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151853.4837-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: s/BROKEN_NS/BROKEN_SH/

Steve

On 08/09/2020 16:18, Neil Armstrong wrote:
> The coherency integration of the IOMMU in the Mali-G52 found in the Amlogic G12B SoCs
> is broken and leads to constant and random faults from the IOMMU.
> 
> Disabling shareability completely fixes the issue.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 7 ++++---
>   include/linux/io-pgtable.h     | 4 ++++
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index dc7bcf858b6d..d2d48dc86556 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -440,7 +440,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>   				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>   	}
>   
> -	if (prot & IOMMU_CACHE)
> +	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_BROKEN_SH)
> +		pte |= ARM_LPAE_PTE_SH_NS;
> +	else if (prot & IOMMU_CACHE)
>   		pte |= ARM_LPAE_PTE_SH_IS;
>   	else
>   		pte |= ARM_LPAE_PTE_SH_OS;
> @@ -1005,8 +1007,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   {
>   	struct arm_lpae_io_pgtable *data;
>   
> -	/* No quirks for Mali (hopefully) */
> -	if (cfg->quirks)
> +	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_BROKEN_SH))
>   		return NULL;
>   
>   	if (cfg->ias > 48 || cfg->oas > 40)
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 23285ba645db..efb9c8f20909 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -86,6 +86,9 @@ struct io_pgtable_cfg {
>   	 *
>   	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
>   	 *	for use in the upper half of a split address space.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_BROKEN_SH: (ARM LPAE format) Disables shareability
> +	 *	when coherency integration is broken.
>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> @@ -93,6 +96,7 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
>   	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
> +	#define IO_PGTABLE_QUIRK_ARM_BROKEN_SH	BIT(6)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 

