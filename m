Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA40C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA7A207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otzKIV8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404481AbgE1PjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404416AbgE1PjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:39:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FCFC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:39:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l15so33599681lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Y7aOuNvIw5NVFCCz5l+IgP3xwz47PqMV8f7imNV0wlY=;
        b=otzKIV8HkaQa6FQTKaxIbrFQfQOOyMEevT1/B9LyoTX7v6RO0ME3tdnkWuVHHY05Ad
         mDf2nX6h02SDED/XQbaBtn58lJwn+wuRLEzLTGL06AOH9xfpruiZsZb87FBfDFkl6crg
         MTQehHyL7U7E7CU2OvuLDm04FrdJUWrreel+JfFXgvCfZrZJSJY4wONQsT0WFLRLiKzG
         MC50wWu29l4QuCkzFEsRtRuaevt27/5F2opnzuZ5W1Tp0E0uUVh1ABBhTha86m9XQwxq
         KDD2icPBL4axARO4bX6x7JK5zAd9OOINOyQVh7L2v90ghgpnfMECyA1NxXoYEPjJn4Um
         wp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y7aOuNvIw5NVFCCz5l+IgP3xwz47PqMV8f7imNV0wlY=;
        b=KigEB9CHdvnefZnKKj+gXWO45/Y2lw1DwgUptnVyNSRhMcH0lTCJg9Vg8XzucmEGye
         uauJWOz6m6JSfuqK6U59eLyaRlGc9BtTcXG2D7AISYu4Ksv1gpe5UG6kuUGFdp47B80A
         X0ivOIA7qeoGi6aM230irAwqFhVqT9eNyqNrF7g1il6+ezYdRR/DknxI0pak1lAgtyz7
         p14YIVT7EAaGfn0Q4JTx1OqlDL8moEv3DG98WlX7wJH1PtxOTLHH2w/B9ifiQ0YPCrWz
         lIGblAgUdyJB3lUAl2u3fPhb+QHbCGT5c3O9vS0x9NoNn5v1xs8lcOA/w7It8m6bek5/
         ttlQ==
X-Gm-Message-State: AOAM53371yfIDigAg9TiPzR+7z9wEhwnjGLgDNmHqs5EvGcr5aDJ4QHC
        gmRD1lh1ImBy1WhAtjjtiC232/PEhbo=
X-Google-Smtp-Source: ABdhPJx7i0rMGVf+5qXx8jip/0zcWOlHE0422d/hFJBcqe2d2mLsNt+RhrsFQJ5TE0fw11SCzxlPdw==
X-Received: by 2002:a2e:597:: with SMTP id 145mr1939226ljf.282.1590680344125;
        Thu, 28 May 2020 08:39:04 -0700 (PDT)
Received: from [192.168.1.36] (89-166-24-184.bb.dnainternet.fi. [89.166.24.184])
        by smtp.gmail.com with ESMTPSA id u15sm1689254lfg.92.2020.05.28.08.39.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:39:03 -0700 (PDT)
Subject: Re: [PATCH] clk: qcom: Add missing msm8998 ufs_unipro_core_clk_src
To:     linux-kernel@vger.kernel.org
References: <20200528142205.44003-1-jeffrey.l.hugo@gmail.com>
From:   Jami Kettunen <jamipkettunen@gmail.com>
Message-ID: <e2d1f11d-9a16-a6be-6773-3f27afef2149@gmail.com>
Date:   Thu, 28 May 2020 18:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528142205.44003-1-jeffrey.l.hugo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Jami Kettunen <jamipkettunen@gmail.com>

On 28.5.2020 17.22, Jeffrey Hugo wrote:
> ufs_unipro_core_clk_src is required to allow UFS to clock scale for power
> savings.
>
> Fixes: b5f5f525c547 ("clk: qcom: Add MSM8998 Global Clock Control (GCC) driver")
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>   drivers/clk/qcom/gcc-msm8998.c               | 27 ++++++++++++++++++++
>   include/dt-bindings/clock/qcom,gcc-msm8998.h |  1 +
>   2 files changed, 28 insertions(+)
>
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index df1d7056436c..9d7016bcd680 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -1110,6 +1110,27 @@ static struct clk_rcg2 ufs_axi_clk_src = {
>   	},
>   };
>   
> +static const struct freq_tbl ftbl_ufs_unipro_core_clk_src[] = {
> +	F(37500000, P_GPLL0_OUT_MAIN, 16, 0, 0),
> +	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 ufs_unipro_core_clk_src = {
> +	.cmd_rcgr = 0x76028,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_ufs_unipro_core_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "ufs_unipro_core_clk_src",
> +		.parent_names = gcc_parent_names_0,
> +		.num_parents = 4,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
>   static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
>   	F(19200000, P_XO, 1, 0, 0),
>   	F(60000000, P_GPLL0_OUT_MAIN, 10, 0, 0),
> @@ -2549,6 +2570,11 @@ static struct clk_branch gcc_ufs_unipro_core_clk = {
>   		.enable_mask = BIT(0),
>   		.hw.init = &(struct clk_init_data){
>   			.name = "gcc_ufs_unipro_core_clk",
> +			.parent_names = (const char *[]){
> +				"ufs_unipro_core_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
>   			.ops = &clk_branch2_ops,
>   		},
>   	},
> @@ -2904,6 +2930,7 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
>   	[SDCC4_APPS_CLK_SRC] = &sdcc4_apps_clk_src.clkr,
>   	[TSIF_REF_CLK_SRC] = &tsif_ref_clk_src.clkr,
>   	[UFS_AXI_CLK_SRC] = &ufs_axi_clk_src.clkr,
> +	[UFS_UNIPRO_CORE_CLK_SRC] = &ufs_unipro_core_clk_src.clkr,
>   	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
>   	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
>   	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
> index 63e02dc32a0b..6a73a174f049 100644
> --- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
> +++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
> @@ -183,6 +183,7 @@
>   #define GCC_MSS_SNOC_AXI_CLK					174
>   #define GCC_MSS_MNOC_BIMC_AXI_CLK				175
>   #define GCC_BIMC_GFX_CLK					176
> +#define UFS_UNIPRO_CORE_CLK_SRC					177
>   
>   #define PCIE_0_GDSC						0
>   #define UFS_GDSC						1
