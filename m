Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2730A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgF2VRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgF2Sy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 688D11570;
        Mon, 29 Jun 2020 09:29:37 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8123F71E;
        Mon, 29 Jun 2020 09:29:36 -0700 (PDT)
Subject: Re: [PATCH] iommu: SUN50I_IOMMU should depend on HAS_DMA
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joerg Roedel <joro@8bytes.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200629121146.24011-1-geert@linux-m68k.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c2047394-ea6e-3bc3-4bf0-a732237dbeca@arm.com>
Date:   Mon, 29 Jun 2020 17:29:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629121146.24011-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 13:11, Geert Uytterhoeven wrote:
> If NO_DMA=y (e.g. Sun-3 all{mod,yes}-config):
> 
>      drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
>      dma-iommu.c:(.text+0x92e): undefined reference to `dma_pgprot'
> 
> IOMMU_DMA must not be selected, unless HAS_DMA=y.

Wait, no, IOMMU_DMA should not be selected by drivers at all - it's for 
arch code to choose.

x86 just complicates matters with some of its arch code being in its 
IOMMU drivers...

Robin.

> Hence fix this by making SUN50I_IOMMU depend on HAS_DMA.
> 
> Fixes: 4100b8c229b32835 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6dc49ed8377a5c12..b0f308cb7f7c2fc2 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -305,6 +305,7 @@ config ROCKCHIP_IOMMU
>   
>   config SUN50I_IOMMU
>   	bool "Allwinner H6 IOMMU Support"
> +	depends on HAS_DMA
>   	depends on ARCH_SUNXI || COMPILE_TEST
>   	select ARM_DMA_USE_IOMMU
>   	select IOMMU_API
> 
