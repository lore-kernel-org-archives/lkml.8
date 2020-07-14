Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D9EC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC952145D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGNJKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:10:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:30094 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:10:53 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 14 Jul 2020 18:10:51 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9ACA460060;
        Tue, 14 Jul 2020 18:10:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 14 Jul 2020 18:10:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2AC731A0508;
        Tue, 14 Jul 2020 18:10:51 +0900 (JST)
Received: from [10.212.0.26] (unknown [10.212.0.26])
        by yuzu.css.socionext.com (Postfix) with ESMTP id C7F8F12012F;
        Tue, 14 Jul 2020 18:10:50 +0900 (JST)
Subject: Re: [PATCH v2 2/2] phy: socionext: Add UniPhier AHCI PHY driver
 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1593507574-10007-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1593507574-10007-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200713050527.GR34333@vkoul-mobl>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <9f358850-eb2a-769c-be57-866d77183a7f@socionext.com>
Date:   Tue, 14 Jul 2020 18:10:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713050527.GR34333@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2020/07/13 14:05, Vinod Koul wrote:
> On 30-06-20, 17:59, Kunihiko Hayashi wrote:
> 
>> +++ b/drivers/phy/socionext/phy-uniphier-ahci.c
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * phy-uniphier-ahci.c - PHY driver for UniPhier AHCI controller
>> + * Copyright 2016-2018, Socionext Inc.
> 
> we are in 2020 now!

Oops, I'll adjust it.

>> +static int uniphier_ahciphy_pxs2_power_on(struct uniphier_ahciphy_priv *priv)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	/* enable reference clock for PHY */
>> +	val = readl(priv->base + CKCTRL);
>> +	val |= CKCTRL_REF_SSP_EN;
>> +	writel(val, priv->base + CKCTRL);
>> +
>> +	/* release port reset */
>> +	val = readl(priv->base + CKCTRL);
>> +	val &= ~CKCTRL_P0_RESET;
>> +	writel(val, priv->base + CKCTRL);
>> +
>> +	/* wait until PLL is ready */
>> +	if (priv->data->is_ready_high)
>> +		ret = readl_poll_timeout(priv->base + CKCTRL, val,
>> +					 (val & CKCTRL_P0_READY), 200, 400);
>> +	else
>> +		ret = readl_poll_timeout(priv->base + CKCTRL, val,
>> +					 !(val & CKCTRL_P0_READY), 200, 400);
>> +	if (ret) {
>> +		dev_err(priv->dev, "Failed to check whether PHY PLL is ready\n");
>> +		goto out_disable_clock;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_disable_clock:
>> +	/* assert port reset */
>> +	val = readl(priv->base + CKCTRL);
>> +	val |= CKCTRL_P0_RESET;
>> +	writel(val, priv->base + CKCTRL);
>> +
>> +	/* disable reference clock for PHY */
>> +	val = readl(priv->base + CKCTRL);
>> +	val &= ~CKCTRL_REF_SSP_EN;
>> +	writel(val, priv->base + CKCTRL);
> 
> this seems to be repeated patter, why not add a modifyl() helper here..

Hmm, I try to add helpers for modifying P0_RESET and REF_SSP_EN bits.

> 
>> +static int uniphier_ahciphy_pxs3_init(struct uniphier_ahciphy_priv *priv)
>> +{
>> +	int i;
>> +	u32 val;
>> +
>> +	/* setup port parameter */
>> +	val = readl(priv->base + TXCTRL0);
>> +	val &= ~TXCTRL0_AMP_G3_MASK;
>> +	val |= FIELD_PREP(TXCTRL0_AMP_G3_MASK, 0x73);
>> +	val &= ~TXCTRL0_AMP_G2_MASK;
>> +	val |= FIELD_PREP(TXCTRL0_AMP_G2_MASK, 0x46);
>> +	val &= ~TXCTRL0_AMP_G1_MASK;
>> +	val |= FIELD_PREP(TXCTRL0_AMP_G1_MASK, 0x42);
>> +	writel(val, priv->base + TXCTRL0);
>> +
>> +	val = readl(priv->base + TXCTRL1);
>> +	val &= ~TXCTRL1_DEEMPH_G3_MASK;
>> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G3_MASK, 0x23);
>> +	val &= ~TXCTRL1_DEEMPH_G2_MASK;
>> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G2_MASK, 0x05);
>> +	val &= ~TXCTRL1_DEEMPH_G1_MASK;
>> +	val |= FIELD_PREP(TXCTRL1_DEEMPH_G1_MASK, 0x05);
>> +
>> +	val = readl(priv->base + RXCTRL);
>> +	val &= ~RXCTRL_LOS_LVL_MASK;
>> +	val |= FIELD_PREP(RXCTRL_LOS_LVL_MASK, 0x9);
>> +	val &= ~RXCTRL_LOS_BIAS_MASK;
>> +	val |= FIELD_PREP(RXCTRL_LOS_BIAS_MASK, 0x2);
>> +	val &= ~RXCTRL_RX_EQ_MASK;
>> +	val |= FIELD_PREP(RXCTRL_RX_EQ_MASK, 0x1);
>> +
>> +	/* dummy read 25 times */
> 
> why?

According to the specification document,
these 25 read accesses make a wait time for the phy to stablize.
I'll add the reason as comment.

> 
>> +static int uniphier_ahciphy_init(struct phy *phy)
>> +{
>> +	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(priv->clk_parent);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = reset_control_deassert(priv->rst_parent);
>> +	if (ret)
>> +		goto out_clk_disable;
>> +
>> +	if (priv->data->init) {
>> +		ret = priv->data->init(priv);
>> +		if (ret)
>> +			goto out_rst_assert;
>> +	}
>> +
>> +	return ret;
> 
> return 0?

Yes, I'll fix it.

> 
>> +static const struct uniphier_ahciphy_soc_data uniphier_pxs2_data = {
>> +	.init = NULL,
> 
> Isn't this superfluous ?

Indeed, this can be removed.

Thank you,

---
Best Regards
Kunihiko Hayashi
