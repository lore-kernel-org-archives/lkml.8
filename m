Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF6EC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF3207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDeXOIXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJNtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGJNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:49:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972DC08C5DC;
        Fri, 10 Jul 2020 06:49:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so5993531wml.3;
        Fri, 10 Jul 2020 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iNGUlusb6XGPbY/iiSrmci3WQY8ih0duTRRM8I2QK9k=;
        b=DDeXOIXu2BiCS9fxE/OsSzLix5ZdnrJD7euJ0K+UCFRooM4QhYEWIwlloYFXznyBZm
         bKbGh0uDE6bIJv30lRIEsnj74X57uq3TJMpGjfCn3vhTWD9aEUHTzLDKAqOgcspa30h5
         +CnLyEPQQKos8wPL2CSrAb76Q/pAUFcDrPd+fMBR3yqYPMU5VYP810xOhmmOTpiT4SnC
         YEWmNQnU7GCRAbl4U1BAgGTE4WJbWn/3RMzFI8hOazRhh6VbdhqocEXc05m8/GyughE1
         Q3aASZzlCujpYuV35daJXyN8nOclhExxN91OKM4x9Yiui+i9MqkW7TXPmo+pzisQmUzN
         V7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNGUlusb6XGPbY/iiSrmci3WQY8ih0duTRRM8I2QK9k=;
        b=OAqRhMOU4noy3u39oTi+qV12NuTeLmeQoe4/zwcHzzHtcZeracydIvClVZWoFzuyKr
         AX2jnK7SEPzrmupefXa0kUv+9Dm69Q8v0j+FDAkVbhQ8RFAIk+l0ywBX+iEpjjRZ9eUQ
         oiHkfPsovFiD19UHKTxHFaxC5+rGgzRvRNbX2pqRGNznxrPksvQxg8jUVu1IJPYlB+lq
         7tanwptHQE1ZZTuQmKLlTvGuGmWXipM2aY9ZHYADIMRdkGXL3/2bqg7PpeX7S/Lk4Cwn
         MvYiBlvKQw0LeCqp2UMK+BB47jy3Hl7SvgXGGdYVkEyVNZjRP5Sl1c+HKGC9ZbJ7wGpF
         yjOg==
X-Gm-Message-State: AOAM533+EQqMKV02lVp6t/AqrMKDpEY+rXFsItexVyNkwQQUQxMRKnQc
        yuhiFpI1XUWK3EUXfQCbt/0=
X-Google-Smtp-Source: ABdhPJwHTlESN9DoaaDMAtI7D4n+BAt5h4FXs+RBDE5A/6CTsyJydS9yE1+a9c/jDu4TOKk7lQ8lNw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr5264267wme.160.1594388980849;
        Fri, 10 Jul 2020 06:49:40 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id l14sm10626393wrn.18.2020.07.10.06.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:49:40 -0700 (PDT)
Subject: Re: [PATCH v6 07/10] iommu/mediatek: Add REG_MMU_WR_LEN_CTRL register
 definition
To:     Chao Hao <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
 <20200703044127.27438-8-chao.hao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2500e311-983a-2d79-cd31-a9ff948b2883@gmail.com>
Date:   Fri, 10 Jul 2020 15:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703044127.27438-8-chao.hao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2020 06:41, Chao Hao wrote:
> Some platforms(ex: mt6779) need to improve performance by setting
> REG_MMU_WR_LEN_CTRL register. And we can use WR_THROT_EN macro to control
> whether we need to set the register. If the register uses default value,
> iommu will send command to EMI without restriction, when the number of
> commands become more and more, it will drop the EMI performance. So when
> more than ten_commands(default value) don't be handled for EMI, iommu will
> stop send command to EMI for keeping EMI's performace by enabling write
> throttling mechanism(bit[5][21]=0) in MMU_WR_LEN_CTRL register.
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 11 +++++++++++
>   drivers/iommu/mtk_iommu.h |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0d96dcd8612b..5c8e141668fc 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -46,6 +46,8 @@
>   #define F_MMU_STANDARD_AXI_MODE_MASK		(BIT(3) | BIT(19))
>   
>   #define REG_MMU_DCM_DIS				0x050
> +#define REG_MMU_WR_LEN_CTRL			0x054
> +#define F_MMU_WR_THROT_DIS_MASK			(BIT(5) | BIT(21))
>   
>   #define REG_MMU_CTRL_REG			0x110
>   #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
> @@ -112,6 +114,7 @@
>   #define RESET_AXI			BIT(3)
>   #define OUT_ORDER_WR_EN			BIT(4)
>   #define HAS_SUB_COMM			BIT(5)
> +#define WR_THROT_EN			BIT(6)
>   
>   #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>   		((((pdata)->flags) & (_x)) == (_x))
> @@ -593,6 +596,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>   		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
>   	}
>   	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
> +		/* write command throttling mode */
> +		regval = readl_relaxed(data->base + REG_MMU_WR_LEN_CTRL);
> +		regval &= ~F_MMU_WR_THROT_DIS_MASK;
> +		writel_relaxed(regval, data->base + REG_MMU_WR_LEN_CTRL);
> +	}
>   
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
>   		/* The register is called STANDARD_AXI_MODE in this case */
> @@ -747,6 +756,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>   	struct mtk_iommu_suspend_reg *reg = &data->reg;
>   	void __iomem *base = data->base;
>   
> +	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
>   	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
>   	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
>   	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
> @@ -771,6 +781,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>   		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
>   		return ret;
>   	}
> +	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
>   	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
>   	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
>   	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 46d0d47b22e1..31edd05e2eb1 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -31,6 +31,7 @@ struct mtk_iommu_suspend_reg {
>   	u32				int_main_control;
>   	u32				ivrp_paddr;
>   	u32				vld_pa_rng;
> +	u32				wr_len_ctrl;
>   };
>   
>   enum mtk_iommu_plat {
> 
