Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1138E2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGPHD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:03:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:55352 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:03:27 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jul 2020 16:03:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B5BB760060;
        Thu, 16 Jul 2020 16:03:25 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 16 Jul 2020 16:03:25 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 45A7A4035D;
        Thu, 16 Jul 2020 16:03:25 +0900 (JST)
Received: from [10.212.7.208] (unknown [10.212.7.208])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E8AC8120488;
        Thu, 16 Jul 2020 16:03:24 +0900 (JST)
Subject: Re: [PATCH v3 2/2] phy: socionext: Add UniPhier AHCI PHY driver
 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1594867382-27509-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1594867382-27509-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200716063750.GH55478@vkoul-mobl>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <de019ff3-ba7b-4ace-d415-3ca1caf8b195@socionext.com>
Date:   Thu, 16 Jul 2020 16:03:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716063750.GH55478@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2020/07/16 15:37, Vinod Koul wrote:
> On 16-07-20, 11:43, Kunihiko Hayashi wrote:
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
>> +	/* dummy read 25 times to make a wait time for the phy to stablize */
> 
> s/stablize/stabilize

Need more spell checking. I'll fix it.

>> +static int uniphier_ahciphy_power_off(struct phy *phy)
>> +{
>> +	struct uniphier_ahciphy_priv *priv = phy_get_drvdata(phy);
>> +	int ret = 0;
>> +
>> +	if (priv->data->power_off)
>> +		ret = priv->data->power_off(priv);
>> +
>> +	reset_control_assert(priv->rst);
>> +	clk_disable_unprepare(priv->clk);
>> +
>> +	return ret;
>> +}
>> +
>> +
> 
> multiple blank lines

I'll remove it.

>> +static const struct phy_ops uniphier_ahciphy_ops = {
>> +	.init  = uniphier_ahciphy_init,
>> +	.exit  = uniphier_ahciphy_exit,
>> +	.power_on  = uniphier_ahciphy_power_on,
>> +	.power_off = uniphier_ahciphy_power_off,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int uniphier_ahciphy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct uniphier_ahciphy_priv *priv;
>> +	struct phy *phy;
>> +	struct phy_provider *phy_provider;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev = dev;
>> +	priv->data = of_device_get_match_data(dev);
>> +	if (WARN_ON(!priv->data))
>> +		return -EINVAL;
>> +
>> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(priv->base))
>> +		return PTR_ERR(priv->base);
>> +
>> +	priv->clk_parent = devm_clk_get(dev, "link");
>> +	if (IS_ERR(priv->clk_parent))
>> +		return PTR_ERR(priv->clk_parent);
>> +
>> +	if (priv->data->is_phy_clk) {
>> +		priv->clk = devm_clk_get(dev, "phy");
>> +		if (IS_ERR(priv->clk))
>> +			return PTR_ERR(priv->clk);
>> +	}
>> +
>> +	priv->rst_parent = devm_reset_control_get_shared(dev, "link");
>> +	if (IS_ERR(priv->rst_parent))
>> +		return PTR_ERR(priv->rst_parent);
>> +
>> +	priv->rst = devm_reset_control_get_shared(dev, "phy");
>> +	if (IS_ERR(priv->rst))
>> +		return PTR_ERR(priv->rst);
>> +
>> +	phy = devm_phy_create(dev, dev->of_node, &uniphier_ahciphy_ops);
>> +	if (IS_ERR(phy)) {
>> +		dev_err(dev, "failed to create phy\n");
>> +		return PTR_ERR(phy);
>> +	}
>> +
>> +	phy_set_drvdata(phy, priv);
>> +	phy_provider = devm_of_phy_provider_register(dev,
>> +						     of_phy_simple_xlate);
> 
> single line?

Ok, It can be merged into single line.

Thank you,
  
---
Best Regards
Kunihiko Hayashi
