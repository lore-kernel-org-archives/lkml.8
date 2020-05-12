Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85016C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A6D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgELJxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:53:34 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36000 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgELJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:53:34 -0400
Received: from penelope.horms.nl (tulip.horms.nl [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AB32C25AD50;
        Tue, 12 May 2020 19:53:31 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 57B76717; Tue, 12 May 2020 11:53:29 +0200 (CEST)
Date:   Tue, 12 May 2020 11:53:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hai Nguyen Pham <hai.pham.ud@renesas.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/renesas: fix unused-function warning
Message-ID: <20200512095329.GA18408@vergenet.net>
References: <20200508220224.688985-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508220224.688985-1-arnd@arndb.de>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:02:16AM +0200, Arnd Bergmann wrote:
> gcc warns because the only reference to ipmmu_find_group
> is inside of an #ifdef:
> 
> drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]
> 
> Change the #ifdef to an equivalent IS_ENABLED().
> 
> Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index fb7e702dee23..4c2972f3153b 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -903,11 +903,8 @@ static const struct iommu_ops ipmmu_ops = {
>  	.probe_device = ipmmu_probe_device,
>  	.release_device = ipmmu_release_device,
>  	.probe_finalize = ipmmu_probe_finalize,
> -#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> -	.device_group = generic_device_group,
> -#else
> -	.device_group = ipmmu_find_group,
> -#endif
> +	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
> +			? generic_device_group : ipmmu_find_group,
>  	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>  	.of_xlate = ipmmu_of_xlate,
>  };
> -- 
> 2.26.0
> 
