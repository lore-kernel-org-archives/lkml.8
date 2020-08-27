Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9174EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669B2207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Iiqx0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgH0JxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0JxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:53:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB6C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:53:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so4725246wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3S2ltGK2B4ahfxRE0OqRsWU+E5mMz97vYPSClpVkEpw=;
        b=j/Iiqx0CIhx0nsty8bj+dxZr7X5let9JMzxAJtte6vf0GUcfyJn+kxd/lKo8+1aVU3
         LEoLd1clGvpkQaBGLO6T22hrbWW3S8KWsahbXmqEp1+sSwllynNwQsbtOpuZrOnwGvqM
         XCJCrMkGqxNCg1Y8mYDi07x+C2FsgXBF6bYz4iIeEkgH+T+4h7v2X6kT+DzKQ9btHwm4
         b1WQKZKh48+9ZASVFD0W+dA+aGB6ZsGDeLi+EZEbtUJddD07+SrIXiriWuVFqaKfZhks
         oUl1IkoQfBshCWgRjZvV1DId5tUXKSI25nx9fubmMDQDS7yn7DPzcIWVgP3PXaLAg7vu
         Y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3S2ltGK2B4ahfxRE0OqRsWU+E5mMz97vYPSClpVkEpw=;
        b=Do1VbYcf2lhMc9x1siACmBXnwt2nHeJYeyRokTxL+Ycd4xOqfAhMPt1Xh0N/V2nHOM
         97pgwRekYziYCjQqvxd8ZCFrTrz3bpkgRCc5FTB/jJio8xrlZ0/WanpgR+rw/VSCpGD9
         QGig/M1+JboXziM9mjtPalEjG36AGw+R2H2ik+XqYnc9/MGtD0f/3bw2wl3zHYEFXt6n
         ynrNULanxpj1TV3THr4rCdDdBPo02Z1PoHt3hqAel4DkEetY6ZQ+GeCyfaRSsINkLy2g
         SePTx8JK1TVrlSjqdHsw/KduM/OZsjNa0PItqv4FkSFkg/lQCmQ4arIL3fWY21JvFSvO
         UzRg==
X-Gm-Message-State: AOAM532Ux+VFmzlAmJsCUf+qkdDMg+/YHzaZIjkuZ7WZlvSFB57oFt+A
        5GAoi0zOlaD760nj8qu2LD4=
X-Google-Smtp-Source: ABdhPJxCQib2nyRWJhQUT1arhmXoAnRcByD/McQ+QvDCu5PGTRgjO4PCrkOK/qYUpcMj1POZM32MmA==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr106089wrx.292.1598521994965;
        Thu, 27 Aug 2020 02:53:14 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id s8sm3707553wmc.1.2020.08.27.02.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 02:53:14 -0700 (PDT)
Subject: Re: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading
 infracfg
To:     Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200826085618.2889-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0d1a4c6d-03ce-a5c4-d17b-26f5203e899a@gmail.com>
Date:   Thu, 27 Aug 2020 11:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826085618.2889-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2020 10:56, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
> Change since v3
> - use lore.kernel.org links
> - move "change since..." after "---"
> 
> Change since v2:
> - determine compatible string by m4u_plat
> - rebase to next-20200720
> - add "---"
> 
> Change since v1:
> - remove the phandle usage, search for infracfg instead [3]
> - use infracfg instead of infracfg_regmap
> - move infracfg definitaions to linux/soc/mediatek/infracfg.h
> - update enable_4GB only when has_4gb_mode
> ---
>   drivers/iommu/mtk_iommu.c             | 34 +++++++++++++++++++++++----
>   include/linux/soc/mediatek/infracfg.h |  3 +++
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..adc350150492 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2015-2016 MediaTek Inc.
>    * Author: Yong Wu <yong.wu@mediatek.com>
>    */
> -#include <linux/memblock.h>
>   #include <linux/bug.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
> @@ -15,13 +14,16 @@
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
>   #include <linux/list.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/of_address.h>
>   #include <linux/of_iommu.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> +#include <linux/soc/mediatek/infracfg.h>
>   #include <asm/barrier.h>
>   #include <soc/mediatek/smi.h>
>   
> @@ -640,8 +642,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	struct resource         *res;
>   	resource_size_t		ioaddr;
>   	struct component_match  *match = NULL;
> +	struct regmap		*infracfg;
>   	void                    *protect;
>   	int                     i, larb_nr, ret;
> +	u32			val;
> +	char                    *p;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -655,10 +660,29 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
> -		data->enable_4GB = false;
> +	data->enable_4GB = false;
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> +		switch (data->plat_data->m4u_plat) {
> +		case M4U_MT2712:
> +			p = "mediatek,mt2712-infracfg";
> +			break;
> +		case M4U_MT8173:
> +			p = "mediatek,mt8173-infracfg";
> +			break;
> +		default:
> +			p = NULL;
> +		}
> +
> +		infracfg = syscon_regmap_lookup_by_compatible(p);
> +
> +		if (IS_ERR(infracfg))
> +			return PTR_ERR(infracfg);
> +
> +		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
> +		if (ret)
> +			return ret;
> +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> +	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	data->base = devm_ioremap_resource(dev, res);
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index fd25f0148566..233463d789c6 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -32,6 +32,9 @@
>   #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
>   						 BIT(7) | BIT(8))
>   
> +#define REG_INFRA_MISC				0xf00
> +#define F_DDR_4GB_SUPPORT_EN			BIT(13)
> +
>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>   		bool reg_update);
>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> 
