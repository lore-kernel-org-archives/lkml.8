Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35442076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHRQJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:09:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59334 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgHRQJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:09:07 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k84AX-009vyk-Nw; Tue, 18 Aug 2020 18:09:01 +0200
Date:   Tue, 18 Aug 2020 18:09:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Landen Chao <landen.chao@mediatek.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        davem@davemloft.net, sean.wang@mediatek.com, opensource@vdorst.com,
        frank-w@public-files.de, dqfext@gmail.com
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: Add the support of
 MT7531 switch
Message-ID: <20200818160901.GF2330298@lunn.ch>
References: <cover.1597729692.git.landen.chao@mediatek.com>
 <e980fda45e0fb478f55e72765643bb641f352c65.1597729692.git.landen.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e980fda45e0fb478f55e72765643bb641f352c65.1597729692.git.landen.chao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 03:14:10PM +0800, Landen Chao wrote:
> Add new support for MT7531:
> 
> MT7531 is the next generation of MT7530. It is also a 7-ports switch with
> 5 giga embedded phys, 2 cpu ports, and the same MAC logic of MT7530. Cpu
> port 6 only supports SGMII interface. Cpu port 5 supports either RGMII
> or SGMII in different HW sku. Due to SGMII interface support, pll, and
> pad setting are different from MT7530. This patch adds different initial
> setting, and SGMII phylink handlers of MT7531.
> 
> MT7531 SGMII interface can be configured in following mode:
> - 'SGMII AN mode' with in-band negotiation capability
>     which is compatible with PHY_INTERFACE_MODE_SGMII.
> - 'SGMII force mode' without in-bnad negotiation

band

>     which is compatible with 10B/8B encoding of
>     PHY_INTERFACE_MODE_1000BASEX with fixed full-duplex and fixed pause.
> - 2.5 times faster clocked 'SGMII force mode' without in-bnad negotiation

band

> +static int mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
> +			      phy_interface_t interface)
> +{
> +	u32 val;
> +
> +	if (!mt7531_is_rgmii_port(priv, port)) {
> +		dev_err(priv->dev, "RGMII mode is not available for port %d\n",
> +			port);
> +		return -EINVAL;
> +	}
> +
> +	val = mt7530_read(priv, MT7531_CLKGEN_CTRL);
> +	val |= GP_CLK_EN;
> +	val &= ~GP_MODE_MASK;
> +	val |= GP_MODE(MT7531_GP_MODE_RGMII);
> +	val &= ~(TXCLK_NO_REVERSE | RXCLK_NO_DELAY);
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		val |= TXCLK_NO_REVERSE;
> +		val |= RXCLK_NO_DELAY;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		val |= TXCLK_NO_REVERSE;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= RXCLK_NO_DELAY;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

You need to be careful here. If the MAC is doing the RGMII delays, you
need to ensure the PHY is not. What interface mode is passed to the
PHY?

	Andrew
