Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAE22082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfK1WVnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDKBBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:01:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40918 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDKBBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:01:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so1194522plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JnweRSJzbFA/HZJs3MpjVTk2omd0xC4ncUbfKrlGFuw=;
        b=AfK1WVnxwG7uZsgDtL5AKGrzGbqbYwkb8OQZXU/szpAPWTNX6mXt+fKCDUlEzTSfiU
         mLTrYajKIcfrWwHNlBUDmjK+Se8AzofhAE6/K6QCFv+rXvBaAUetqsAw3Hb1ILyYwV0J
         x8IwGn2qVx0vwZJQubgBtUcJCxVwk/filqEKSGbYjn9yHHdxJRKAvpdjHNd++IC48jPK
         1iZ44mTgC9JT79eoM1jiZ84QDPlHHVaiVXmzMcMRF/W7t0BiihsGiPGztaQR8p0t+UEM
         5VFMARXC+qvLvhXpjtvErOQUPmh1STEAp24Ci59/RVXQBOtHvzuOxwgeEPXQCL8Vy48P
         QkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnweRSJzbFA/HZJs3MpjVTk2omd0xC4ncUbfKrlGFuw=;
        b=A7FQz1N7y6SZUAaSW8QHOZf/Zi29DXLK69vc8jZ8U2kfdGsNyvDjySU7srccwTW/8L
         l9VtnteqjaQ+alUwns4M50lSPiXzGuMQ1ZJgmsvae+6SUbVzdoZANkl43u/otNPBSvNx
         tHMzdRZDqLMN/m2Andv48HeHV7VJU6AJwTR3i6DiYttkFoq0ILeVEvhLzgRU8mXWosfb
         tmEcYmXJ9BxT2jF9DFZJnVAIOMXgHUwGrAKFssAD3WE2by8WF2scAvO6U071lKMy5ui+
         wevSPOFyTY8nDD8QKivUevJOpPvwKfCzHPZYemZVkX2Cp+uxmrSVpKaIeHhZpXP7ADu4
         yHmg==
X-Gm-Message-State: AGi0PuZQot9qHG9OvSrs/lEwQ+2a1COjOTWK/73d1d6Zwms9ff09i5tO
        j4E4XFKFv6Gspx4fpmeZz6njwQ==
X-Google-Smtp-Source: APiQypJdhHrHpSQZULqAtlQ5+75We8n8BQ7hLwWMFPX17WGan0vJQ+38ci68Rc0D56ubTYTUgx+RnQ==
X-Received: by 2002:a17:902:8b87:: with SMTP id ay7mr7208355plb.281.1586566894101;
        Fri, 10 Apr 2020 18:01:34 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i190sm823811pfc.119.2020.04.10.18.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:01:33 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:01:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org
Subject: Re: [PATCH v4 1/2] clk: qcom: gcc: Add USB3 PIPE clock and GDSC for
 SM8150
Message-ID: <20200411010143.GF20625@builder.lan>
References: <1586566362-21450-1-git-send-email-wcheng@codeaurora.org>
 <1586566362-21450-2-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586566362-21450-2-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Apr 17:52 PDT 2020, Wesley Cheng wrote:

> This adds the USB3 PIPE clock and GDSC structures, so
> that the USB driver can vote for these resources to be
> enabled/disabled when required.  Both are needed for SS
> and HS USB paths to operate properly.  The GDSC will
> allow the USB system to be brought out of reset, while
> the PIPE clock is needed for data transactions between
> the PHY and controller.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Stephen, let me know when you take this patch and I'll take the dts one.

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gcc-sm8150.c               | 52 +++++++++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sm8150.h |  4 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 2087721..ef98fdc 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -21,6 +21,7 @@
>  #include "clk-rcg.h"
>  #include "clk-regmap.h"
>  #include "reset.h"
> +#include "gdsc.h"
>  
>  enum {
>  	P_BI_TCXO,
> @@ -3171,6 +3172,18 @@ enum {
>  	},
>  };
>  
> +static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0xf058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb3_prim_phy_pipe_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch gcc_usb3_sec_clkref_clk = {
>  	.halt_reg = 0x8c028,
>  	.halt_check = BRANCH_HALT,
> @@ -3218,6 +3231,18 @@ enum {
>  	},
>  };
>  
> +static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
> +	.halt_check = BRANCH_HALT_SKIP,
> +	.clkr = {
> +		.enable_reg = 0x10058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb3_sec_phy_pipe_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  /*
>   * Clock ON depends on external parent 'config noc', so cant poll
>   * delay and also mark as crtitical for video boot
> @@ -3292,6 +3317,24 @@ enum {
>  	},
>  };
>  
> +static struct gdsc usb30_prim_gdsc = {
> +		.gdscr = 0xf004,
> +		.pd = {
> +			.name = "usb30_prim_gdsc",
> +		},
> +		.pwrsts = PWRSTS_OFF_ON,
> +		.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc usb30_sec_gdsc = {
> +		.gdscr = 0x10004,
> +		.pd = {
> +			.name = "usb30_sec_gdsc",
> +		},
> +		.pwrsts = PWRSTS_OFF_ON,
> +		.flags = POLL_CFG_GDSCR,
> +};
> +
>  static struct clk_regmap *gcc_sm8150_clocks[] = {
>  	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
>  	[GCC_AGGRE_UFS_CARD_AXI_CLK] = &gcc_aggre_ufs_card_axi_clk.clkr,
> @@ -3480,10 +3523,12 @@ enum {
>  	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
>  	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
>  	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
> +	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
>  	[GCC_USB3_SEC_CLKREF_CLK] = &gcc_usb3_sec_clkref_clk.clkr,
>  	[GCC_USB3_SEC_PHY_AUX_CLK] = &gcc_usb3_sec_phy_aux_clk.clkr,
>  	[GCC_USB3_SEC_PHY_AUX_CLK_SRC] = &gcc_usb3_sec_phy_aux_clk_src.clkr,
>  	[GCC_USB3_SEC_PHY_COM_AUX_CLK] = &gcc_usb3_sec_phy_com_aux_clk.clkr,
> +	[GCC_USB3_SEC_PHY_PIPE_CLK] = &gcc_usb3_sec_phy_pipe_clk.clkr,
>  	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
>  	[GCC_VIDEO_AXI0_CLK] = &gcc_video_axi0_clk.clkr,
>  	[GCC_VIDEO_AXI1_CLK] = &gcc_video_axi1_clk.clkr,
> @@ -3527,6 +3572,11 @@ enum {
>  	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
>  };
>  
> +static struct gdsc *gcc_sm8150_gdscs[] = {
> +	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
> +	[USB30_SEC_GDSC] = &usb30_sec_gdsc,
> +};
> +
>  static const struct regmap_config gcc_sm8150_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
> @@ -3541,6 +3591,8 @@ enum {
>  	.num_clks = ARRAY_SIZE(gcc_sm8150_clocks),
>  	.resets = gcc_sm8150_resets,
>  	.num_resets = ARRAY_SIZE(gcc_sm8150_resets),
> +	.gdscs = gcc_sm8150_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gcc_sm8150_gdscs),
>  };
>  
>  static const struct of_device_id gcc_sm8150_match_table[] = {
> diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> index 90d60ef..3e1a918 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> @@ -240,4 +240,8 @@
>  #define GCC_USB30_SEC_BCR					27
>  #define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
>  
> +/* GCC GDSCRs */
> +#define USB30_PRIM_GDSC                     4
> +#define USB30_SEC_GDSC						5
> +
>  #endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
