Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32903C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0850C20724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdrKaIvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGFPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgGFPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:17:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7DC061755;
        Mon,  6 Jul 2020 08:17:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so41398888wrw.5;
        Mon, 06 Jul 2020 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tw3x7ahuyaAr/zeHubI/pIIWiTosQ0VrfuSXevvDkyQ=;
        b=qdrKaIvWzvlQ5WxszQQRnltR2zmNstt2XFPYYuqAYlMbnfoH2asZAlQY1MpOPq5Xwn
         AbQvBVREyV0/p4yyhOFA9maeUVDcNlc/hSz+oPQ9yObQcfrO+fJpYE8uSvhL1OIbOdpt
         1TlD+HaO4Swl3Au1O8TflkE6hygAhUY19yM/bg+rSqziinVOSrGt1z274rA8D1R4HXlT
         TccqM0Ah6JG45prRuMcHqRm8eDHNtw28WiHD44jonScFFks14J7qs+M/+MjZUdGFxWWU
         DIJV9btcpP6/ruTKdi64Us3oKXJLrZWBaa2Fw1PyzP0BMwYST6RdhiQf3gaIyVk0yEDo
         Wx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tw3x7ahuyaAr/zeHubI/pIIWiTosQ0VrfuSXevvDkyQ=;
        b=gySITa1piD+5YmbdqKtlYXSm4JgUpaijbAOOPkpRiypBCUK1KvzvOAKJCHp5JOBPPK
         GYxxXt1v/tkuEWWP4lGvnR3XH4TUd50zocxulpIFy8CWpZjfXE+TqRzUO41HIqOgi4ON
         KwAPekZFWDJQ5o/GdUJuMlc7SeOPej7hmkquzgmlIRvZAo4P2HgZeTqU2ajp09Yvjwp1
         A1vC35hWlnRjTCRpKykgqgxN/JVbkyVjfpieK021e3ee4fuJur/zzJpj/ItL4326PDJa
         eUJXLSgT9OLoKn4VbrA9KHUMQxpO59wLaq2sUgiAz3kuU/Nqcgm+ixfTOn3UIvT1nKzc
         /lYg==
X-Gm-Message-State: AOAM530eln7hYmSJtFNpP7Hk695iVcGbp9zku1RvIUVGhM+eh4mHD/xt
        Nz09J/qaDwccExkyMVZ9QYE=
X-Google-Smtp-Source: ABdhPJyR6f1c+3rsYGvrANlV6vEt4kBeaGtcGE/SSDZ3hT+m4ZF6+lY08jb33yABKgzRuFlrzsuOfg==
X-Received: by 2002:adf:f842:: with SMTP id d2mr53494954wrq.55.1594048625575;
        Mon, 06 Jul 2020 08:17:05 -0700 (PDT)
Received: from ziggy.stardust (81.172.57.81.dyn.user.ono.com. [81.172.57.81])
        by smtp.gmail.com with ESMTPSA id x7sm25127283wrr.72.2020.07.06.08.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 08:17:04 -0700 (PDT)
Subject: Re: [PATCH v6 03/10] iommu/mediatek: Use a u32 flags to describe
 different HW features
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, TH Yang <th.yang@mediatek.com>,
        linux-mediatek@lists.infradead.org, Yong Wu <yong.wu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200703044127.27438-1-chao.hao@mediatek.com>
 <20200703044127.27438-4-chao.hao@mediatek.com>
 <1593825398.4355.1.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bce3e1e0-f0b0-8c77-d966-3b6e37b3b647@gmail.com>
Date:   Mon, 6 Jul 2020 17:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593825398.4355.1.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2020 03:16, Yingjoe Chen wrote:
> On Fri, 2020-07-03 at 12:41 +0800, Chao Hao wrote:
>> Given the fact that we are adding more and more plat_data bool values,
>> it would make sense to use a u32 flags register and add the appropriate
>> macro definitions to set and check for a flag present.
>> No functional change.
>>
>> Cc: Yong Wu <yong.wu@mediatek.com>
>> Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  drivers/iommu/mtk_iommu.c | 28 +++++++++++++++++-----------
>>  drivers/iommu/mtk_iommu.h |  7 +------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 88d3df5b91c2..40ca564d97af 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -100,6 +100,15 @@
>>  #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
>>  #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
>>  
>> +#define HAS_4GB_MODE			BIT(0)
>> +/* HW will use the EMI clock if there isn't the "bclk". */
>> +#define HAS_BCLK			BIT(1)
>> +#define HAS_VLD_PA_RNG			BIT(2)
>> +#define RESET_AXI			BIT(3)
>> +
>> +#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>> +		((((pdata)->flags) & (_x)) == (_x))
>> +
>>  struct mtk_iommu_domain {
>>  	struct io_pgtable_cfg		cfg;
>>  	struct io_pgtable_ops		*iop;
>> @@ -563,7 +572,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>>  			 upper_32_bits(data->protect_base);
>>  	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>>  
>> -	if (data->enable_4GB && data->plat_data->has_vld_pa_rng) {
>> +	if (data->enable_4GB &&
>> +	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
>>  		/*
>>  		 * If 4GB mode is enabled, the validate PA range is from
>>  		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
>> @@ -573,7 +583,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>>  	}
>>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>>  
>> -	if (data->plat_data->reset_axi) {
>> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
>>  		/* The register is called STANDARD_AXI_MODE in this case */
>>  		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
>>  	}
>> @@ -618,7 +628,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>  
>>  	/* Whether the current dram is over 4GB */
>>  	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
>> -	if (!data->plat_data->has_4gb_mode)
>> +	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>>  		data->enable_4GB = false;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -631,7 +641,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>  	if (data->irq < 0)
>>  		return data->irq;
>>  
>> -	if (data->plat_data->has_bclk) {
>> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
>>  		data->bclk = devm_clk_get(dev, "bclk");
>>  		if (IS_ERR(data->bclk))
>>  			return PTR_ERR(data->bclk);
>> @@ -763,23 +773,19 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
>>  
>>  static const struct mtk_iommu_plat_data mt2712_data = {
>>  	.m4u_plat     = M4U_MT2712,
>> -	.has_4gb_mode = true,
>> -	.has_bclk     = true,
>> -	.has_vld_pa_rng   = true,
>> +	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
>>  	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>>  };
>>  
>>  static const struct mtk_iommu_plat_data mt8173_data = {
>>  	.m4u_plat     = M4U_MT8173,
>> -	.has_4gb_mode = true,
>> -	.has_bclk     = true,
>> -	.reset_axi    = true,
>> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
>>  	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
>>  };
>>  
>>  static const struct mtk_iommu_plat_data mt8183_data = {
>>  	.m4u_plat     = M4U_MT8183,
>> -	.reset_axi    = true,
>> +	.flags        = RESET_AXI,
>>  	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
>>  };
>>  
>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
>> index 7212e6fcf982..5225a9170aaa 100644
>> --- a/drivers/iommu/mtk_iommu.h
>> +++ b/drivers/iommu/mtk_iommu.h
>> @@ -39,12 +39,7 @@ enum mtk_iommu_plat {
>>  
>>  struct mtk_iommu_plat_data {
>>  	enum mtk_iommu_plat m4u_plat;
>> -	bool                has_4gb_mode;
>> -
>> -	/* HW will use the EMI clock if there isn't the "bclk". */
>> -	bool                has_bclk;
>> -	bool                has_vld_pa_rng;
>> -	bool                reset_axi;
>> +	u32                 flags;
> 
> 
> How about using bit field instead? eg
> 
>   u32 has_bclk:1;
> 
> In this way, we don't need to change code.
> 

Actually I proposed to use the flag approach because I didn't want to bloat the
mtk_iommu_plat_data structure with new variables for every new feature, being it
a bit field or a bool.

Regards,
Matthias
