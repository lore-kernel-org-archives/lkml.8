Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6466D2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594881476;
	bh=i0+VY+ygP+qTpBzCKjka9/Jb+MkkhClqH6AwSsN73UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gztB2vbPd1ek3pyL0BeGJrbM8jo+Iu8XIv2nZw6uLF4U9FMo6sl5II5ZRNb07JXbz
	 UmRmVL+oMyWv66UdwYGuC4UVS6WvwLtqdWR3LDF7FFd4+jWku/mUQ3w019qIfRgOEG
	 4+pM+ZltWaFpgrk2SKvZLKDzOx9gAWU+hekpQt8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGPGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPGhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:37:55 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5999206F5;
        Thu, 16 Jul 2020 06:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594881474;
        bh=i0+VY+ygP+qTpBzCKjka9/Jb+MkkhClqH6AwSsN73UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJHuMs3A2ePVdZ/8EsBZn//CVJgzRPBMiPbGsqOQziG+R1NMZXk4L4tHeNxLiHYWm
         fdX+12atzFWsOnNMslCw+KFAMNyvylfmBkgrgDsEdRPY0jEIdpuVBhnAsOul/o+pB4
         fry41USRLXqLNSf85zOgcglsrcE1gYLS9sFHZHzY=
Date:   Thu, 16 Jul 2020 12:07:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: socionext: Add UniPhier AHCI PHY driver
 support
Message-ID: <20200716063750.GH55478@vkoul-mobl>
References: <1594867382-27509-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1594867382-27509-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594867382-27509-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-20, 11:43, Kunihiko Hayashi wrote:

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
> +	/* dummy read 25 times to make a wait time for the phy to stablize */

s/stablize/stabilize

> +static int uniphier_ahciphy_power_off(struct phy *phy)
> +{
> +	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	if (priv->data->power_off)
> +		ret = priv->data->power_off(priv);
> +
> +	reset_control_assert(priv->rst);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +

multiple blank lines

> +static const struct phy_ops uniphier_ahciphy_ops = {
> +	.init  = uniphier_ahciphy_init,
> +	.exit  = uniphier_ahciphy_exit,
> +	.power_on  = uniphier_ahciphy_power_on,
> +	.power_off = uniphier_ahciphy_power_off,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int uniphier_ahciphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_ahciphy_priv *priv;
> +	struct phy *phy;
> +	struct phy_provider *phy_provider;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->data = of_device_get_match_data(dev);
> +	if (WARN_ON(!priv->data))
> +		return -EINVAL;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk_parent = devm_clk_get(dev, "link");
> +	if (IS_ERR(priv->clk_parent))
> +		return PTR_ERR(priv->clk_parent);
> +
> +	if (priv->data->is_phy_clk) {
> +		priv->clk = devm_clk_get(dev, "phy");
> +		if (IS_ERR(priv->clk))
> +			return PTR_ERR(priv->clk);
> +	}
> +
> +	priv->rst_parent = devm_reset_control_get_shared(dev, "link");
> +	if (IS_ERR(priv->rst_parent))
> +		return PTR_ERR(priv->rst_parent);
> +
> +	priv->rst = devm_reset_control_get_shared(dev, "phy");
> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);
> +
> +	phy = devm_phy_create(dev, dev->of_node, &uniphier_ahciphy_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "failed to create phy\n");
> +		return PTR_ERR(phy);
> +	}
> +
> +	phy_set_drvdata(phy, priv);
> +	phy_provider = devm_of_phy_provider_register(dev,
> +						     of_phy_simple_xlate);

single line?

-- 
~Vinod
