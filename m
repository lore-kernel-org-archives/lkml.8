Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAAEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBC42073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594616733;
	bh=JxJp9VSiVtBSKbZYDcCaTaxt/f4xJQVvXKj7oFzNxxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e38rFCsx0daVNDqabD4A+L94dovAGodHV3GAxlEmn4g9v4/Q+H7zeVVSutyhbypT7
	 EjyZk166/GtsqswSabyWj9xi+WiW0TTQnAxoa8J1JHdXbEnn6LABto2zHvNZKwqr54
	 X2nHnHHXzu87zNi7zodCC40+VhcrQAj5Nzgujzh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGMFFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:05:32 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A125120724;
        Mon, 13 Jul 2020 05:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594616731;
        bh=JxJp9VSiVtBSKbZYDcCaTaxt/f4xJQVvXKj7oFzNxxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqnQ2+SiDhAGgzNWnPs2gt0UTDKTww104BASz7gdSal7PjzQbx9Cvb2l9ppmjNl9B
         p1VjslY09VfaebQt1i0ani+oC4d6Qs5zZgjAF4YH8wgWYVUh9fYfdfprYlxkig3hg4
         gXjydw3C0S2tJFgcMq8ryMyDrnncqXGm9B7692oo=
Date:   Mon, 13 Jul 2020 10:35:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] phy: socionext: Add UniPhier AHCI PHY driver
 support
Message-ID: <20200713050527.GR34333@vkoul-mobl>
References: <1593507574-10007-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1593507574-10007-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593507574-10007-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 17:59, Kunihiko Hayashi wrote:

> +++ b/drivers/phy/socionext/phy-uniphier-ahci.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-uniphier-ahci.c - PHY driver for UniPhier AHCI controller
> + * Copyright 2016-2018, Socionext Inc.

we are in 2020 now!

> +static int uniphier_ahciphy_pxs2_power_on(struct uniphier_ahciphy_priv *priv)
> +{
> +	int ret;
> +	u32 val;
> +
> +	/* enable reference clock for PHY */
> +	val = readl(priv->base + CKCTRL);
> +	val |= CKCTRL_REF_SSP_EN;
> +	writel(val, priv->base + CKCTRL);
> +
> +	/* release port reset */
> +	val = readl(priv->base + CKCTRL);
> +	val &= ~CKCTRL_P0_RESET;
> +	writel(val, priv->base + CKCTRL);
> +
> +	/* wait until PLL is ready */
> +	if (priv->data->is_ready_high)
> +		ret = readl_poll_timeout(priv->base + CKCTRL, val,
> +					 (val & CKCTRL_P0_READY), 200, 400);
> +	else
> +		ret = readl_poll_timeout(priv->base + CKCTRL, val,
> +					 !(val & CKCTRL_P0_READY), 200, 400);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to check whether PHY PLL is ready\n");
> +		goto out_disable_clock;
> +	}
> +
> +	return 0;
> +
> +out_disable_clock:
> +	/* assert port reset */
> +	val = readl(priv->base + CKCTRL);
> +	val |= CKCTRL_P0_RESET;
> +	writel(val, priv->base + CKCTRL);
> +
> +	/* disable reference clock for PHY */
> +	val = readl(priv->base + CKCTRL);
> +	val &= ~CKCTRL_REF_SSP_EN;
> +	writel(val, priv->base + CKCTRL);

this seems to be repeated patter, why not add a modifyl() helper here..

> +static int uniphier_ahciphy_pxs3_init(struct uniphier_ahciphy_priv *priv)
> +{
> +	int i;
> +	u32 val;
> +
> +	/* setup port parameter */
> +	val = readl(priv->base + TXCTRL0);
> +	val &= ~TXCTRL0_AMP_G3_MASK;
> +	val |= FIELD_PREP(TXCTRL0_AMP_G3_MASK, 0x73);
> +	val &= ~TXCTRL0_AMP_G2_MASK;
> +	val |= FIELD_PREP(TXCTRL0_AMP_G2_MASK, 0x46);
> +	val &= ~TXCTRL0_AMP_G1_MASK;
> +	val |= FIELD_PREP(TXCTRL0_AMP_G1_MASK, 0x42);
> +	writel(val, priv->base + TXCTRL0);
> +
> +	val = readl(priv->base + TXCTRL1);
> +	val &= ~TXCTRL1_DEEMPH_G3_MASK;
> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G3_MASK, 0x23);
> +	val &= ~TXCTRL1_DEEMPH_G2_MASK;
> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G2_MASK, 0x05);
> +	val &= ~TXCTRL1_DEEMPH_G1_MASK;
> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G1_MASK, 0x05);
> +
> +	val = readl(priv->base + RXCTRL);
> +	val &= ~RXCTRL_LOS_LVL_MASK;
> +	val |= FIELD_PREP(RXCTRL_LOS_LVL_MASK, 0x9);
> +	val &= ~RXCTRL_LOS_BIAS_MASK;
> +	val |= FIELD_PREP(RXCTRL_LOS_BIAS_MASK, 0x2);
> +	val &= ~RXCTRL_RX_EQ_MASK;
> +	val |= FIELD_PREP(RXCTRL_RX_EQ_MASK, 0x1);
> +
> +	/* dummy read 25 times */

why?

> +static int uniphier_ahciphy_init(struct phy *phy)
> +{
> +	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk_parent);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(priv->rst_parent);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	if (priv->data->init) {
> +		ret = priv->data->init(priv);
> +		if (ret)
> +			goto out_rst_assert;
> +	}
> +
> +	return ret;

return 0?

> +static const struct uniphier_ahciphy_soc_data uniphier_pxs2_data = {
> +	.init = NULL,

Isn't this superfluous ?
-- 
~Vinod
