Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C899820720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/bLLtFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgGUVT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbgGUVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:19:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:19:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so5165176wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UfaaXDzDLl64kXCbfxTecuzVYPHxG6njBTZ46/VZRxM=;
        b=n/bLLtFLAZABy0+eAqv5JOF0siLIMX2/vEn232R5DlcqQFyZn7yWcCupGfjwFrjnFj
         +XKAfVXj0cAP3iVBoOrZanT86pGRK4bGm+EAf2gzp3ZpmiHYd7R9pmpsaL5PkY/Zu5rm
         mVzQ2P3lOhsSb2+gWBF59GG5sqAIqP/c7qZC9uaFyP8RAZ0dx0uS7xWBmlW0cpl+f1Ep
         DZZGqHn1AXpLNFwzjhphgs9Dy5uahH9CGwiU5NHqx/ZE5Y+8QybFxiD92SrmrF0OM4Qx
         oku75NLri4d2qZrMWwjQmdivpH0rrcyXGkVa8VA8hVukSM19m9f/sBS4WjoFTwHsnaaY
         p9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfaaXDzDLl64kXCbfxTecuzVYPHxG6njBTZ46/VZRxM=;
        b=SmY4rT/KJMHlFaZoEUP65dtc2ljaMnuoNzJx8chT/Ds8ypjbPAum/W4fHeEjv9ODah
         UXExIqrucsdQCc6Sh/fCpETdrCH7jFdu/QbcakZ3V++bBLg+i3P4992I+MingX0q7p3U
         oxirM4HwTW/b7GYg+x+IIYKF70pIYIJuEMAHwD99bT77e3ml2gY9GPdWWFbQTUHcYrUu
         /xUZg3LDnqqwUxeAUuwri/tyeny/Z65nZaottDNfR95yFADNqMeBMLHBPJA8abHMSlf/
         pScAYlcVBaWQaHnQdmyxzskHB5xoqO0trgM6cIskBwHs2v4wJR+GmonGyjf8edgYJ4qK
         i4EA==
X-Gm-Message-State: AOAM532gw+fNvOHDtau9aWrSEOPPFyGeTKolGjvgnyjGk0o2V1c5rhfg
        vJHRTFpye2gIX+981kKyImo=
X-Google-Smtp-Source: ABdhPJxPVerR4H+cxm4UhuSVQZ/RwXNNmjheXMsIFW2MGE/7/bFuLKr9pYd/bXDbTrAFFQT9qQl86g==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr26846749wrt.136.1595366365025;
        Tue, 21 Jul 2020 14:19:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id a123sm5319714wmd.28.2020.07.21.14.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:19:24 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        Chao Hao <chao.hao@mediatek.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
 <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
 <1595330677.16172.55.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
Date:   Tue, 21 Jul 2020 23:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595330677.16172.55.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2020 13:24, Yong Wu wrote:
> On Tue, 2020-07-21 at 11:40 +0200, Matthias Brugger wrote:
>>
>> On 21/07/2020 04:16, Miles Chen wrote:
>>> In previous discussion [1] and [2], we found that it is risky to
>>> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
>>>
>>> Check 4GB mode by reading infracfg register, remove the usage
>>> of the un-exported symbol max_pfn.
>>>
>>> This is a step towards building mtk_iommu as a kernel module.
>>>
>>> Change since v1:
>>> 1. remove the phandle usage, search for infracfg instead [3]
>>> 2. use infracfg instead of infracfg_regmap
>>> 3. move infracfg definitaions to linux/soc/mediatek/infracfg.h
>>> 4. update enable_4GB only when has_4gb_mode
>>>
>>> [1] https://lkml.org/lkml/2020/6/3/733
>>> [2] https://lkml.org/lkml/2020/6/4/136
>>> [3] https://lkml.org/lkml/2020/7/15/1147
>>>
>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Yong Wu <yong.wu@mediatek.com>
>>> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Yong Wu <yong.wu@mediatek.com>
>>> Cc: Chao Hao <chao.hao@mediatek.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
>>>    include/linux/soc/mediatek/infracfg.h |  3 +++
>>>    2 files changed, 24 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 2be96f1cdbd2..16765f532853 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -3,7 +3,6 @@
>>>     * Copyright (c) 2015-2016 MediaTek Inc.
>>>     * Author: Yong Wu <yong.wu@mediatek.com>
>>>     */
>>> -#include <linux/memblock.h>
>>>    #include <linux/bug.h>
>>>    #include <linux/clk.h>
>>>    #include <linux/component.h>
>>> @@ -15,13 +14,16 @@
>>>    #include <linux/iommu.h>
>>>    #include <linux/iopoll.h>
>>>    #include <linux/list.h>
>>> +#include <linux/mfd/syscon.h>
>>>    #include <linux/of_address.h>
>>>    #include <linux/of_iommu.h>
>>>    #include <linux/of_irq.h>
>>>    #include <linux/of_platform.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>> +#include <linux/soc/mediatek/infracfg.h>
>>>    #include <asm/barrier.h>
>>>    #include <soc/mediatek/smi.h>
>>>    
>>> @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>>    	struct resource         *res;
>>>    	resource_size_t		ioaddr;
>>>    	struct component_match  *match = NULL;
>>> +	struct regmap		*infracfg;
>>>    	void                    *protect;
>>>    	int                     i, larb_nr, ret;
>>> +	u32			val;
>>>    
>>>    	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>    	if (!data)
>>> @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>>    		return -ENOMEM;
>>>    	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>>>    
>>> -	/* Whether the current dram is over 4GB */
>>> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
>>> -	if (!data->plat_data->has_4gb_mode)
>>> -		data->enable_4GB = false;
>>> +	data->enable_4GB = false;
>>> +	if (data->plat_data->has_4gb_mode) {
>>> +		infracfg = syscon_regmap_lookup_by_compatible(
>>> +				"mediatek,mt8173-infracfg");
>>> +		if (IS_ERR(infracfg)) {
>>> +			infracfg = syscon_regmap_lookup_by_compatible(
>>> +					"mediatek,mt2712-infracfg");
>>> +			if (IS_ERR(infracfg))
>>> +				return PTR_ERR(infracfg);
>>
>> I think we should check m4u_plat instead to decide which compatible we have to
>> look for.
>> Another option would be to add a general compatible something like
>> "mtk-infracfg" and search for that. That would need an update of all DTS having
>> a infracfg compatible right now. After thinking twice, this would break newer
>> kernel with older device tree, so maybe it's better to go with m4u_plat switch
>> statement.
> 
> Add a "char *infracfg" in the plat_data, Use the mt2712, mt8173
> corresponding string in it. If it is NULL, It means the "enable_4GB"
> always is false. Then we also can remove the flag "has_4gb_mode".
> 
> is this OK?
> 

It's an option, but I personally find that a bit hacky.

Regards,
Matthias
