Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58382075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589871178;
	bh=CyfrSLclfmxgX/VSCSYoBd+ec6qbw/b1+Oqdv1x9CSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emyfZIq+VEm6+8RWsTkZivo/l+MG/3AXoE/zXEEeGAa/LwQrtUgeFVxs4m8Cjz067
	 2p91zAXxlpvO2fcwL0mzrLV77PxVgnpsDhNBymADa+3ay9zAdEjZDHwSYbtaNbdQ+1
	 hiiT/UGLf29s2PCJGZXH4z1eDtrZbvbKoui1/1zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESGw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgESGw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:52:57 -0400
Received: from localhost (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EFE120758;
        Tue, 19 May 2020 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589871176;
        bh=CyfrSLclfmxgX/VSCSYoBd+ec6qbw/b1+Oqdv1x9CSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9UIdz7zVHWjlHi04D1zGW/6N9J7Qiq5/zpWEUrHTJ1i8NlilFX8UFZ9dRx4ybCGe
         5/6Ajm1MzocZTqg6g2GF3vRCMD4EHPSTVkLMHwZNyJBZKRNVG7Sbi4J4m4yJAkunD9
         2Bt9xMcCT7QfCVuEG4BxP+LF8u3XTTHIQuzUxo6E=
Date:   Tue, 19 May 2020 12:22:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: Re: [PATCH v1 1/1] drivers: phy: sr-usb: do not use internal fsm for
 USB2 phy init
Message-ID: <20200519065251.GK374218@vkoul-mobl.Dlink>
References: <20200513173947.10919-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513173947.10919-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-20, 23:09, Rayagonda Kokatanur wrote:
> From: Bharat Gooty <bharat.gooty@broadcom.com>
> 
> During different reboot cycles, USB PHY PLL may not always lock
> during initialization and therefore can cause USB to be not usable.

Ok

> Hence do not use internal FSM programming sequence for the USB
> PHY initialization.

And what is the impact of not using FSM programming sequence? If not
impact why was it added in the first place ?

> Fixes: 4dcddbb38b64 ("phy: sr-usb: Add Stingray USB PHY driver")
> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/phy/broadcom/phy-bcm-sr-usb.c | 55 +--------------------------
>  1 file changed, 2 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> index fe6c58910e4c..7c7862b4f41f 100644
> --- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
> +++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> @@ -16,8 +16,6 @@ enum bcm_usb_phy_version {
>  };
>  
>  enum bcm_usb_phy_reg {
> -	PLL_NDIV_FRAC,
> -	PLL_NDIV_INT,
>  	PLL_CTRL,
>  	PHY_CTRL,
>  	PHY_PLL_CTRL,
> @@ -31,18 +29,11 @@ static const u8 bcm_usb_combo_phy_ss[] = {
>  };
>  
>  static const u8 bcm_usb_combo_phy_hs[] = {
> -	[PLL_NDIV_FRAC]	= 0x04,
> -	[PLL_NDIV_INT]	= 0x08,
>  	[PLL_CTRL]	= 0x0c,
>  	[PHY_CTRL]	= 0x10,
>  };
>  
> -#define HSPLL_NDIV_INT_VAL	0x13
> -#define HSPLL_NDIV_FRAC_VAL	0x1005
> -
>  static const u8 bcm_usb_hs_phy[] = {
> -	[PLL_NDIV_FRAC]	= 0x0,
> -	[PLL_NDIV_INT]	= 0x4,
>  	[PLL_CTRL]	= 0x8,
>  	[PHY_CTRL]	= 0xc,
>  };
> @@ -52,7 +43,6 @@ enum pll_ctrl_bits {
>  	SSPLL_SUSPEND_EN,
>  	PLL_SEQ_START,
>  	PLL_LOCK,
> -	PLL_PDIV,
>  };
>  
>  static const u8 u3pll_ctrl[] = {
> @@ -66,29 +56,17 @@ static const u8 u3pll_ctrl[] = {
>  #define HSPLL_PDIV_VAL		0x1
>  
>  static const u8 u2pll_ctrl[] = {
> -	[PLL_PDIV]	= 1,
>  	[PLL_RESETB]	= 5,
>  	[PLL_LOCK]	= 6,
>  };
>  
>  enum bcm_usb_phy_ctrl_bits {
>  	CORERDY,
> -	AFE_LDO_PWRDWNB,
> -	AFE_PLL_PWRDWNB,
> -	AFE_BG_PWRDWNB,
> -	PHY_ISO,
>  	PHY_RESETB,
>  	PHY_PCTL,
>  };
>  
>  #define PHY_PCTL_MASK	0xffff
> -/*
> - * 0x0806 of PCTL_VAL has below bits set
> - * BIT-8 : refclk divider 1
> - * BIT-3:2: device mode; mode is not effect
> - * BIT-1: soft reset active low
> - */
> -#define HSPHY_PCTL_VAL	0x0806
>  #define SSPHY_PCTL_VAL	0x0006
>  
>  static const u8 u3phy_ctrl[] = {
> @@ -98,10 +76,6 @@ static const u8 u3phy_ctrl[] = {
>  
>  static const u8 u2phy_ctrl[] = {
>  	[CORERDY]		= 0,
> -	[AFE_LDO_PWRDWNB]	= 1,
> -	[AFE_PLL_PWRDWNB]	= 2,
> -	[AFE_BG_PWRDWNB]	= 3,
> -	[PHY_ISO]		= 4,
>  	[PHY_RESETB]		= 5,
>  	[PHY_PCTL]		= 6,
>  };
> @@ -186,38 +160,13 @@ static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
>  	int ret = 0;
>  	void __iomem *regs = phy_cfg->regs;
>  	const u8 *offset;
> -	u32 rd_data;
>  
>  	offset = phy_cfg->offset;
>  
> -	writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
> -	writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
> -
> -	rd_data = readl(regs + offset[PLL_CTRL]);
> -	rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
> -	rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
> -	writel(rd_data, regs + offset[PLL_CTRL]);
> -
> -	/* Set Core Ready high */
> -	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> -			      BIT(u2phy_ctrl[CORERDY]));
> -
> -	/* Maximum timeout for Core Ready done */
> -	msleep(30);
> -
> +	bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
> +			      BIT(u2pll_ctrl[PLL_RESETB]));
>  	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
>  			      BIT(u2pll_ctrl[PLL_RESETB]));
> -	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> -			      BIT(u2phy_ctrl[PHY_RESETB]));
> -
> -
> -	rd_data = readl(regs + offset[PHY_CTRL]);
> -	rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
> -	rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
> -	writel(rd_data, regs + offset[PHY_CTRL]);
> -
> -	/* Maximum timeout for PLL reset done */
> -	msleep(30);
>  
>  	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
>  				     BIT(u2pll_ctrl[PLL_LOCK]));
> -- 
> 2.17.1

-- 
~Vinod
