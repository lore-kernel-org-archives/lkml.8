Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515B92070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7ygYoSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGUJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:40:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:40:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so2146416wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rCxIL+rHjym7zqqOLzszCPAKBEVgacDmz2OZWqCIgDo=;
        b=d7ygYoSU9BwJvXFBjfOzjT3xC1XvPBSJ78cKJk0f30A59kcnNZf8/m6jU2QFc4v7U2
         laXUPKM8zkow1EO7JaeNQQwBZsjAE8DjUyh/gRlUj4kQYtl9CxnDAIV64EqyslAVtHnI
         UE/IIO8bQnvoA1JuSwhtRcIF/vEy4e3fvuKp0mrucjS/EJ3pruXS9KpX8SSBg0HqquB4
         BSqXAj/r1cyM47IfNrsHQ4DVFCptzi08AtEWCl7DMaXgpDGNkqP9krSKEmD05fDP3ATN
         2NK+jnUP99/bPs8+Vkw2035Fnf87azVz8jRxgxskHTie0jBqKXA2pvdj34md/yNIH33U
         5htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rCxIL+rHjym7zqqOLzszCPAKBEVgacDmz2OZWqCIgDo=;
        b=CkUpo7YJYm2fcfMwOgma84XdEnh415ig23DVV7lff3jE2aTtDm8H8WWAS71z2Cmxxk
         ueniox/MuKl+QpV8M41CUyc5BBwwzXm+yGVCyKrvURdBdfNRzwEJfVvygnWMfiR01BPl
         PoN07/6jXlCCLXKPR2rpsdwVblWgq2udNk+ZHPpAqD1/tiHeaSr/GmsT1X3t5tefwLxa
         DwGBRzHn8sUQN2qky20uLp6f4w9w4mDWusx16zNiRZMtWFJvzdQuzg4AxwGqQwHOelaZ
         iJQfTWxXwOHM9fNhdz5ypeCPRkdKvgDZWk7l9rR2jfJCYGVEYPBujTHZXYkRdGiYuSRE
         mpFg==
X-Gm-Message-State: AOAM532edAU0BrL7YywlY+oqAtKUMtrGd46Cp+3sAPsYjlnms1IQSSvk
        o8kOLsJxhS2oReZGl+pLtfs=
X-Google-Smtp-Source: ABdhPJwuugwNgvo79Cj+BQrID56nD2Y7XD53afgdNWdzMsthSvIH6suVNQ+ocUsmuhrOHqTBwCORbw==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr3395716wmd.80.1595324443879;
        Tue, 21 Jul 2020 02:40:43 -0700 (PDT)
Received: from ziggy.stardust ([213.195.120.199])
        by smtp.gmail.com with ESMTPSA id r11sm2637848wmh.1.2020.07.21.02.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 02:40:43 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
To:     Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        Chao Hao <chao.hao@mediatek.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
Date:   Tue, 21 Jul 2020 11:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721021619.25575-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2020 04:16, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> Change since v1:
> 1. remove the phandle usage, search for infracfg instead [3]
> 2. use infracfg instead of infracfg_regmap
> 3. move infracfg definitaions to linux/soc/mediatek/infracfg.h
> 4. update enable_4GB only when has_4gb_mode
> 
> [1] https://lkml.org/lkml/2020/6/3/733
> [2] https://lkml.org/lkml/2020/6/4/136
> [3] https://lkml.org/lkml/2020/7/15/1147
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Chao Hao <chao.hao@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
>   include/linux/soc/mediatek/infracfg.h |  3 +++
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2be96f1cdbd2..16765f532853 100644
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
> @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	struct resource         *res;
>   	resource_size_t		ioaddr;
>   	struct component_match  *match = NULL;
> +	struct regmap		*infracfg;
>   	void                    *protect;
>   	int                     i, larb_nr, ret;
> +	u32			val;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!data->plat_data->has_4gb_mode)
> -		data->enable_4GB = false;
> +	data->enable_4GB = false;
> +	if (data->plat_data->has_4gb_mode) {
> +		infracfg = syscon_regmap_lookup_by_compatible(
> +				"mediatek,mt8173-infracfg");
> +		if (IS_ERR(infracfg)) {
> +			infracfg = syscon_regmap_lookup_by_compatible(
> +					"mediatek,mt2712-infracfg");
> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);

I think we should check m4u_plat instead to decide which compatible we have to 
look for.
Another option would be to add a general compatible something like 
"mtk-infracfg" and search for that. That would need an update of all DTS having 
a infracfg compatible right now. After thinking twice, this would break newer 
kernel with older device tree, so maybe it's better to go with m4u_plat switch 
statement.

Regards,
Matthias

> +
> +		}
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
